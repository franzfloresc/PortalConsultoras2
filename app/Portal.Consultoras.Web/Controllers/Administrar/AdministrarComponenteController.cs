using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarComponenteController : BaseController
    {
        protected OfertaBaseProvider _ofertaBaseProvider;

        public AdministrarComponenteController()
        {
            _ofertaBaseProvider = new OfertaBaseProvider();
        }

        public ActionResult ConsultarSegunEstrategia(string sidx, string sord, int page, int rows, string estrategiaId,
            string codigoTipoEstrategia = null)
        {

            if (ModelState.IsValid)
            {
                 

                List<ServicePedido.BEEstrategiaProducto> lst;
                var palancaMongoPrueba = Constantes.TipoEstrategiaCodigo.ArmaTuPack == codigoTipoEstrategia;
                if (palancaMongoPrueba && _ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, codigoTipoEstrategia, false))
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


                ////INI ATP
                ////Estrategia gruepo
                //var taskApi = Task.Run(() => estrategiaGrupoProvider.ObtenerEstrategiaGrupoApi(string.Format(Constantes.PersonalizacionOfertasService.UrlGetEstrategiaGrupoByEstrategiaId, userData.CodigoISO, estrategiaId), userData));
                //Task.WhenAll(taskApi);
                //var estrategiaGrupoLista = taskApi.Result.Result;

                //foreach (var item in lst)
                //{
                //    int index = estrategiaGrupoLista.ToList().FindIndex(x => x.Grupo.Trim().Equals(item.Grupo.Trim()));
                //    if (index != -1)
                //    {
                //        var find = estrategiaGrupoLista.ToList()[index];
                //        item.DescripcionGrupo = find.DescripcionSingular + " - " + find.DescripcionPlural;
                //    }
                //}
                ////END ATP

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

        // metodo duplicado
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