using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using System.ServiceModel;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServicePedido;
using AutoMapper;
using Portal.Consultoras.Common;
using System.IO;
using System.Configuration;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertaLiquidacionController : BaseController
    {
        #region Visualización de Pedidos Liquidación

        public ActionResult OfertasLiquidacion()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaLiquidacion/OfertasLiquidacion"))
                    return RedirectToAction("Index", "Bienvenida");
                ViewBag.CampaniaID = userData.CampaniaID.ToString();
                ViewBag.ISO = userData.CodigoISO.ToString();
                ViewBag.Simbolo = userData.Simbolo.ToString().Trim();
                //var lista = GetListadoOfertasLiquidacion();
                //if (lista != null && lista.Count > 0)
                //    lista.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                BEConfiguracionCampania oBEConfiguracionCampania = null;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }
                if (oBEConfiguracionCampania != null)
                    ValidarStatusCampania(oBEConfiguracionCampania);
                //ViewBag.ListaOfertasLiquidacion = lista;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View("OfertasLiquidacion");
        }

        public string GetDescripcionMarca(int MarcaID)
        {
            string result = string.Empty;

            switch (MarcaID)
            {
                case 1: result = "Lbel";
                    break;
                case 2: result = "Esika";
                    break;
                case 3: result = "Cyzone";
                    break;
                case 6: result = "Finart";
                    break;
            }

            return result;
        }

        private void ValidarStatusCampania(BEConfiguracionCampania oBEConfiguracionCampania)
        {
            UsuarioModel usuario = userData;
            usuario.ZonaValida = oBEConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = oBEConfiguracionCampania.FechaInicioFacturacion;

            usuario.FechaFinCampania = oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(oBEConfiguracionCampania.DiasDuracionCronograma - 1);

            usuario.HoraInicioReserva = oBEConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = oBEConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = oBEConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = oBEConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = oBEConfiguracionCampania.DiasAntes;
            //usuario.DiaPROL = ValidarPROL(usuario);
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

        [HttpGet] 
        public JsonResult JsonGetOfertasLiquidacion(int offset, int cantidadregistros)
        {
            var lst = new List<BEOfertaProducto>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetOfertaProductosPortal2(userData.PaisID, Constantes.ConfiguracionOferta.Liquidacion, 1, userData.CampaniaID, offset, cantidadregistros).ToList();
            }
            ViewBag.Simbolo = userData.Simbolo.ToString().Trim();
            Mapper.CreateMap<BEOfertaProducto, OfertaProductoModel>()
                  .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                  .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                  .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                  .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                  .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                  .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                  .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                  .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                  .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                  .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                  .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                  .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                  .ForMember(t => t.OfertaProductoID, f => f.MapFrom(c => c.OfertaProductoID))
                  .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal))
                  .ForMember(t => t.TallaColor, f => f.MapFrom(c => c.TallaColor))
                  .ForMember(t => t.DescripcionMarca, f => f.MapFrom(c => c.DescripcionMarca))
                  .ForMember(t => t.DescripcionCategoria, f => f.MapFrom(c => c.DescripcionCategoria))
                  .ForMember(t => t.DescripcionEstrategia, f => f.MapFrom(c => c.DescripcionEstrategia));

            // 1664
            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                lst.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                lst.Update(x => x.PrecioString = Util.DecimalToStringFormat(x.PrecioOferta, userData.CodigoISO));
            }

            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public PartialViewResult GetListadoOfertasLiquidacionPaginado(int offset, int cantidadregistros)
        {
            int dobleCantidadRegistros = cantidadregistros * 2;
            var lst = new List<BEOfertaProducto>();
            OfertaLiquidacionModel modelo = new OfertaLiquidacionModel()
            {
                MostrarVerMas = false
            };
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetOfertaProductosPortal2(userData.PaisID, Constantes.ConfiguracionOferta.Liquidacion, 1, userData.CampaniaID, offset, dobleCantidadRegistros).ToList();
            }

            ViewBag.Simbolo = userData.Simbolo.ToString().Trim();
            Mapper.CreateMap<BEOfertaProducto, OfertaProductoModel>()
                  .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                  .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                  .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                  .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                  .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                  .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                  .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                  .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                  .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                  .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                  .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                  .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                  .ForMember(t => t.OfertaProductoID, f => f.MapFrom(c => c.OfertaProductoID))
                  .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal))
                  .ForMember(t => t.TallaColor, f => f.MapFrom(c => c.TallaColor))
                  .ForMember(t => t.DescripcionMarca, f => f.MapFrom(c => c.DescripcionMarca))
                  .ForMember(t => t.DescripcionCategoria, f => f.MapFrom(c => c.DescripcionCategoria))
                  .ForMember(t => t.DescripcionEstrategia, f => f.MapFrom(c => c.DescripcionEstrategia));

            if (lst != null && lst.Count > 0)
            {
                if (lst.Count > cantidadregistros)
                {
                    modelo.MostrarVerMas = true;
                }

                lst = lst.Take(cantidadregistros).ToList();
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                lst.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
            }

            modelo.ListaProductos = Mapper.Map<IList<BEOfertaProducto>, List<OfertaProductoModel>>(lst);
            return PartialView("_ListadoOfertasLiquidacion", modelo);
        }

        public List<OfertaProductoModel> GetListadoOfertasLiquidacion()
        {
            var lst = new List<BEOfertaProducto>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int Cantidad = sv.ObtenerMaximoItemsaMostrarLiquidacion(userData.PaisID);
                lst = sv.GetOfertaProductosPortal(userData.PaisID, Constantes.ConfiguracionOferta.Liquidacion, 1, userData.CampaniaID).Take(Cantidad).ToList();
            }

            Mapper.CreateMap<BEOfertaProducto, OfertaProductoModel>()
                  .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                  .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                  .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                  .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                  .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                  .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                  .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                  .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                  .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                  .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                  .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                  .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                  .ForMember(t => t.OfertaProductoID, f => f.MapFrom(c => c.OfertaProductoID))
                  .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal))
                  .ForMember(t => t.TallaColor, f => f.MapFrom(c => c.TallaColor))
                  .ForMember(t => t.DescripcionMarca, f => f.MapFrom(c => c.DescripcionMarca))
                  .ForMember(t => t.DescripcionCategoria, f => f.MapFrom(c => c.DescripcionCategoria))
                  .ForMember(t => t.DescripcionEstrategia, f => f.MapFrom(c => c.DescripcionEstrategia));

            // 1664
            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
            }

            return Mapper.Map<IList<BEOfertaProducto>, List<OfertaProductoModel>>(lst);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
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
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;
                    entidad.IPUsuario = userData.IPUsuario;

                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;

                    sv.InsPedidoWebDetalleOferta(entidad);

                    SessionKeys.ClearSessionCantidadProductos();
                    SessionKeys.ClearSessionResumenCampania();
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
                Mapper.CreateMap<PedidoDetalleModel, BEPedidoWebDetalle>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CantidadAnterior, f => f.MapFrom(c => c.CantidadAnterior))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                    .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                    .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad))
                    .ForMember(t => t.PrecioUnidad, f => f.MapFrom(c => c.PrecioUnidad))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Flag, f => f.MapFrom(c => c.Flag))
                    .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                    .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                    .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID));

                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;

                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;

                    sv.UpdPedidoWebDetalleOferta(entidad);
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

        public JsonResult ObtenerStockActualProducto(string CUV)
        {
            int Stock = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Stock = sv.GetStockOfertaProductoLiquidacion(userData.PaisID, userData.CampaniaID, CUV);
            }

            return Json(new
            {
                Stock = Stock
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerStockActualProductoLista(List<ValidacionStockModel> Lista)
        {
            string msj = string.Empty;

            if (Lista.Count > 0)
            {
                for (int i = 0; i < Lista.Count; i++)
                {
                    int Stock = 0;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        Stock = sv.GetStockOfertaProductoLiquidacion(userData.PaisID, userData.CampaniaID, Lista[i].CUV);
                    }

                    if (Lista[i].Stock > Stock)
                        msj += "- El stock para el CUV <b>" + Lista[i].CUV + "</b> es <b>" + Stock + "</b> unidades deberá validar la cantidad nuevamente.\n";
                }
            }
            return Json(new
            {
                Mensaje = msj
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerUnidadesPermitidasProducto(string CUV)
        {
            int UnidadesPermitidas = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                UnidadesPermitidas = sv.GetUnidadesPermitidasByCuv(userData.PaisID, userData.CampaniaID, CUV);
            }

            return Json(new
            {
                UnidadesPermitidas = UnidadesPermitidas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV)
        {
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
                UnidadesPermitidas = sv.GetUnidadesPermitidasByCuv(userData.PaisID, userData.CampaniaID, CUV);
                Saldo = sv.ValidarUnidadesPermitidasEnPedido(userData.PaisID, userData.CampaniaID, CUV, userData.ConsultoraID);
                CantidadPedida = sv.CantidadPedidoByConsultora(entidad);
            }

            return Json(new
            {
                UnidadesPermitidas = UnidadesPermitidas,
                Saldo = Saldo,
                CantidadPedida = CantidadPedida
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCantidadMaximaPorPais(int paisID)
        {
            int Cantidad = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Cantidad = sv.ObtenerMaximoItemsaMostrarLiquidacion(paisID);
            }

            return Json(new
            {
                Cantidad = Cantidad
            }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Administrador de Ofertas de Liquidación

        public ActionResult AdministrarOfertasLiquidacion()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaLiquidacion/AdministrarOfertasLiquidacion"))
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

        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        private IEnumerable<PaisModel> DropDowListPaises()
        {
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

        public JsonResult ObtenerDatosAdministracionCorreo(int paisID)
        {
            List<BEAdministracionOfertaProducto> lst = new List<BEAdministracionOfertaProducto>();

            if (paisID > 0)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetDatosAdmStockMinimoCorreos(paisID).ToList();
                }
            }

            if (lst.Count > 0)
            {
                return Json(new
                {
                    Correo = lst[0].Correos,
                    Stock = lst[0].StockMinimo
                }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new
                {
                    Correo = string.Empty,
                    Stock = string.Empty
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisID)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisID, Constantes.ConfiguracionOferta.Liquidacion).ToList();
                lst = lstConfiguracion;
            }
            Mapper.CreateMap<BEConfiguracionOferta, ConfiguracionOfertaModel>()
                    .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                    .ForMember(t => t.CodigoOferta, f => f.MapFrom(c => c.CodigoOferta))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        }

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

        public JsonResult ObtenerImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
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
                FlagExiste = sv.ValidarPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
            }

            return Json(new
            {
                FlagExiste = FlagExiste
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ConsultarOfertaLiquidacion(string sidx, string sord, int page, int rows, int PaisID, string codigoOferta, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaProducto> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosByTipoOferta(PaisID, Constantes.ConfiguracionOferta.Liquidacion, CampaniaID, codigoOferta).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEOfertaProducto> items = lst;

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
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);
                string ISO = Util.GetPaisISO(PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO;
                // lst.Update(x => x.ImagenProducto = (x.ImagenProducto.ToString().Equals(string.Empty) ? string.Empty : (ISO + "/" + x.ImagenProducto)));
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
                                   a.StockInicial.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.ImagenProducto.ToString(),
                                   a.CampaniaID.ToString() ,
                                   a.Stock.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaProductoID.ToString(),
                                   a.CodigoTipoOferta.ToString().Trim(),
                                   a.ISOPais.ToString(),
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.CodigoProducto.ToString()
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
                Mapper.CreateMap<OfertaProductoModel, BEOfertaProducto>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
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

                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    //string tempNombreImagenFondo = model.ImagenProducto;
                    //if (model.FlagImagen == 1)
                    //{
                    //    entidad.ImagenProducto = FileManager.CopyImagesOfertas(Globals.RutaImagenesOfertasLiquidacion + "\\" + userData.CodigoISO + "\\" + model.CodigoCampania, tempNombreImagenFondo, Globals.RutaImagenesTempOfertas, userData.CodigoISO, model.CodigoCampania, model.CUV);
                    //    FileManager.DeleteImagesInFolder(Globals.RutaImagenesTempOfertas);
                    //}
                    //else
                    //    entidad.ImagenProducto = string.Empty;
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;
                    sv.InsOfertaProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Liquidación satisfactoriamente.",
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
        public JsonResult UpdateOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                Mapper.CreateMap<OfertaProductoModel, BEOfertaProducto>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
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

                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    //string tempNombreImagenFondo = model.ImagenProducto;
                    //string imgAnterior = System.IO.Path.GetFileName(model.ImagenProductoAnterior).ToString().Trim();
                    //string img = System.IO.Path.GetFileName(model.ImagenProducto);
                    //if (model.FlagImagen == 1)
                    //{
                    //    FileManager.DeleteImage(Globals.RutaImagenesOfertasLiquidacion + "\\" + userData.CodigoISO + "\\" + model.CodigoCampania, imgAnterior);
                    //    entidad.ImagenProducto = FileManager.CopyImagesOfertas(Globals.RutaImagenesOfertasLiquidacion + "\\" + userData.CodigoISO + "\\" + model.CodigoCampania, tempNombreImagenFondo, Globals.RutaImagenesTempOfertas, userData.CodigoISO, model.CodigoCampania, model.CUV);
                    //    FileManager.DeleteImagesInFolder(Globals.RutaImagenesTempOfertas);
                    //}
                    //else
                    //    entidad.ImagenProducto = (img == "prod_grilla_vacio.png" ? string.Empty : img);
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    //entidad.Stock = model.Cantida;
                    sv.UpdOfertaProducto(entidad);
                    //sv.UpdOfertaProductoStock()
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Liquidación satisfactoriamente.",
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
                Mapper.CreateMap<OfertaProductoModel, BEOfertaProducto>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
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

                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora.ToString();
                    sv.DelOfertaProducto(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito la Oferta de Liquidación satisfactoriamente.",
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
            string message = string.Empty;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV
                string finalPath = string.Empty;
                List<BEOfertaProducto> lstStock = new List<BEOfertaProducto>(); ;

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
                        lstStock.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion);
                        List<BEOfertaProducto> lstPaises = lstStock.GroupBy(x => x.ISOPais).Select(g => g.First()).ToList();

                        for (int i = 0; i < lstPaises.Count; i++)
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                List<BEOfertaProducto> lstStockTemporal = lstStock.FindAll(x => x.ISOPais == lstPaises[i].ISOPais);
                                int paisID = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisID > 0)
                                {
                                    try
                                    {
                                        registros += sv.UpdOfertaProductoStockMasivo(paisID, lstStockTemporal.ToArray());

                                        #region Log de Cargas de Stock
                                        using (PedidoServiceClient srv = new PedidoServiceClient())
                                        {
                                            BEStockCargaLog ent = new BEStockCargaLog();
                                            ent.CantidadRegistros = registros;
                                            ent.PaisID = paisID;
                                            ent.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;
                                            ent.UsuarioRegistro = userData.CodigoConsultora;
                                            srv.InsStockCargaLog(ent);
                                        }
                                        #endregion
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
        public JsonResult AdministrarCorreosOferta(AdministracionOfertaProductoModel model)
        {
            try
            {
                Mapper.CreateMap<AdministracionOfertaProductoModel, BEAdministracionOfertaProducto>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.OfertaAdmID, f => f.MapFrom(c => c.OfertaAdmID))
                    .ForMember(t => t.Correos, f => f.MapFrom(c => c.Correos))
                    .ForMember(t => t.StockMinimo, f => f.MapFrom(c => c.StockMinimo));

                BEAdministracionOfertaProducto entidad = Mapper.Map<AdministracionOfertaProductoModel, BEAdministracionOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora.ToString();
                    entidad.UsuarioRegistro = userData.CodigoConsultora.ToString();
                    if (model.FlagRegistro == 0)
                        sv.InsAdministracionStockMinimo(entidad);
                    else
                        sv.UpdAdministracionStockMinimo(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró satisfactoriamente la Administración del Stock Mínimo.",
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

        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;

            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        [HttpPost]
        public JsonResult ActualizarCantidadMaximaMostrar(int PaisID, int Cantidad)
        {
            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.ActualizarItemsMostrarLiquidacion(PaisID, Cantidad);
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

        public ActionResult ExportarExcel(int vPaisID, int vCampania, string vCodigoOferta)
        {
            List<BEOfertaProducto> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetProductosByTipoOferta(vPaisID, Constantes.ConfiguracionOferta.Liquidacion, vCampania, vCodigoOferta).ToList();
            }
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Tipo Oferta", "TipoOferta");
            dic.Add("Código SAP", "CodigoProducto");
            dic.Add("Campaña", "CodigoCampania");
            dic.Add("CUV", "CUV");
            dic.Add("Descripción", "Descripcion");
            dic.Add("Precio Oferta", "PrecioOferta");
            dic.Add("Priorización", "Orden");
            dic.Add("Stock", "Stock");
            dic.Add("Stock Inicial", "StockInicial");
            dic.Add("UnidadesPermitidas", "UnidadesPermitidas");
            Util.ExportToExcel("ProductosLiquidacion", lst, dic);
            return View();
        }

        /* 2024 - Inicio */

        [HttpGet]
        public ActionResult ConsultarTallaColor(string sidx, string sord, int page, int rows, string CampaniaID, string CUV)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaProducto> lst = new List<BEOfertaProducto>();

                var entidad = new BEOfertaProducto();
                entidad.PaisID = userData.PaisID;
                entidad.CampaniaID = Convert.ToInt32((CampaniaID != "") ? CampaniaID : "0");
                entidad.CUV = (CUV != "") ? CUV : "0";

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetTallaColorLiquidacion(entidad).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEOfertaProducto> items = lst;

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ID,
                               cell = new string[] 
                               {
                                   a.ID.ToString(),                                   
                                   a.CUV.ToString(),
                                   a.DescripcionCUV.ToString(),
                                   a.PrecioUnitario.ToString(),
                                   a.Tipo.ToString(),
                                   a.DescripcionTipo.ToString(),
                                   a.DescripcionTallaColor.ToString(),
                                   a.IDAux.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("AdministrarOfertasLiquidacion", "OfertaLiquidacion");
        }

        [HttpPost]
        public JsonResult RegistrarTallaColor(string Id, string Cuv, string CampaniaID, string Tipo, string Descripcion, string CUVPadre, string DescripcionCUV)
        {
            int resultado = 0;
            try
            {
                var entidad = new BEOfertaProducto();
                entidad.ID = Convert.ToInt32(Id);
                entidad.CUV = Cuv;
                entidad.CUVPadre = CUVPadre;
                entidad.Tipo = Tipo;
                entidad.CampaniaID = Convert.ToInt32(CampaniaID);
                entidad.PaisID = userData.PaisID;
                entidad.DescripcionTallaColor = Descripcion;
                entidad.UsuarioRegistro = userData.CodigoUsuario;
                entidad.UsuarioModificacion = userData.CodigoUsuario;
                entidad.DescripcionCUV = DescripcionCUV;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.InsertarTallaColorLiquidacion(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito.",
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
        public JsonResult EliminarTallaColor(string Id)
        {
            int resultado = 0;
            try
            {
                var entidad = new BEOfertaProducto();
                entidad.ID = Convert.ToInt32(Id);
                entidad.PaisID = userData.PaisID;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.EliminarTallaColorLiquidacion(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se eliminó con éxito.",
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
        public JsonResult GetOfertaByCUV(string CampaniaID, string CUV)
        {
            try
            {
                List<BEOfertaProducto> lst = new List<BEOfertaProducto>();

                var entidad = new BEOfertaProducto();
                entidad.PaisID = userData.PaisID;
                entidad.CampaniaID = Convert.ToInt32(CampaniaID);
                entidad.CUV = CUV;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.ConsultarLiquidacionByCUV(entidad).ToList();
                }

                return Json(new
                {
                    success = true,
                    data = lst[0]
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message.ToString(),
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        /* 2024 - Fin */

        #endregion

        [HttpPost]
        public JsonResult RemoverOfertaLiquidacion(OfertaProductoModel model)
        {
            try
            {
                Mapper.CreateMap<OfertaProductoModel, BEOfertaProducto>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
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

                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora.ToString();
                    sv.RemoverOfertaLiquidacion(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se eliminó la Oferta de Liquidación satisfactoriamente.",
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
    }
}
