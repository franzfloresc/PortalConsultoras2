using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertaFlexipagoController : BaseController
    {
        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        #region Oferta Flexipago

        public ActionResult OfertasFlexipago()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaFlexipago/OfertasFlexipago"))
                    return RedirectToAction("Index", "Bienvenida");
                ViewBag.CampaniaID = userData.CampaniaID.ToString();
                ViewBag.ISO = userData.CodigoISO;
                var lista = GetListadoOfertasFlexipago();
                if (lista != null && lista.Count > 0)
                {
                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                    lista.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                    lista.Update(x => x.ImagenProducto = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenProducto));
                }
                BEConfiguracionCampania obeConfiguracionCampania;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    obeConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }
                if (obeConfiguracionCampania != null)
                    ValidarStatusCampania(obeConfiguracionCampania);

                ViewBag.ListaOfertasFlexipago = lista;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View();

        }

        public string GetDescripcionMarca(int marcaId)
        {
            string result = string.Empty;

            switch (marcaId)
            {
                case 1:
                    result = "L'Bel";
                    break;
                case 2:
                    result = "Ésika";
                    break;
                case 3:
                    result = "Cyzone";
                    break;
                case 6:
                    result = "Finart";
                    break;
            }

            return result;
        }

        private void ValidarStatusCampania(BEConfiguracionCampania obeConfiguracionCampania)
        {
            UsuarioModel usuario = UserData();
            usuario.ZonaValida = obeConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = obeConfiguracionCampania.FechaInicioFacturacion;

            usuario.FechaFinCampania = obeConfiguracionCampania.FechaInicioFacturacion.AddDays(obeConfiguracionCampania.DiasDuracionCronograma - 1);

            usuario.HoraInicioReserva = obeConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = obeConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = obeConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = obeConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = obeConfiguracionCampania.DiasAntes;
            usuario.NombreCorto = obeConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = obeConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = obeConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = obeConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = obeConfiguracionCampania.HoraCierreZonaNormal;

            if (DateTime.Now.AddHours(obeConfiguracionCampania.ZonaHoraria) < obeConfiguracionCampania.FechaInicioFacturacion.AddDays(-obeConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = obeConfiguracionCampania.FechaInicioFacturacion.AddDays(-obeConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = obeConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = obeConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = obeConfiguracionCampania.HoraFin;
            }
            SetUserData(usuario);
        }

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV)
        {
            int unidadesPermitidas;
            int saldo;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                unidadesPermitidas = sv.GetUnidadesPermitidasByCuvFlexipago(userData.PaisID, userData.CampaniaID, CUV);
                saldo = sv.ValidarUnidadesPermitidasEnPedidoFlexipago(userData.PaisID, userData.CampaniaID, CUV, userData.ConsultoraID);
            }

            return Json(new
            {
                UnidadesPermitidas = unidadesPermitidas,
                Saldo = saldo
            }, JsonRequestBehavior.AllowGet);
        }

        public List<OfertaFlexipagoModel> GetListadoOfertasFlexipago()
        {
            List<BEOfertaFlexipago> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int cantidad = sv.ObtenerMaximoItemsaMostrarFlexipago(userData.PaisID);
                lst = sv.GetOfertaProductosPortalFlexipago(userData.PaisID, Constantes.ConfiguracionOferta.Flexipago, userData.CodigoConsultora, userData.CampaniaID).Take(cantidad).ToList();
            }

            return Mapper.Map<IList<BEOfertaFlexipago>, List<OfertaFlexipagoModel>>(lst);
        }

        public JsonResult ObtenerStockActualProducto(string CUV)
        {
            int stock;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                stock = sv.GetStockOfertaProductoFlexipago(userData.PaisID, userData.CampaniaID, CUV, Constantes.ConfiguracionOferta.Flexipago);
            }

            return Json(new
            {
                Stock = stock
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            try
            {
                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);

                entidad.PaisID = userData.PaisID;
                entidad.ConsultoraID = userData.ConsultoraID;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago;
                entidad.IPUsuario = userData.IPUsuario;

                entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
                entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsPedidoWebDetalleOferta(entidad);
                }

                UpdPedidoWebMontosPROL();

                BEIndicadorPedidoAutentico indPedidoAutentico = new BEIndicadorPedidoAutentico
                {
                    PedidoID = entidad.PedidoID,
                    CampaniaID = entidad.CampaniaID,
                    PedidoDetalleID = entidad.PedidoDetalleID,
                    IndicadorIPUsuario = GetIPCliente(),
                    IndicadorFingerprint = "",
                    IndicadorToken = (Session["TokenPedidoAutentico"] != null)
                        ? Session["TokenPedidoAutentico"].ToString()
                        : ""
                };

                InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);

                return Json(new
                {
                    success = true,
                    message = "Se agregó la Oferta satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult UpdateOfertaWebPortal(PedidoDetalleModel model)
        {
            try
            {
                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago;

                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;

                    sv.UpdPedidoWebDetalleOferta(entidad);
                }

                UpdPedidoWebMontosPROL();

                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        #endregion

        #region Administración Flexipago

        public JsonResult ObtenerCantidadMaximaPorPais(int paisID)
        {
            int cantidad;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                cantidad = sv.ObtenerMaximoItemsaMostrarFlexipago(paisID);
            }

            return Json(new
            {
                Cantidad = cantidad
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AdministrarOfertasFlexipago()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaFlexipago/AdministrarOfertasFlexipago"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            var cronogramaModel = new OfertaFlexipagoModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstConfiguracionOferta = new List<ConfiguracionOfertaModel>(),
                lstPais = DropDowListPaises()
            };
            return View(cronogramaModel);
        }

        [HttpPost]
        public JsonResult ActualizarCantidadMaximaMostrar(int PaisID, int Cantidad)
        {
            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.ActualizarItemsMostrarFlexipago(PaisID, Cantidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó satisfactoriamente el registro.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public string ActualizarStockMasivo(HttpPostedFileBase flStock, string tipoCarga)
        {
            string message;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV

                List<BEOfertaFlexipago> lstActualizMasiva = new List<BEOfertaFlexipago>();

                if (flStock != null)
                {
                    string extension = Path.GetExtension(flStock.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    var finalPath = Path.Combine(pathFile, newfileName);
                    flStock.SaveAs(finalPath);

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            var values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                if (tipoCarga.Equals("0")) // Carga de Stock por Categoria
                                {
                                    if (IsNumeric(values[1].Trim()) && IsNumeric(values[2].Trim())
                                        && IsNumeric(values[3].Trim()))
                                    {
                                        BEOfertaFlexipago ent = new BEOfertaFlexipago
                                        {
                                            ISOPais = values[0].Trim(),
                                            CampaniaID = int.Parse(values[1]),
                                            CUV = values[2].Trim(),
                                            Stock = 0,
                                            CategoriaID = values[3].Trim()
                                        };
                                        if (ent.Stock >= 0)
                                            lstActualizMasiva.Add(ent);
                                    }
                                }
                                else //Carga de Consultoras por Categoria [tipoCarga=1]
                                {
                                    if (IsNumeric(values[1].Trim()) && IsNumeric(values[2].Trim())
                                       && IsNumeric(values[3].Trim()))
                                    {
                                        BEOfertaFlexipago ent = new BEOfertaFlexipago
                                        {
                                            ISOPais = values[0].Trim(),
                                            CampaniaID = int.Parse(values[1]),
                                            CodigoConsultora = values[2].Trim(),
                                            CategoriaID = values[3].Trim()
                                        };

                                        if (!string.IsNullOrEmpty(ent.CodigoConsultora))
                                            lstActualizMasiva.Add(ent);
                                    }
                                }
                            }
                        }
                    }
                    if (lstActualizMasiva.Count > 0)
                    {
                        lstActualizMasiva.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago);
                        List<BEOfertaFlexipago> lstPaises = lstActualizMasiva.GroupBy(x => x.ISOPais).Select(g => g.First()).ToList();

                        for (int i = 0; i < lstPaises.Count; i++)
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                List<BEOfertaFlexipago> lstStockTemporal = lstActualizMasiva.FindAll(x => x.ISOPais == lstPaises[i].ISOPais);
                                int paisId = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisId > 0)
                                {
                                    try
                                    {
                                        if (tipoCarga.Equals("0")) // Carga de Stock por Categoria
                                        {
                                            registros += sv.UpdOfertaFlexipagoStockMasivo(paisId, lstStockTemporal.ToArray());

                                            #region Log de Cargas de Stock
                                            using (PedidoServiceClient srv = new PedidoServiceClient())
                                            {
                                                BEStockCargaLog ent = new BEStockCargaLog
                                                {
                                                    CantidadRegistros = registros,
                                                    PaisID = paisId,
                                                    TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago,
                                                    UsuarioRegistro = userData.CodigoConsultora
                                                };

                                                srv.InsStockCargaLog(ent);
                                            }
                                            #endregion
                                        }
                                        else //Carga de Consultoras por Categoria [tipoCarga=1]
                                        {
                                            registros += sv.UpdCategoriaConsultoraMasivo(paisId, lstStockTemporal.ToArray());
                                        }
                                    }
                                    catch (FaultException ex)
                                    {
                                        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                                    }
                                    catch (Exception ex)
                                    {
                                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                                    }
                                }
                            }
                        }
                    }
                }
                #endregion

                if (registros > 0)
                {
                    if (tipoCarga.Equals("0"))
                        message = "Se realizó la actualización de " + registros + " registro(s) de CUV's por Categoria";
                    else
                        message = "Se realizó la actualización de " + registros + " registro(s) de Consultora por Categoria";
                }
                else
                {
                    message = tipoCarga.Equals("0")
                        ? "No se actualizó la Categoría de ninguno de los CUV's de productos que estaban dentro del archivo (CSV), verifique."
                        : "No se actualizó ninguna de las consultoras por categoría que estaban dentro del archivo (CSV), verifique que los códigos sean correctos.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                if (tipoCarga.Equals("0"))
                    message = "Se actualizaron solo " + registros + " registro(s), debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
                else
                    message = "Se actualizaron solo " + registros + " registro(s), debido a que uno o más Código's ingresados en el archivo no son correctos.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                if (tipoCarga.Equals("0"))
                    message = "Se actualizaron solo " + registros + " registro(s), debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
                else
                    message = "Se actualizaron solo " + registros + " registro(s), debido a que uno o más Código's ingresados en el archivo no son correctos.";
            }
            return message;
        }

        public static bool IsNumeric(object expression)
        {
            double retNum;
            var isNum = Double.TryParse(Convert.ToString(expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        public JsonResult ObtenerImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            List<BEMatrizComercial> lst;

            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            List<BEMatrizComercial> lstFinal = new List<BEMatrizComercial>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCodigoSAP(paisID, codigoSAP).ToList();
            }            

            if (lst != null && lst.Count > 0)
            {
                lstFinal.Add(new BEMatrizComercial
                {
                    IdMatrizComercial = lst[0].IdMatrizComercial,
                    CodigoSAP = lst[0].CodigoSAP,
                    Descripcion = lst[0].Descripcion,
                    PaisID = lst[0].PaisID
                });

                if (lst[0].FotoProducto != "")
                    lstFinal[0].FotoProducto01 = ConfigCdn.GetUrlFileCdn(carpetaPais, lst[0].FotoProducto);

                if (lst[1].FotoProducto != "")
                    lstFinal[0].FotoProducto02 = ConfigCdn.GetUrlFileCdn(carpetaPais, lst[1].FotoProducto);

                if (lst[2].FotoProducto != "")
                    lstFinal[0].FotoProducto03 = ConfigCdn.GetUrlFileCdn(carpetaPais, lst[2].FotoProducto);
            }

            return Json(new
            {
                lista = lstFinal
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ConsultarOfertaFlexipago(string sidx, string sord, int page, int rows, int PaisID, string codigoOferta, int CampaniaID,
            string CodigoSAP, string CUV, string CategoriaID)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaFlexipago> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosByOfertaFlexipago(PaisID, Constantes.ConfiguracionOferta.Flexipago, CampaniaID, codigoOferta,
                        CodigoSAP, CUV, CategoriaID).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEOfertaFlexipago> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "TipoOferta":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "CodigoCampania":
                            items = lst.OrderBy(x => x.CodigoCampania);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "PrecioOferta":
                            items = lst.OrderBy(x => x.PrecioOferta);
                            break;
                        case "Orden":
                            items = lst.OrderBy(x => x.Orden);
                            break;
                        case "Stock":
                            items = lst.OrderBy(x => x.Stock);
                            break;
                        case "CategoriaID":
                            items = lst.OrderBy(x => x.CategoriaID);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "TipoOferta":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "CodigoCampania":
                            items = lst.OrderByDescending(x => x.CodigoCampania);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "PrecioOferta":
                            items = lst.OrderByDescending(x => x.PrecioOferta);
                            break;
                        case "Orden":
                            items = lst.OrderByDescending(x => x.Orden);
                            break;
                        case "Stock":
                            items = lst.OrderByDescending(x => x.Stock);
                            break;
                        case "CategoriaID":
                            items = lst.OrderByDescending(x => x.CategoriaID);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                string iso = Util.GetPaisISO(PaisID);
                
                var carpetaPais = Globals.UrlMatriz + "/" + iso;
                lst.Update(x => x.ImagenProducto = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenProducto));
                lst.Update(x => x.ISOPais = iso);
                lst.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago);
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.NroOrden,
                               cell = new string[]
                               {
                                   a.TipoOferta,
                                   a.CodigoProducto,
                                   a.CodigoCampania,
                                   a.CUV,
                                   a.Descripcion,
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.PrecioNormal.ToString("#0.00"),
                                   a.Orden.ToString(),
                                   a.CategoriaID,
                                   a.Stock.ToString(),
                                   a.ImagenProducto,
                                   a.CampaniaID.ToString() ,
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaProductoID.ToString(),
                                   a.CodigoTipoOferta.Trim(),
                                   a.ISOPais,
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.CodigoProducto,
                                   a.TipoOfertaSisID.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarCategoriaByConsultora(int PaisID, int CampaniaID, string ConsultoraID)
        {
            try
            {
                string resultado;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    resultado = svc.GetCategoriaByConsultora(PaisID, CampaniaID, ConsultoraID);
                }

                if (!string.IsNullOrEmpty(resultado))
                    return Json(new
                    {
                        success = true,
                        Categoria = resultado
                    }, JsonRequestBehavior.AllowGet);

                return Json(new
                {
                    success = false,
                    message = "No se encontró categoría para la consultora especificada"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public ActionResult GuardarLinkFlexipago(OfertaFlexipagoModel model)
        {
            try
            {
                BEOfertaFlexipago entidad = Mapper.Map<OfertaFlexipagoModel, BEOfertaFlexipago>(model);

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {

                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;

                    svc.GuardarLinksOfertaFlexipago(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se guardo satisfactoriamente el link para la Oferta Flexipago.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public JsonResult CargarLinkFlexipago(int PaisID)
        {
            try
            {
                BEOfertaFlexipago entidad;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    entidad = svc.GetLinksOfertaFlexipago(PaisID);
                }

                return Json(new
                {
                    LinksFlexipago = entidad.LinksFlexipago
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public JsonResult ValidarPriorizacion(int paisID, string codigoOferta, int CampaniaID, int Orden)
        {
            int flagExiste;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int configuracionOfertaId = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
                flagExiste = sv.ValidarPriorizacion(paisID, configuracionOfertaId, CampaniaID, Orden);
            }

            return Json(new
            {
                FlagExiste = flagExiste
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            int orden;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                orden = sv.GetOrdenPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID);
            }

            return Json(new
            {
                Orden = orden
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertOfertaFlexipago(OfertaFlexipagoModel model)
        {
            try
            {
                BEOfertaFlexipago entidad = Mapper.Map<OfertaFlexipagoModel, BEOfertaFlexipago>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;
                    sv.InsOfertaFlexipago(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Flexipago satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult UpdateOfertaFlexipago(OfertaFlexipagoModel model)
        {
            try
            {
                BEOfertaFlexipago entidad = Mapper.Map<OfertaFlexipagoModel, BEOfertaFlexipago>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    sv.UpdOfertaFlexipago(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Flexipago satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult DeshabilitarOfertaFlexipago(OfertaFlexipagoModel model)
        {
            try
            {
                BEOfertaFlexipago entidad = Mapper.Map<OfertaFlexipagoModel, BEOfertaFlexipago>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    entidad.TipoOfertaSisID = model.TipoOfertaSisID;
                    sv.DelOfertaFlexipago(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito la Oferta de Flexipago satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = UserData().RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(UserData().PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ConfiguracionOfertaModel> lstConfig = DropDowListConfiguracion(PaisID);
            return Json(new
            {
                lista = lst,
                lstConfig = lstConfig
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisId)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisId, Constantes.ConfiguracionOferta.Flexipago).ToList();
                lst = lstConfiguracion;
            }

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        }

        #endregion
    }
}