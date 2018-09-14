using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
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
    public class OfertaWebController : BaseController
    {
        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        public ActionResult OfertasWeb()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaWeb/OfertasWeb"))
                    return RedirectToAction("Index", "Bienvenida");
                ViewBag.CampaniaID = userData.CampaniaID.ToString();
                ViewBag.ISO = userData.CodigoISO;
                ViewBag.PaisID = userData.PaisID.ToString().Trim();
                BEConfiguracionCampania obeConfiguracionCampania;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    obeConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }
                if (obeConfiguracionCampania != null)
                    ValidarStatusCampania(obeConfiguracionCampania);

                var lista = GetListadoOfertasWeb();
                if (lista != null && lista.Count > 0)
                {
                    lista.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                    lista.Update(x => x.ImagenProducto = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenProducto));
                }
                ViewBag.ListaOfertasWeb = lista;
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
            UsuarioModel usuario = userData;
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
            sessionManager.SetUserData(usuario);
        }

        #region Visualización Ofertas Web

        public List<OfertaProductoModel> GetListadoOfertasWeb()
        {
            List<BEOfertaProducto> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetOfertaProductosPortal(userData.PaisID, Constantes.ConfiguracionOferta.Web, userData.IndicadorDupla, userData.CampaniaID).ToList();
            }

            return Mapper.Map<IList<BEOfertaProducto>, List<OfertaProductoModel>>(lst);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            try
            {
                object jsoNdata;
                if (CUVTieneStock(model.CUV))
                {
                    BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);

                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Web;
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
                        IndicadorToken = (sessionManager.GetTokenPedidoAutentico() != null)
                            ? sessionManager.GetTokenPedidoAutentico().ToString()
                            : ""
                    };

                    InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);

                    jsoNdata = new
                    {
                        success = true,
                        message = "Se agregó la Oferta Web satisfactoriamente.",
                        extra = ""
                    };
                }
                else
                {
                    jsoNdata = new
                    {
                        success = false,
                        message = "Producto Agotado.",
                        extra = ""
                    };
                }

                return Json(jsoNdata);
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

        private bool CUVTieneStock(string cuv)
        {
            bool response = false;

            List<ServiceODS.BEProducto> olstProducto;

            using (ODSServiceClient sv = new ODSServiceClient())
            {
                olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, cuv, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, false).ToList();
            }

            if (olstProducto.Count != 0)
            {
                response = olstProducto[0].TieneStock;
            }

            return response;
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
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Web;

                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;

                    sv.UpdPedidoWebDetalleOferta(entidad);
                }

                UpdPedidoWebMontosPROL();

                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Web satisfactoriamente.",
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

        #region Administrador de Ofertas Web

        public ActionResult AdministrarOfertas()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaWeb/AdministrarOfertas"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            var cronogramaModel = new OfertaProductoModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstConfiguracionOferta = new List<ConfiguracionOfertaModel>(),
                lstPais = DropDowListPaises()
            };
            return View(cronogramaModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2 ? sv.SelectPaises().ToList() : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisId)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisId, Constantes.ConfiguracionOferta.Web).ToList();
                lst = lstConfiguracion;
            }

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
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

        public ActionResult ConsultarOfertaWeb(string sidx, string sord, int page, int rows, int PaisID, string codigoOferta, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaProducto> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosByTipoOferta(PaisID, Constantes.ConfiguracionOferta.Web, CampaniaID, codigoOferta).ToList();
                }

                string iso = Util.GetPaisISO(PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + iso;

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEOfertaProducto> items = lst;

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
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                lst.Update(x => x.ISOPais = iso);
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
                                   a.Orden.ToString(),
                                   a.Stock.ToString(),
                                   ConfigCdn.GetUrlFileCdn(carpetaPais, a.ImagenProducto), // 1664
                                   a.CampaniaID.ToString() ,
                                   a.Stock.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaProductoID.ToString(),
                                   a.CodigoTipoOferta,
                                   a.ISOPais,
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.CodigoProducto,
                                   a.DescripcionLegal
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult InsertOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Web;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;
                    sv.InsOfertaProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Web satisfactoriamente.",
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

        public JsonResult ValidarPriorizacion(int paisID, string codigoOferta, int CampaniaID, int Orden)
        {
            int flagExiste;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int configuracionOfertaId = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
                flagExiste = sv.ValidarPriorizacion(userData.PaisID, configuracionOfertaId, CampaniaID, Orden);
            }

            return Json(new
            {
                FlagExiste = flagExiste
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult UpdateOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Web;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    sv.UpdOfertaProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Web satisfactoriamente.",
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
        public JsonResult DeshabilitarOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    sv.DelOfertaProducto(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito la Oferta Web satisfactoriamente.",
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
        public string ActualizarStockMasivo(HttpPostedFileBase flStock)
        {
            string message;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV

                List<BEOfertaProducto> lstStock = new List<BEOfertaProducto>();

                if (flStock != null)
                {
                    string fileName = Path.GetFileName(flStock.FileName) ?? "";
                    string pathBanner = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    var finalPath = Path.Combine(pathBanner, fileName);
                    flStock.SaveAs(finalPath);

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            var values = inputLine.Split(',');
                            if (values.Length <= 1) continue;

                            if (!IsNumeric(values[1].Trim()) || !IsNumeric(values[3].Trim())) continue;

                            BEOfertaProducto ent = new BEOfertaProducto
                            {
                                ISOPais = values[0].Trim(),
                                CampaniaID = int.Parse(values[1]),
                                CUV = values[2].Trim(),
                                Stock = int.Parse(values[3].Trim())
                            };
                            if (ent.Stock >= 0)
                                lstStock.Add(ent);
                        }
                    }
                    if (lstStock.Count > 0)
                    {
                        lstStock.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.Web);
                        List<BEOfertaProducto> lstPaises = lstStock.GroupBy(x => x.ISOPais).Select(g => g.First()).ToList();

                        for (int i = 0; i < lstPaises.Count; i++)
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                lstStock = lstStock.FindAll(x => x.ISOPais == lstPaises[i].ISOPais);
                                int paisId = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisId > 0)
                                    registros += sv.UpdOfertaProductoStockMasivo(paisId, lstStock.ToArray());
                            }
                        }
                    }
                }
                #endregion
                if (registros > 0)
                {
                    message = "Se realizó la actualización del stock de " + registros + " Productos";

                    #region Log de Cargas de Stock
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        BEStockCargaLog ent = new BEStockCargaLog
                        {
                            CantidadRegistros = registros,
                            TipoOfertaSisID = Constantes.ConfiguracionOferta.Web,
                            UsuarioRegistro = userData.CodigoConsultora
                        };
                        sv.InsStockCargaLog(ent);
                    }
                    #endregion
                }
                else
                    message = "No se actualizó el stock de ninguno de los productos que estaban dentro del archivo (CSV), verifique el Tipo de Oferta.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente.";
            }

            return message;
        }

        public static bool IsNumeric(object expression)
        {
            double retNum;
            var isNum = Double.TryParse(Convert.ToString(expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        #endregion
    }
}
