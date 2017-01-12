using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Common;
using System.ServiceModel;
using Portal.Consultoras.Web.ServiceCliente;

namespace Portal.Consultoras.Web.Controllers
{
    public class PedidoFICController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "PedidoFIC/Index")) return RedirectToAction("Index", "Bienvenida");

                Session["PedidoFIC"] = null;
                ViewBag.ClaseTabla = "tabla2";
                ViewBag.Pais_ISO = UserData().CodigoISO.ToString();
                ViewBag.PROL = "Guardar";
                ViewBag.PROLDes = "Guarda los productos que haz ingresado";
                ViewBag.ModPedido = "display:none;";
                ViewBag.NombreConsultora = UserData().NombreConsultora;
                ViewBag.PedidoFIC = "C" + (CampaniaSiguiente(UserData().CampaniaID).ToString()).Substring(4, 2);
                ViewBag.MensajeFIC ="antes del " + UserData().FechaFinFIC.Day + " de "+ NombreMes(UserData().FechaFinFIC.Month);//1501

                List<BEPedidoFICDetalle> olstPedidoFICDetalle = new List<BEPedidoFICDetalle>();
                olstPedidoFICDetalle = ObtenerPedidoFICDetalle();

                PedidoFICDetalleModel PedidoModelo = new PedidoFICDetalleModel();
                PedidoModelo.PaisID = UserData().PaisID;
                PedidoModelo.ListaDetalle = olstPedidoFICDetalle;
                PedidoModelo.Simbolo = UserData().Simbolo;
                PedidoModelo.Total = string.Format("{0:N2}", olstPedidoFICDetalle.Sum(p => p.ImporteTotal));
                ViewBag.Simbolo = PedidoModelo.Simbolo;
                ViewBag.Total = PedidoModelo.Total;
                ViewBag.IndicadorOfertaFIC = UserData().IndicadorOfertaFIC; //SSAP CGI(Id Solicitud=1402)

                // Req. 1664 - Gestion de contenido S3
                var carpetaPais = Globals.UrlOfertasFic + "/" + UserData().CodigoISO;
                var url = ConfigS3.GetUrlFileS3(carpetaPais, UserData().ImagenURLOfertaFIC, "");

                ViewBag.ImagenUrlOfertaFIC = url; //SSAP CGI(Id Solicitud=1402)
                ViewBag.PaisID = UserData().PaisID; //1501

                if (olstPedidoFICDetalle.Count != 0)
                {
                    if (UserData().PedidoID == 0)
                    {
                        UsuarioModel usuario = UserData();
                        usuario.PedidoID = olstPedidoFICDetalle[0].PedidoID;
                        SetUserData(usuario);
                    }
                }

                return View(PedidoModelo);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(new PedidoFICDetalleModel());
        }

        [HttpPost]
        public JsonResult CargarDetallePedido(string sidx, string sord, int page, int rows, int clienteId, bool mobil = false)
        {
            try
            {
                PedidoSb2Model model = new PedidoSb2Model();
                model.CodigoIso = userData.CodigoISO;
                var listaDetalle = ObtenerPedidoFICDetalle() ?? new List<BEPedidoFICDetalle>();
                
                decimal total = listaDetalle.Sum(p => p.ImporteTotal);

                model.ListaCliente = (from item in listaDetalle
                                      select new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre }
                    ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
                model.ListaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });

                listaDetalle = listaDetalle.Where(p => p.ClienteID == clienteId || clienteId == -1).ToList();
                decimal totalCliente = listaDetalle.Sum(p => p.ImporteTotal);

                var pedidoWebDetalleModel = Mapper.Map<List<BEPedidoFICDetalle>, List<PedidoWebDetalleModel>>(listaDetalle);
                pedidoWebDetalleModel.Update(p => p.Simbolo = userData.Simbolo);
                pedidoWebDetalleModel.Update(p => p.CodigoIso = userData.CodigoISO);

                model.ListaDetalleModel = pedidoWebDetalleModel;
                model.Total = total;
                model.TotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                model.TotalProductos = pedidoWebDetalleModel.Sum(p => Convert.ToInt32(p.Cantidad));

                userData.PedidoID = 0;
                if (model.ListaDetalleModel.Any())
                {
                    userData.PedidoID = model.ListaDetalleModel[0].PedidoID;
                    SetUserData(userData);

                    BEGrid grid = SetGrid(sidx, sord, page, rows);
                    BEPager pag = Util.PaginadorGenerico(grid, model.ListaDetalleModel);

                    model.ListaDetalleModel = model.ListaDetalleModel.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();

                    model.Registros = grid.PageSize.ToString();
                    model.RegistrosTotal = pag.RecordCount.ToString();
                    model.Pagina = pag.CurrentPage.ToString();
                    model.PaginaDe = pag.PageCount.ToString();
                }
                else
                {
                    model.RegistrosTotal = "0";
                    model.Pagina = "1";
                    model.PaginaDe = "1";
                }

                model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;
                model.Simbolo = userData.Simbolo;

                return Json(new
                {
                    success = false,
                    message = "OK",
                    data = model
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

        public ActionResult EnHorarioRestringido()
        {
            try
            {
                string mensaje = string.Empty;
                bool estado = ValidarHorarioRestringido(out mensaje);
                return Json(new
                {
                    success = estado,
                    message = mensaje,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al calcular el horario restringido",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        #region CRUD

        [HttpPost]
        public JsonResult Insert(PedidoDetalleModel model)
        {
            UserData().PedidoID = 0;
            List<BEPedidoFICDetalle> olstPedidoFICDetal = new List<BEPedidoFICDetalle>();
            olstPedidoFICDetal = ObtenerPedidoFICDetalle();
            if (olstPedidoFICDetal.Count != 0)
            {
                UsuarioModel usuario = UserData();
                usuario.PedidoID = olstPedidoFICDetal[0].PedidoID;
                SetUserData(usuario);
            }

            BEPedidoFICDetalle oBEPedidoFICDetalle = new BEPedidoFICDetalle();
            oBEPedidoFICDetalle.IPUsuario = UserData().IPUsuario;
            oBEPedidoFICDetalle.CampaniaID = CampaniaSiguiente(UserData().CampaniaID);
            oBEPedidoFICDetalle.ConsultoraID = UserData().ConsultoraID;
            oBEPedidoFICDetalle.PaisID = UserData().PaisID;
            oBEPedidoFICDetalle.TipoOfertaSisID = model.TipoOfertaSisID;
            oBEPedidoFICDetalle.ConfiguracionOfertaID = model.ConfiguracionOfertaID;
            oBEPedidoFICDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID);
            oBEPedidoFICDetalle.PedidoID = UserData().PedidoID;
            oBEPedidoFICDetalle.OfertaWeb = false;
            oBEPedidoFICDetalle.IndicadorMontoMinimo = Convert.ToInt32(model.IndicadorMontoMinimo);
            //oBEPedidoFICDetalle.TipoOfertaSisID = model.TipoOfertaSisID;

            if (model.Tipo != 2)
            {
                oBEPedidoFICDetalle.MarcaID = model.MarcaID;
                oBEPedidoFICDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
                oBEPedidoFICDetalle.PrecioUnidad = model.PrecioUnidad;
                oBEPedidoFICDetalle.CUV = model.CUV;
            }
            else
            {
                oBEPedidoFICDetalle.MarcaID = model.MarcaIDComplemento;
                oBEPedidoFICDetalle.Cantidad = 1;
                oBEPedidoFICDetalle.PrecioUnidad = model.PrecioUnidadComplemento;
                oBEPedidoFICDetalle.CUV = model.CUVComplemento;
            }
            oBEPedidoFICDetalle.DescripcionProd = model.DescripcionProd;
            oBEPedidoFICDetalle.ImporteTotal = oBEPedidoFICDetalle.Cantidad * oBEPedidoFICDetalle.PrecioUnidad;
            oBEPedidoFICDetalle.Nombre = oBEPedidoFICDetalle.ClienteID == 0 ? UserData().NombreConsultora : model.ClienteDescripcion;

            bool ErrorServer;
            AdministradorPedido(oBEPedidoFICDetalle, "I", false, out ErrorServer);
            if (ErrorServer)
            {
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al intentar insertar el producto"
                }, JsonRequestBehavior.AllowGet);
            }

            return Json(new
            {
                success = true,
                message = "El producto se insertó exitosamente."
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Update(PedidoFICDetalleModel model)
        {
            string message = string.Empty;

            BEPedidoFICDetalle oBEPedidoFICDetalle = new BEPedidoFICDetalle();
            oBEPedidoFICDetalle.PaisID = UserData().PaisID;
            oBEPedidoFICDetalle.CampaniaID = model.CampaniaID;
            oBEPedidoFICDetalle.PedidoID = model.PedidoID;
            oBEPedidoFICDetalle.PedidoDetalleID = model.PedidoDetalleID;
            oBEPedidoFICDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
            oBEPedidoFICDetalle.PrecioUnidad = model.PrecioUnidad;
            oBEPedidoFICDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID);

            //Cambios para Oferta de Liquidación
            oBEPedidoFICDetalle.CUV = model.CUV;
            oBEPedidoFICDetalle.TipoOfertaSisID = model.TipoOfertaSisID;
            oBEPedidoFICDetalle.Stock = model.Stock;
            oBEPedidoFICDetalle.Flag = model.Flag;

            oBEPedidoFICDetalle.DescripcionProd = model.DescripcionProd;
            oBEPedidoFICDetalle.ImporteTotal = oBEPedidoFICDetalle.Cantidad * oBEPedidoFICDetalle.PrecioUnidad;
            oBEPedidoFICDetalle.Nombre = oBEPedidoFICDetalle.ClienteID == 0 ? UserData().NombreConsultora : model.ClienteDescripcion;
            bool ErrorServer;
            var olstPedidoWebDetalle = AdministradorPedido(oBEPedidoFICDetalle, "U", false, out ErrorServer);

            decimal Total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            string formatoTotal = Util.DecimalToStringFormat(Total, userData.CodigoISO);
            
            decimal totalCliente = 0;
            string Total_Cliente = "";
            if (model.ClienteID_ != "-1")
            {
                olstPedidoWebDetalle = (from item in olstPedidoWebDetalle
                                        where item.ClienteID == Convert.ToInt16(model.ClienteID_)
                                        select item).ToList();
                totalCliente = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                Total_Cliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
            }

            message = ErrorServer ? "Hubo un problema al intentar actualizar el registro. Por favor inténtelo nuevamente." : "El registro ha sido actualizado de manera exitosa.";

            return Json(new
            {
                success = !ErrorServer,
                Total = Total,
                FormatoTotal = formatoTotal,
                TotalCliente = Total_Cliente,
                ClienteID_ = model.ClienteID_,
                Simbolo = userData.Simbolo,
                message = message,
                extra = ""
            });
        }

        [HttpPost]
        public JsonResult Delete(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string CUV, int Cantidad)
        {
            BEPedidoFICDetalle obe = new BEPedidoFICDetalle();
            obe.PaisID = UserData().PaisID;
            obe.CampaniaID = CampaniaID;
            obe.PedidoID = PedidoID;
            obe.PedidoDetalleID = PedidoDetalleID;
            obe.TipoOfertaSisID = TipoOfertaSisID;
            obe.CUV = CUV;
            obe.Cantidad = Cantidad;

            string mensaje = string.Empty;
            // se valida si esta en horario restringido
            if (ValidarHorarioRestringido(out mensaje))
            {
                return Json(new
                {
                    success = false,
                    message = mensaje
                }, JsonRequestBehavior.AllowGet);
            }

            bool ErrorServer = false;
            AdministradorPedido(obe, "D", false, out ErrorServer);            
            if (ErrorServer)
            {
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al intentar eliminar el detalle"
                }, JsonRequestBehavior.AllowGet);
            }

            return Json(new
            {
                success = true,
                message = "El detalle se eliminó exitosamente."
            }, JsonRequestBehavior.AllowGet);
        }
        
        [HttpPost]
        public JsonResult DeleteAll()
        {
            bool ErrorServer = false;
            bool EliminacionMasiva = false;
            string message = string.Empty;

            try
            {
                List<BEPedidoFICDetalle> olstTempListado = new List<BEPedidoFICDetalle>();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    EliminacionMasiva = sv.DelPedidoFICDetalleMasivo(UserData().PaisID, CampaniaSiguiente(UserData().CampaniaID), UserData().PedidoID);
                }
                if (!EliminacionMasiva)
                {
                    ErrorServer = true;
                    message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
                }

            }
            catch
            {
                ErrorServer = true;
                message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            }

            return Json(new
            {
                success = !ErrorServer,
                message = message,
                extra = ""
            });

        }

        public JsonResult Insertar()
        {
            try
            {
                int IsInsert;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    Portal.Consultoras.Web.ServicePedido.BEPedidoWeb oBEPedidoWeb = new Portal.Consultoras.Web.ServicePedido.BEPedidoWeb();
                    oBEPedidoWeb.CampaniaID = UserData().CampaniaID;
                    oBEPedidoWeb.ConsultoraID = UserData().ConsultoraID;
                    oBEPedidoWeb.PaisID = UserData().PaisID;
                    oBEPedidoWeb.IPUsuario = UserData().IPUsuario;
                    oBEPedidoWeb.CodigoUsuarioCreacion = UserData().CodigoUsuario;
                    IsInsert = sv.GetOfertaFICToInsert(oBEPedidoWeb);
                }

                object jsonData = null;

                jsonData = new
                {
                    success = true,
                    message = "Los registros han sido ingresados satisfactoriamente.",
                    extra = ""
                };

                return Json(jsonData);

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        #endregion

        #region Autocompletes

        public ActionResult AutocompleteByProductoCUV(string term)
        {
            List<BEProducto> olstProducto = new List<BEProducto>();
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                UsuarioModel oUsuarioModel = UserData();
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, CampaniaSiguiente(oUsuarioModel.CampaniaID), term, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 1, 5, true).ToList();
                }

                foreach (var item in olstProducto)
                {
                    olstProductoModel.Add(new ProductoModel()
                    {
                        CUV = item.CUV.Trim(),
                        Descripcion = item.Descripcion.Trim(),
                        PrecioCatalogo = item.PrecioCatalogo,
                        MarcaID = item.MarcaID,
                        EstaEnRevista = item.EstaEnRevista,
                        TieneStock = item.TieneStock,
                        EsExpoOferta = item.EsExpoOferta,
                        CUVRevista = item.CUVRevista.Trim(),
                        CUVComplemento = item.CUVComplemento.Trim(),
                        IndicadorMontoMinimo = item.IndicadorMontoMinimo.ToString().Trim(),
                        //CUVComplemento = item.CUVComplemento.Trim(),
                        TipoOfertaSisID = item.TipoOfertaSisID,
                        ConfiguracionOfertaID = item.ConfiguracionOfertaID
                    });
                }

                if (olstProductoModel.Count == 0)
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe." });
                }
            }
            catch (Exception ex)
            {
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
        }

        public ActionResult FindByCUV(PedidoDetalleModel model)
        {
            List<BEProducto> olstProducto = new List<BEProducto>();
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                UsuarioModel oUsuarioModel = UserData();

                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, CampaniaSiguiente(oUsuarioModel.CampaniaID), model.CUV, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 1, 1, true).ToList();
                }

                if (olstProducto.Count != 0)
                {
                    olstProductoModel.Add(new ProductoModel()
                    {
                        CUV = olstProducto[0].CUV.Trim(),
                        Descripcion = olstProducto[0].Descripcion.Trim(),
                        PrecioCatalogo = olstProducto[0].PrecioCatalogo,
                        MarcaID = olstProducto[0].MarcaID,
                        EstaEnRevista = olstProducto[0].EstaEnRevista,
                        TieneStock = olstProducto[0].TieneStock,
                        EsExpoOferta = olstProducto[0].EsExpoOferta,
                        CUVRevista = olstProducto[0].CUVRevista.Trim(),
                        CUVComplemento = olstProducto[0].CUVComplemento.Trim(),
                        IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                        //CUVComplemento = olstProducto[0].CUVComplemento.Trim(),
                        TipoOfertaSisID = olstProducto[0].TipoOfertaSisID,
                        ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID
                    });
                }
                else
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe." });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);


        }

        public ActionResult AutocompleteByProductoDescripcion(string term)
        {
            List<BEProducto> olstProducto = new List<BEProducto>();
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                UsuarioModel oUsuarioModel = UserData();

                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, CampaniaSiguiente(oUsuarioModel.CampaniaID), term, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 2, 5, true).ToList();
                }

                foreach (var item in olstProducto)
                {
                    olstProductoModel.Add(new ProductoModel()
                    {
                        CUV = item.CUV.Trim(),
                        Descripcion = item.Descripcion.Trim(),
                        PrecioCatalogo = item.PrecioCatalogo,
                        MarcaID = item.MarcaID,
                        EstaEnRevista = item.EstaEnRevista,
                        TieneStock = item.TieneStock,
                        EsExpoOferta = item.EsExpoOferta,
                        CUVRevista = item.CUVRevista.Trim(),
                        CUVComplemento = item.CUVComplemento.Trim(),
                        TipoOfertaSisID = item.TipoOfertaSisID,
                        ConfiguracionOfertaID = item.ConfiguracionOfertaID,
                        //CUVComplemento = item.CUVComplemento.Trim(),
                        IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                    });
                }

                if (olstProductoModel.Count == 0)
                {
                    olstProductoModel.Add(new ProductoModel() { CUV = "0", Descripcion = "El producto solicitado no existe." });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                olstProductoModel.Add(new ProductoModel() { CUV = "0", Descripcion = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Funciones Privadas

        private bool ValidarHorarioRestringido(out string mensaje)
        {
            bool enHorarioRestringido = false;
            mensaje = string.Empty;
            UsuarioModel usuario = (UsuarioModel)Session["UserData"];
            DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);

            // si no es dia prol se devuelve false sino se analiza el rango horario
            // tambien se valida el flag de habilitacion de restriccion horaria
            if (!usuario.DiaPROL || !usuario.HabilitarRestriccionHoraria)
                return false;
            else
            {
                // rango de dias prol
                if (FechaHoraActual > usuario.FechaInicioCampania &&
                    FechaHoraActual < usuario.FechaFinCampania.AddDays(1))
                {
                    TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                    // si no es demanda anticipada se usa la hora de cierre normal
                    if (usuario.EsZonaDemAnti == 0)
                    {
                        if (HoraNow > usuario.HoraCierreZonaNormal)
                            enHorarioRestringido = true;
                        else
                            enHorarioRestringido = false;
                    }
                    else // sino se usa la hora de cierre de demanda anticipada
                    {
                        if (HoraNow > usuario.HoraCierreZonaDemAnti)
                            enHorarioRestringido = true;
                        else
                            enHorarioRestringido = false;
                    }
                }
                // si no es horario restringido se devuelve el resultado false , sino se prepara el mensaje correspondiente
                if (!enHorarioRestringido)
                    return false;
                else
                {
                    mensaje = "Se encuentra en horario restringido, no podrá realizar esta funcionalidad hasta el dia siguiente";
                    return true;
                }
            }
        }

        public List<BEPedidoFICDetalle> ObtenerPedidoFICDetalle()
        {
            List<BEPedidoFICDetalle> olstPedidoFICDetalle = new List<BEPedidoFICDetalle>();
            if (Session["PedidoFIC"] == null)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    olstPedidoFICDetalle = sv.SelectFICByCampania(UserData().PaisID, CampaniaSiguiente(UserData().CampaniaID), UserData().ConsultoraID, UserData().NombreConsultora).ToList();
                }
            }
            else
                olstPedidoFICDetalle = (List<BEPedidoFICDetalle>)Session["PedidoFIC"];

            Session["PedidoFIC"] = olstPedidoFICDetalle;
            return olstPedidoFICDetalle;
        }

        private List<BEPedidoFICDetalle> AdministradorPedido(BEPedidoFICDetalle oBEPedidoFICDetalle, string TipoAdm, bool Reservado, out bool ErrorServer)
        {
            List<BEPedidoFICDetalle> olstTempListado = new List<BEPedidoFICDetalle>();

            BEPedidoFICDetalle obe = null;
            try
            {
                if (Session["PedidoFIC"] == null)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        olstTempListado = sv.SelectFICByCampania(UserData().PaisID, UserData().CampaniaID, UserData().ConsultoraID, UserData().NombreConsultora).ToList();
                    }
                    Session["PedidoFIC"] = olstTempListado;
                }
                else
                    olstTempListado = (List<BEPedidoFICDetalle>)Session["PedidoFIC"];

                if (TipoAdm == "I")
                {
                    int Cantidad;
                    short Result = ValidarInsercion(olstTempListado, oBEPedidoFICDetalle, out Cantidad);
                    if (Result != 0)
                    {
                        TipoAdm = "U";
                        oBEPedidoFICDetalle.Stock = oBEPedidoFICDetalle.Cantidad;
                        oBEPedidoFICDetalle.Cantidad += Cantidad;
                        oBEPedidoFICDetalle.ImporteTotal = oBEPedidoFICDetalle.Cantidad * oBEPedidoFICDetalle.PrecioUnidad;
                        oBEPedidoFICDetalle.PedidoDetalleID = Result;
                        oBEPedidoFICDetalle.Flag = 2;
                    }
                }
                else
                {
                    if (TipoAdm == "I_S")
                    {
                        int Cantidad;
                        bool Eliminacion;
                        short PedidoDetalleID;
                        short Result = ValidarInsercionSession(olstTempListado, oBEPedidoFICDetalle, out Cantidad, out Eliminacion, out PedidoDetalleID);
                        if (Result != 0)
                        {
                            TipoAdm = "U_S";
                            if (Eliminacion)
                                oBEPedidoFICDetalle.EliminadoTemporal = false;
                            else
                                oBEPedidoFICDetalle.Cantidad += Cantidad;

                            oBEPedidoFICDetalle.ImporteTotal = oBEPedidoFICDetalle.Cantidad * oBEPedidoFICDetalle.PrecioUnidad;
                            oBEPedidoFICDetalle.PedidoDetalleID = Result;
                        }
                    }
                }

                int TotalClientes = CalcularTotalCliente(olstTempListado, oBEPedidoFICDetalle, TipoAdm == "D" || TipoAdm == "D_S" ? oBEPedidoFICDetalle.PedidoDetalleID : (short)0, TipoAdm);
                decimal TotalImporte = CalcularTotalImporte(olstTempListado, oBEPedidoFICDetalle, TipoAdm == "I" || TipoAdm == "I_S" ? (short)0 : oBEPedidoFICDetalle.PedidoDetalleID, TipoAdm);
                oBEPedidoFICDetalle.ImporteTotalPedido = TotalImporte;
                oBEPedidoFICDetalle.Clientes = TotalClientes;

                switch (TipoAdm)
                {
                    case "I":
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            obe = sv.InsertFIC(oBEPedidoFICDetalle);
                        }
                        obe.ImporteTotal = oBEPedidoFICDetalle.ImporteTotal;
                        obe.DescripcionProd = oBEPedidoFICDetalle.DescripcionProd;
                        obe.Nombre = oBEPedidoFICDetalle.Nombre;

                        if (UserData().PedidoID == 0)
                        {
                            UsuarioModel usuario = UserData();
                            usuario.PedidoID = obe.PedidoID;
                            SetUserData(usuario);
                        }

                        olstTempListado.Add(obe);

                        break;
                    case "U":

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdPedidoFICDetalle(oBEPedidoFICDetalle);
                        }

                        olstTempListado.Where(p => p.PedidoDetalleID == oBEPedidoFICDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = oBEPedidoFICDetalle.Cantidad;
                                p.ImporteTotal = oBEPedidoFICDetalle.ImporteTotal;
                                p.ClienteID = oBEPedidoFICDetalle.ClienteID;
                                p.DescripcionProd = oBEPedidoFICDetalle.DescripcionProd;
                                p.Nombre = oBEPedidoFICDetalle.Nombre;
                            });

                        break;
                    case "D":
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.DelPedidoFICDetalle(oBEPedidoFICDetalle);
                        }
                        olstTempListado.RemoveAll(p => p.PedidoDetalleID == oBEPedidoFICDetalle.PedidoDetalleID);
                        break;
                    case "I_S":
                        oBEPedidoFICDetalle.PedidoDetalleID = Convert.ToInt16((1000 + DateTime.Now.Second + DateTime.Now.Millisecond).ToString());
                        oBEPedidoFICDetalle.EstadoItem = 1;
                        oBEPedidoFICDetalle.CUVNuevo = true;
                        oBEPedidoFICDetalle.ClaseFila = "f3";
                        olstTempListado.Add(oBEPedidoFICDetalle);
                        break;
                    case "U_S":
                        olstTempListado.Where(p => p.PedidoDetalleID == oBEPedidoFICDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = oBEPedidoFICDetalle.Cantidad;
                                p.ImporteTotal = oBEPedidoFICDetalle.ImporteTotal;
                                p.ClienteID = oBEPedidoFICDetalle.ClienteID;
                                p.DescripcionProd = oBEPedidoFICDetalle.DescripcionProd;
                                p.Nombre = oBEPedidoFICDetalle.Nombre;
                                p.EstadoItem = 2;
                                p.ClaseFila = "f3";
                                p.Stock = oBEPedidoFICDetalle.Stock;
                                p.Flag = oBEPedidoFICDetalle.Flag;
                                p.EliminadoTemporal = oBEPedidoFICDetalle.EliminadoTemporal;
                            });
                        break;
                    case "D_S":
                        olstTempListado.Where(p => p.PedidoDetalleID == oBEPedidoFICDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.EstadoItem = 3;
                                p.EliminadoTemporal = true;
                            });
                        break;
                }

                olstTempListado = olstTempListado.OrderByDescending(p => p.PedidoDetalleID).ToList();
                Session["PedidoFIC"] = olstTempListado;

                ErrorServer = false;
            }
            catch(Exception ex)
            {
                if (Session["PedidoFIC"] != null)
                    olstTempListado = (List<BEPedidoFICDetalle>)Session["PedidoFIC"];
                ErrorServer = true;
            }

            return olstTempListado;
        }

        private int CalcularTotalCliente(List<BEPedidoFICDetalle> Pedido, BEPedidoFICDetalle ItemPedido, short PedidoDetalleID, string Adm)
        {
            List<BEPedidoFICDetalle> Temp = new List<BEPedidoFICDetalle>(Pedido);
            if (PedidoDetalleID == 0)
            {
                if (Adm == "I" || Adm == "I_S")
                    Temp.Add(ItemPedido);
                else
                    Temp.Where(p => p.PedidoDetalleID == ItemPedido.PedidoDetalleID).Update(p => p.ClienteID = ItemPedido.ClienteID);

            }
            else
                Temp = Temp.Where(p => p.PedidoDetalleID != PedidoDetalleID).ToList();

            return Temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private decimal CalcularTotalImporte(List<BEPedidoFICDetalle> Pedido, BEPedidoFICDetalle ItemPedido, short PedidoDetalleID, string Adm)
        {
            List<BEPedidoFICDetalle> Temp = new List<BEPedidoFICDetalle>(Pedido);
            if (PedidoDetalleID == 0)
                Temp.Add(ItemPedido);
            else
                Temp = Temp.Where(p => p.PedidoDetalleID != PedidoDetalleID).ToList();
            return Temp.Sum(p => p.ImporteTotal) + (Adm == "U" || Adm == "U_S" ? ItemPedido.ImporteTotal : 0);
        }

        private short ValidarInsercion(List<BEPedidoFICDetalle> Pedido, BEPedidoFICDetalle ItemPedido, out int Cantidad)
        {
            List<BEPedidoFICDetalle> Temp = new List<BEPedidoFICDetalle>(Pedido);
            BEPedidoFICDetalle obe = Temp.FirstOrDefault(p => p.ClienteID == ItemPedido.ClienteID && p.CUV == ItemPedido.CUV);
            Cantidad = obe != null ? obe.Cantidad : 0;
            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        private short ValidarInsercionSession(List<BEPedidoFICDetalle> Pedido, BEPedidoFICDetalle ItemPedido, out int Cantidad, out bool Eliminacion, out short PedidoDetalleID)
        {
            List<BEPedidoFICDetalle> Temp = new List<BEPedidoFICDetalle>(Pedido);
            BEPedidoFICDetalle obe = Temp.FirstOrDefault(p => p.ClienteID == ItemPedido.ClienteID && p.CUV == ItemPedido.CUV);
            Cantidad = obe != null ? obe.Cantidad : 0;
            if (obe != null)
            {
                Eliminacion = obe.EliminadoTemporal;
                PedidoDetalleID = obe.PedidoDetalleID;
            }
            else
            {
                PedidoDetalleID = (short)0;
                Eliminacion = false;
            }

            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        #endregion

        public int CampaniaSiguiente(int CampaniaActual)
        {
            if (CampaniaActual.ToString().Substring(4,2) != "18")
                return CampaniaActual + 1;
            else
                return CampaniaActual + 83;
        }
    }
}
