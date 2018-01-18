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
        #region Oferta Flexipago

        public ActionResult OfertasFlexipago()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaFlexipago/OfertasFlexipago"))
                    return RedirectToAction("Index", "Bienvenida");
                ViewBag.CampaniaID = UserData().CampaniaID.ToString();
                ViewBag.ISO = UserData().CodigoISO.ToString();
                ViewBag.Simbolo = UserData().Simbolo.ToString().Trim();
                var lista = GetListadoOfertasFlexipago();
                if (lista != null && lista.Count > 0)
                {
                    lista.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                    var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                    lista.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO));
                }
                BEConfiguracionCampania oBEConfiguracionCampania = null;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionCampania = sv.GetEstadoPedido(UserData().PaisID, UserData().CampaniaID, UserData().ConsultoraID, UserData().ZonaID, UserData().RegionID);
                }
                if (oBEConfiguracionCampania != null)
                    ValidarStatusCampania(oBEConfiguracionCampania);

                ViewBag.ListaOfertasFlexipago = lista;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View();

        }

        public string GetDescripcionMarca(int MarcaID)
        {
            string result = string.Empty;

            switch (MarcaID)
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

        private void ValidarStatusCampania(BEConfiguracionCampania oBEConfiguracionCampania)
        {
            UsuarioModel usuario = UserData();
            usuario.ZonaValida = oBEConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = oBEConfiguracionCampania.FechaInicioFacturacion;

            usuario.FechaFinCampania = oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(oBEConfiguracionCampania.DiasDuracionCronograma - 1);

            usuario.HoraInicioReserva = oBEConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = oBEConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = oBEConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = oBEConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = oBEConfiguracionCampania.DiasAntes;
            usuario.NombreCorto = oBEConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = oBEConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = oBEConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = oBEConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = oBEConfiguracionCampania.HoraCierreZonaNormal;

            if (DateTime.Now.AddHours(oBEConfiguracionCampania.ZonaHoraria) < oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(-oBEConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(-oBEConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = oBEConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = oBEConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = oBEConfiguracionCampania.HoraFin;
            }
            SetUserData(usuario);
        }

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV)
        {
            int UnidadesPermitidas = 0;
            int Saldo = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                UnidadesPermitidas = sv.GetUnidadesPermitidasByCuvFlexipago(UserData().PaisID, UserData().CampaniaID, CUV);
                Saldo = sv.ValidarUnidadesPermitidasEnPedidoFlexipago(UserData().PaisID, UserData().CampaniaID, CUV, UserData().ConsultoraID);
            }

            return Json(new
            {
                UnidadesPermitidas = UnidadesPermitidas,
                Saldo = Saldo
            }, JsonRequestBehavior.AllowGet);
        }

        public List<OfertaFlexipagoModel> GetListadoOfertasFlexipago()
        {
            var lst = new List<BEOfertaFlexipago>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int Cantidad = sv.ObtenerMaximoItemsaMostrarFlexipago(UserData().PaisID);
                lst = sv.GetOfertaProductosPortalFlexipago(UserData().PaisID, Constantes.ConfiguracionOferta.Flexipago, UserData().CodigoConsultora, UserData().CampaniaID).Take(Cantidad).ToList();
            }
            
            return Mapper.Map<IList<BEOfertaFlexipago>, List<OfertaFlexipagoModel>>(lst);
        }

        public JsonResult ObtenerStockActualProducto(string CUV)
        {
            int Stock = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Stock = sv.GetStockOfertaProductoFlexipago(UserData().PaisID, UserData().CampaniaID, CUV, Constantes.ConfiguracionOferta.Flexipago);
            }

            return Json(new
            {
                Stock = Stock
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            try
            {
                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);

                entidad.PaisID = UserData().PaisID;
                entidad.ConsultoraID = UserData().ConsultoraID;
                entidad.CampaniaID = UserData().CampaniaID;
                entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago;
                entidad.IPUsuario = UserData().IPUsuario;

                entidad.CodigoUsuarioCreacion = UserData().CodigoConsultora;
                entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
                entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsPedidoWebDetalleOferta(entidad);
                }

                UpdPedidoWebMontosPROL();

                    BEIndicadorPedidoAutentico indPedidoAutentico = new BEIndicadorPedidoAutentico();
                    indPedidoAutentico.PedidoID = entidad.PedidoID;
                    indPedidoAutentico.CampaniaID = entidad.CampaniaID;
                    indPedidoAutentico.PedidoDetalleID = entidad.PedidoDetalleID;
                    indPedidoAutentico.IndicadorIPUsuario = GetIPCliente();
                    indPedidoAutentico.IndicadorFingerprint = "";
                    indPedidoAutentico.IndicadorToken = (Session["TokenPedidoAutentico"] != null) ? Session["TokenPedidoAutentico"].ToString() : "";

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                    entidad.PaisID = UserData().PaisID;
                    entidad.ConsultoraID = UserData().ConsultoraID;
                    entidad.CampaniaID = UserData().CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago;

                    entidad.CodigoUsuarioCreacion = UserData().CodigoConsultora;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        #endregion

        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        #region Administración Flexipago

        public JsonResult ObtenerCantidadMaximaPorPais(int paisID)
        {
            int Cantidad = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Cantidad = sv.ObtenerMaximoItemsaMostrarFlexipago(paisID);
            }

            return Json(new
            {
                Cantidad = Cantidad
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
            string message = string.Empty;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV
                string finalPath = string.Empty;
                List<BEOfertaFlexipago> lstActualizMasiva = new List<BEOfertaFlexipago>();

                if (flStock != null)
                {
                    string extension = Path.GetExtension(flStock.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    finalPath = Path.Combine(pathFile, newfileName);
                    flStock.SaveAs(finalPath);

                    string inputLine = "";

                    string[] values = null;

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                if (tipoCarga.Equals("0")) // Carga de Stock por Categoria
                                {
                                    if (IsNumeric(values[1].ToString().Trim()) && IsNumeric(values[2].ToString().Trim())
                                        && IsNumeric(values[3].ToString().Trim()))
                                    {
                                        BEOfertaFlexipago ent = new BEOfertaFlexipago();
                                        ent.ISOPais = values[0].ToString().Trim();
                                        ent.CampaniaID = int.Parse(values[1].ToString());
                                        ent.CUV = values[2].ToString().Trim();
                                        ent.Stock = 0;
                                        ent.CategoriaID = values[3].ToString().Trim();
                                        if (ent.Stock >= 0)
                                            lstActualizMasiva.Add(ent);
                                    }
                                }
                                else //Carga de Consultoras por Categoria [tipoCarga=1]
                                {
                                    if (IsNumeric(values[1].ToString().Trim()) && IsNumeric(values[2].ToString().Trim())
                                       && IsNumeric(values[3].ToString().Trim()))
                                    {
                                        BEOfertaFlexipago ent = new BEOfertaFlexipago();
                                        ent.ISOPais = values[0].ToString().Trim();
                                        ent.CampaniaID = int.Parse(values[1].ToString());
                                        ent.CodigoConsultora = values[2].ToString().Trim();
                                        ent.CategoriaID = values[3].ToString().Trim();
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
                                int paisID = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisID > 0)
                                {
                                    try
                                    {
                                        if (tipoCarga.Equals("0")) // Carga de Stock por Categoria
                                        {
                                            registros += sv.UpdOfertaFlexipagoStockMasivo(paisID, lstStockTemporal.ToArray());

                                            #region Log de Cargas de Stock
                                            using (PedidoServiceClient srv = new PedidoServiceClient())
                                            {
                                                BEStockCargaLog ent = new BEStockCargaLog();
                                                ent.CantidadRegistros = registros;
                                                ent.PaisID = paisID;
                                                ent.TipoOfertaSisID = Constantes.ConfiguracionOferta.Flexipago;
                                                ent.UsuarioRegistro = UserData().CodigoConsultora;
                                                srv.InsStockCargaLog(ent);
                                            }
                                            #endregion
                                        }
                                        else //Carga de Consultoras por Categoria [tipoCarga=1]
                                        {
                                            registros += sv.UpdCategoriaConsultoraMasivo(paisID, lstStockTemporal.ToArray());
                                        }
                                    }
                                    catch (FaultException ex)
                                    {
                                        LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                                    }
                                    catch (Exception ex)
                                    {
                                        LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                    if (tipoCarga.Equals("0"))
                        message = "No se actualizó la Categoría de ninguno de los CUV's de productos que estaban dentro del archivo (CSV), verifique.";
                    else
                        message = "No se actualizó ninguna de las consultoras por categoría que estaban dentro del archivo (CSV), verifique que los códigos sean correctos.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                if (tipoCarga.Equals("0"))
                    message = "Se actualizaron solo " + registros + " registro(s), debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
                else
                    message = "Se actualizaron solo " + registros + " registro(s), debido a que uno o más Código's ingresados en el archivo no son correctos.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                if (tipoCarga.Equals("0"))
                    message = "Se actualizaron solo " + registros + " registro(s), debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
                else
                    message = "Se actualizaron solo " + registros + " registro(s), debido a que uno o más Código's ingresados en el archivo no son correctos.";
            }
            return message;
        }

        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;

            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        public JsonResult ObtenerImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            List<BEMatrizComercial> lst = new List<BEMatrizComercial>();

            var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
            List<BEMatrizComercial> lstFinal = new List<BEMatrizComercial>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCodigoSAP(paisID, codigoSAP).ToList();
            }
            
            if (lst.Count > 0)
            {
                lstFinal.Add(new BEMatrizComercial
                {
                    IdMatrizComercial = lst[0].IdMatrizComercial,
                    CodigoSAP = lst[0].CodigoSAP,
                    Descripcion = lst[0].Descripcion,
                    PaisID = lst[0].PaisID
                });

                if (lst[0].FotoProducto != "")
                    lstFinal[0].FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                if (lst[1].FotoProducto != "")
                    lstFinal[0].FotoProducto02 = ConfigS3.GetUrlFileS3(carpetaPais, lst[1].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                if (lst[2].FotoProducto != "")
                    lstFinal[0].FotoProducto03 = ConfigS3.GetUrlFileS3(carpetaPais, lst[2].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
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

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
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
                string ISO = Util.GetPaisISO(PaisID);

                var carpetaPais = Globals.UrlMatriz + "/" + ISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO));
                lst.Update(x => x.ISOPais = ISO);
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
                                   a.TipoOferta.ToString(),
                                   a.CodigoProducto.ToString(),
                                   a.CodigoCampania.ToString(),
                                   a.CUV.ToString(),
                                   a.Descripcion.ToString(),
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.PrecioNormal.ToString("#0.00"),
                                   a.Orden.ToString(),
                                   a.CategoriaID,
                                   a.Stock.ToString(),
                                   a.ImagenProducto.ToString(),
                                   a.CampaniaID.ToString() ,
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaProductoID.ToString(),
                                   a.CodigoTipoOferta.ToString().Trim(),
                                   a.ISOPais.ToString(),
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.CodigoProducto.ToString(),
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                    entidad.UsuarioRegistro = UserData().CodigoConsultora;

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                BEOfertaFlexipago entidad = null;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
            int FlagExiste = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
                FlagExiste = sv.ValidarPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
            }

            return Json(new
            {
                FlagExiste = FlagExiste
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            int Orden = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Orden = sv.GetOrdenPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID);
            }

            return Json(new
            {
                Orden = Orden
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
                    entidad.UsuarioRegistro = UserData().CodigoConsultora;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                    entidad.UsuarioModificacion = UserData().CodigoConsultora;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                    entidad.UsuarioModificacion = UserData().CodigoConsultora.ToString();
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }
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

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisID)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisID, Constantes.ConfiguracionOferta.Flexipago).ToList();
                lst = lstConfiguracion;
            }

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        }

        #endregion
    }
}