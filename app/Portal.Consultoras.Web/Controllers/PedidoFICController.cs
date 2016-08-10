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

namespace Portal.Consultoras.Web.Controllers
{
    public class PedidoFICController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
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
                olstPedidoFICDetalle = ObtenerPedidoWeb();

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

        private bool ValidarPROL(UsuarioModel usuario, out bool MostrarBotonValidar)
        {
            DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            bool DiaPROL = false;
            MostrarBotonValidar = false;
            //if (DateTime.Now.AddHours(oBEUsuario.ZonaHoraria) < oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes))
            if (FechaHoraActual > usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) &&
                FechaHoraActual < usuario.FechaInicioCampania)
            {
                TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                if (HoraNow > usuario.HoraInicioPreReserva && HoraNow < usuario.HoraFinPreReserva)
                    MostrarBotonValidar = true;
                else
                    MostrarBotonValidar = false;
                DiaPROL = true;
            }
            else
            {
                // rango de dias prol
                if (FechaHoraActual > usuario.FechaInicioCampania &&
                    FechaHoraActual < usuario.FechaFinCampania.AddDays(1))
                {
                    DiaPROL = true;
                    //MostrarBotonValidar = true;
                    TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                    if (HoraNow > usuario.HoraInicioReserva && HoraNow < usuario.HoraFinReserva)
                        MostrarBotonValidar = true;
                    else
                        MostrarBotonValidar = false;

                    //TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                    //// rango de horas permitidas
                    //if (HoraNow > usuario.HoraInicioReserva && 
                    //    HoraNow < usuario.HoraFinReserva)
                    //    DiaPROL = true;
                    //else
                    //    DiaPROL = false;
                }
            }
            return DiaPROL;
        }

        #region CRUD

        [HttpPost]
        public ActionResult Insert(PedidoDetalleModel model)
        {
            ViewBag.IndicadorOfertaFIC = UserData().IndicadorOfertaFIC;//SSAP CGI(Id Solicitud=1402)
            ViewBag.ImagenUrlOfertaFIC = UserData().ImagenURLOfertaFIC;//SSAP CGI(Id Solicitud=1402)

            PedidoFICDetalleModel PedidoModelo = new PedidoFICDetalleModel();
            List<BEPedidoFICDetalle> olstPedidoFICDetalle = new List<BEPedidoFICDetalle>();

            UserData().PedidoID = 0;
            List<BEPedidoFICDetalle> olstPedidoFICDetal = new List<BEPedidoFICDetalle>();
            olstPedidoFICDetal = ObtenerPedidoWeb();
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
            if (UserData().ModificaPedido)
                olstPedidoFICDetalle = AdministradorPedido(oBEPedidoFICDetalle, "I_S", false, out ErrorServer);
            else
                olstPedidoFICDetalle = AdministradorPedido(oBEPedidoFICDetalle, "I", false, out ErrorServer);

            PedidoModelo.ListaDetalle = olstPedidoFICDetalle;
            PedidoModelo.Simbolo = UserData().Simbolo;

            if (UserData().ModificaPedido)
            {
                List<BEPedidoFICDetalle> Temp = new List<BEPedidoFICDetalle>(olstPedidoFICDetalle);
                PedidoModelo.Total = string.Format("{0:N2}", Temp.Where(p => p.EliminadoTemporal == false).Sum(p => p.ImporteTotal));
                PedidoModelo.Total_Minimo = string.Format("{0:N2}", olstPedidoFICDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal));
            }
            else
            {
                PedidoModelo.Total = string.Format("{0:N2}", olstPedidoFICDetalle.Sum(p => p.ImporteTotal));
                PedidoModelo.Total_Minimo = string.Format("{0:N2}", olstPedidoFICDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal));
            }

            if (!ErrorServer)
            {
                if (Request.IsAjaxRequest())
                {
                    return PartialView("ListadoPedido", PedidoModelo);
                }
            }
            else
            {
                ModelState.AddModelError("", "Ocurrió un error al ejecutar la operación.");
                return PartialView("ListadoPedido", PedidoModelo);

            }

            return RedirectToAction("Index");
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
            if (UserData().ModificaPedido)
                AdministradorPedido(oBEPedidoFICDetalle, "U_S", false, out ErrorServer);
            else
                AdministradorPedido(oBEPedidoFICDetalle, "U", false, out ErrorServer);

            message = ErrorServer ? "Hubo un problema al intentar actualizar el registro. Por favor inténtelo nuevamente." : "El registro ha sido actualizado de manera exitosa.";

            return Json(new
            {
                success = !ErrorServer,
                message = message,
                extra = ""
            });
        }

        [HttpPost]
        public ActionResult Delete(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string CUV, int Cantidad)
        {
            PedidoFICDetalleModel PedidoModelo = new PedidoFICDetalleModel();
            PedidoModelo.Simbolo = UserData().Simbolo;
            List<BEPedidoFICDetalle> olstPedidoFICDetalle = new List<BEPedidoFICDetalle>();
            BEPedidoFICDetalle obe = new BEPedidoFICDetalle();
            obe.PaisID = UserData().PaisID;
            obe.CampaniaID = CampaniaID;
            obe.PedidoID = PedidoID;
            obe.PedidoDetalleID = PedidoDetalleID;
            obe.TipoOfertaSisID = TipoOfertaSisID;
            obe.CUV = CUV;
            obe.Cantidad = Cantidad;

            bool ErrorServer = false;
            string mensaje = string.Empty;
            // se valida si esta en horario restringido
            if (ValidarHorarioRestringido(out mensaje))
            {
                // se crea el mensaje de error
                ViewBag.ErrorDelete = mensaje;
                ModelState.AddModelError("", mensaje);
                // se restaura el modelo de la vista
                if (Session["PedidoFIC"] == null)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        olstPedidoFICDetalle = sv.SelectFICByCampania(UserData().PaisID, CampaniaSiguiente(UserData().CampaniaID), UserData().ConsultoraID, UserData().NombreConsultora).ToList();
                    }
                    Session["PedidoFIC"] = olstPedidoFICDetalle;
                }
                else
                    olstPedidoFICDetalle = (List<BEPedidoFICDetalle>)Session["PedidoFIC"];
                PedidoModelo.ListaDetalle = olstPedidoFICDetalle;
                PedidoModelo.Total = string.Format("{0:N2}", olstPedidoFICDetalle.Sum(p => p.ImporteTotal));
                return PartialView("ListadoPedido", PedidoModelo);
            }

            if (UserData().ModificaPedido)
                olstPedidoFICDetalle = AdministradorPedido(obe, "D_S", false, out ErrorServer);
            else
                olstPedidoFICDetalle = AdministradorPedido(obe, "D", false, out ErrorServer);

            PedidoModelo.ListaDetalle = olstPedidoFICDetalle;
            PedidoModelo.Simbolo = UserData().Simbolo;
            if (UserData().ModificaPedido)
            {
                List<BEPedidoFICDetalle> Temp = new List<BEPedidoFICDetalle>(olstPedidoFICDetalle);
                PedidoModelo.Total = string.Format("{0:N2}", Temp.Where(p => p.EliminadoTemporal == false).Sum(p => p.ImporteTotal));
                PedidoModelo.Total_Minimo = string.Format("{0:N2}", olstPedidoFICDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal));
            }
            else
            {
                PedidoModelo.Total = string.Format("{0:N2}", olstPedidoFICDetalle.Sum(p => p.ImporteTotal));
                PedidoModelo.Total_Minimo = string.Format("{0:N2}", olstPedidoFICDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal));
            }

            if (!ErrorServer)
            {
                if (Request.IsAjaxRequest())
                {
                    return PartialView("ListadoPedido", PedidoModelo);
                }
            }
            else
            {
                ModelState.AddModelError("", "Ocurrió un error al ejecutar la operación.");
                return PartialView("ListadoPedido", PedidoModelo);
            }

            return RedirectToAction("Index");
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
            catch (Exception ex)
            {
                ErrorServer = true;
                message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            }

            return Json(new
            {
                success = ErrorServer,
                message = message,
                extra = ""
            });

        }

        #endregion

        #region Ofertas Web

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult GetOfertasWeb()
        {
            List<ServiceSAC.BEOfertaWeb> olstOfertaWeb = new List<ServiceSAC.BEOfertaWeb>();
            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                olstOfertaWeb = sv.GetOfertaWebByCampania(UserData().PaisID, UserData().CampaniaID, UserData().PedidoID, UserData().ConsultoraID).ToList();
            }

            PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();
            PedidoModelo.ListaOfertaWeb = olstOfertaWeb;
            PedidoModelo.MatrizOW = 3;
            PedidoModelo.Simbolo = UserData().Simbolo;

            if (Request.IsAjaxRequest())
            {
                return PartialView("ListadoOfertas", PedidoModelo);
            }

            return RedirectToAction("Index");

        }

        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult InsertOfertaWeb(PedidoDetalleModel model)
        {
            PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();
            List<ServiceSAC.BEOfertaWeb> olstOfertaWeb = new List<ServiceSAC.BEOfertaWeb>();

            BEPedidoFICDetalle oBEPedidoFICDetalle = new BEPedidoFICDetalle();
            oBEPedidoFICDetalle.CampaniaID = UserData().CampaniaID;
            oBEPedidoFICDetalle.ConsultoraID = UserData().ConsultoraID;
            oBEPedidoFICDetalle.PaisID = UserData().PaisID;
            oBEPedidoFICDetalle.ClienteID = 0;
            oBEPedidoFICDetalle.PedidoID = UserData().PedidoID;
            oBEPedidoFICDetalle.OfertaWeb = true;

            oBEPedidoFICDetalle.MarcaID = model.MarcaID;
            oBEPedidoFICDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
            oBEPedidoFICDetalle.PrecioUnidad = model.PrecioUnidad;
            oBEPedidoFICDetalle.CUV = model.CUV;
            oBEPedidoFICDetalle.ImporteTotal = oBEPedidoFICDetalle.Cantidad * oBEPedidoFICDetalle.PrecioUnidad;
            oBEPedidoFICDetalle.DescripcionProd = model.DescripcionProd;
            oBEPedidoFICDetalle.Nombre = UserData().NombreConsultora;

            //----------Solucion Temporal - Mejora PR - RD
            int IndicadorMontoMinimo = 1;
            try
            {
                List<BEProducto> olstProducto = new List<BEProducto>();
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcion(oBEPedidoFICDetalle.PaisID, oBEPedidoFICDetalle.CampaniaID, oBEPedidoFICDetalle.CUV, 1, 1).ToList();
                }

                if (olstProducto.Count != 0)
                {
                    IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo;
                }
            }
            catch (Exception ex)
            {

            }

            oBEPedidoFICDetalle.IndicadorMontoMinimo = IndicadorMontoMinimo;
            //----------------------------------------


            bool ErrorServer;
            if (UserData().ModificaPedido)
                AdministradorPedido(oBEPedidoFICDetalle, "I_S", false, out ErrorServer);
            else
                AdministradorPedido(oBEPedidoFICDetalle, "I", false, out ErrorServer);

            if (ErrorServer)
            {
                ModelState.AddModelError("CustomError", "Error al intentar añadir el producto al pedido.");
            }

            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                olstOfertaWeb = sv.GetOfertaWebByCampania(UserData().PaisID, UserData().CampaniaID, UserData().PedidoID, UserData().ConsultoraID).ToList();
            }

            PedidoModelo.ListaOfertaWeb = olstOfertaWeb;
            PedidoModelo.MatrizOW = 3;
            PedidoModelo.Simbolo = UserData().Simbolo;

            if (Request.IsAjaxRequest())
            {
                return PartialView("ListadoOfertas", PedidoModelo);
            }

            return RedirectToAction("Index");
        }

        /* Metodo desactivado para la primera fase. Tener en cuenta la nueva casuistica para la segunda*/
        [HttpPost]
        public ActionResult DeleteOfertaWeb(int CampaniaID, string CUV)
        {
            PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();
            List<ServiceSAC.BEOfertaWeb> olstOfertaWeb = new List<ServiceSAC.BEOfertaWeb>();
            if (ModelState.IsValid)
            {
                //using (PedidoServiceClient sv = new PedidoServiceClient())
                //{
                //    sv.DelPedidoWebDetalle(UserData().PaisID, CampaniaID, UserData().PedidoID, 0, CUV);
                //}
                using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                {
                    olstOfertaWeb = sv.GetOfertaWebByCampania(UserData().PaisID, UserData().CampaniaID, UserData().PedidoID, UserData().ConsultoraID).ToList();
                }

                PedidoModelo.ListaOfertaWeb = olstOfertaWeb;
                PedidoModelo.MatrizOW = 3;
                PedidoModelo.Simbolo = UserData().Simbolo;

                if (Request.IsAjaxRequest())
                {
                    return PartialView("ListadoOfertas", PedidoModelo);
                }
            }

            return RedirectToAction("Index");

        }

        #endregion

        #region Packs Ofertas para Nuevas

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult GuardarOfertaNueva(string vMarcaID, string vPrecioUnidad, string vCUV, string vIndicadorMontoMinimo, string vDescripcionProd)
        {
            var pedidoModel = new PedidoDetalleModel()
            {
                ClienteID = string.Empty,
                IndicadorMontoMinimo = vIndicadorMontoMinimo,
                Tipo = 1,
                MarcaID = Convert.ToByte(vMarcaID),
                Cantidad = "1",
                PrecioUnidad = Convert.ToDecimal(vPrecioUnidad),
                CUV = vCUV,
                DescripcionProd = vDescripcionProd,
                ConfiguracionOfertaID = Constantes.TipoOferta.Nueva,
                TipoOfertaSisID = Constantes.ConfiguracionOferta.Nueva
            };
            return Insert(pedidoModel);
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        private List<OfertaNuevaModel> ObtenerPackOfertasNuevasPorCampania(int vCampaniaID)
        {
            int result = UserData().ConsultoraNueva;
            int estado = -1;
            List<OfertaNuevaModel> lstresult = null;
            // Si es consultora nueva
            if (result == Constantes.ConsultoraNueva.Sicc ||
                result == Constantes.ConsultoraNueva.Fox)
            {
                List<BEOfertaNueva> lista;
                int vPaisID = UserData().PaisID;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    result = svc.ObtenerEstadoPacksOfertasNuevas(vPaisID, UserData().CodigoConsultora);

                    if (result == 0) // Entro por primera vez, obtiene los packs de ofertas nuevas
                    {
                        string simbolo = UserData().Simbolo;
                        lista = svc.GetPackOfertasNuevasByCampania(vPaisID, vCampaniaID).ToList();

                        if (lista.Count > 0)
                            estado = result;

                        Mapper.CreateMap<BEOfertaNueva, OfertaNuevaModel>()
                       .ForMember(t => t.OfertaNuevaId, f => f.MapFrom(c => c.OfertaNuevaId))
                       .ForMember(t => t.NumeroPedido, f => f.MapFrom(c => c.NumeroPedido))
                       .ForMember(t => t.ImagenProducto01, f => f.MapFrom(c => c.ImagenProducto01))
                       .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                       .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                       .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                       .ForMember(t => t.IndicadorMontoMinimo, f => f.MapFrom(c => c.IndicadorMontoMinimo))
                       .ForMember(t => t.DescripcionProd, f => f.MapFrom(c => c.DescripcionProd))
                       .ForMember(t => t.PrecioNormal, f => f.MapFrom(c => c.PrecioNormal))
                       .ForMember(t => t.PrecioParaTi, f => f.MapFrom(c => c.PrecioParaTi))
                       .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas));

                        lstresult = Mapper.Map<IList<BEOfertaNueva>, List<OfertaNuevaModel>>(lista);
                        lstresult.Each(p => p.Simbolo = simbolo);
                    }
                }
            }
            ViewBag.EstadoOfertaNueva = estado;
            return lstresult;
        }

        #endregion

        #region Ofertas Flexipago

        public string CargarLinkPaisFlexipago()
        {
            string linkFlexipago = "";
            try
            {
                BEOfertaFlexipago entidad = null;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    int vPaisID = UserData().PaisID;
                    entidad = svc.GetLinksOfertaFlexipago(vPaisID);
                    entidad.PaisID = vPaisID;
                }

                if (!string.IsNullOrEmpty(entidad.LinksFlexipago))
                    linkFlexipago = entidad.LinksFlexipago;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return linkFlexipago;
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        private void ObtenerLineaCredito()
        {
            try
            {
                int vPaisID = UserData().PaisID;
                string consultora = UserData().CodigoConsultora;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    int CampaniaID = UserData().CampaniaID;
                    BEOfertaFlexipago oBe = svc.GetLineaCreditoFlexipago(vPaisID, consultora, CampaniaID);
                    ViewBag.LineaCredito = string.Format("{0:#,##0.00}", oBe.LineaCredito);
                    ViewBag.PedidoBase = string.Format("{0:#,##0.00}", oBe.PedidoBase);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                ViewBag.LineaCredito = "0.00";
                ViewBag.PedidoBase = "0.00";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                ViewBag.LineaCredito = "0.00";
                ViewBag.PedidoBase = "0.00";
            }
        }

        #endregion

        #region Productos Recomendados

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult GuardarProductoRecomendado(string MarcaID,
                                                       string CUV,
                                                       string PrecioUnidad,
                                                       string Descripcion,
                                                       string TipoOfertaSisID,
                                                       string ConfiguracionOfertaID,
                                                       string Cantidad,
                                                       string ClientID,
                                                       string ClienteDescripcion)
        {

            int IndicadorMontoMinimo = 1;
            try
            {
                List<BEProducto> olstProducto = new List<BEProducto>();
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcion(UserData().PaisID, UserData().CampaniaID, CUV, 1, 1).ToList();
                }

                if (olstProducto.Count != 0)
                {
                    IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo;
                }
            }
            catch (Exception ex)
            {

            }

            var pedidoModel = new PedidoDetalleModel()
            {
                ClienteID = string.IsNullOrEmpty(ClientID) ? string.Empty : ClientID,
                ClienteDescripcion = ClienteDescripcion,
                Tipo = 1,
                MarcaID = Convert.ToByte(MarcaID),
                Cantidad = Cantidad,
                PrecioUnidad = Convert.ToDecimal(PrecioUnidad),
                CUV = CUV,
                IndicadorMontoMinimo = IndicadorMontoMinimo.ToString(),
                DescripcionProd = Descripcion,
                TipoOfertaSisID = string.IsNullOrEmpty(TipoOfertaSisID) ? 0 : int.Parse(TipoOfertaSisID),
                ConfiguracionOfertaID = string.IsNullOrEmpty(ConfiguracionOfertaID) ? 0 : int.Parse(ConfiguracionOfertaID)
            };
            return Insert(pedidoModel);
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
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, CampaniaSiguiente(oUsuarioModel.CampaniaID), term, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 1, 5).ToList();
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
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, CampaniaSiguiente(oUsuarioModel.CampaniaID), model.CUV, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 1, 1).ToList();
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
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, CampaniaSiguiente(oUsuarioModel.CampaniaID), term, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 2, 5).ToList();
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

        public List<BEPedidoFICDetalle> ObtenerPedidoWeb()
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

        public List<BEPedidoFICDetalle> ObtenerPedidoWebServer()
        {
            List<BEPedidoFICDetalle> olstPedidoFICDetalle = new List<BEPedidoFICDetalle>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                olstPedidoFICDetalle = sv.SelectFICByCampania(UserData().PaisID, UserData().CampaniaID, UserData().ConsultoraID, UserData().NombreConsultora).ToList();
            }

            Session["PedidoFIC"] = olstPedidoFICDetalle;
            return olstPedidoFICDetalle;
        }


        #region Vista Campaña y Zona No Configurada

        public ActionResult CampaniaZonaNoConfigurada()
        {
            if (UserData().CampaniaID == 0)
                ViewBag.MensajeCampaniaZona = "Campaña";
            else
                ViewBag.MensajeCampaniaZona = "Zona";
            return View();
        }

        #endregion

        public ServicePROL.TransferirDatos Devolver()
        {
            ServicePROL.TransferirDatos datos = new ServicePROL.TransferirDatos();
            datos.codigoMensaje = "00";
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();

            dt.Columns.Add("0");
            dt.Columns.Add("1");
            dt.Columns.Add("2");
            dt.Columns.Add("3");

            dt.Rows.Add("1", "05400", "Test", "Test");
            //dt.Rows.Add("1", "05400", "Test", "Test");

            ds.Tables.Add(dt);


            datos.data = ds;


            return datos;
        }

        public ServicePROL.TransferirDatos Devolver2()
        {
            ServicePROL.TransferirDatos datos = new ServicePROL.TransferirDatos();
            datos.codigoMensaje = "00";
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();

            dt.Columns.Add("0");
            dt.Columns.Add("1");
            dt.Columns.Add("2");
            dt.Columns.Add("3");
            dt.Columns.Add("4");
            dt.Columns.Add("5");

            dt.Rows.Add("05400", "ES AVENTOUR EDT 100 ML", "17.90", "12", "214.80", "1");
            //dt.Rows.Add("04808", "ES AVENTOUR EDT 100 ML 2", "15.0", "2", "30.0", "0");

            ds.Tables.Add(dt);


            datos.data = ds;


            return datos;
        }

        private List<BEPedidoFICDetalle> PedidoJerarquico(List<BEPedidoFICDetalle> ListadoPedidos)
        {
            List<BEPedidoFICDetalle> Result = new List<BEPedidoFICDetalle>();
            List<BEPedidoFICDetalle> Padres = ListadoPedidos.Where(p => p.PedidoDetalleIDPadre == 0).ToList();
            foreach (var item in Padres)
            {
                Result.Add(item);
                var items = ListadoPedidos.Where(p => p.PedidoDetalleIDPadre == item.PedidoDetalleID);
                if (items.Count() != 0)
                    Result.AddRange(items);
            }

            return Result;
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

        private void CalcularMasivo(List<BEPedidoFICDetalle> Pedido, List<BEPedidoFICDetalle> Actualizar, bool Modifica, out int Clientes, out decimal Importe)
        {
            List<BEPedidoFICDetalle> TempPedido = new List<BEPedidoFICDetalle>(Pedido);
            List<BEPedidoFICDetalle> TempActualizar = new List<BEPedidoFICDetalle>(Actualizar);

            foreach (var item in TempActualizar)
            {
                TempPedido.Where(p => p.PedidoDetalleID == item.PedidoDetalleID).Update(p =>
                {
                    p.Cantidad = item.Cantidad;
                    p.ImporteTotal = item.ImporteTotal;
                    p.ClienteID = item.ClienteID;
                    p.EstadoItem = Modifica == true ? (short)2 : (short)0;
                });
            }

            Clientes = TempPedido.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
            Importe = TempPedido.Sum(p => p.ImporteTotal);
        }

        // OGA: valida si estamos en dia PROL y fuera del horario permitido (true = en horario restringido, false = en horario normal)
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

        //private bool ValidarHorarioRestringido_VERSION_ANTERIOR(out string mensaje)
        //{
        //    bool enHorarioRestringido = false;
        //    mensaje = string.Empty;
        //    UsuarioModel usuario = (UsuarioModel)Session["UserData"];
        //    DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);

        //    // si no es dia prol se devuelve false sino se analiza el rango horario
        //    // tambien se valida el flag de habilitacion de restriccion horaria
        //    if (!usuario.DiaPROL || !usuario.HabilitarRestriccionHoraria)
        //        return false;
        //    else
        //    {
        //        //if (DateTime.Now.AddHours(usuario.ZonaHoraria) < usuario.FechaInicioFacturacion.AddDays(-usuario.DiasAntes))
        //        //if (FechaHoraActual > usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) &&
        //        //FechaHoraActual < usuario.FechaInicioCampania)
        //        //if (FechaHoraActual >= usuario.FechaInicioCampania.AddDays(-usuario.DiasAntes) &&
        //        //    FechaHoraActual < usuario.FechaInicioCampania)
        //        if (FechaHoraActual >= usuario.FechaInicioCampania &&
        //           FechaHoraActual < usuario.FechaInicioCampania)
        //        {
        //            TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
        //            if (HoraNow > usuario.HoraInicioPreReserva && HoraNow < usuario.HoraFinPreReserva)
        //                enHorarioRestringido = false;
        //            else
        //                enHorarioRestringido = true;
        //        }
        //        else
        //        {
        //            // rango de dias prol
        //            if (FechaHoraActual > usuario.FechaInicioCampania &&
        //                FechaHoraActual < usuario.FechaFinCampania.AddDays(1))
        //            {
        //                TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
        //                // rango de horas permitidas
        //                if (HoraNow > usuario.HoraInicioReserva &&
        //                    HoraNow < usuario.HoraFinReserva)
        //                    enHorarioRestringido = false;
        //                else
        //                    enHorarioRestringido = true;
        //            }
        //        }

        //        // si no es horario restringido se devuelve el resultado false , sino se prepara el mensaje correspondiente
        //        if (!enHorarioRestringido)
        //            return false;
        //        else
        //        {
        //            TimeSpan horaActual = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, FechaHoraActual.Second);
        //            // se halla la hora de inicio para el rango que corresponda
        //            TimeSpan? horaInicio = null;
        //            // dias previos a PROL
        //            if (FechaHoraActual > usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) &&
        //                FechaHoraActual < usuario.FechaInicioCampania)
        //            {
        //                horaInicio = usuario.HoraInicioPreReserva;
        //            }
        //            else // dias PROL
        //            {
        //                if (FechaHoraActual > usuario.FechaInicioCampania &&
        //                    FechaHoraActual < usuario.FechaFinCampania.AddDays(1))
        //                {
        //                    horaInicio = usuario.HoraInicioReserva;
        //                }
        //            }
        //            mensaje = string.Format("Se encuentra en horario restringido, no podrá realizar esta funcionalidad hasta las {0} del dia siguiente", horaInicio.ToString());
        //            return true;
        //        }
        //    }
        //}

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

        public string Demo()
        {
            return "demo";
        }


        public int CampaniaSiguiente(int CampaniaActual)
        {
            if (CampaniaActual.ToString().Substring(4,2) != "18")
                return CampaniaActual + 1;
            else
                return CampaniaActual + 83;
        }
        public JsonResult Insertar()
        {
            try
            {
                int IsInsert;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    BEPedidoWeb oBEPedidoWeb = new BEPedidoWeb();
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

        public string NombreMes(int Mes)
        {
            string Result = string.Empty;
            switch (Mes)
            {
                case 1: Result = "Enero";
                    break;
                case 2: Result = "Febrero";
                    break;
                case 3: Result = "Marzo";
                    break;
                case 4: Result = "Abril";
                    break;
                case 5: Result = "Mayo";
                    break;
                case 6: Result = "Junio";
                    break;
                case 7: Result = "Julio";
                    break;
                case 8: Result = "Agosto";
                    break;
                case 9: Result = "Setiembre";
                    break;
                case 10: Result = "Octubre";
                    break;
                case 11: Result = "Noviembre";
                    break;
                case 12: Result = "Diciembre";
                    break;
            }
            return Result;
        }
    }
}
