using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class PedidoFICController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "PedidoFIC/Index")) return RedirectToAction("Index", "Bienvenida");

                Session[Constantes.ConstSession.PedidoFIC] = null;
                ViewBag.ClaseTabla = "tabla2";
                ViewBag.Pais_ISO = userData.CodigoISO;
                ViewBag.PROL = "Guardar";
                ViewBag.PROLDes = "Guarda los productos que haz ingresado";
                ViewBag.ModPedido = "display:none;";
                ViewBag.NombreConsultora = userData.NombreConsultora;
                ViewBag.PedidoFIC = "C" + AddCampaniaAndNumero(userData.CampaniaID, 1);
                ViewBag.MensajeFIC = "hasta el " + userData.FechaFinFIC.Day + " de " + NombreMes(userData.FechaFinFIC.Month);

                var olstPedidoFicDetalle = ObtenerPedidoFICDetalle();

                PedidoFICDetalleModel pedidoModelo = new PedidoFICDetalleModel
                {
                    PaisID = userData.PaisID,
                    ListaDetalle = olstPedidoFicDetalle,
                    Simbolo = userData.Simbolo,
                    Total = string.Format("{0:N2}", olstPedidoFicDetalle.Sum(p => p.ImporteTotal))
                };
                ViewBag.Total = pedidoModelo.Total;
                ViewBag.IndicadorOfertaFIC = userData.IndicadorOfertaFIC;

                var carpetaPais = Globals.UrlOfertasFic + "/" + userData.CodigoISO;
                var url = ConfigS3.GetUrlFileS3(carpetaPais, userData.ImagenURLOfertaFIC);

                ViewBag.ImagenUrlOfertaFIC = url;
                ViewBag.PaisID = userData.PaisID;

                if (olstPedidoFicDetalle.Count != 0 && userData.PedidoID == 0)
                {
                    userData.PedidoID = olstPedidoFicDetalle[0].PedidoID;
                    SetUserData(userData);
                }

                ViewBag.UrlFranjaNegra = GetUrlFranjaNegra();

                return View(pedidoModelo);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new PedidoFICDetalleModel());
        }

        [HttpPost]
        public JsonResult CargarDetallePedido(string sidx, string sord, int page, int rows, int clienteId, bool mobil = false)
        {
            try
            {
                PedidoSb2Model model = new PedidoSb2Model { CodigoIso = userData.CodigoISO };
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

                    BEGrid grid = new BEGrid(sidx, sord, page, rows);
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

        #region CRUD

        [HttpPost]
        public JsonResult Insert(PedidoDetalleModel model)
        {
            userData.PedidoID = 0;
            var olstPedidoFicDetal = ObtenerPedidoFICDetalle();
            if (olstPedidoFicDetal.Count != 0)
            {
                userData.PedidoID = olstPedidoFicDetal[0].PedidoID;
                SetUserData(userData);
            }

            BEPedidoFICDetalle obePedidoFicDetalle = new BEPedidoFICDetalle
            {
                IPUsuario = userData.IPUsuario,
                CampaniaID = AddCampaniaAndNumero(userData.CampaniaID, 1),
                ConsultoraID = userData.ConsultoraID,
                PaisID = userData.PaisID,
                TipoOfertaSisID = model.TipoOfertaSisID,
                ConfiguracionOfertaID = model.ConfiguracionOfertaID,
                ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID),
                PedidoID = userData.PedidoID,
                OfertaWeb = false,
                IndicadorMontoMinimo = Convert.ToInt32(model.IndicadorMontoMinimo)
            };

            if (model.Tipo != 2)
            {
                obePedidoFicDetalle.MarcaID = model.MarcaID;
                obePedidoFicDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
                obePedidoFicDetalle.PrecioUnidad = model.PrecioUnidad;
                obePedidoFicDetalle.CUV = model.CUV;
            }
            else
            {
                obePedidoFicDetalle.MarcaID = model.MarcaIDComplemento;
                obePedidoFicDetalle.Cantidad = 1;
                obePedidoFicDetalle.PrecioUnidad = model.PrecioUnidadComplemento;
                obePedidoFicDetalle.CUV = model.CUVComplemento;
            }
            obePedidoFicDetalle.DescripcionProd = model.DescripcionProd;
            obePedidoFicDetalle.ImporteTotal = obePedidoFicDetalle.Cantidad * obePedidoFicDetalle.PrecioUnidad;
            obePedidoFicDetalle.Nombre = obePedidoFicDetalle.ClienteID == 0 ? userData.NombreConsultora : model.ClienteDescripcion;

            bool errorServer;
            AdministradorPedido(obePedidoFicDetalle, "I", false, out errorServer);
            if (errorServer)
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
            BEPedidoFICDetalle obePedidoFicDetalle = new BEPedidoFICDetalle
            {
                PaisID = userData.PaisID,
                CampaniaID = model.CampaniaID,
                PedidoID = model.PedidoID,
                PedidoDetalleID = model.PedidoDetalleID,
                Cantidad = Convert.ToInt32(model.Cantidad),
                PrecioUnidad = model.PrecioUnidad,
                ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID),
                CUV = model.CUV,
                TipoOfertaSisID = model.TipoOfertaSisID,
                Stock = model.Stock,
                Flag = model.Flag,
                DescripcionProd = model.DescripcionProd
            };

            obePedidoFicDetalle.ImporteTotal = obePedidoFicDetalle.Cantidad * obePedidoFicDetalle.PrecioUnidad;
            obePedidoFicDetalle.Nombre = obePedidoFicDetalle.ClienteID == 0 ? userData.NombreConsultora : model.ClienteDescripcion;
            bool errorServer;
            var olstPedidoWebDetalle = AdministradorPedido(obePedidoFicDetalle, "U", false, out errorServer);

            decimal total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            string formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

            string totalCliente = "";
            if (model.ClienteID_ != "-1")
            {
                olstPedidoWebDetalle = (from item in olstPedidoWebDetalle
                                        where item.ClienteID == Convert.ToInt16(model.ClienteID_)
                                        select item).ToList();
                var tCliente = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                totalCliente = Util.DecimalToStringFormat(tCliente, userData.CodigoISO);
            }

            var message = errorServer ? "Hubo un problema al intentar actualizar el registro. Por favor inténtelo nuevamente." : "El registro ha sido actualizado de manera exitosa.";

            return Json(new
            {
                success = !errorServer,
                Total = total,
                FormatoTotal = formatoTotal,
                TotalCliente = totalCliente,
                ClienteID_ = model.ClienteID_,
                Simbolo = userData.Simbolo,
                message = message,
                extra = ""
            });
        }

        [HttpPost]
        public JsonResult Delete(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string CUV, int Cantidad)
        {
            BEPedidoFICDetalle obe = new BEPedidoFICDetalle
            {
                PaisID = userData.PaisID,
                CampaniaID = CampaniaID,
                PedidoID = PedidoID,
                PedidoDetalleID = PedidoDetalleID,
                TipoOfertaSisID = TipoOfertaSisID,
                CUV = CUV,
                Cantidad = Cantidad
            };

            string mensaje;
            if (ReservadoEnHorarioRestringido(out mensaje))
            {
                return Json(new
                {
                    success = false,
                    message = mensaje
                }, JsonRequestBehavior.AllowGet);
            }

            bool errorServer;
            AdministradorPedido(obe, "D", false, out errorServer);
            if (errorServer)
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
            bool errorServer = false;
            string message = string.Empty;

            try
            {
                bool eliminacionMasiva;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    eliminacionMasiva = sv.DelPedidoFICDetalleMasivo(userData.PaisID, AddCampaniaAndNumero(userData.CampaniaID, 1), userData.PedidoID);
                }
                if (!eliminacionMasiva)
                {
                    errorServer = true;
                    message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
                }

            }
            catch
            {
                errorServer = true;
                message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            }

            return Json(new
            {
                success = !errorServer,
                message = message,
                extra = ""
            });

        }

        public JsonResult Insertar()
        {
            try
            {
                ServicePedido.BEPedidoWeb obePedidoWeb = new ServicePedido.BEPedidoWeb
                {
                    CampaniaID = userData.CampaniaID,
                    ConsultoraID = userData.ConsultoraID,
                    PaisID = userData.PaisID,
                    IPUsuario = userData.IPUsuario,
                    CodigoUsuarioCreacion = userData.CodigoUsuario
                };

                int isInsert;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    isInsert = sv.GetOfertaFICToInsert(obePedidoWeb);
                }

                object jsonData = new
                {
                    success = true,
                    message = "Los registros han sido ingresados satisfactoriamente.",
                    extra = ""
                };

                return Json(jsonData);

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                List<ServiceODS.BEProducto> olstProducto;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, AddCampaniaAndNumero(userData.CampaniaID, 1), term, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 5, true).ToList();
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
        }

        public ActionResult FindByCUV(PedidoDetalleModel model)
        {
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                List<ServiceODS.BEProducto> olstProducto;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, AddCampaniaAndNumero(userData.CampaniaID, 1), model.CUV, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, true).ToList();
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);


        }

        public ActionResult AutocompleteByProductoDescripcion(string term)
        {
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                List<ServiceODS.BEProducto> olstProducto;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, AddCampaniaAndNumero(userData.CampaniaID, 1), term, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 2, 5, true).ToList();
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstProductoModel.Add(new ProductoModel() { CUV = "0", Descripcion = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Funciones Privadas

        private List<BEPedidoFICDetalle> ObtenerPedidoFICDetalle()
        {
            if (Session[Constantes.ConstSession.PedidoFIC] != null) return (List<BEPedidoFICDetalle>)Session[Constantes.ConstSession.PedidoFIC];

            List<BEPedidoFICDetalle> list;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                list = sv.SelectFICByCampania(userData.PaisID, AddCampaniaAndNumero(userData.CampaniaID, 1), userData.ConsultoraID, userData.NombreConsultora).ToList();
            }
            Session[Constantes.ConstSession.PedidoFIC] = list;
            return list;
        }

        private List<BEPedidoFICDetalle> AdministradorPedido(BEPedidoFICDetalle obePedidoFicDetalle, string tipoAdm, bool reservado, out bool errorServer)
        {
            errorServer = false;
            List<BEPedidoFICDetalle> olstTempListado = new List<BEPedidoFICDetalle>();

            try
            {
                if (Session[Constantes.ConstSession.PedidoFIC] == null)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        olstTempListado = sv.SelectFICByCampania(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                    }
                    Session[Constantes.ConstSession.PedidoFIC] = olstTempListado;
                }
                else olstTempListado = (List<BEPedidoFICDetalle>)Session[Constantes.ConstSession.PedidoFIC];

                if (tipoAdm == "I")
                {
                    int cantidad;
                    short result = ValidarInsercion(olstTempListado, obePedidoFicDetalle, out cantidad);
                    if (result != 0)
                    {
                        tipoAdm = "U";
                        obePedidoFicDetalle.Stock = obePedidoFicDetalle.Cantidad;
                        obePedidoFicDetalle.Cantidad += cantidad;
                        obePedidoFicDetalle.ImporteTotal = obePedidoFicDetalle.Cantidad * obePedidoFicDetalle.PrecioUnidad;
                        obePedidoFicDetalle.PedidoDetalleID = result;
                        obePedidoFicDetalle.Flag = 2;
                    }
                }
                else
                {
                    if (tipoAdm == "I_S")
                    {
                        int cantidad;
                        bool eliminacion;
                        short pedidoDetalleId;
                        short result = ValidarInsercionSession(olstTempListado, obePedidoFicDetalle, out cantidad, out eliminacion, out pedidoDetalleId);
                        if (result != 0)
                        {
                            tipoAdm = "U_S";
                            if (eliminacion)
                                obePedidoFicDetalle.EliminadoTemporal = false;
                            else
                                obePedidoFicDetalle.Cantidad += cantidad;

                            obePedidoFicDetalle.ImporteTotal = obePedidoFicDetalle.Cantidad * obePedidoFicDetalle.PrecioUnidad;
                            obePedidoFicDetalle.PedidoDetalleID = result;
                        }
                    }
                }

                int totalClientes = CalcularTotalCliente(olstTempListado, obePedidoFicDetalle, tipoAdm == "D" || tipoAdm == "D_S" ? obePedidoFicDetalle.PedidoDetalleID : (short)0, tipoAdm);
                decimal totalImporte = CalcularTotalImporte(olstTempListado, obePedidoFicDetalle, tipoAdm == "I" || tipoAdm == "I_S" ? (short)0 : obePedidoFicDetalle.PedidoDetalleID, tipoAdm);
                obePedidoFicDetalle.ImporteTotalPedido = totalImporte;
                obePedidoFicDetalle.Clientes = totalClientes;

                switch (tipoAdm)
                {
                    case "I":
                        BEPedidoFICDetalle obe;
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            obe = sv.InsertFIC(obePedidoFicDetalle);
                        }
                        obe.ImporteTotal = obePedidoFicDetalle.ImporteTotal;
                        obe.DescripcionProd = obePedidoFicDetalle.DescripcionProd;
                        obe.Nombre = obePedidoFicDetalle.Nombre;

                        if (userData.PedidoID == 0)
                        {
                            userData.PedidoID = obe.PedidoID;
                            SetUserData(userData);
                        }

                        olstTempListado.Add(obe);

                        break;
                    case "U":

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdPedidoFICDetalle(obePedidoFicDetalle);
                        }

                        olstTempListado.Where(p => p.PedidoDetalleID == obePedidoFicDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = obePedidoFicDetalle.Cantidad;
                                p.ImporteTotal = obePedidoFicDetalle.ImporteTotal;
                                p.ClienteID = obePedidoFicDetalle.ClienteID;
                                p.DescripcionProd = obePedidoFicDetalle.DescripcionProd;
                                p.Nombre = obePedidoFicDetalle.Nombre;
                            });

                        break;
                    case "D":
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.DelPedidoFICDetalle(obePedidoFicDetalle);
                        }
                        olstTempListado.RemoveAll(p => p.PedidoDetalleID == obePedidoFicDetalle.PedidoDetalleID);
                        break;
                    case "I_S":
                        obePedidoFicDetalle.PedidoDetalleID = Convert.ToInt16((1000 + DateTime.Now.Second + DateTime.Now.Millisecond).ToString());
                        obePedidoFicDetalle.EstadoItem = 1;
                        obePedidoFicDetalle.CUVNuevo = true;
                        obePedidoFicDetalle.ClaseFila = "f3";
                        olstTempListado.Add(obePedidoFicDetalle);
                        break;
                    case "U_S":
                        olstTempListado.Where(p => p.PedidoDetalleID == obePedidoFicDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = obePedidoFicDetalle.Cantidad;
                                p.ImporteTotal = obePedidoFicDetalle.ImporteTotal;
                                p.ClienteID = obePedidoFicDetalle.ClienteID;
                                p.DescripcionProd = obePedidoFicDetalle.DescripcionProd;
                                p.Nombre = obePedidoFicDetalle.Nombre;
                                p.EstadoItem = 2;
                                p.ClaseFila = "f3";
                                p.Stock = obePedidoFicDetalle.Stock;
                                p.Flag = obePedidoFicDetalle.Flag;
                                p.EliminadoTemporal = obePedidoFicDetalle.EliminadoTemporal;
                            });
                        break;
                    case "D_S":
                        olstTempListado.Where(p => p.PedidoDetalleID == obePedidoFicDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.EstadoItem = 3;
                                p.EliminadoTemporal = true;
                            });
                        break;
                }

                olstTempListado = olstTempListado.OrderByDescending(p => p.PedidoDetalleID).ToList();
                Session[Constantes.ConstSession.PedidoFIC] = olstTempListado;

                errorServer = false;
            }
            catch
            {
                if (Session[Constantes.ConstSession.PedidoFIC] != null) olstTempListado = (List<BEPedidoFICDetalle>)Session[Constantes.ConstSession.PedidoFIC];
                errorServer = true;
            }

            return olstTempListado;
        }

        private int CalcularTotalCliente(List<BEPedidoFICDetalle> pedido, BEPedidoFICDetalle itemPedido, short pedidoDetalleId, string adm)
        {
            List<BEPedidoFICDetalle> temp = new List<BEPedidoFICDetalle>(pedido);
            if (pedidoDetalleId == 0)
            {
                if (adm == "I" || adm == "I_S")
                    temp.Add(itemPedido);
                else
                    temp.Where(p => p.PedidoDetalleID == itemPedido.PedidoDetalleID).Update(p => p.ClienteID = itemPedido.ClienteID);

            }
            else
                temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();

            return temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private decimal CalcularTotalImporte(List<BEPedidoFICDetalle> pedido, BEPedidoFICDetalle itemPedido, short pedidoDetalleId, string adm)
        {
            List<BEPedidoFICDetalle> temp = new List<BEPedidoFICDetalle>(pedido);
            if (pedidoDetalleId == 0)
                temp.Add(itemPedido);
            else
                temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();
            return temp.Sum(p => p.ImporteTotal) + (adm == "U" || adm == "U_S" ? itemPedido.ImporteTotal : 0);
        }

        private short ValidarInsercion(List<BEPedidoFICDetalle> pedido, BEPedidoFICDetalle itemPedido, out int cantidad)
        {
            List<BEPedidoFICDetalle> temp = new List<BEPedidoFICDetalle>(pedido);
            BEPedidoFICDetalle obe = temp.FirstOrDefault(p => p.ClienteID == itemPedido.ClienteID && p.CUV == itemPedido.CUV);
            cantidad = obe != null ? obe.Cantidad : 0;
            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        private short ValidarInsercionSession(List<BEPedidoFICDetalle> pedido, BEPedidoFICDetalle itemPedido, out int cantidad, out bool eliminacion, out short pedidoDetalleId)
        {
            List<BEPedidoFICDetalle> temp = new List<BEPedidoFICDetalle>(pedido);
            BEPedidoFICDetalle obe = temp.FirstOrDefault(p => p.ClienteID == itemPedido.ClienteID && p.CUV == itemPedido.CUV);
            cantidad = obe != null ? obe.Cantidad : 0;
            if (obe != null)
            {
                eliminacion = obe.EliminadoTemporal;
                pedidoDetalleId = obe.PedidoDetalleID;
            }
            else
            {
                pedidoDetalleId = (short)0;
                eliminacion = false;
            }

            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        #endregion
    }
}
