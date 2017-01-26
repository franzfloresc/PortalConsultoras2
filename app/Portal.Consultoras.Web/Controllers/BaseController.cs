using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [Authorize]
    public class BaseController : Controller
    {
        #region Variables

        protected UsuarioModel userData;

        #endregion

        #region Constructor

        public BaseController()
        {
            userData = new UsuarioModel();
        }

        #endregion

        #region Overrides

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                userData = UserData();

                if (userData == null)
                {
                    string URLSignOut = string.Empty;

                    if (Request.UrlReferrer != null && Request.UrlReferrer.ToString().Contains(Request.Url.Host))
                        URLSignOut = "/Login/SesionExpirada";
                    else
                        URLSignOut = "/Login/UserUnknown";

                    Session.Clear();
                    Session.Abandon();

                    filterContext.Result = new RedirectResult(URLSignOut);
                    return;
                }
                else
                {
                    ViewBag.Permiso = BuildMenu();
                    ViewBag.ProgramasBelcorpMenu = BuildMenuService();
                    ViewBag.codigoISOMenu = userData.CodigoISO;

                    if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                    {
                        ViewBag.SegmentoConsultoraMenu = userData.SegmentoID;
                    }
                    else
                    {
                        ViewBag.SegmentoConsultoraMenu = userData.SegmentoInternoID.HasValue ? userData.SegmentoInternoID.Value : userData.SegmentoID;
                    }

                    ViewBag.UrlRaizS3 = string.Format("{0}/{1}/{2}/", ConfigurationManager.AppSettings["URL_S3"], ConfigurationManager.AppSettings["BUCKET_NAME"], ConfigurationManager.AppSettings["ROOT_DIRECTORY"]);
                    ViewBag.ServiceController = ConfigurationManager.AppSettings["ServiceController"].ToString();
                    ViewBag.ServiceAction = ConfigurationManager.AppSettings["ServiceAction"].ToString();

                    ObtenerPedidoWeb();
                    ObtenerPedidoWebDetalle();

                    ViewBag.TieneOfertaDelDia = userData.TieneOfertaDelDia;

                    if (userData.TieneOfertaDelDia)
                    {
                        // validar si se cerro el banner
                        if (userData.CloseOfertaDelDia)
                            ViewBag.TieneOfertaDelDia = false;

                        // validar si tiene pedido reservado
                        string msg = string.Empty;
                        if (ValidarPedidoReservado(out msg))
                            ViewBag.TieneOfertaDelDia = false;
                    }
                }

                base.OnActionExecuting(filterContext);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        #endregion

        #region Métodos

        #region Pedido

        protected BEPedidoWeb ObtenerPedidoWeb()
        {
            BEPedidoWeb bePedidoWeb = new BEPedidoWeb();

            if (Session["PedidoWeb"] == null)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    bePedidoWeb = sv.GetPedidoWebByCampaniaConsultora(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
                }
                bePedidoWeb = bePedidoWeb ?? new BEPedidoWeb();
            }
            else
            {
                bePedidoWeb = (BEPedidoWeb)Session["PedidoWeb"];
            }

            bePedidoWeb = bePedidoWeb ?? new BEPedidoWeb();

            Session["PedidoWeb"] = bePedidoWeb;
            return bePedidoWeb;
        }

        protected List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle()
        {
            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();

            if (Session["PedidoWebDetalle"] == null)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    olstPedidoWebDetalle = sv.SelectByCampania(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                }
            }
            else
            {
                olstPedidoWebDetalle = (List<BEPedidoWebDetalle>)Session["PedidoWebDetalle"];
            }

            if (Session["ObservacionesPROL"] != null)
            {
                List<ObservacionModel> Observaciones = (List<ObservacionModel>)Session["ObservacionesPROL"];
                if (Observaciones != null)
                {
                    olstPedidoWebDetalle = PedidoConObservaciones(olstPedidoWebDetalle, Observaciones);
                }
            }

            olstPedidoWebDetalle = olstPedidoWebDetalle ?? new List<BEPedidoWebDetalle>();

            foreach (var item in olstPedidoWebDetalle)
            {
                item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
                item.Nombre = string.IsNullOrEmpty(item.Nombre) ? userData.NombreConsultora : item.Nombre;
            }

            Session["PedidoWebDetalle"] = olstPedidoWebDetalle;
            return olstPedidoWebDetalle;
        }

        protected List<BEPedidoWebDetalle> PedidoConObservaciones(List<BEPedidoWebDetalle> Pedido, List<ObservacionModel> Observaciones)
        {
            List<BEPedidoWebDetalle> PedObs = Pedido;

            if (userData.NuevoPROL && userData.ZonaNuevoPROL)
            {
                foreach (var item in PedObs)
                {
                    List<ObservacionModel> temp = Observaciones.Where(o => o.CUV == item.CUV).ToList();
                    if (temp != null && temp.Count != 0)
                    {
                        if (temp[0].Caso == 0)
                        {
                            item.ClaseFila = string.Empty;
                            item.TipoObservacion = 0;
                            item.Mensaje = string.Empty;
                        }
                        else
                        {
                            item.ClaseFila = temp[0].Tipo == 1 ? "f1" : "f2";
                            item.TipoObservacion = temp[0].Tipo;
                            item.Mensaje = string.Empty;
                        }
                        foreach (var ob in temp)
                        {
                            item.Mensaje += ob.Descripcion + "<br/>";
                        }
                    }
                    else
                    {
                        item.ClaseFila = string.Empty;
                        item.TipoObservacion = 0;
                        item.Mensaje = string.Empty;
                    }
                }
            }
            else
            {
                foreach (var item in PedObs)
                {
                    List<ObservacionModel> temp = Observaciones.Where(o => o.CUV == item.CUV).ToList();
                    if (temp != null && temp.Count != 0)
                    {
                        item.ClaseFila = temp[0].Tipo == 1 ? "f1" : "f2";
                        item.TipoObservacion = temp[0].Tipo;
                        item.Mensaje = string.Empty;
                        foreach (var ob in temp)
                        {
                            item.Mensaje += ob.Descripcion + "<br/>";
                        }
                    }
                    else
                    {
                        item.ClaseFila = string.Empty;
                        item.TipoObservacion = 0;
                        item.Mensaje = string.Empty;
                    }
                }
            }
            return PedObs.OrderByDescending(p => p.TipoObservacion).ToList();
        }

        protected List<ObjMontosProl> ServicioProl_CalculoMontosProl(bool session = true)
        {
            if (Session[Constantes.ConstSession.PROL_CalculoMontosProl] != null)
            {
                if (session)
                {
                    return (List<ObjMontosProl>)Session[Constantes.ConstSession.PROL_CalculoMontosProl];
                }
            }

            var listProducto = ObtenerPedidoWebDetalle();

            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("cuv");
            dt.Columns.Add("cantidad");
            foreach (var prod in listProducto)
            {
                dt.Rows.Add(prod.CUV, prod.Cantidad);
            }

            ds.Tables.Add(dt);

            var ambiente = ConfigurationManager.AppSettings["Ambiente"] ?? "";
            var keyWeb = ambiente.ToUpper() == "QA" ? "QA_Prol_ServicesCalculos" : "PR_Prol_ServicesCalculos";

            var rtpa = new List<ObjMontosProl>();
            using (var sv = new ServicesCalculosPROL.ServicesCalculoPrecioNiveles())
            {
                sv.Url = ConfigurationManager.AppSettings[keyWeb];
                rtpa = sv.CalculoMontosProl(userData.CodigoISO, userData.CampaniaID.ToString(), userData.CodigoConsultora.ToString(), userData.CodigoZona.ToString(), ds.Tables[0]).ToList();
            }

            rtpa = rtpa ?? new List<ObjMontosProl>();
            Session[Constantes.ConstSession.PROL_CalculoMontosProl] = rtpa;
            return rtpa;
        }

        protected void UpdPedidoWebMontosPROL()
        {
            userData.EjecutaProl = false;
            decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;

            var lista = ServicioProl_CalculoMontosProl(false);
            if (lista.Count > 0)
            {
                var datos = lista[0];
                Decimal.TryParse(datos.AhorroCatalogo, out montoAhorroCatalogo);
                Decimal.TryParse(datos.AhorroRevista, out montoAhorroRevista);
                Decimal.TryParse(datos.MontoTotalDescuento, out montoDescuento);
                Decimal.TryParse(datos.MontoEscala, out montoEscala);
            }

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                BEPedidoWeb bePedidoWeb = new BEPedidoWeb();
                bePedidoWeb.PaisID = userData.PaisID;
                bePedidoWeb.CampaniaID = userData.CampaniaID;
                bePedidoWeb.ConsultoraID = userData.ConsultoraID;
                bePedidoWeb.CodigoConsultora = userData.CodigoConsultora;
                bePedidoWeb.MontoAhorroCatalogo = montoAhorroCatalogo;
                bePedidoWeb.MontoAhorroRevista = montoAhorroRevista;
                bePedidoWeb.DescuentoProl = montoDescuento;
                bePedidoWeb.MontoEscala = montoEscala;

                sv.UpdateMontosPedidoWeb(bePedidoWeb);

                // poner en Session
                Session["PedidoWeb"] = null;
                userData.EjecutaProl = true;
                ObtenerPedidoWeb();
            }
        }

        protected bool ReservadoEnHorarioRestringido(out string mensaje)
        {
            if (userData == null)
            {
                mensaje = "Se sessión expiró, por favor vuelva a loguearse.";
                HttpContext.Session["UserData"] = null;
                HttpContext.Session.Clear();
                HttpContext.Session.Abandon();
                return true;
            }

            mensaje = "";
            if (EstaProcesoFacturacion(out mensaje)) return true;
            if (ValidarPedidoReservado(out mensaje)) return true;
            return ValidarHorarioRestringido(out mensaje);
        }

        protected bool EstaProcesoFacturacion(out string mensaje)
        {
            mensaje = "";
            if (userData.IndicadorGPRSB == 1)
            {
                mensaje = "En este momento nos encontramos facturando tu pedido de C" + userData.CampaniaID.ToString().Substring(4, 2) + ", inténtalo más tarde";
                return true;
            }
            return false;
        }

        protected bool ValidarPedidoReservado(out string mensaje)
        {
            mensaje = string.Empty;
            var ConsultoraID = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID;
            
            BEConfiguracionCampania oBEConfiguracionCampania = null;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                

                oBEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, ConsultoraID, userData.ZonaID, userData.RegionID);
            }
            if (oBEConfiguracionCampania != null && oBEConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                !oBEConfiguracionCampania.ModificaPedidoReservado && !oBEConfiguracionCampania.ValidacionAbierta)
            {
                mensaje = "Ya tienes un pedido reservado para esta campaña.";
                return true;
            }
            return false;
        }

        protected bool ValidarHorarioRestringido(out string mensaje)
        {
            bool enHorarioRestringido = false;
            mensaje = string.Empty;
            UsuarioModel usuario = (UsuarioModel)Session["UserData"];
            DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);

            if (!usuario.DiaPROL || !usuario.HabilitarRestriccionHoraria)
                return false;
            else
            {
                // rango de dias prol
                if (FechaHoraActual > usuario.FechaInicioCampania &&
                    FechaHoraActual < usuario.FechaFinCampania.AddDays(1))
                {
                    TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                    TimeSpan HoraAdicional = TimeSpan.Parse(usuario.HorasDuracionRestriccion.ToString() + ":00");
                    // si no es demanda anticipada se usa la hora de cierre normal
                    if (usuario.EsZonaDemAnti == 0)
                    {
                        if (HoraNow > usuario.HoraCierreZonaNormal && HoraNow < usuario.HoraCierreZonaNormal + HoraAdicional)
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
                    TimeSpan HoraCierrePais = usuario.EsZonaDemAnti == 0 ? usuario.HoraCierreZonaNormal : usuario.HoraCierreZonaDemAnti;
                    if (usuario.IngresoPedidoCierre)
                        mensaje = string.Format("Lamentablemente el rango de fechas para ingresar o modificar tu pedido ha concluido. Te recomendamos que en la siguiente campaña lo hagas antes de las {0}:{1} horas de tu día de facturación.", HoraCierrePais.Hours.ToString().PadLeft(2, '0'), HoraCierrePais.Minutes.ToString().PadLeft(2, '0'));
                    else
                        mensaje = string.Format("Se ha cerrado el período de facturación a las {0}:{1} horas. Todos los códigos ingresados hasta esa hora han sido registrados en el sistema. Gracias", HoraCierrePais.Hours.ToString().PadLeft(2, '0'), HoraCierrePais.Minutes.ToString().PadLeft(2, '0'));
                    return true;
                }
            }
        }

        #endregion

        #region Menú

        private List<PermisoModel> BuildMenu()
        {
            if (userData.Menu == null)
            {
                IList<ServiceSeguridad.BEPermiso> lst = new List<ServiceSeguridad.BEPermiso>();
                using (ServiceSeguridad.SeguridadServiceClient sv = new ServiceSeguridad.SeguridadServiceClient())
                {
                    lst = sv.GetPermisosByRol(userData.PaisID, userData.RolID).ToList();
                }

                string mostrarPedidosPendientes = ConfigurationManager.AppSettings.Get("MostrarPedidosPendientes");
                string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
                bool mostrarClienteOnline = (mostrarPedidosPendientes == "1" && strpaises.Contains(userData.CodigoISO));
                if (!mostrarClienteOnline) lst.Remove(lst.FirstOrDefault(p => p.UrlItem.ToLower() == "consultoraonline/index"));
                if (userData.IndicadorPermisoFIC == 0) lst.Remove(lst.FirstOrDefault(p => p.UrlItem.ToLower() == "pedidofic/index"));
                    if(userData.CatalogoPersonalizado == 0 || !userData.EsCatalogoPersonalizadoZonaValida) lst.Remove(lst.FirstOrDefault(p => p.UrlItem.ToLower() == "catalogopersonalizado/index"));

                List<PermisoModel> lstModel = new List<PermisoModel>();
                foreach (var permiso in lst)
                {
                    lstModel.Add(new PermisoModel
                    {
                        PermisoID = permiso.PermisoID,
                        RolId = permiso.RolId,
                        Descripcion = permiso.Descripcion,
                        IdPadre = permiso.IdPadre,
                        OrdenItem = permiso.OrdenItem,
                        UrlItem = permiso.UrlItem,
                        PaginaNueva = permiso.PaginaNueva,
                        Mostrar = permiso.Mostrar,
                        Posicion = permiso.Posicion,
                        UrlImagen = permiso.UrlImagen,
                        EsMenuEspecial = permiso.EsMenuEspecial,
                        EsSoloImagen = permiso.EsSoloImagen,
                        EsServicios = permiso.EsServicios,
                        EsDireccionExterior = permiso.UrlItem.ToLower().StartsWith("http"),
                        DescripcionFormateada = Util.RemoveDiacritics(permiso.Descripcion.ToLower()).Replace(" ", "-")
                    });
                }

                // Separar los datos obtenidos y para generar el 
                userData.Menu = SepararItemsMenu(lstModel);
            }
            return userData.Menu;
        }

        private int MostrarMenuCDR()
        {
            int resultado = 0;
            if (Session["UserData"] != null)
            {
                var tieneAcceso = userData.IndicadorBloqueoCDR == 0;
                var tieneAccesoZona = userData.EsCDRWebZonaValida == 1;
            }
            return resultado;
        }

        private List<PermisoModel> SepararItemsMenu(List<PermisoModel> menuOriginal)
        {
            // Crear lista resultante
            var menu = new List<PermisoModel>();

            // Separar los items desde la raiz (0)
            SepararItemsMenu(ref menu, menuOriginal, 0);

            return menu;
        }

        private void SepararItemsMenu(ref List<PermisoModel> menu, List<PermisoModel> menuOriginal, int idPadre)
        {
            // Asignar los hijos
            menu = menuOriginal.Where(x => x.IdPadre == idPadre)
                .OrderBy(x => x.Posicion)
                .ToList();

            // Por cada uno buscar si se tienen hijos y agregarlos
            foreach (var itemMenu in menu)
            {
                var temp = new List<PermisoModel>();

                SepararItemsMenu(ref temp, menuOriginal, itemMenu.PermisoID);

                itemMenu.SubMenus = temp;
                itemMenu.SubMenus = itemMenu.SubMenus.OrderBy(p => p.OrdenItem).ToList();
            }
        }

        private List<ServicioCampaniaModel> BuildMenuService()
        {
            if (userData.MenuService == null)
            {
                int Campaniaid = userData.CampaniaID;
                IList<ServiceSAC.BEServicioCampania> lstTemp_1 = new List<ServiceSAC.BEServicioCampania>();
                IList<ServiceSAC.BEServicioCampania> lstTemp_2 = new List<ServiceSAC.BEServicioCampania>();
                IList<ServiceSAC.BEServicioCampania> lst = new List<ServiceSAC.BEServicioCampania>();

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lstTemp_1 = sv.GetServicioByCampaniaPais(userData.PaisID, userData.CampaniaID).ToList();
                }

                int SegmentoID;
                if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                {
                    SegmentoID = userData.SegmentoID;
                }
                else
                {
                    SegmentoID = userData.SegmentoInternoID.HasValue ? userData.SegmentoInternoID.Value : userData.SegmentoID;
                }

                int SegmentoServicio = userData.EsJoven == 1 ? 99 : SegmentoID;

                lstTemp_2 = lstTemp_1.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(userData.ZonaID.ToString())).ToList();
                lst = lstTemp_2.Where(p => p.Segmento == "-1" || p.Segmento == SegmentoServicio.ToString()).ToList();

                Mapper.CreateMap<ServiceSAC.BEServicioCampania, ServicioCampaniaModel>()
                        .ForMember(x => x.ServicioId, t => t.MapFrom(c => c.ServicioId))
                        .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                        .ForMember(x => x.Url, t => t.MapFrom(c => c.Url));

                userData.MenuService = Mapper.Map<IList<ServiceSAC.BEServicioCampania>, List<ServicioCampaniaModel>>(lst);
            }
            return userData.MenuService;
        }

        #endregion

        #region UserData

        protected void SetUserData(UsuarioModel model)
        {
            Session["UserData"] = model;
        }

        public UsuarioModel UserData()
        {
            UsuarioModel model = (UsuarioModel)Session["UserData"];

            if (model != null)
            {
                #region Cargar variables

                CargarEntidadesShowRoom(model);

                ViewBag.Usuario = "Hola, " + (string.IsNullOrEmpty(model.Sobrenombre) ? model.NombreConsultora : model.Sobrenombre);
                ViewBag.Rol = model.RolID;
                ViewBag.ListaProductoFaltante = model.ListaProductoFaltante;
                ViewBag.Campania = NombreCampania(model.NombreCorto);
                ViewBag.CampaniaCodigo = model.CampaniaID;
                ViewBag.BanderaImagen = model.BanderaImagen;
                ViewBag.NombrePais = model.NombrePais;
                ViewBag.CambioClave = model.CambioClave;
                ViewBag.UrlAyuda = string.IsNullOrEmpty(model.UrlAyuda) ? string.Empty : model.UrlAyuda;
                ViewBag.UrlCapedevi = string.IsNullOrEmpty(model.UrlCapedevi) ? string.Empty : model.UrlCapedevi;
                ViewBag.UrlTerminos = string.IsNullOrEmpty(model.UrlTerminos) ? string.Empty : Url + model.UrlTerminos;
                ViewBag.CodigoZonaConsultora = model.CodigoZona;
                ViewBag.RolAnalytics = model.RolDescripcion;
                ViewBag.EdadAnalytics = Util.Edad(model.FechaNacimiento);
                ViewBag.ZonaAnalytics = model.CodigoZona;
                ViewBag.PaisAnalytics = model.CodigoISO;
                ViewBag.CodigoISODL = model.CodigoISO;
                ViewBag.MensajeAniversario = string.Empty;
                ViewBag.MensajeCumpleanos = string.Empty;
                ViewBag.IndicadorPermisoFIC = model.IndicadorPermisoFIC;
                ViewBag.IndicadorPermisoFlexipago = model.IndicadorPermisoFlexipago;
                ViewBag.HorasDuracionRestriccion = model.HorasDuracionRestriccion;
                string urlBelcorpChat = ConfigurationManager.AppSettings["UrlBelcorpChat"];
                ViewBag.UrlBelcorpChat = string.Format(urlBelcorpChat, model.Segmento.Trim(), model.CodigoUsuario.Trim(), model.PrimerNombre.Split(' ').First().Trim(), model.EMail.Trim(), model.CodigoISO.Trim());

                ViewBag.RegionAnalytics = model.CodigorRegion;
                ViewBag.SegmentoAnalytics = model.Segmento != null && model.Segmento != "" ?
                    (string.IsNullOrEmpty(model.Segmento) ? string.Empty : model.Segmento.ToString().Trim()) : "(not available)";
                ViewBag.esConsultoraLiderAnalytics = model.esConsultoraLider == true ? "Socia" : model.RolDescripcion;
                ViewBag.SeccionAnalytics = model.SeccionAnalytics != null && model.SeccionAnalytics != "" ? model.SeccionAnalytics : "(not available)";
                ViewBag.CodigoConsultoraDL = model.CodigoConsultora != null && model.CodigoConsultora != "" ? model.CodigoConsultora : "(not available)";
                ViewBag.SegmentoConstancia = model.SegmentoConstancia != null && model.SegmentoConstancia != "" ? model.SegmentoConstancia.Trim() : "(not available)";
                ViewBag.DescripcionNivelAnalytics = model.DescripcionNivel != null && model.DescripcionNivel != "" ? model.DescripcionNivel : "(not available)";
                ViewBag.ConsultoraAsociada = model.ConsultoraAsociada;

                if (model.RolID == Constantes.Rol.Consultora)
                {
                    if (model.ConsultoraNueva != Constantes.ConsultoraNueva.Sicc &&
                        model.ConsultoraNueva != Constantes.ConsultoraNueva.Fox)
                    {
                        if (model.NombreCorto != null &&
                            model.AnoCampaniaIngreso.Trim() != "")
                        {
                            int campaniaActual = int.Parse(model.NombreCorto);
                            int campaniaIngreso = int.Parse(model.AnoCampaniaIngreso);
                            int diferencia = campaniaActual - campaniaIngreso;
                            if (diferencia >= 12)
                            {
                                if (model.AnoCampaniaIngreso.Trim().EndsWith(model.NombreCorto.Trim().Substring(4)))
                                {
                                    ViewBag.MensajeAniversario = string.Format("!Feliz Aniversario {0}!", (string.IsNullOrEmpty(model.Sobrenombre) ? model.PrimerNombre + " " + model.PrimerApellido : model.Sobrenombre));
                                }
                            }
                        }
                    }

                    if (model.FechaNacimiento.Date != DateTime.Now.Date)
                    {
                        if (model.FechaNacimiento.Month == DateTime.Now.Month &&
                            model.FechaNacimiento.Day == DateTime.Now.Day)
                        {
                            ViewBag.MensajeCumpleanos = string.Format("!Feliz Cumpleaños {0}!", (string.IsNullOrEmpty(model.Sobrenombre) ? model.PrimerNombre + " " + model.PrimerApellido : model.Sobrenombre));
                        }
                    }
                }

                DateTime fechaHoy = DateTime.Now.AddHours(model.ZonaHoraria).Date;
                model.EsDiasFacturacion = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date ? true : false;

                ViewBag.FechaActualPais = fechaHoy.ToShortDateString();
            ViewBag.Dias = ((fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date) || (fechaHoy >= model.FechaInicioCampania.Date && fechaHoy >= model.FechaFinCampania.Date)) ? 0 : (model.FechaInicioCampania.Subtract(DateTime.Now.AddHours(model.ZonaHoraria)).Days + 1);
            //ViewBag.Dias = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date ? 0 : (model.FechaInicioCampania.Subtract(DateTime.Now.AddHours(model.ZonaHoraria)).Days + 1);

                ViewBag.PeriodoAnalytics = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date ? "Facturacion" : "Venta";
                ViewBag.SemanaAnalytics = "No Disponible";
                DateTime FechaHoraActual = DateTime.Now.AddHours(model.ZonaHoraria);
                TimeSpan HoraCierrePortal = model.EsZonaDemAnti == 0 ? model.HoraCierreZonaNormal : model.HoraCierreZonaDemAnti;

                //Mensaje Cierre Campania y Fecha Promesa
                var TextoPromesaEspecial = false;
                var TextoPromesa = ".";
                var TextoNuevoPROL = "";

                if (model.ZonaValida)
                {
                    if (!model.DiaPROL)
                    {
                        if (model.NuevoPROL && model.ZonaNuevoPROL)
                        {
                            ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                            if (!("BO CL VE").Contains(model.CodigoISO))
                                TextoNuevoPROL = " Revisa tus notificaciones o correo y verifica que tu pedido esté completo.";
                        }
                        else
                        {
                            if (model.CodigoISO == "VE")
                            {
                                ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                            }
                            else
                            {
                                ViewBag.MensajeCierreCampania = "El <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> desde las <b>" + FormatearHora(model.HoraFacturacion) + "</b> hasta las <b>" + FormatearHora(HoraCierrePortal) + "</b> podrás validar los productos que te llegarán en el pedido";
                            }
                        }
                    }
                    else
                    {
                        if (model.DiasCampania != 0 && FechaHoraActual < model.FechaInicioCampania)
                        {
                            ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                        }
                        else
                        {
                            if (model.NuevoPROL && model.ZonaNuevoPROL)
                            {
                                ViewBag.MensajeCierreCampania = "Pasa o modifica tu pedido hasta el día de <b>hoy a las " + FormatearHora(HoraCierrePortal) + "</b>";
                            }
                            else
                            {
                                if (model.CodigoISO == "VE")
                                {
                                    ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                                }
                                else
                                {
                                    ViewBag.MensajeCierreCampania = "Recuerda que tienes hasta las <b>" + FormatearHora(HoraCierrePortal) + "</b> para validar lo que vas a recibir en el pedido";
                                    TextoPromesaEspecial = true;
                                }
                            }
                        }
                    }
                }
                else
                {
                    ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                }

                if (model.TipoCasoPromesa != "0")
                {
                    if (model.TipoCasoPromesa == "1" && model.DiasCasoPromesa != -1)
                    {
                        TextoPromesa = " y recíbelo en ";
                        TextoPromesa += model.DiasCasoPromesa.ToString() + (model.DiasCasoPromesa == 1 ? " día." : " días.");

                    }
                    else if (("2 3 4").Contains(model.TipoCasoPromesa) && model.DiasCasoPromesa != -1) //casos 2,3 y 4
                    {
                        model.FechaPromesaEntrega = FechaHoraActual.AddDays(model.DiasCasoPromesa);
                        if (TextoPromesaEspecial)
                            TextoPromesa = " Recibirás tu pedido el <b>" + model.FechaPromesaEntrega.Day + " de " + NombreMes(model.FechaPromesaEntrega.Month) + "</b>.";

                        else
                            TextoPromesa = " y recíbelo el <b>" + model.FechaPromesaEntrega.Day + " de " + NombreMes(model.FechaPromesaEntrega.Month) + "</b>.";
                    }
                }

                ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa + TextoNuevoPROL;

                ViewBag.FechaFacturacionPedido = model.FechaFacturacion.Day + " de " + NombreMes(model.FechaFacturacion.Month);
                ViewBag.QSBR = string.Format("NOMB={0}&PAIS={1}&CODI={2}&CORR={3}&TELF={4}", model.NombreConsultora.ToUpper(), model.CodigoISO, model.CodigoConsultora, model.EMail, model.Telefono.Trim() + (model.Celular.Trim() == string.Empty ? "" : "; " + model.Celular.Trim()));

                model.MenuNotificaciones = 1;
                ViewBag.TieneFechaPromesa = 0;
                ViewBag.MensajeFechaPromesa = string.Empty;
                ViewBag.DiaFechaPromesa = 0;

                ViewBag.TieneNotificaciones = model.TieneNotificaciones;
                ViewBag.EsUsuarioComunidad = model.EsUsuarioComunidad ? 1 : 0;
                ViewBag.NombreC = model.PrimerNombre;
                ViewBag.ApellidoC = model.PrimerApellido;
                ViewBag.CorreoC = model.EMail;
                ViewBag.Lider = model.Lider;
                ViewBag.PortalLideres = model.PortalLideres;
                ViewBag.LogOutComunidad = ConfigurationManager.AppSettings["URL_COM_LO"] + "&dest_url=" + ConfigurationManager.AppSettings["URL_SB"] + "/WebPages/ComunidadLogout.aspx";
                ViewBag.LogOutSB = ConfigurationManager.AppSettings["URL_SB"] + "/WebPages/ComunidadLogout.aspx";
                ViewBag.TokenAtento = ConfigurationManager.AppSettings["TokenAtento_" + model.CodigoISO];
                ViewBag.IdbelcorpChat = "belcorpChat" + model.CodigoISO;
                ViewBag.EstadoSimplificacionCUV = model.EstadoSimplificacionCUV;
                ViewBag.FormatDecimalPais = GetFormatDecimalPais(model.CodigoISO);
                ViewBag.OfertaFinal = model.OfertaFinal;
                ViewBag.CatalogoPersonalizado = model.CatalogoPersonalizado;
                ViewBag.Simbolo = model.Simbolo;
                string paisesConTrackingJetlore = ConfigurationManager.AppSettings.Get("PaisesConTrackingJetlore") ?? "";
                ViewBag.PaisesConTrackingJetlore = paisesConTrackingJetlore.Contains(model.CodigoISO) ? "1" : "0";
                ViewBag.EsCatalogoPersonalizadoZonaValida = model.EsCatalogoPersonalizadoZonaValida;

            ViewBag.IndicadorGPRSB = model.IndicadorGPRSB;
                ViewBag.CerrarRechazado = model.CerrarRechazado;
            ViewBag.MostrarBannerRechazo = model.MostrarBannerRechazo;
            ViewBag.MotivoRechazo = model.MotivoRechazo.Trim();
                ViewBag.Efecto_TutorialSalvavidas = ConfigurationManager.AppSettings.Get("Efecto_TutorialSalvavidas") ?? "1";

                #endregion
            }

            return model;
        }

        private string GetFormatDecimalPais(string isoPais)
        {
            var listaPaises = ConfigurationManager.AppSettings["KeyPaisFormatDecimal"] ?? "";
            if (listaPaises == "" || isoPais == "") return ",|.|2";
            if (listaPaises.Contains(isoPais)) return ".||0";
            return ",|.|2";
        }

        private List<BEProductoFaltante> GetProductosFaltantes(int PaisID, int CampaniaID, int ZonaID)
        {
            List<BEProductoFaltante> olstProductoFaltante = new List<BEProductoFaltante>();
            using (SACServiceClient sv = new SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(PaisID, CampaniaID, ZonaID).ToList();
            }
            return olstProductoFaltante;
        }

        private List<TipoLinkModel> GetLinksPorPais(int PaisID)
        {
            List<ServiceContenido.BETipoLink> listModel = new List<ServiceContenido.BETipoLink>();
            using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
            {
                listModel = sv.GetLinksPorPais(PaisID).ToList();
            }

            Mapper.CreateMap<BETipoLink, TipoLinkModel>()
                  .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                  .ForMember(t => t.TipoLinkID, f => f.MapFrom(c => c.TipoLinkID))
                  .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

            return Mapper.Map<IList<BETipoLink>, List<TipoLinkModel>>(listModel);
        }

        private bool GetPermisoFlexipago(int PaisID, string PaisISO, string CodigoConsultora, int CampaniaID)
        {
            bool Result = false;
            string hasFlexipago = ConfigurationManager.AppSettings.Get("PaisesFlexipago") ?? string.Empty;
            if (hasFlexipago.Contains(PaisISO))
            {
                using (ServicePedido.PedidoServiceClient sv = new ServicePedido.PedidoServiceClient())
                {
                    Result = sv.GetPermisoFlexipago(PaisID, CodigoConsultora, CampaniaID);
                }
            }

            return Result;
        }

        private string NombreCampania(string Campania)
        {
            string Result = Campania;
            try
            {
                if (Campania.Length == 6)
                {
                    return Result = string.Format("Campaña {0}", Campania.Substring(4, 2));
                }
            }
            catch { }
            return Result;
        }

        private string GetIPCliente()
        {
            string IP = string.Empty;
            try
            {
                IP = HttpContext.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            }
            catch { }
            return IP;
        }

        private bool EsUsuarioComunidad(int PaisId, string CodigoUsuario)
        {
            ServiceComunidad.BEUsuarioComunidad result = null;
            try
            {
                using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    result = sv.GetUsuarioInformacion(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        PaisId = PaisId,
                        UsuarioId = 0,
                        CodigoUsuario = CodigoUsuario,
                        Tipo = 3
                    });
                }
            }
            catch
            {

            }

            return result == null ? false : true;
        }

        private int TieneNotificaciones(BEUsuario oBEUsuario)
        {
            int Tiene = 0;
            List<BENotificaciones> olstNotificaciones = new List<BENotificaciones>();
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstNotificaciones = sv.GetNotificacionesConsultora(oBEUsuario.PaisID, oBEUsuario.ConsultoraID, oBEUsuario.IndicadorBloqueoCDR).ToList();
            }
            if (olstNotificaciones.Count != 0)
            {
                int Cantidad = olstNotificaciones.Count(p => p.Visualizado == false);
                if (Cantidad > 0)
                    Tiene = 1;
            }
            return Tiene;
        }

        protected void CargarEntidadesShowRoom(UsuarioModel model)
        {
            if (model.CargoEntidadesShowRoom) return;

            Session["EsShowRoom"] = "0";

            var paisesShowRoom = ConfigurationManager.AppSettings["PaisesShowRoom"];
            if (paisesShowRoom.Contains(model.CodigoISO))
            {
                try
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        model.CodigoConsultora = model.UsuarioPrueba == 1 ? model.ConsultoraAsociada.ToString() : model.CodigoConsultora;
                        model.BeShowRoomConsultora = sv.GetShowRoomConsultora(model.PaisID, model.CampaniaID, model.CodigoConsultora);
                        model.BeShowRoom = sv.GetShowRoomEventoByCampaniaID(model.PaisID, model.CampaniaID);

                        if (model.BeShowRoom != null)
                        {
                            var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;

                            model.BeShowRoom.Imagen1 = string.IsNullOrEmpty(model.BeShowRoom.Imagen1)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.Imagen1, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.Imagen2 = string.IsNullOrEmpty(model.BeShowRoom.Imagen2)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.Imagen2, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenCabeceraProducto = string.IsNullOrEmpty(model.BeShowRoom.ImagenCabeceraProducto)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenCabeceraProducto, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenVentaSetPopup = string.IsNullOrEmpty(model.BeShowRoom.ImagenVentaSetPopup)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenVentaSetPopup, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenVentaTagLateral = string.IsNullOrEmpty(model.BeShowRoom.ImagenVentaTagLateral)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenVentaTagLateral, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenPestaniaShowRoom = string.IsNullOrEmpty(model.BeShowRoom.ImagenPestaniaShowRoom)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenPestaniaShowRoom, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenPreventaDigital = string.IsNullOrEmpty(model.BeShowRoom.ImagenPreventaDigital)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenPreventaDigital, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);

                            if (model.BeShowRoomConsultora != null)
                            {
                                Session["EsShowRoom"] = "1";
                            }
                        }
                    }
                    model.CargoEntidadesShowRoom = true;
                }
                catch (Exception ex)
                {
                    Portal.Consultoras.Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                    model.CargoEntidadesShowRoom = false;
                }
            }
            else
            {
                model.BeShowRoomConsultora = null;
                model.BeShowRoom = null;
                model.CargoEntidadesShowRoom = true;
            }
        }

        #endregion

        public string NombreMes(int Mes)
        {
            string Result = string.Empty;
            switch (Mes)
            {
                case 1:
                    Result = "Enero";
                    break;
                case 2:
                    Result = "Febrero";
                    break;
                case 3:
                    Result = "Marzo";
                    break;
                case 4:
                    Result = "Abril";
                    break;
                case 5:
                    Result = "Mayo";
                    break;
                case 6:
                    Result = "Junio";
                    break;
                case 7:
                    Result = "Julio";
                    break;
                case 8:
                    Result = "Agosto";
                    break;
                case 9:
                    Result = "Septiembre";
                    break;
                case 10:
                    Result = "Octubre";
                    break;
                case 11:
                    Result = "Noviembre";
                    break;
                case 12:
                    Result = "Diciembre";
                    break;
            }
            return Result;
        }

        protected string ConfigurarUrlServiceProl()
        {
            string ambiente = ConfigurationManager.AppSettings["Ambiente"];
            string pais = UserData().CodigoISO;
            string key = ambiente.Trim().ToUpper() + "_Prol_" + pais.Trim().ToUpper();
            return ConfigurationManager.AppSettings[key];
        }

        protected BEGrid SetGrid(string sidx, string sord, int page, int rows)
        {
            BEGrid grid = new BEGrid();
            grid.PageSize = rows <= 0 ? 10 : rows;
            grid.CurrentPage = page <= 0 ? 1 : page;
            grid.SortColumn = sidx ?? "";
            grid.SortOrder = sord ?? "asc";
            return grid;
        }

        protected BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(string constSession)
        {
            constSession = constSession ?? "";
            constSession = constSession.Trim();
            if (constSession == "")
                return new BEConfiguracionProgramaNuevas();

            if (Session[constSession] != null)
                return (BEConfiguracionProgramaNuevas)Session[constSession];

            try
            {
                BEConfiguracionProgramaNuevas oBEConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas();
                oBEConfiguracionProgramaNuevas.CampaniaInicio = userData.CampaniaID.ToString();
                oBEConfiguracionProgramaNuevas.CodigoRegion = userData.CodigorRegion;
                oBEConfiguracionProgramaNuevas.CodigoZona = userData.CodigoZona;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionProgramaNuevas = sv.GetConfiguracionProgramaNuevas(userData.PaisID, oBEConfiguracionProgramaNuevas);
                }

                Session[constSession] = oBEConfiguracionProgramaNuevas ?? new BEConfiguracionProgramaNuevas();
            }
            catch (Exception)
            {
                Session[constSession] = new BEConfiguracionProgramaNuevas();
            }

            return (BEConfiguracionProgramaNuevas)Session[constSession];
        }

        protected Converter<decimal, string> CreateConverterDecimalToString(int paisID)
        {
            if (paisID == 4) return new Converter<decimal, string>(p => p.ToString("n0", new System.Globalization.CultureInfo("es-CO")));
            return new Converter<decimal, string>(p => p.ToString("n2", new System.Globalization.CultureInfo("es-PE")));
        }

        protected int AddCampaniaAndNumero(int campania, int numero)
        {
            int nroCampanias = userData.NroCampanias;

            int anioCampania = campania / 100;
            int nroCampania = campania % 100;
            int sumNroCampania = (nroCampania + numero) - 1;
            int anioCampaniaResult = anioCampania + (sumNroCampania / userData.NroCampanias);
            int nroCampaniaResult = (sumNroCampania % userData.NroCampanias) + 1;

            if (nroCampaniaResult < 1)
            {
                anioCampaniaResult = anioCampaniaResult - 1;
                nroCampaniaResult = nroCampaniaResult + userData.NroCampanias;
            }
            return (anioCampaniaResult * 100) + nroCampaniaResult;
        }

        public string FormatearHora(TimeSpan hora)
        {
            DateTime tiempo = DateTime.Today.Add(hora);
            string displayTiempo = tiempo.ToShortTimeString().Replace(".", " ").Replace(" ", "");
            if (displayTiempo.Length == 6)
                displayTiempo = displayTiempo.Insert(4, " ");
            else
                displayTiempo = displayTiempo.Insert(5, " ");

            return displayTiempo;
        }

        public BarraConsultoraModel GetDataBarra(bool inEscala = true, bool inMensaje = false)
        {
            var objR = new BarraConsultoraModel();
            objR.ListaEscalaDescuento = new List<BarraConsultoraEscalaDescuentoModel>();
            objR.ListaMensajeMeta = new List<BEMensajeMetaConsultora>();

            try
            {
                var rtpa = ServicioProl_CalculoMontosProl(userData.EjecutaProl);
                userData.EjecutaProl = true;

                if (!rtpa.Any())
                    return objR;

                var obj = rtpa[0];

                #region Tipping Point

                objR.TippingPointStr = "";
                objR.TippingPoint = 0;
                if (userData.MontoMaximo > 0)
                {
                    var tp = GetConfiguracionProgramaNuevas(Constantes.ConstSession.TippingPoint);

                    if (tp.IndExigVent == "1")
                    {
                        var oBEConsultorasProgramaNuevas = GetConsultorasProgramaNuevas(Constantes.ConstSession.TippingPoint_MontoVentaExigido, tp.CodigoPrograma);

                        objR.TippingPoint = oBEConsultorasProgramaNuevas.MontoVentaExigido;
                        objR.TippingPointStr = Util.DecimalToStringFormat(objR.TippingPoint, userData.CodigoISO);
                    }
                }

                #endregion

                objR.MontoMaximo = 0;
                objR.MontoEscala = 0;
                objR.MontoDescuento = 0;

                objR.MontoMinimoStr = Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO);
                objR.MontoMinimo = userData.MontoMinimo;

                objR.MontoMaximoStr = Util.ValidaMontoMaximo(userData.MontoMaximo, userData.CodigoISO);
                if (objR.MontoMaximoStr != "")
                    objR.MontoMaximo = userData.MontoMaximo;

                objR.MontoEscalaStr = Util.DecimalToStringFormat(obj.MontoEscala, userData.CodigoISO);
                objR.MontoDescuentoStr = Util.DecimalToStringFormat(obj.MontoTotalDescuento, userData.CodigoISO);
                if (objR.MontoEscalaStr != "")
                    objR.MontoEscala = decimal.Parse(obj.MontoEscala);
                if (objR.MontoDescuentoStr != "")
                    objR.MontoDescuento = decimal.Parse(obj.MontoTotalDescuento);

                objR.MontoAhorroCatalogoStr = Util.DecimalToStringFormat(obj.AhorroCatalogo, userData.CodigoISO);
                if (objR.MontoAhorroCatalogoStr != "")
                    objR.MontoAhorroCatalogo = decimal.Parse(obj.AhorroCatalogo);

                objR.MontoAhorroRevistaStr = Util.DecimalToStringFormat(obj.AhorroRevista, userData.CodigoISO);
                if (objR.MontoAhorroRevistaStr != "")
                    objR.MontoAhorroRevista = decimal.Parse(obj.AhorroRevista);

                objR.MontoGanancia = objR.MontoAhorroCatalogo + objR.MontoAhorroRevista;
                objR.MontoGananciaStr = Util.DecimalToStringFormat(objR.MontoGanancia, userData.CodigoISO);

                var listProducto = ObtenerPedidoWebDetalle();
                objR.TotalPedido = listProducto.Sum(d => d.ImporteTotal);
                objR.TotalPedidoStr = Util.DecimalToStringFormat(objR.TotalPedido, userData.CodigoISO);

                objR.CantidadProductos = listProducto.Sum(p => p.Cantidad);
                objR.CantidadCuv = listProducto.Count();

                #region listaEscalaDescuento
                var listaEscalaDescuento = new List<BEEscalaDescuento>();
                if (inEscala)
                {
                    //if (objR.MontoMaximoStr == "")
                    //{
                    listaEscalaDescuento = GetListaEscalaDescuento() ?? new List<BEEscalaDescuento>();
                    //}
                }

                foreach (var escala in listaEscalaDescuento)
                {
                    objR.ListaEscalaDescuento.Add(new BarraConsultoraEscalaDescuentoModel
                    {
                        MontoDesde = escala.MontoDesde,
                        MontoDesdeStr = Util.DecimalToStringFormat(escala.MontoDesde, userData.CodigoISO),
                        MontoHasta = escala.MontoHasta,
                        MontoHastaStr = Util.DecimalToStringFormat(escala.MontoHasta, userData.CodigoISO),
                        PorDescuento = escala.PorDescuento,
                    });
                }
                #endregion

                #region Mensajes
                objR.ListaMensajeMeta = new List<BEMensajeMetaConsultora>();
                if (inMensaje)
                    objR.ListaMensajeMeta = GetMensajeMetaConsultora(Constantes.ConstSession.MensajeMetaConsultora, "") ?? new List<BEMensajeMetaConsultora>();

                #endregion
            }
            catch (Exception)
            {
                //return new BarraConsultoraModel();
            }

            return objR;
        }

        public List<BEEscalaDescuento> GetListaEscalaDescuento()
        {
            List<BEEscalaDescuento> listaEscalaDescuento;

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaEscalaDescuento = sv.GetEscalaDescuento(userData.PaisID).ToList() ?? new List<BEEscalaDescuento>();
                }
            }
            catch (Exception)
            {
                listaEscalaDescuento = new List<BEEscalaDescuento>();
            }

            return listaEscalaDescuento;
        }

        protected BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(string constSession, string codigoPrograma)
        {
            constSession = constSession ?? "";
            constSession = constSession.Trim();
            if (constSession == "")
                return new BEConsultorasProgramaNuevas();

            if (Session[constSession] != null)
                return (BEConsultorasProgramaNuevas)Session[constSession];

            try
            {
                var oBEConsultorasProgramaNuevas = new BEConsultorasProgramaNuevas();
                oBEConsultorasProgramaNuevas.CodigoConsultora = userData.CodigoConsultora;
                oBEConsultorasProgramaNuevas.Campania = userData.CampaniaID.ToString();
                oBEConsultorasProgramaNuevas.CodigoPrograma = codigoPrograma;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConsultorasProgramaNuevas = sv.GetConsultorasProgramaNuevas(userData.PaisID, oBEConsultorasProgramaNuevas);
                }

                Session[constSession] = oBEConsultorasProgramaNuevas ?? new BEConsultorasProgramaNuevas();
            }
            catch (Exception)
            {
                Session[constSession] = new BEConsultorasProgramaNuevas();
            }

            return (BEConsultorasProgramaNuevas)Session[constSession];
        }

        protected List<BEMensajeMetaConsultora> GetMensajeMetaConsultora(string constSession, string tipoMensaje)
        {
            constSession = constSession ?? "";
            constSession = constSession.Trim();
            if (constSession == "")
                return new List<BEMensajeMetaConsultora>();

            if (Session[constSession] != null)
                return (List<BEMensajeMetaConsultora>)Session[constSession];

            try
            {
                var lista = new List<BEMensajeMetaConsultora>();
                var entity = new BEMensajeMetaConsultora();
                entity.TipoMensaje = tipoMensaje ?? "";
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lista = sv.GetMensajeMetaConsultora(userData.PaisID, entity).ToList();
                }

                Session[constSession] = lista ?? new List<BEMensajeMetaConsultora>();
            }
            catch (Exception)
            {
                Session[constSession] = new List<BEMensajeMetaConsultora>();
            }

            return (List<BEMensajeMetaConsultora>)Session[constSession];
        }

        public List<EstadoCuentaModel> ObtenerEstadoCuenta()
        {
            List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();

            if (Session["ListadoEstadoCuenta"] == null)
            {
                List<BEEstadoCuenta> EstadoCuenta = new List<BEEstadoCuenta>();
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        EstadoCuenta = client.GetEstadoCuentaConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

                if (EstadoCuenta != null && EstadoCuenta.Count > 0)
                {
                    foreach (var ec in EstadoCuenta)
                    {
                        lst.Add(new EstadoCuentaModel
                        {
                            Fecha = ec.FechaRegistro,
                            Glosa = ec.DescripcionOperacion,
                            Cargo = ec.Cargo,
                            Abono = ec.Abono
                        });
                    }

                    decimal monto = userData.MontoDeuda;

                    lst.Add(new EstadoCuentaModel
                    {
                        Fecha = userData.FechaLimPago,
                        Glosa = "MONTO A PAGAR",
                        Cargo = monto > 0 ? monto : 0,
                        Abono = monto < 0 ? 0 : monto
                    });
                }

                Session["ListadoEstadoCuenta"] = lst;
            }
            else
            {
                lst = Session["ListadoEstadoCuenta"] as List<EstadoCuentaModel>;
            }

            return lst;
        }

        private void ActualizarDatosHana(ref UsuarioModel model)
        {
            using (UsuarioServiceClient us = new UsuarioServiceClient())
            {
                var datosConsultoraHana = us.GetDatosConsultoraHana(model.PaisID, model.CodigoUsuario, model.CampaniaID);

                if (datosConsultoraHana != null)
                {
                    model.FechaLimPago = datosConsultoraHana.FechaLimPago;
                    model.MontoMinimo = datosConsultoraHana.MontoMinimoPedido;
                    model.MontoMaximo = datosConsultoraHana.MontoMaximoPedido;
                    model.MontoDeuda = datosConsultoraHana.MontoDeuda;
                    model.IndicadorFlexiPago = datosConsultoraHana.IndicadorFlexiPago;
                    model.MontoMinimoFlexipago = string.Format("{0:#,##0.00}", (datosConsultoraHana.MontoMinimoFlexipago < 0 ? 0M : datosConsultoraHana.MontoMinimoFlexipago));
                }
            }
        }

        private string CalcularNroCampaniaSiguiente(string CampaniaActual, int nroCampanias)
        {
            CampaniaActual = CampaniaActual ?? "";
            CampaniaActual = CampaniaActual.Trim();
            if (CampaniaActual.Length < 6)
                return "";

            var campAct = CampaniaActual.Substring(4, 2);
            if (campAct == nroCampanias.ToString()) return "01";
            return (Convert.ToInt32(campAct) + 1).ToString().PadLeft(2, '0');
        }

        public List<BEProductoFaltante> GetModelPedidoAgotado(int PaisID, int CampaniaID, int ZonaID)
        {
            List<ServiceSAC.BEProductoFaltante> olstProductoFaltante = new List<ServiceSAC.BEProductoFaltante>();
            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(PaisID, CampaniaID, ZonaID).ToList();
            }
            return olstProductoFaltante;
        }

        public string GetFechaPromesaEntrega(int PaisId, int CampaniaId, string CodigoConsultora, DateTime FechaFact)
        {
            string sFecha = Convert.ToDateTime("2000-01-01").ToString();
            DateTime Fecha = Convert.ToDateTime("2000-01-01");
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    sFecha = sv.GetFechaPromesaCronogramaByCampania(PaisId, CampaniaId, CodigoConsultora, FechaFact);
                }
            }
            catch
            {

            }
            return sFecha;
        }
        
        public TimeSpan CountdownODD(UsuarioModel model)
        {
            //DateTime hoy = DateTime.Now;
            //DateTime d1 = new DateTime(hoy.Year, hoy.Month, hoy.Day, 0, 0, 0);
            DateTime hoy;

            using (SACServiceClient svc = new SACServiceClient())
            {
                hoy = svc.GetFechaHoraPais(model.PaisID);
            }

            DateTime d1 = new DateTime(hoy.Year, hoy.Month, hoy.Day, 0, 0, 0);
            DateTime d2;

            if (model.EsDiasFacturacion)  // dias de facturacion
            {
                TimeSpan t1 = model.HoraCierreZonaNormal;
                d2 = new DateTime(hoy.Year, hoy.Month, hoy.Day, t1.Hours, t1.Minutes, t1.Seconds);
            }
            else
            {
                d2 = d1.AddDays(1);
            }

            TimeSpan t2 = (d2 - hoy);
            return t2;
        }

        #endregion
        
        protected OfertaDelDiaModel GetOfertaDelDiaModel()
        {
            if (userData.OfertaDelDia != null)
            {
                OfertaDelDiaModel model = userData.OfertaDelDia;
                model.TeQuedan = CountdownODD(userData);
                return model;
            }
            return null;
        }
        
        public ShowRoomBannerLateralModel GetShowRoomBannerLateral()
        {
            ShowRoomBannerLateralModel model = new ShowRoomBannerLateralModel();

            var paisesShowRoom = ConfigurationManager.AppSettings["PaisesShowRoom"];
            if (!paisesShowRoom.Contains(userData.CodigoISO)) return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            if (!userData.CargoEntidadesShowRoom) throw new Exception("Ocurrió un error al intentar traer la información de los evento y consultora de ShowRoom.");
            model.BEShowRoomConsultora = userData.BeShowRoomConsultora;
            model.BEShowRoom = userData.BeShowRoom;

            if (model.BEShowRoom == null)
            {
                model.BEShowRoom = new BEShowRoomEvento();
                model.BEShowRoomConsultora = new BEShowRoomEventoConsultora();
            }
            else if (model.BEShowRoomConsultora == null) model.BEShowRoomConsultora = new BEShowRoomEventoConsultora();
            if (model.BEShowRoom.Estado != 1) return new ShowRoomBannerLateralModel { EventoNoEncontrado = true };

            model.RutaShowRoomBannerLateral = model.BEShowRoom.RutaShowRoomBannerLateral;
            model.EstaActivoLateral = true;
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

            if (fechaHoy >= userData.FechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes).Date &&
                fechaHoy <= userData.FechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date)
            {
                model.MostrarShowRoomProductos = true;
                model.RutaShowRoomBannerLateral = Url.Action("Index", "ShowRoom");
            }
            if (fechaHoy > userData.FechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date) model.EstaActivoLateral = false;

            model.DiasFaltantes = userData.FechaInicioCampania.Day - model.BEShowRoom.DiasAntes;
            model.MesFaltante = userData.FechaInicioCampania.Month;
            model.AnioFaltante = userData.FechaInicioCampania.Year;

            return model;
        }
    }
}
