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
                ViewBag.CampaniaID = UserData().CampaniaID.ToString();
                ViewBag.ISO = UserData().CodigoISO.ToString();
                ViewBag.Simbolo = UserData().Simbolo.ToString().Trim();
                ViewBag.PaisID = UserData().PaisID.ToString().Trim();
                BEConfiguracionCampania oBEConfiguracionCampania = null;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionCampania = sv.GetEstadoPedido(UserData().PaisID, UserData().CampaniaID, UserData().ConsultoraID, UserData().ZonaID, UserData().RegionID);
                }
                if (oBEConfiguracionCampania != null)
                    ValidarStatusCampania(oBEConfiguracionCampania);

                var lista = GetListadoOfertasWeb();
                if (lista != null && lista.Count > 0)
                {
                    lista.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                    var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                    lista.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO));
                }
                ViewBag.ListaOfertasWeb = lista;
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

        #region Visualización Ofertas Web

        public List<OfertaProductoModel> GetListadoOfertasWeb()
        {
            var lst = new List<BEOfertaProducto>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetOfertaProductosPortal(UserData().PaisID, Constantes.ConfiguracionOferta.Web, UserData().IndicadorDupla, UserData().CampaniaID).ToList();
            }
            
            return Mapper.Map<IList<BEOfertaProducto>, List<OfertaProductoModel>>(lst);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            object JSONdata = null;

            try
            {
                if (CUVTieneStock(model.CUV))
                {
                    BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);

                    entidad.PaisID = UserData().PaisID;
                    entidad.ConsultoraID = UserData().ConsultoraID;
                    entidad.CampaniaID = UserData().CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Web;
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

                    JSONdata = new
                    {
                        success = true,
                        message = "Se agregó la Oferta Web satisfactoriamente.",
                        extra = ""
                    };
                }
                else
                {
                    JSONdata = new
                    {
                        success = false,
                        message = "Producto Agotado.",
                        extra = ""
                    };
                }

                return Json(JSONdata);
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

        private bool CUVTieneStock(string CUV)
        {
            bool response = false;

            List<BEProducto> olstProducto = new List<BEProducto>();

            using (ODSServiceClient sv = new ODSServiceClient())
            {
                olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(UserData().PaisID, UserData().CampaniaID, CUV, UserData().RegionID, UserData().ZonaID, UserData().CodigorRegion, UserData().CodigoZona, 1, 1, false).ToList();
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
                    entidad.PaisID = UserData().PaisID;
                    entidad.ConsultoraID = UserData().ConsultoraID;
                    entidad.CampaniaID = UserData().CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Web;

                    entidad.CodigoUsuarioCreacion = UserData().CodigoConsultora;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisID)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisID, Constantes.ConfiguracionOferta.Web).ToList();
                lst = lstConfiguracion;
            }

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
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

        public ActionResult ConsultarOfertaWeb(string sidx, string sord, int page, int rows, int PaisID, string codigoOferta, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaProducto> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosByTipoOferta(PaisID, Constantes.ConfiguracionOferta.Web, CampaniaID, codigoOferta).ToList();
                }

                string ISO = Util.GetPaisISO(PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO;

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                
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
                lst.Update(x => x.ISOPais = ISO);
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
                                   a.Orden.ToString(),
                                   a.Stock.ToString(),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.ImagenProducto.ToString(), Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO),
                                   a.CampaniaID.ToString() ,
                                   a.Stock.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaProductoID.ToString(),
                                   a.CodigoTipoOferta.ToString(),
                                   a.ISOPais.ToString(),
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.CodigoProducto.ToString(),
                                   a.DescripcionLegal.ToString()
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
                    entidad.UsuarioRegistro = UserData().CodigoConsultora;
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

        public JsonResult ValidarPriorizacion(int paisID, string codigoOferta, int CampaniaID, int Orden)
        {
            int FlagExiste = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
                FlagExiste = sv.ValidarPriorizacion(UserData().PaisID, ConfiguracionOfertaID, CampaniaID, Orden);
            }

            return Json(new
            {
                FlagExiste = FlagExiste
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
                    entidad.UsuarioModificacion = UserData().CodigoConsultora;
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
        public JsonResult DeshabilitarOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = UserData().CodigoConsultora.ToString();
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
        public string ActualizarStockMasivo(HttpPostedFileBase flStock)
        {
            string message = string.Empty;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV
                string finalPath = string.Empty;
                List<BEOfertaProducto> lstStock = new List<BEOfertaProducto>();

                if (flStock != null)
                {
                    string fileName = Path.GetFileName(flStock.FileName);
                    string pathBanner = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    finalPath = Path.Combine(pathBanner, fileName);
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
                                if (IsNumeric(values[1].ToString().Trim()) && IsNumeric(values[3].ToString().Trim()))
                                {
                                    BEOfertaProducto ent = new BEOfertaProducto();
                                    ent.ISOPais = values[0].ToString().Trim();
                                    ent.CampaniaID = int.Parse(values[1].ToString());
                                    ent.CUV = values[2].ToString().Trim();
                                    ent.Stock = int.Parse(values[3].ToString().Trim());
                                    if (ent.Stock >= 0)
                                        lstStock.Add(ent);
                                }
                            }
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
                                int paisID = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisID > 0)
                                    registros += sv.UpdOfertaProductoStockMasivo(paisID, lstStock.ToArray());
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
                        BEStockCargaLog ent = new BEStockCargaLog();
                        ent.CantidadRegistros = registros;
                        ent.TipoOfertaSisID = Constantes.ConfiguracionOferta.Web;
                        ent.UsuarioRegistro = UserData().CodigoConsultora;
                        sv.InsStockCargaLog(ent);
                    }
                    #endregion
                }
                else
                    message = "No se actualizó el stock de ninguno de los productos que estaban dentro del archivo (CSV), verifique el Tipo de Oferta.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente.";
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

        #endregion
    }
}
