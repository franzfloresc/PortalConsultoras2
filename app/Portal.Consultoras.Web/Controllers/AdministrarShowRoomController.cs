﻿using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarShowRoomController : BaseController
    {
        protected OfertaBaseProvider _ofertaBaseProvider;

        public AdministrarShowRoomController()
        {
            _ofertaBaseProvider = new OfertaBaseProvider();
        }

        public JsonResult ConsultarShowRoom(string sidx, string sord, int page, int rows, int paisId, int campaniaId, string tipoEstrategiaCodigo)
        {
            try
            {
                ShowRoomEventoModelo showRoomEvento;
                var listaShowRoomEvento = new List<ShowRoomEventoModelo>();

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCodigo))
                {
                    var l = administrarEstrategiaProvider.ConsultarShowRoom(userData.CodigoISO, campaniaId);

                    showRoomEvento = l.Count > 0 ? l.FirstOrDefault() : null;
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        ServicePedido.BEShowRoomEvento serviceShowRoomEvento = sv.GetShowRoomEventoByCampaniaID(userData.PaisID, campaniaId);

                        string stringShowRoomEvento = JsonConvert.SerializeObject(serviceShowRoomEvento);

                        showRoomEvento = JsonConvert.DeserializeObject<ShowRoomEventoModelo>(stringShowRoomEvento);
                    }
                }

                if (showRoomEvento != null)
                {
                    var iso = Util.GetPaisISO(paisId);

                    showRoomEvento.Imagen1 = ConfigCdn.GetUrlFileCdnMatriz(iso, showRoomEvento.Imagen1);
                    showRoomEvento.Imagen2 = ConfigCdn.GetUrlFileCdnMatriz(iso, showRoomEvento.Imagen2);
                    showRoomEvento.ImagenCabeceraProducto = ConfigCdn.GetUrlFileCdnMatriz(iso, showRoomEvento.ImagenCabeceraProducto);
                    showRoomEvento.ImagenVentaSetPopup = ConfigCdn.GetUrlFileCdnMatriz(iso, showRoomEvento.ImagenVentaSetPopup);
                    showRoomEvento.ImagenVentaTagLateral = ConfigCdn.GetUrlFileCdnMatriz(iso, showRoomEvento.ImagenVentaTagLateral);
                    showRoomEvento.ImagenPestaniaShowRoom = ConfigCdn.GetUrlFileCdnMatriz(iso, showRoomEvento.ImagenPestaniaShowRoom);
                    showRoomEvento.ImagenPreventaDigital = ConfigCdn.GetUrlFileCdnMatriz(iso, showRoomEvento.ImagenPreventaDigital);

                    listaShowRoomEvento.Add(showRoomEvento);
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<ShowRoomEventoModelo> items = listaShowRoomEvento;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "EventoID":
                            items = listaShowRoomEvento.OrderBy(x => x.EventoID);
                            break;
                        case "Nombre":
                            items = listaShowRoomEvento.OrderBy(x => x.Nombre);
                            break;
                        case "Tema":
                            items = listaShowRoomEvento.OrderBy(x => x.Tema);
                            break;
                        case "DiasAntes":
                            items = listaShowRoomEvento.OrderBy(x => x.DiasAntes);
                            break;
                        case "DiasDespues":
                            items = listaShowRoomEvento.OrderBy(x => x.DiasDespues);
                            break;
                        case "NumeroPerfiles":
                            items = listaShowRoomEvento.OrderBy(x => x.NumeroPerfiles);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "EventoID":
                            items = listaShowRoomEvento.OrderByDescending(x => x.EventoID);
                            break;
                        case "Nombre":
                            items = listaShowRoomEvento.OrderByDescending(x => x.Nombre);
                            break;
                        case "Tema":
                            items = listaShowRoomEvento.OrderByDescending(x => x.Tema);
                            break;
                        case "DiasAntes":
                            items = listaShowRoomEvento.OrderByDescending(x => x.DiasAntes);
                            break;
                        case "DiasDespues":
                            items = listaShowRoomEvento.OrderByDescending(x => x.DiasDespues);
                            break;
                        case "NumeroPerfiles":
                            items = listaShowRoomEvento.OrderByDescending(x => x.NumeroPerfiles);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, listaShowRoomEvento);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.EventoID,
                               a.Nombre,
                               a.Tema,
                               DiasAntes = a.DiasAntes.ToString(),
                               DiasDespues = a.DiasDespues.ToString(),
                               NumeroPerfiles = a.NumeroPerfiles.ToString(),
                               a.Imagen1,
                               a.Imagen2,
                               a.ImagenCabeceraProducto,
                               a.ImagenVentaSetPopup,
                               a.ImagenVentaTagLateral,
                               a.ImagenPestaniaShowRoom,
                               a.ImagenPreventaDigital,
                               CampaniaID = a.CampaniaID.ToString(),
                               Descuento = a.Descuento.ToString(),
                               a.TextoEstrategia,
                               OfertaEstrategia = a.OfertaEstrategia.ToString(),
                               Estado = a.Estado.ToString(),
                               TieneCategoria = a.TieneCategoria.ToString(),
                               TieneCompraXcompra = a.TieneCompraXcompra.ToString(),
                               TieneSubCampania = a.TieneSubCampania.ToString(),
                               TienePersonalizacion = a.TienePersonalizacion,
                               PersonalizacionNivel = JsonConvert.SerializeObject(a.PersonalizacionNivel),
                               _id = a._id
                           }
                };

                return Json(data, JsonRequestBehavior.AllowGet);
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
        public JsonResult GetShowRoomNiveles()
        {
            try
            {
                List<ShowRoomNivelModel> listaShowRoomNivel = null;

                _showRoomProvider.CargarNivelShowRoom(userData);
                configEstrategiaSR = SessionManager.GetEstrategiaSR();
                listaShowRoomNivel = configEstrategiaSR.ListaNivel ?? new List<ShowRoomNivelModel>();


                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaShowRoomNivel
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

        public JsonResult GuardarShowRoom(ShowRoomEventoModel showRoomEventoModel, string TipoEstrategiaCodigo)
        {
            try
            {
                ServicePedido.BEShowRoomEvento beShowRoomEvento = Mapper.Map<ShowRoomEventoModel, ServicePedido.BEShowRoomEvento>(showRoomEventoModel);

                if (beShowRoomEvento.EventoID == 0)
                {
                    int idEventoNuevo;
                    beShowRoomEvento.UsuarioCreacion = userData.CodigoConsultora;

                    if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, TipoEstrategiaCodigo))
                    {
                        idEventoNuevo = administrarEstrategiaProvider.GuardarShowRoom(showRoomEventoModel);
                    }
                    else
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            idEventoNuevo = sv.InsertShowRoomEvento(userData.PaisID, beShowRoomEvento);
                        }
                    }

                    return Json(new
                    {
                        success = true,
                        message = "ShowRoom Agregado correctamente",
                        data = idEventoNuevo
                    });
                }

                beShowRoomEvento.UsuarioModificacion = userData.CodigoConsultora;

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, TipoEstrategiaCodigo))
                {
                    administrarEstrategiaProvider.UpdateShowRoomEvento(showRoomEventoModel);
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        sv.UpdateShowRoomEvento(userData.PaisID, beShowRoomEvento);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "ShowRoom Modificado correctamente",
                    data = beShowRoomEvento.EventoID
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

        [HttpPost]
        public JsonResult DeshabilitarShowRoomEvento(int campaniaId, int eventoId, string tipoEstrategiaCodigo, string id)
        {
            try
            {
                var beShowRoomEvento = new ServicePedido.BEShowRoomEvento
                {
                    UsuarioModificacion = userData.CodigoConsultora,
                    CampaniaID = campaniaId,
                    EventoID = eventoId
                };

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCodigo))
                {
                    administrarEstrategiaProvider.DeshabilitarShowRoomEvento(id);
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        sv.DeshabilitarShowRoomEvento(userData.PaisID, beShowRoomEvento);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito el Evento ShowRoom satisfactoriamente.",
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
        public JsonResult EliminarShowRoomEvento(int campaniaId, int eventoId, string tipoEstrategiaCodigo, string id)
        {
            try
            {
                var beShowRoomEvento = new ServicePedido.BEShowRoomEvento
                {
                    CampaniaID = campaniaId,
                    EventoID = eventoId
                };

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCodigo))
                {
                    administrarEstrategiaProvider.EliminarShowRoomEvento(id);
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        sv.EliminarShowRoomEvento(userData.PaisID, beShowRoomEvento);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino el Evento ShowRoom satisfactoriamente.",
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
        public string CargarProductoCpc(HttpPostedFileBase flCargarProductoCpc, int hdCargarProductoCpcEventoId,
            int hdCargarProductoCpcCampaniaId)
        {
            string message;
            int registros = 0;

            try
            {
                #region Procesar Carga Masiva Consultoras Archivo CSV

                var listaProductoCpc = new List<BEShowRoomCompraPorCompra>();

                if (flCargarProductoCpc != null)
                {
                    string extension = Path.GetExtension(flCargarProductoCpc.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileShowRoomCargaConsultora");

                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    var finalPath = Path.Combine(pathFile, newfileName);
                    flCargarProductoCpc.SaveAs(finalPath);

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath, Encoding.GetEncoding("iso-8859-1")))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            var values = inputLine.Split('|');
                            if (values.Length > 1)
                            {
                                var ent = new BEShowRoomCompraPorCompra
                                {
                                    CUV = values[0].Trim().Replace("\"", ""),
                                    SAP = values[1].Replace("\"", "0"),
                                    Orden = values[2].Trim().Replace("\"", "").ToInt(),
                                    PrecioValorizado = decimal.Parse(values[3].Trim().Replace("\"", ""))
                                };

                                listaProductoCpc.Add(ent);
                            }
                        }
                    }

                    if (listaProductoCpc.Count > 0)
                    {
                        int paisId = userData.PaisID;
                        if (paisId > 0)
                        {
                            using (var sv = new PedidoServiceClient())
                            {
                                try
                                {
                                    registros += sv.CargarProductoCpc(paisId, hdCargarProductoCpcEventoId,
                                        userData.CodigoConsultora, listaProductoCpc.ToArray());
                                }
                                catch (FaultException ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora,
                                        userData.CodigoISO);
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora,
                                        userData.CodigoISO);
                                }
                            }
                        }
                    }
                }
                #endregion

                if (registros > 0)
                {
                    message = "Se realizó la carga de " + registros + " producto(s) de Compra por Compra";
                }
                else
                {
                    message = "No se actualizó ninguna carga de las consultoras que estaban dentro del archivo (CSV), verifique que el código sea correcto.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " set(s).";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " set(s).";
            }

            return message;
        }

        [HttpPost]
        public JsonResult GetShowRoomPersonalizacionNivel(int eventoId, int nivelId, string lstPersonalizacion = null)
        {
            try
            {

                List<ShowRoomPersonalizacionModel> listaPersonalizacionModel = null;
                string iso = Util.GetPaisISO(userData.PaisID);

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
                {
                    listaPersonalizacionModel = JsonConvert.DeserializeObject<List<ShowRoomPersonalizacionModel>>(lstPersonalizacion);

                    listaPersonalizacionModel.Where(c => c.TipoAtributo.Trim() == "IMAGEN").Update(
                         c =>
                         {
                             c.Valor = ConfigCdn.GetUrlFileCdnMatriz(iso, c.Valor);
                             c.PersonalizacionNivelId = 999999;
                         });
                    listaPersonalizacionModel = listaPersonalizacionModel.OrderBy(x => x.TipoAplicacion).ThenBy(x => x.Orden).ToList();
                }
                else
                {
                    listaPersonalizacionModel = configEstrategiaSR.ListaPersonalizacionConsultora.Where(
                            p => p.TipoPersonalizacion == Constantes.ShowRoomPersonalizacion.TipoPersonalizacion.Evento).ToList();

                    List<ServicePedido.BEShowRoomPersonalizacionNivel> listaPersonalizacionNivel;

                    using (var ps = new PedidoServiceClient())
                    {
                        listaPersonalizacionNivel = ps.GetShowRoomPersonalizacionNivel(userData.PaisID, eventoId, nivelId, 0).ToList();

                    }

                    foreach (var item in listaPersonalizacionModel)
                    {
                        var personalizacionnivel =
                            listaPersonalizacionNivel.FirstOrDefault(p => p.NivelId == nivelId && p.EventoID == eventoId &&
                                    p.PersonalizacionId == item.PersonalizacionId);

                        if (personalizacionnivel != null)
                        {
                            item.PersonalizacionNivelId = personalizacionnivel.PersonalizacionNivelId;
                            item.Valor = personalizacionnivel.Valor;

                            if (item.TipoAtributo == "IMAGEN")
                            {
                                item.Valor = ConfigCdn.GetUrlFileCdnMatriz(iso, item.Valor);
                            }
                        }
                        else
                        {
                            item.PersonalizacionNivelId = 0;
                            item.Valor = "";
                        }
                    }
                }
                return Json(new
                {
                    success = true,
                    message = "Ok",
                    listaPersonalizacion = listaPersonalizacionModel,
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

        [HttpPost]
        public JsonResult GuardarPersonalizacionNivelShowRoom(List<ShowRoomPersonalizacionNivelModel> lista, string eventoId = null, string _id = null, string lstPersonalizacion = null)
        {
            try
            {
                var listaPersonalizacionAux = string.Empty;
                var listaFinal = new List<ShowRoomPersonalizacionNivelModel>();
                foreach (var model in lista)
                {
                    model.Valor = Util.Trim(model.Valor);
                    model.ValorAnterior = Util.Trim(model.ValorAnterior);

                    if (model.EsImagen)
                    {
                        string imagenProductoFinal = GuardarImagenAmazon(model.Valor, model.ValorAnterior, userData.PaisID);
                        model.Valor = imagenProductoFinal;
                    }

                    if (model.Valor != model.ValorAnterior)
                    {
                        listaFinal.Add(model);
                    }
                }

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
                {
                    List<ShowRoomPersonalizacionModel> listaPersonalizacionModel =
                            JsonConvert.DeserializeObject<List<ShowRoomPersonalizacionModel>>(lstPersonalizacion);

                    foreach (var item in listaFinal)
                    {
                        listaPersonalizacionModel.Where(x => x.PersonalizacionId == item.PersonalizacionId).Update(c => c.Valor = item.Valor);
                    }
                    administrarEstrategiaProvider.RegistrarEventoPersonalizacion(userData.CodigoISO, eventoId, _id, listaPersonalizacionModel);
                    listaPersonalizacionAux = JsonConvert.SerializeObject(listaPersonalizacionModel);
                }
                else
                {
                    var listaEntidades = Mapper.Map<IList<ShowRoomPersonalizacionNivelModel>, IList<ServicePedido.BEShowRoomPersonalizacionNivel>>(listaFinal);

                    foreach (var entidad in listaEntidades)
                    {
                        using (PedidoServiceClient ps = new PedidoServiceClient())
                        {
                            if (entidad.PersonalizacionNivelId == 0)
                            {
                                ps.InsertShowRoomPersonalizacionNivel(userData.PaisID, entidad);
                            }
                            else
                            {
                                ps.UpdateShowRoomPersonalizacionNivel(userData.PaisID, entidad);
                            }
                        }
                    }
                }
                return Json(new
                {
                    success = true,
                    message = "Se insertó las personalizaciones satisfactoriamente.",
                    extra = "",
                    personalizacionMod = listaPersonalizacionAux
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = "",
                    personalizacionMod = string.Empty
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = "",
                    personalizacionMod = string.Empty
                });
            }
        }

        public ActionResult ConsultarOfertaShowRoomDetalleNew(string sidx, string sord, int page, int rows, string estrategiaId,
            string codigoTipoEstrategia = null)
        {
            if (ModelState.IsValid)
            {
                List<ServicePedido.BEEstrategiaProducto> lst;

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, codigoTipoEstrategia, false) && 
                    Constantes.TipoEstrategiaCodigo.ArmaTuPack == codigoTipoEstrategia)
                {
                    lst = administrarEstrategiaProvider.FiltrarEstrategia(estrategiaId, userData.CodigoISO)
                        .Select(x => x.Componentes)
                        .FirstOrDefault();
                }
                else
                {
                    var estrategiaX = new BEEstrategia() { PaisID = userData.PaisID, EstrategiaID = Int32.Parse(estrategiaId) };

                    using (var sv = new PedidoServiceClient())
                    {
                        lst = sv.GetEstrategiaProducto(estrategiaX).ToList();
                    }
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<ServicePedido.BEEstrategiaProducto> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "NombreProducto":
                            items = lst.OrderBy(x => x.NombreProducto);
                            break;
                        case "Descripcion1":
                            items = lst.OrderBy(x => x.Descripcion1);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "NombreProducto":
                            items = lst.OrderBy(x => x.NombreProducto);
                            break;
                        case "Descripcion1":
                            items = lst.OrderBy(x => x.Descripcion1);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                string iso = Util.GetPaisISO(userData.PaisID);

                lst.Update(x => x.ImagenProducto = ConfigCdn.GetUrlFileCdnMatriz(iso, x.ImagenProducto));

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.EstrategiaProductoID,
                               cell = new[]
                                {
                                    a.EstrategiaProductoID.ToString(),
                                    a.EstrategiaID.ToString(),
                                    a.Campania.ToString(),
                                    a.CUV,
                                    a.NombreProducto,
                                    a.Descripcion1,
                                    a.ImagenProducto,
                                    a.IdMarca.ToString(),
                                    a.Precio.ToString(),
                                    a.PrecioValorizado.ToString(),
                                    a.Activo.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }


        [HttpPost]
        public JsonResult EliminarOfertaShowRoomDetalleAllNew(int estrategiaId)
        {
            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    sv.EliminarEstrategiaProductoAll(userData.PaisID, estrategiaId, userData.CodigoConsultora);
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino todos los Productos del set satisfactoriamente.",
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
        public JsonResult EliminarOfertaShowRoomDetalleNew(int estrategiaId, string cuv)
        {
            try
            {
                var entidad = new ServicePedido.BEEstrategiaProducto
                {
                    PaisID = userData.PaisID,
                    EstrategiaID = estrategiaId,
                    CUV = cuv
                };

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
                {
                    administrarEstrategiaProvider.EliminarOfertaShowRoomDetalleNew(estrategiaId, cuv);
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        sv.EliminarEstrategiaProducto(entidad);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino el Producto satisfactoriamente.",
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
        public JsonResult InsertOfertaShowRoomDetalleNew(EstrategiaProductoModel model)
        {
            try
            {
                var entidad = Mapper.Map<EstrategiaProductoModel, ServicePedido.BEEstrategiaProducto>(model);

                entidad.PaisID = userData.PaisID;
                entidad.UsuarioModificacion = userData.CodigoConsultora;
                entidad.ImagenProducto = GuardarImagenAmazon(model.ImagenProducto, model.ImagenAnterior, userData.PaisID);

                List<ServicePedido.BEEstrategiaProducto> lstProd;
                var estrategiaX = new ServicePedido.BEEstrategia() { PaisID = userData.PaisID, EstrategiaID = model.EstrategiaID };

                using (var sv = new PedidoServiceClient())
                {
                    lstProd = sv.GetEstrategiaProducto(estrategiaX).ToList();
                }

                var existe = false;
                if (lstProd.Any())
                {
                    var objx = lstProd.FirstOrDefault(x => x.CUV == model.CUV && x.Activo == 1);
                    existe = objx != null;
                }

                if (!existe)
                {
                    var entidadx = new ServicePedido.BEEstrategia { CampaniaID = entidad.Campania, CUV2 = entidad.CUV2 };
                    var respuestaServiceCdr = EstrategiaProductoObtenerServicio(entidadx);

                    if (respuestaServiceCdr.Any())
                    {
                        var objProd = respuestaServiceCdr.FirstOrDefault(x => x.cuv == entidad.CUV);
                        if (objProd != null)
                        {
                            entidad.CodigoEstrategia = objProd.codigo_estrategia;
                            entidad.Grupo = objProd.grupo;
                            entidad.Orden = objProd.orden;
                            entidad.SAP = objProd.codigo_sap;
                            entidad.Cantidad = objProd.cantidad;
                            entidad.Precio = objProd.precio_unitario;
                            entidad.PrecioValorizado = objProd.precio_valorizado;
                            entidad.Digitable = Convert.ToInt16(objProd.digitable);
                            entidad.FactorCuadre = objProd.factor_cuadre;
                            entidad.IdMarca = objProd.idmarca;

                            using (var sv = new PedidoServiceClient())
                            {
                                sv.InsertarEstrategiaProducto(entidad);
                            }

                            return Json(new
                            {
                                success = true,
                                message = "Se insertó el Producto satisfactoriamente.",
                                extra = ""
                            });
                        }
                    }
                }

                return Json(new
                {
                    success = false,
                    message = "No se pudo insertar el Producto, vuelva a intentar.",
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
        public JsonResult UpdateOfertaShowRoomDetalleNew(EstrategiaProductoModel model)
        {
            try
            {
                var entidad = Mapper.Map<EstrategiaProductoModel, ServicePedido.BEEstrategiaProducto>(model);

                entidad.PaisID = userData.PaisID;
                entidad.UsuarioModificacion = userData.CodigoConsultora;
                entidad.ImagenProducto = GuardarImagenAmazon(model.ImagenProducto, model.ImagenAnterior, userData.PaisID);

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
                {
                    model.ImagenProducto = entidad.ImagenProducto;
                    administrarEstrategiaProvider.UpdateOfertaShowRoomDetalleNew(model);
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        sv.ActualizarEstrategiaProducto(entidad);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó el Producto satisfactoriamente.",
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

        private string GuardarImagenAmazon(string nombreImagen, string nombreImagenAnterior, int paisId, bool keepFile = false)
        {
            string nombreImagenFinal;
            nombreImagen = nombreImagen ?? "";
            nombreImagenAnterior = nombreImagenAnterior ?? "";

            if (nombreImagen != nombreImagenAnterior)
            {
                string iso = Util.GetPaisISO(paisId);
                string carpetaPais = Globals.UrlMatriz + "/" + iso;

                string soloImagen = nombreImagen.Split('.')[0];
                string soloExtension = nombreImagen.Split('.')[1];
                string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                nombreImagenFinal = iso + "_" + soloImagen + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + "." + soloExtension;

                if (nombreImagenAnterior != "") ConfigS3.DeleteFileS3(carpetaPais, nombreImagenAnterior);
                ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, nombreImagen), carpetaPais, nombreImagenFinal, true, !keepFile, false);
            }
            else nombreImagenFinal = nombreImagen;

            return nombreImagenFinal;
        }

        private List<RptProductoEstrategia> EstrategiaProductoObtenerServicio(ServicePedido.BEEstrategia entidad)
        {
            var respuestaServiceCdr = new List<RptProductoEstrategia>();
            try
            {
                var codigo = _tablaLogicaProvider.GetTablaLogicaDatoCodigo(userData.PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.Tonos, true);

                if (Convert.ToInt32(codigo) <= entidad.CampaniaID)
                {
                    using (var sv = new WsGestionWeb())
                    {
                        respuestaServiceCdr = sv.GetEstrategiaProducto(entidad.CampaniaID.ToString(), userData.CodigoConsultora, entidad.CUV2, userData.CodigoISO).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                respuestaServiceCdr = new List<RptProductoEstrategia>();
            }
            return respuestaServiceCdr;
        }

    }
}