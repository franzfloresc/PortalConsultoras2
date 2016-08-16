using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Controllers
{
    public class ShowRoomController : BaseController
    {
        public ActionResult Index()
        {
            ViewBag.TerminoMostrar = 1;
            var userData = UserData();

            try
            {
                var showRoomEvento = new BEShowRoomEvento();
                var showRoomEventoConsultora = new BEShowRoomEventoConsultora();
                var listaShowRoomOferta = new List<BEShowRoomOferta>();

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    showRoomEvento = sv.GetShowRoomEventoByCampaniaID(userData.PaisID, userData.CampaniaID);
                    showRoomEventoConsultora = sv.GetShowRoomConsultora(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora);
                    listaShowRoomOferta = sv.GetShowRoomOfertas(userData.PaisID, userData.CampaniaID).ToList();
                }

                if (showRoomEvento == null)
                {
                    return RedirectToAction("Index", "Bienvenida");
                }
                else
                {
                    if (showRoomEventoConsultora == null)
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }
                    else
                    {
                        var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                        if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-2).Date &&
                            fechaHoy <= userData.FechaInicioCampania.AddDays(1).Date))
                        {
                            var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                            showRoomEvento.Imagen1 = showRoomEvento.Imagen1 ?? "";
                            showRoomEvento.Imagen2 = showRoomEvento.Imagen2 ?? "";

                            showRoomEvento.Imagen1 = ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.Imagen1, Globals.UrlMatriz + "/" + UserData().CodigoISO);
                            showRoomEvento.Imagen2 = ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.Imagen2, Globals.UrlMatriz + "/" + UserData().CodigoISO);

                            if (listaShowRoomOferta != null)
                            {
                                listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto) ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                                listaShowRoomOferta.Update(x => x.ImagenProducto1 = string.IsNullOrEmpty(x.ImagenProducto1) ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto1, Globals.UrlMatriz + "/" + userData.CodigoISO));
                                listaShowRoomOferta.Update(x => x.ImagenProducto2 = string.IsNullOrEmpty(x.ImagenProducto2) ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto2, Globals.UrlMatriz + "/" + userData.CodigoISO));
                                listaShowRoomOferta.Update(x => x.ImagenProducto3 = string.IsNullOrEmpty(x.ImagenProducto3) ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto3, Globals.UrlMatriz + "/" + userData.CodigoISO));
                            }

                            Mapper.CreateMap<BEShowRoomEvento, ShowRoomEventoModel>()
                                .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                                .ForMember(t => t.Imagen1, f => f.MapFrom(c => c.Imagen1))
                                .ForMember(t => t.Imagen2, f => f.MapFrom(c => c.Imagen2))
                                .ForMember(t => t.Descuento, f => f.MapFrom(c => c.Descuento));

                            Mapper.CreateMap<BEShowRoomOferta, ShowRoomOfertaModel>()
                                .ForMember(t => t.OfertaShowRoomID, f => f.MapFrom(c => c.OfertaShowRoomID))
                                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                                .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                                .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                                .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                                .ForMember(t => t.PrecioCatalogo, f => f.MapFrom(c => c.PrecioCatalogo))
                                .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                                .ForMember(t => t.StockInicial, f => f.MapFrom(c => c.StockInicial))
                                .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                                .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                                .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                                .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                                .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal))
                                .ForMember(t => t.CategoriaID, f => f.MapFrom(c => c.CategoriaID))
                                .ForMember(t => t.DescripcionProducto1, f => f.MapFrom(c => c.DescripcionProducto1))
                                .ForMember(t => t.DescripcionProducto2, f => f.MapFrom(c => c.DescripcionProducto2))
                                .ForMember(t => t.DescripcionProducto3, f => f.MapFrom(c => c.DescripcionProducto3))
                                .ForMember(t => t.ImagenProducto1, f => f.MapFrom(c => c.ImagenProducto1))
                                .ForMember(t => t.ImagenProducto2, f => f.MapFrom(c => c.ImagenProducto2))
                                .ForMember(t => t.ImagenProducto3, f => f.MapFrom(c => c.ImagenProducto3))
                                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID));

                            ShowRoomEventoModel showRoomEventoModel = Mapper.Map<BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
                            showRoomEventoModel.Simbolo = userData.Simbolo;

                            var listaShowRoomOfertaModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOferta);

                            listaShowRoomOfertaModel.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

                            showRoomEventoModel.ListaShowRoomOferta = listaShowRoomOfertaModel;

                            return View(showRoomEventoModel);
                        }
                        else
                        {
                            return RedirectToAction("Index", "Bienvenida");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult AdministrarShowRoom()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ShowRoom/AdministrarShowRoom"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                var userData = UserData();
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

        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            //PaisID = 11;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ConfiguracionOfertaModel> lstConfig = DropDowListConfiguracion(PaisID);
            return Json(new
            {
                lista = lst,
                lstConfig = lstConfig
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ConsultarShowRoom(int campaniaID)
        {
            var userData = UserData();

            try
            {
                var showRoomEvento = new BEShowRoomEvento();

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    showRoomEvento = sv.GetShowRoomEventoByCampaniaID(userData.PaisID, campaniaID);
                }

                if (showRoomEvento == null)
                {
                    return Json(new
                    {
                        success = true,
                        message = "No existe ShowRoom para la campaña seleccionada.",
                        data = "-1"
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        message = "ShowRoom obtenido satisfactoriamente.",
                        data = showRoomEvento
                    });
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }

        }

        public JsonResult GuardarShowRoom(ShowRoomEventoModel showRoomEventoModel)
        {
            var userData = UserData();

            try
            {
                Mapper.CreateMap<ShowRoomEventoModel, BEShowRoomEvento>()
                .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.Imagen1, f => f.MapFrom(c => c.Imagen1))
                .ForMember(t => t.Imagen2, f => f.MapFrom(c => c.Imagen2))
                .ForMember(t => t.Descuento, f => f.MapFrom(c => c.Descuento))
                .ForMember(t => t.OfertaEstrategia, f => f.MapFrom(c => c.OfertaEstrategia))
                .ForMember(t => t.TextoEstrategia, f => f.MapFrom(c => c.TextoEstrategia));

                BEShowRoomEvento beShowRoomEvento = Mapper.Map<ShowRoomEventoModel, BEShowRoomEvento>(showRoomEventoModel);

                if (beShowRoomEvento.EventoID == 0)
                {
                    var idEventoNuevo = 0;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        beShowRoomEvento.UsuarioCreacion = userData.CodigoConsultora;
                        idEventoNuevo = sv.InsertShowRoomEvento(userData.PaisID, beShowRoomEvento);
                    }

                    return Json(new
                    {
                        success = true,
                        message = "ShowRoom Agregado correctamente",
                        data = idEventoNuevo
                    });
                }
                else
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        beShowRoomEvento.UsuarioModificacion = userData.CodigoConsultora;
                        sv.UpdateShowRoomEvento(userData.PaisID, beShowRoomEvento);
                    }

                    return Json(new
                    {
                        success = true,
                        message = "ShowRoom Modificado correctamente",
                        data = beShowRoomEvento.EventoID
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        [HttpPost]
        public string CargarMasivaConsultora(HttpPostedFileBase flCargarConsultoras, int hdCargaEventoID, int hdCargaCampaniaID)
        {
            string message = string.Empty;
            int registros = 0;
            var userData = UserData();

            try
            {
                #region Procesar Carga Masiva Consultoras Archivo CSV

                string finalPath = string.Empty;
                List<BEShowRoomEventoConsultora> listaConsultoras = new List<BEShowRoomEventoConsultora>();

                if (flCargarConsultoras != null)
                {
                    string fileName = Path.GetFileName(flCargarConsultoras.FileName);
                    string extension = Path.GetExtension(flCargarConsultoras.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileShowRoomCargaConsultora");

                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    finalPath = Path.Combine(pathFile, newfileName);
                    flCargarConsultoras.SaveAs(finalPath);

                    string inputLine = "";

                    string[] values = null;

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                BEShowRoomEventoConsultora ent = new BEShowRoomEventoConsultora();
                                ent.EventoID = hdCargaEventoID;
                                ent.CampaniaID = hdCargaCampaniaID;
                                ent.CodigoConsultora = values[0].Trim();
                                ent.Segmento = values[1].Trim();
                                ent.UsuarioCreacion = userData.CodigoConsultora;
                                ent.FechaCreacion = DateTime.Now;
                                ent.FechaModificacion = DateTime.Now;
                                listaConsultoras.Add(ent);
                            }
                        }
                    }

                    if (listaConsultoras.Count > 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            int paisID = userData.PaisID;
                            if (paisID > 0)
                            {
                                try
                                {
                                    registros += sv.CargarMasivaConsultora(paisID, listaConsultoras.ToArray());
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
                #endregion

                if (registros > 0)
                {
                    message = "Se realizó la carga de " + registros + " consultora(s)";
                }
                else
                {
                    message = "No se actualizó ninguna carga de las consultoras que estaban dentro del archivo (CSV), verifique que el código sea correcto.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " consultora(s).";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " consultora(s).";
            }

            return message;
        }

        [HttpPost]
        public string ActualizarStockMasivo(HttpPostedFileBase flStock)
        {
            var userData = UserData();
            string message = string.Empty;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV
                string finalPath = string.Empty;
                List<BEShowRoomOferta> lstStock = new List<BEShowRoomOferta>();

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

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                if (IsNumeric(values[1].Trim()) && IsNumeric(values[3].Trim()))
                                {
                                    BEShowRoomOferta ent = new BEShowRoomOferta();
                                    ent.ISOPais = values[0].Trim();
                                    ent.CampaniaID = int.Parse(values[1]);
                                    ent.CUV = values[2].Trim();
                                    ent.Stock = int.Parse(values[3].Trim());
                                    if (ent.Stock >= 0)
                                        lstStock.Add(ent);
                                }
                            }
                        }
                    }
                    if (lstStock.Count > 0)
                    {
                        lstStock.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom);
                        List<BEShowRoomOferta> lstPaises = lstStock.GroupBy(x => x.ISOPais).Select(g => g.First()).ToList();

                        for (int i = 0; i < lstPaises.Count; i++)
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                List<BEShowRoomOferta> lstStockTemporal = lstStock.FindAll(x => x.ISOPais == lstPaises[i].ISOPais);
                                int paisID = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisID > 0)
                                {
                                    try
                                    {
                                        registros += sv.UpdOfertaShowRoomStockMasivo(paisID, lstStockTemporal.ToArray());
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
                    message = "Se realizó la actualización de stock de " + registros + " Productos";
                else
                    message = "No se actualizó el stock de ninguno de los productos que estaban dentro del archivo (CSV), verifique el Tipo de Oferta.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizó el stock solo de " + registros + " registros, debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizó el stock solo de " + registros + " registros, debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
            }
            return message;
        }

        [HttpPost]
        public JsonResult UpdatePopupShowRoom(bool noMostrarPopup)
        {
            var userData = UserData();

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.UpdateShowRoomConsultoraMostrarPopup(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora, !noMostrarPopup);
                }

                return Json(new
                {
                    success = true,
                    message = "Actualizado correctamente",
                    data = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        public ActionResult ConsultarOfertaShowRoom(string sidx, string sord, int page, int rows, int PaisID, string codigoOferta, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEShowRoomOferta> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosShowRoom(PaisID, Constantes.ConfiguracionOferta.ShowRoom, CampaniaID, codigoOferta).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEShowRoomOferta> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "TipoOferta":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderBy(x => x.CodigoProducto);
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
                        case "UnidadesPermitidas":
                            items = lst.OrderBy(x => x.UnidadesPermitidas);
                            break;
                        case "DescripcionProducto1":
                            items = lst.OrderBy(x => x.DescripcionProducto1);
                            break;
                        case "DescripcionProducto2":
                            items = lst.OrderBy(x => x.DescripcionProducto2);
                            break;
                        case "DescripcionProducto3":
                            items = lst.OrderBy(x => x.DescripcionProducto3);
                            break;
                        case "ImagenProducto1":
                            items = lst.OrderBy(x => x.ImagenProducto1);
                            break;
                        case "ImagenProducto2":
                            items = lst.OrderBy(x => x.ImagenProducto2);
                            break;
                        case "ImagenProducto3":
                            items = lst.OrderBy(x => x.ImagenProducto3);
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
                        case "CodigoProducto":
                            items = lst.OrderByDescending(x => x.CodigoProducto);
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
                        case "UnidadesPermitidas":
                            items = lst.OrderByDescending(x => x.UnidadesPermitidas);
                            break;
                        case "DescripcionProducto1":
                            items = lst.OrderBy(x => x.DescripcionProducto1);
                            break;
                        case "DescripcionProducto2":
                            items = lst.OrderBy(x => x.DescripcionProducto2);
                            break;
                        case "DescripcionProducto3":
                            items = lst.OrderBy(x => x.DescripcionProducto3);
                            break;
                        case "ImagenProducto1":
                            items = lst.OrderBy(x => x.ImagenProducto1);
                            break;
                        case "ImagenProducto2":
                            items = lst.OrderBy(x => x.ImagenProducto2);
                            break;
                        case "ImagenProducto3":
                            items = lst.OrderBy(x => x.ImagenProducto3);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);
                string ISO = Util.GetPaisISO(PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO;
                lst.Update(x => x.ImagenProducto = (x.ImagenProducto.ToString().Equals(string.Empty) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + ISO)));
                lst.Update(x => x.ISOPais = ISO);
                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.NroOrden,
                               cell = new[] 
                               {
                                   a.TipoOferta,
                                   a.CodigoProducto,
                                   a.CodigoCampania,
                                   a.CUV,
                                   a.Descripcion,
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.Orden.ToString(),
                                   a.Stock.ToString(),
                                   a.StockInicial.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.DescripcionProducto1,
                                   a.DescripcionProducto2,
                                   a.DescripcionProducto3,
                                   a.ImagenProducto1,
                                   a.ImagenProducto2,
                                   a.ImagenProducto3,
                                   a.ImagenProducto,
                                   a.CampaniaID.ToString() ,
                                   a.Stock.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaShowRoomID.ToString(),
                                   a.CodigoTipoOferta.Trim(),
                                   a.ISOPais.ToString(),
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.CodigoProducto                                   
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult ObtenerImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            var userData = UserData();

            List<BEMatrizComercial> lst = new List<BEMatrizComercial>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCodigoSAP(paisID, codigoSAP).ToList();
            }

            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            if (lst != null && lst.Count > 0)
            {
                if (lst[0].FotoProducto01 != "")
                    lst[0].FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto01, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                if (lst[0].FotoProducto02 != "")
                    lst[0].FotoProducto02 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto02, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                if (lst[0].FotoProducto03 != "")
                    lst[0].FotoProducto03 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto03, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
            }
            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarPriorizacion(int paisID, string codigoOferta, int CampaniaID, int Orden)
        {
            int FlagExiste = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
                FlagExiste = sv.ValidarPriorizacionShowRoom(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
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
                Orden = sv.GetOrdenPriorizacionShowRoom(paisID, ConfiguracionOfertaID, CampaniaID);
            }

            return Json(new
            {
                Orden = Orden
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertOfertaShowRoom(ShowRoomOfertaModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<ShowRoomOfertaModel, BEShowRoomOferta>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                    .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta))
                    .ForMember(t => t.DescripcionProducto1, f => f.MapFrom(c => c.DescripcionProducto1))
                    .ForMember(t => t.DescripcionProducto2, f => f.MapFrom(c => c.DescripcionProducto2))
                    .ForMember(t => t.DescripcionProducto3, f => f.MapFrom(c => c.DescripcionProducto3))
                    .ForMember(t => t.ImagenProducto1, f => f.MapFrom(c => c.ImagenProducto1))
                    .ForMember(t => t.ImagenProducto2, f => f.MapFrom(c => c.ImagenProducto2))
                    .ForMember(t => t.ImagenProducto3, f => f.MapFrom(c => c.ImagenProducto3));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;
                    sv.InsOfertaShowRoom(userData.PaisID, entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se insertó la Oferta ShowRoom satisfactoriamente.",
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
        public JsonResult UpdateOfertaShowRoom(ShowRoomOfertaModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<ShowRoomOfertaModel, BEShowRoomOferta>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                    .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta))
                    .ForMember(t => t.DescripcionProducto1, f => f.MapFrom(c => c.DescripcionProducto1))
                    .ForMember(t => t.DescripcionProducto2, f => f.MapFrom(c => c.DescripcionProducto2))
                    .ForMember(t => t.DescripcionProducto3, f => f.MapFrom(c => c.DescripcionProducto3))
                    .ForMember(t => t.ImagenProducto1, f => f.MapFrom(c => c.ImagenProducto1))
                    .ForMember(t => t.ImagenProducto2, f => f.MapFrom(c => c.ImagenProducto2))
                    .ForMember(t => t.ImagenProducto3, f => f.MapFrom(c => c.ImagenProducto3));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;

                    sv.UpdOfertaShowRoom(userData.PaisID, entidad);

                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Show Room satisfactoriamente.",
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
        public JsonResult DeshabilitarOfertaShowRoom(ShowRoomOfertaModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<ShowRoomOfertaModel, BEShowRoomOferta>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                    .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    sv.DelOfertaShowRoom(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito la Oferta de Show Room satisfactoriamente.",
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
        public JsonResult RemoverOfertaShowRoom(ShowRoomOfertaModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<ShowRoomOfertaModel, BEShowRoomOferta>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                    .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    sv.RemoverOfertaShowRoom(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se eliminó la Oferta de Show Room satisfactoriamente.",
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

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV)
        {
            var userData = UserData();
            int UnidadesPermitidas = 0;
            int Saldo = 0;
            /* 2024 - Inicio */
            int CantidadPedida = 0;
            var entidad = new BEOfertaProducto();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.CUV = CUV;
            entidad.ConsultoraID = Convert.ToInt32(userData.ConsultoraID);

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                UnidadesPermitidas = sv.GetUnidadesPermitidasByCuvShowRoom(userData.PaisID, userData.CampaniaID, CUV);
                Saldo = sv.ValidarUnidadesPermitidasEnPedidoShowRoom(userData.PaisID, userData.CampaniaID, CUV, userData.ConsultoraID);
                CantidadPedida = sv.CantidadPedidoByConsultoraShowRoom(entidad);
            }

            return Json(new
            {
                UnidadesPermitidas,
                Saldo,
                CantidadPedida
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerStockActualProducto(string CUV)
        {
            var userData = UserData();
            int Stock = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Stock = sv.GetStockOfertaShowRoom(userData.PaisID, userData.CampaniaID, CUV);
            }

            return Json(new
            {
                Stock
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<PedidoDetalleModel, BEPedidoWebDetalle>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                    .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                    .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad))
                    .ForMember(t => t.PrecioUnidad, f => f.MapFrom(c => c.PrecioUnidad))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                    .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID));


                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    entidad.IPUsuario = userData.IPUsuario;

                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;

                    sv.InsPedidoWebDetalleOferta(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se agregó la Oferta Web satisfactoriamente.",
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;

            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            var userData = UserData();
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (userData.RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(userData.PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                    .ForMember(t => t.Anio, f => f.MapFrom(c => c.Anio))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Activo, f => f.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisID)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisID, Constantes.ConfiguracionOferta.ShowRoom).ToList();
                lst = lstConfiguracion;
            }
            Mapper.CreateMap<BEConfiguracionOferta, ConfiguracionOfertaModel>()
                    .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                    .ForMember(t => t.CodigoOferta, f => f.MapFrom(c => c.CodigoOferta))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        }

        private string GetDescripcionMarca(int marcaId)
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
                case 4:
                    result = "S&M";
                    break;
                case 5:
                    result = "Home Collection";
                    break;
                case 6:
                    result = "Finart";
                    break;
                case 7:
                    result = "Generico";
                    break;
                case 8:
                    result = "Glance";
                    break;
                default:
                    result = "NO DISPONIBLE";
                    break;
            }

            return result;
        }
    }
}
