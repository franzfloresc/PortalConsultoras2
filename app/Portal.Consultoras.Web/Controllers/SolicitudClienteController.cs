using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System.Globalization;

namespace Portal.Consultoras.Web.Controllers
{
    public class SolicitudClienteController : BaseController
    {
        //
        // GET: /SolicitudCliente/
        public ActionResult Index(string Campania, string Estado, string paginacion)
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "SolicitudCliente/Index"))
                return RedirectToAction("Index", "Bienvenida");

            var solicitudClienteModel = new SolicitudClienteModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises()
            };

            if (Campania != null && Campania != string.Empty && Estado != null && Estado != string.Empty)
            {
                solicitudClienteModel.listaCampania = DropDowListCampanias(UserData().PaisID);
                solicitudClienteModel.listaEstadoSolicitudCliente = DropDowListEstado(UserData().PaisID);
                solicitudClienteModel.PaisID = UserData().PaisID;
                solicitudClienteModel.Campania = Campania;
                solicitudClienteModel.EstadoSolicitudClienteID = int.Parse(Estado);
                solicitudClienteModel.Paginacion = paginacion;
                ViewBag.HdConsulta = 1;
            }
            else
            {
                ViewBag.HdConsulta = 0;
            }
            solicitudClienteModel.listaEstadoSolicitudCliente = DropDowListEstado(UserData().PaisID);

            return View(solicitudClienteModel);
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

        private List<BEEstadoSolicitudCliente> DropDowListEstado(int PaisID)
        {
            List<BEEstadoSolicitudCliente> listaEstadoSolicitudCliente = new List<BEEstadoSolicitudCliente>();

            BEEstadoSolicitudCliente estadoSeleccione = new BEEstadoSolicitudCliente();
            estadoSeleccione.EstadoSolicitudClienteID = -1;
            estadoSeleccione.Descripcion = "-- Selecione Estado --";
            estadoSeleccione.TipoEstado = ""; //"Carga Todos los estados"
            estadoSeleccione.Activo = true;
            listaEstadoSolicitudCliente.Add(estadoSeleccione);


            BEEstadoSolicitudCliente estadoSolicitudCliente = new BEEstadoSolicitudCliente();
            estadoSolicitudCliente.EstadoSolicitudClienteID = 0;
            estadoSolicitudCliente.Descripcion = "Todos";
            estadoSolicitudCliente.TipoEstado = "T"; //"Carga Todos los estados"
            estadoSolicitudCliente.Activo = true;
            listaEstadoSolicitudCliente.Add(estadoSolicitudCliente);


            using (SACServiceClient sv = new SACServiceClient())
            {
                listaEstadoSolicitudCliente.AddRange(sv.GetEstadoSolicitudCliente(PaisID).ToList());
            }

            return listaEstadoSolicitudCliente;
        }

        public ActionResult Detalle(string SolicitudClienteId,string Estado, string paginacion)
        {
            var entidadCliente = new BESolicitudCliente();
            using (SACServiceClient sv = new SACServiceClient())
            {
                var paramSolicitudCliente = new BESolicitudCliente();
                paramSolicitudCliente.SolicitudClienteID = Convert.ToInt64(SolicitudClienteId);
                //paramSolicitudCliente.EstadoSolicitudClienteId = int.Parse(Estado);
                entidadCliente = sv.DetalleSolicitudAnuladasRechazadas(UserData().PaisID, paramSolicitudCliente);
            }

            SolicitudClienteModel modelSolicitudCliente = new SolicitudClienteModel();
            modelSolicitudCliente.UnidadGeografica1 = entidadCliente.UnidadGeografica1;
            modelSolicitudCliente.UnidadGeografica2 = entidadCliente.UnidadGeografica2;
            modelSolicitudCliente.UnidadGeografica3 = entidadCliente.UnidadGeografica3;
            modelSolicitudCliente.TipoDistribucion = entidadCliente.TipoDistribucion;
            modelSolicitudCliente.Seccion = entidadCliente.Seccion;
            modelSolicitudCliente.NombreConsultoraAsignada = entidadCliente.NombreConsultoraAsignada;
            modelSolicitudCliente.CorreoConsultoraAsginada = entidadCliente.CorreoConsultoraAsginada;
            modelSolicitudCliente.NombreCliente = entidadCliente.NombreCompleto;
            modelSolicitudCliente.EmailCliente = entidadCliente.Email;
            modelSolicitudCliente.TelefonoCliente = entidadCliente.Telefono;
            modelSolicitudCliente.Mensaje = entidadCliente.Mensaje;
            modelSolicitudCliente.listaDetalle = entidadCliente.DetalleSolicitud.ToList();
            modelSolicitudCliente.NombreGZ = entidadCliente.NombreGZ;
            modelSolicitudCliente.EmailGZ = entidadCliente.EmailGZ;
            modelSolicitudCliente.Direccion = entidadCliente.Direccion;
            modelSolicitudCliente.MensajeaGZ = entidadCliente.MensajeaGZ;
            modelSolicitudCliente.Campania = entidadCliente.Campania;
            modelSolicitudCliente.Estado = entidadCliente.Estado.ToString();
            modelSolicitudCliente.Paginacion = paginacion;

            decimal sumaTotal = 0;
            foreach (var item in modelSolicitudCliente.listaDetalle)
                sumaTotal += (item.Precio * item.Cantidad);

            ViewBag.Simbolo = UserData().Simbolo;
            ViewBag.MontoTotal = sumaTotal.ToString();
            ViewBag.MarcaID = entidadCliente.MarcaID;
            //ViewBag.Tono¿entidadCliente.to
            ViewBag.TieneDetalle = (entidadCliente.DetalleSolicitud != null) ? entidadCliente.DetalleSolicitud.ToList().Count : 0;

            string tipoDistribucion = String.Format("_{0}", modelSolicitudCliente.TipoDistribucion >= 1 ? modelSolicitudCliente.TipoDistribucion : 1);
            //R2319 - JICM - Se Obtiene la descripción de etiquetas correspondiente al pais logueado.
            string desConfig = "DES_UBIGEO_" + UserData().CodigoISO.ToString() + tipoDistribucion;
            string descripcionUnidad = ConfigurationManager.AppSettings.Get(desConfig) ?? string.Empty;
            string[] arrayUnidades = descripcionUnidad.Split(',');
            ViewBag.UnidadGeografica1 = arrayUnidades[0].ToString() + ":";
            ViewBag.UnidadGeografica2 = arrayUnidades[1].ToString() + ":";
            ViewBag.UnidadGeografica3 = arrayUnidades[2].ToString() + ":";
            //R2319 - JICM - FIN

            return View("Detalle", modelSolicitudCliente);
           
        }
        
        public ActionResult Consultar(string sidx, string sord, int page, int rows, string CampaniaID, string PaisID, string Consulta, int Estado, string Paginacion)
        {
            if (ModelState.IsValid)
            {
                if (Paginacion != null && Paginacion != string.Empty )
                {
                    if (page==1 && int.Parse(Paginacion) > 0)
                    {
                        page = int.Parse(Paginacion);
                    }
                }
                List<BESolicitudCliente> lst;

                if (Consulta == "1")
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        var paramSolicitudCliente = new BESolicitudCliente();
                        paramSolicitudCliente.Campania = CampaniaID;
                        paramSolicitudCliente.EstadoSolicitudClienteId = Estado;
                        lst = sv.BuscarSolicitudAnuladasRechazadas(UserData().PaisID, paramSolicitudCliente).ToList();
                    }
                }
                else
                {
                    lst = new List<BESolicitudCliente>();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                
                IEnumerable<BESolicitudCliente> items = lst;
               if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Campania":
                            items = lst.OrderBy(x => x.Campania);
                            break;
                        case "NombreCompleto":
                            items = lst.OrderBy(x => x.NombreCompleto);
                            break;
                        case "FechaSolicitud":
                            items = lst.OrderBy(x => x.FechaSolicitud);
                            break;
                        case "MarcaNombre":
                            items = lst.OrderBy(x => x.MarcaNombre);
                            break;
                        case "Estado":
                            items = lst.OrderBy(x => x.Estado);
                            break;
                        case "Seccion":
                            items = lst.OrderBy(x => x.Seccion);
                            break;
                        case "EnviadoGZ":
                            items = lst.OrderBy(x => x.EnviadoGZ);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Campania":
                            items = lst.OrderByDescending(x => x.Campania);
                            break;
                        case "NombreCompleto":
                            items = lst.OrderByDescending(x => x.NombreCompleto);
                            break;
                        case "FechaSolicitud":
                            items = lst.OrderByDescending(x => x.FechaSolicitud);
                            break;
                        case "MarcaNombre":
                            items = lst.OrderByDescending(x => x.MarcaNombre);
                            break;
                        case "Estado":
                            items = lst.OrderByDescending(x => x.Estado);
                            break;
                        case "Seccion":
                            items = lst.OrderBy(x => x.Seccion);
                            break;
                        case "EnviadoGZ":
                            items = lst.OrderByDescending(x => x.EnviadoGZ);
                            break;
                    }
                }

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
                               a.SolicitudClienteID,
                               cell = new string[] 
                               {
                                   a.SolicitudClienteID.ToString(),
                                   a.Campania,
                                   a.NombreCompleto,
                                   a.FechaSolicitud.ToShortDateString(),
                                   a.MarcaNombre,
                                   a.Estado,
                                   a.Seccion,
                                   a.EnviadoGZ,
                                   page.ToString(),
                                   Estado.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "SolicitudCliente");
        }
        
        public ActionResult Obtener(string sidx, string sord, int page, int rows, string SolicitudClienteID)
        {
            if (ModelState.IsValid)
            {
                List<BESolicitudClienteDetalle> lst = new List<BESolicitudClienteDetalle>();

                using (SACServiceClient sv = new SACServiceClient())
                {
                    var paramSolicitudCliente = new BESolicitudCliente();
                    paramSolicitudCliente.SolicitudClienteID = Convert.ToInt64(SolicitudClienteID);

                    lst = sv.DetalleSolicitudAnuladasRechazadas(UserData().PaisID, paramSolicitudCliente).DetalleSolicitud.ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BESolicitudClienteDetalle> items = lst;
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
                               a.CUV,
                               cell = new string[] 
                               {
                                   a.CUV,
                                   a.DescripcionProducto,
                                   a.Tono.ToString(),
                                   a.Cantidad.ToString(),
                                   a.Precio.ToString(),
                                   Convert.ToString(a.Cantidad * a.Precio)
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "SolicitudCliente");
        }
        [HttpPost]
        public JsonResult Enviar(string SolicitudClienteId, string NombreGZ, string EmailGZ, string MensajeaGZ)
        {
            int resultado = 0;
            try
            {
                var entidadCliente = new BESolicitudCliente();
                List<BETablaLogicaDatos> list_segmentos = new List<BETablaLogicaDatos>();
                string correoOculto;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    list_segmentos = sv.GetTablaLogicaDatos(UserData().PaisID, 57).ToList();
                    correoOculto = (from item in list_segmentos where item.TablaLogicaDatosID == 5701 select item.Descripcion).First();
                    var solicitudCliente = new BESolicitudCliente();
                    solicitudCliente.SolicitudClienteID = Convert.ToInt64(SolicitudClienteId);
                    solicitudCliente.NombreGZ = NombreGZ;
                    solicitudCliente.EmailGZ = EmailGZ;
                    solicitudCliente.MensajeaGZ = MensajeaGZ;
                    solicitudCliente.UsuarioModificacion = UserData().CodigoUsuario;
                    resultado = sv.EnviarSolicitudClienteaGZ(UserData().PaisID, solicitudCliente);
                    entidadCliente = sv.DetalleSolicitudAnuladasRechazadas(UserData().PaisID, solicitudCliente);
                }

                /* Envío de correo a la gerente de zona */
                string cuerpoCorreo = ConstruirCorreo(entidadCliente);
                string asunto = String.Format("({0}) Nuevo Pedido {1}", UserData().CodigoISO, entidadCliente.MarcaNombre);
                Util.EnviarMail("no-responder@somosbelcorp.com", EmailGZ, correoOculto, asunto, cuerpoCorreo, true, "SomosBelcorp");

                return Json(new
                {
                    success = true,
                    message = "Se envió con éxito la solicitud.",
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

        public string ConstruirCorreo(BESolicitudCliente entidadSolicitud)
        {
            StringBuilder cuerpoMensaje = new StringBuilder();
            decimal sumaTotal = 0;
            string cssColumnaInicial = "style=\"border-left-color: #8064A2;\"";
            string cssColumnaFinal = "style=\"border-right-color: #8064A2;\"";
            cuerpoMensaje.Append("<style type=\"text/css\">");
            cuerpoMensaje.Append("p, table, div {");
	        cuerpoMensaje.Append("    font-family: Arial;");
	        cuerpoMensaje.Append("    font-size: 13px;");
            cuerpoMensaje.Append("}");
            cuerpoMensaje.Append("#tblProducto{");
	        cuerpoMensaje.Append("    border-collapse: collapse;");
            cuerpoMensaje.Append("}");
            cuerpoMensaje.Append("#tblProducto td, #tblProducto th{");
	        cuerpoMensaje.Append("    border-width: 1px;");
	        cuerpoMensaje.Append("    border-style: solid;");
	        cuerpoMensaje.Append("    height: 30px;");
	        cuerpoMensaje.Append("    padding-left: 5px;");
            cuerpoMensaje.Append("}");
            cuerpoMensaje.Append("#tblProducto th{");
	        cuerpoMensaje.Append("    background-color: #8064A2;");
	        cuerpoMensaje.Append("    color: #FFF;");
	        cuerpoMensaje.Append("    text-align: left;");
	        cuerpoMensaje.Append("    border-top-color: #8064A2;");
	        cuerpoMensaje.Append("    border-bottom-color: #8064A2;");
	        cuerpoMensaje.Append("    border-left-color: #8064A2;");
	        cuerpoMensaje.Append("    border-right-color: #8064A2;");
            cuerpoMensaje.Append("}");
            cuerpoMensaje.Append("#tblProducto td{");
	        cuerpoMensaje.Append("    border-top-color: #8064A2;");
	        cuerpoMensaje.Append("    border-bottom-color: #8064A2;");
	        cuerpoMensaje.Append("    border-left-color: #FFF;");
	        cuerpoMensaje.Append("    border-right-color: #FFF;");
            cuerpoMensaje.Append("}");
            cuerpoMensaje.Append("#filaUltima td{");
	        cuerpoMensaje.Append("    border-top-color: #8064A2;");
	        cuerpoMensaje.Append("    border-bottom-color: #FFF;");
	        cuerpoMensaje.Append("    border-left-color: #FFF;");
	        cuerpoMensaje.Append("    border-right-color: #FFF;");
            cuerpoMensaje.Append("}");
            cuerpoMensaje.Append("</style>");

            cuerpoMensaje.Append(String.Format("<p>Estimada <strong>{0}</strong>,</p>", entidadSolicitud.NombreGZ.ToUpper()));
            cuerpoMensaje.Append("<p>Hemos recibido el pedido de un nuevo cliente de tu Zona que está en búsqueda de una Consultora.</p>");
            cuerpoMensaje.Append("<p>Te sugerimos asignar este nuevo cliente a una de tus Consultoras más proactivas, digitales y que quieras motivar.</p>");
            //cuerpoMensaje.Append("<p>Hemos recibido el pedido de un nuevo cliente que no ha podido ser <br />");
            //cuerpoMensaje.Append(String.Format("atendido por {0} consultoras de tu zona.</p>", entidadSolicitud.NumIteracion.ToString()));
            cuerpoMensaje.Append("<p>A continuación te adjuntamos sus datos y pedido para que puedan atenderlo a la brevedad.</p>");
            cuerpoMensaje.Append(String.Format("<p style=\"line-height:22px\">Cliente: {0}<br />", entidadSolicitud.NombreCompleto));
            cuerpoMensaje.Append(String.Format("Correo electrónico: {0}<br />", entidadSolicitud.Email));
            cuerpoMensaje.Append(String.Format("Teléfono: {0}<br />", entidadSolicitud.Telefono));


            string tipoDistribucion = String.Format("_{0}", entidadSolicitud.TipoDistribucion >= 1 ? entidadSolicitud.TipoDistribucion : 1);
            //R2319 - JICM - Se Obtiene la descripción de etiquetas correspondiente al pais logueado.
            string desConfig = "DES_UBIGEO_" + UserData().CodigoISO.ToString() + tipoDistribucion;
            string descripcionUnidad = ConfigurationManager.AppSettings.Get(desConfig) ?? string.Empty;
            string[] arrayUnidades = descripcionUnidad.Split(',');

            if (arrayUnidades[0] != "")
                cuerpoMensaje.Append(String.Format("{1}: {0}<br />", entidadSolicitud.UnidadGeografica1, arrayUnidades[0]));
            if (arrayUnidades[1] != "")
                cuerpoMensaje.Append(String.Format("{1}: {0}<br />", entidadSolicitud.UnidadGeografica2, arrayUnidades[1]));
            if (arrayUnidades[2] != "")
                cuerpoMensaje.Append(String.Format("{1}: {0}<br />", entidadSolicitud.UnidadGeografica3, arrayUnidades[2]));

            cuerpoMensaje.Append(String.Format("Dirección: {0}<br />",entidadSolicitud.Direccion));
            cuerpoMensaje.Append(String.Format("Marca: {0}<br />", entidadSolicitud.MarcaNombre));
            cuerpoMensaje.Append(String.Format("Campaña: {0}<br />", entidadSolicitud.Campania));
            cuerpoMensaje.Append(String.Format("Mensaje del cliente: <br /> {0}</p>", entidadSolicitud.Mensaje));
            if (entidadSolicitud.DetalleSolicitud != null && entidadSolicitud.DetalleSolicitud.ToList().Count > 0)
            {
                cuerpoMensaje.Append("<p>Productos Solicitados:</p>");
                cuerpoMensaje.Append("<table id=\"tblProducto\" style=\"width:50%\" cellpadding=\"0\" cellspacing=\"0\" >");
                cuerpoMensaje.Append("<tr>");
                cuerpoMensaje.Append("<th>Descripción</th>");
                cuerpoMensaje.Append("<th>Tono</th>");
                cuerpoMensaje.Append("<th>Cantidad</th>");
                if (entidadSolicitud.MarcaID != 2)
                {
                    cuerpoMensaje.Append("<th>Precio sin Descuento</th>");
                    cuerpoMensaje.Append("<th>Precio Total</th>");
                }
                cuerpoMensaje.Append("</tr>");
                foreach (var item in entidadSolicitud.DetalleSolicitud.ToList())
                {
                    cuerpoMensaje.Append("<tr>");
                    cuerpoMensaje.Append(String.Format("<td {0}>{1}</td>", cssColumnaInicial, item.DescripcionProducto));

                    if (entidadSolicitud.MarcaID != 2)
                    {
                        cuerpoMensaje.Append(String.Format("<td>{0}</td>", item.Tono.ToString()));
                        cuerpoMensaje.Append(String.Format("<td>{0}</td>", item.Cantidad.ToString()));
                        cuerpoMensaje.Append(String.Format("<td>{0}</td>", item.Precio.ToString()));
                        cuerpoMensaje.Append(String.Format("<td {0}>{1}</td>", cssColumnaFinal, Convert.ToString(item.Cantidad * item.Precio)));
                    }
                    else
                    {
                        cuerpoMensaje.Append(String.Format("<td {0}>{1}</td>", cssColumnaFinal, item.Cantidad.ToString()));
                    }
                    cuerpoMensaje.Append("</tr>");
                    sumaTotal += (item.Precio * item.Cantidad);
                }
                if (entidadSolicitud.MarcaID != 2)
                {
                    cuerpoMensaje.Append("<tr id=\"filaUltima\">");
                    cuerpoMensaje.Append("<td></td>");
                    cuerpoMensaje.Append("<td></td>");
                    cuerpoMensaje.Append("<td></td>");
                    cuerpoMensaje.Append("<td>Total Pedido</td>");
                    cuerpoMensaje.Append(String.Format("<td>{0} {1}</td>", UserData().Simbolo, sumaTotal.ToString()));
                    cuerpoMensaje.Append("</tr>");
                }
                cuerpoMensaje.Append("</table>");
            }
            cuerpoMensaje.Append(String.Format("<p>Mensaje de Ejecutiva SAC:<br />{0}</p>", entidadSolicitud.MensajeaGZ));
            cuerpoMensaje.Append("<p>Gracias,</p>");
            return cuerpoMensaje.ToString();
        }

        public ActionResult ExportarExcel(string CampaniaID, string PaisID, int Estado)
        {
            List<BESolicitudCliente> lst;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    var paramSolicitudCliente = new BESolicitudCliente();
                    paramSolicitudCliente.Campania = CampaniaID;
                    paramSolicitudCliente.EstadoSolicitudClienteId = Estado;

                    lst = sv.BuscarSolicitudAnuladasRechazadas(UserData().PaisID, paramSolicitudCliente).ToList();
                }


            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Campaña", "Campania");
            dic.Add("Nombre del Cliente", "NombreCompleto");
            dic.Add("Fecha de la Solicitud", "FechaSolicitud");
            dic.Add("Marca", "MarcaNombre");
            dic.Add("Estado", "Estado");
            dic.Add("Sección", "Seccion");
            dic.Add("Enviado", "EnviadoGZ");
            Util.ExportToExcel("Solicitud Cliente", lst, dic);
            return View();
        }

        public List<BETablaLogicaDatos> ConsultarTipodeUnidadGeografica()
        {

            List<BETablaLogicaDatos> listaColumna = new List<BETablaLogicaDatos>();

            using (SACServiceClient sv = new SACServiceClient())
            {
                listaColumna = sv.GetTablaLogicaDatos(UserData().PaisID, 65).ToList();
            }

            return listaColumna;
        }

        public ActionResult ReporteAfiliadas()
        {
            List<BETablaLogicaDatos> listaColumna = ConsultarTipodeUnidadGeografica().ToList();
            ViewBag.UnidadGeografica1 = listaColumna.Where(l => l.Codigo == "01").Select(c => c.Descripcion).FirstOrDefault();
            //ViewBag.UnidadGeografica1 = listaColumna.Select(x => { x.Codigo = "01"; return x.Descripcion; }).First();
            ViewBag.UnidadGeografica2 = listaColumna.Where(l => l.Codigo == "02").Select(c => c.Descripcion).FirstOrDefault();
            ViewBag.UnidadGeografica3 = listaColumna.Where(l => l.Codigo == "03").Select(c => c.Descripcion).FirstOrDefault();
            ViewBag.HdConsulta = 0;

            return View();
        }

        public ActionResult ConsultarReportesAfiliados(string sidx, string sord, int page, int rows, string fechaInicio, string fechaFin, string Consulta)
        {
            if (ModelState.IsValid)
            {

                List<BEReporteAfiliados> lst = new List<BEReporteAfiliados>();
                if (Consulta == "1")
                {

                    DateTime fechaInicioSolicitud = Convert.ToDateTime(fechaInicio);
                    DateTime fechaFinSolicitud = Convert.ToDateTime(fechaFin);

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lst = sv.GetReporteAfiliados(UserData().PaisID, fechaInicioSolicitud, fechaFinSolicitud).ToList();
                    }
                }
                else
                {
                    lst = new List<BEReporteAfiliados>();
                }


                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEReporteAfiliados> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.CodigoConsultora);
                            break;
                        case "CodigoUbigeo":
                            items = lst.OrderBy(x => x.CodigoUbigeo);
                            break;
                        case "UnidadGeografica1":
                            items = lst.OrderBy(x => x.UnidadGeografica1);
                            break;
                        case "UnidadGeografica2":
                            items = lst.OrderBy(x => x.UnidadGeografica2);
                            break;
                        case "UnidadGeografica3":
                            items = lst.OrderBy(x => x.UnidadGeografica3);
                            break;
                        case "NombreCompleto":
                            items = lst.OrderBy(x => x.NombreCompleto);
                            break;
                        case "EsAfiliado":
                            items = lst.OrderBy(x => x.EsAfiliado);
                            break;
                        case "Segmento":
                            items = lst.OrderBy(x => x.Segmento);
                            break;
                        case "AnoCampanaIngreso":
                            items = lst.OrderBy(x => x.AnoCampanaIngreso);
                            break;
                        case "FechaCreacion":
                            items = lst.OrderBy(x => x.FechaCreacion);
                            break;
                        case "FechaModificacion":
                            items = lst.OrderBy(x => x.FechaModificacion);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.CodigoConsultora);
                            break;
                        case "CodigoUbigeo":
                            items = lst.OrderByDescending(x => x.CodigoUbigeo);
                            break;
                        case "UnidadGeografica1":
                            items = lst.OrderByDescending(x => x.UnidadGeografica1);
                            break;
                        case "UnidadGeografica2":
                            items = lst.OrderByDescending(x => x.UnidadGeografica2);
                            break;
                        case "UnidadGeografica3":
                            items = lst.OrderByDescending(x => x.UnidadGeografica3);
                            break;
                        case "NombreCompleto":
                            items = lst.OrderByDescending(x => x.NombreCompleto);
                            break;
                        case "EsAfiliado":
                            items = lst.OrderByDescending(x => x.EsAfiliado);
                            break;
                        case "Segmento":
                            items = lst.OrderByDescending(x => x.Segmento);
                            break;
                        case "AnoCampanaIngreso":
                            items = lst.OrderByDescending(x => x.AnoCampanaIngreso);
                            break;
                        case "FechaCreacion":
                            items = lst.OrderByDescending(x => x.FechaCreacion);
                            break;
                        case "FechaModificacion":
                            items = lst.OrderByDescending(x => x.FechaModificacion);
                            break;
                    }
                }
                #endregion
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
                               id = a.CodigoConsultora,
                               cell = new string[] 
                               {
                                   a.CodigoConsultora.ToString(),
                                   a.CodigoUbigeo,
                                   Convert.ToString(a.UnidadGeografica1),
                                   Convert.ToString(a.UnidadGeografica2.ToString()),
                                   Convert.ToString(a.UnidadGeografica3.ToString()),
                                   a.NombreCompleto,
                                   a.EsAfiliado.ToString(),
                                   Convert.ToString(a.Segmento.ToString()),
                                   Convert.ToString(a.AnoCampanaIngreso),
                                   a.FechaCreacionString.ToString(),
                                   a.FechaModificacionString.ToString()
                                   //Convert.ToDateTime(a.FechaCreacion.ToString()).ToShortDateString(),
                                   //Convert.ToDateTime(a.FechaModificacion.ToString()).ToShortDateString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("ReporteAfiliadas", "SolicitudCliente");
        }

        public ActionResult ExportarExcelReporteAfiliadas(string fechaInicio, string fechaFin)
        {
            List<BEReporteAfiliados> lst;

            DateTime fechaInicioSolicitud = Convert.ToDateTime(fechaInicio);
            DateTime fechaFinSolicitud = Convert.ToDateTime(fechaFin);

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetReporteAfiliados(UserData().PaisID, fechaInicioSolicitud, fechaFinSolicitud).ToList();
            }

            List<BETablaLogicaDatos> listaColumna = ConsultarTipodeUnidadGeografica().ToList();

            string UnidadGeografica1 = listaColumna.Where(l => l.Codigo == "01").Select(c => c.Descripcion).FirstOrDefault();
            string UnidadGeografica2 = listaColumna.Where(l => l.Codigo == "02").Select(c => c.Descripcion).FirstOrDefault();
            string UnidadGeografica3 = listaColumna.Where(l => l.Codigo == "03").Select(c => c.Descripcion).FirstOrDefault();

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Código", "CodigoConsultora");
            dic.Add("Código Ubigeo", "CodigoUbigeo");
            dic.Add(UnidadGeografica1, "UnidadGeografica1");
            dic.Add(UnidadGeografica2, "UnidadGeografica2");
            dic.Add(UnidadGeografica3, "UnidadGeografica3");
            dic.Add("Nombre Completo", "NombreCompleto");
            dic.Add("Es Afiliado", "EsAfiliado");
            dic.Add("Segmento", "Segmento");
            dic.Add("Año Campaña Ingreso", "AnoCampanaIngreso");
            dic.Add("Fecha Creación", "FechaCreacionString");
            dic.Add("Fecha Modificación", "FechaModificacionString");
            Util.ExportToExcel("Reporte Afiliadas", lst, dic);
            return View();
        }

        public ActionResult ReportePedidos(string Campania)
        {
            
            var solicitudClienteModel = new SolicitudClienteModel();

            solicitudClienteModel.listaEstadoSolicitudCliente = DropDowListEstado(UserData().PaisID);
            solicitudClienteModel.listaCampania = DropDowListCampanias(UserData().PaisID);
            solicitudClienteModel.listaMarcas = GetDescripcionMarca();

            return View(solicitudClienteModel);
        }

        public Dictionary<int, string> GetDescripcionMarca()
        {

            Dictionary<int, string> dicMarcas = new Dictionary<int, string>();
            dicMarcas.Add(1, "Lbel");
            dicMarcas.Add(2, "Esika");
            dicMarcas.Add(3, "Cyzone");
            dicMarcas.Add(6, "Finart");

            return dicMarcas;
        }

        public ActionResult ConsultarReportesPedidos(string sidx, string sord, int page, int rows, string fechaInicio, string fechaFin, int estado, string marca, string campania)
        {
            if (ModelState.IsValid)
            {
                List<BEReportePedidos> lst;
                
                DateTime fechaInicioSolicitud = Convert.ToDateTime(fechaInicio);
                DateTime fechaFinSolicitud = Convert.ToDateTime(fechaFin);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.GetReportePedidos(fechaInicioSolicitud, fechaFinSolicitud, estado, marca, campania, UserData().PaisID).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                
                BEPager pag = new BEPager();
                IEnumerable<BEReportePedidos> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "SolicitudClienteID":
                            items = lst.OrderBy(x => x.SolicitudClienteID);
                            break;
                        case "Estado":
                            items = lst.OrderBy(x => x.Estado);
                            break;
                        case "FechaSolicitud":
                            items = lst.OrderBy(x => x.FechaSolicitud);
                            break;
                        case "NombreCliente":
                            items = lst.OrderBy(x => x.NombreCliente);
                            break;
                        case "Direccion":
                            items = lst.OrderBy(x => x.Direccion);
                            break;
                        case "EmailCliente":
                            items = lst.OrderBy(x => x.EmailCliente);
                            break;
                        case "TelefonoCliente":
                            items = lst.OrderBy(x => x.TelefonoCliente);
                            break;
                        case "Marca":
                            items = lst.OrderBy(x => x.Marca);
                            break;
                        case "Campania":
                            items = lst.OrderBy(x => x.Campania);
                            break;
                        case "Producto":
                            items = lst.OrderBy(x => x.Producto);
                            break;
                        case "Tono":
                            items = lst.OrderBy(x => x.Tono);
                            break;
                        case "Cantidad":
                            items = lst.OrderBy(x => x.Cantidad);
                            break;
                        case "Precio":
                            items = lst.OrderBy(x => x.Precio);
                            break;
                        case "MensajeCliente":
                            items = lst.OrderBy(x => x.MensajeCliente);
                            break;
                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.CodigoConsultora);
                            break;
                        case "NombreConsultora":
                            items = lst.OrderBy(x => x.NombreConsultora);
                            break;
                        case "TelefonoMovilConsultora":
                            items = lst.OrderBy(x => x.TelefonoMovilConsultora);
                            break;
                        case "TelefonoFijoConsultora":
                            items = lst.OrderBy(x => x.TelefonoFijoConsultora);
                            break;
                        case "EmailConsultora":
                            items = lst.OrderBy(x => x.EmailConsultora);
                            break;
                        case "Leido":
                            items = lst.OrderBy(x => x.Leido);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "SolicitudClienteID":
                            items = lst.OrderByDescending(x => x.SolicitudClienteID);
                            break;
                        case "Estado":
                            items = lst.OrderByDescending(x => x.Estado);
                            break;
                        case "FechaSolicitud":
                            items = lst.OrderByDescending(x => x.FechaSolicitud);
                            break;
                        case "NombreCliente":
                            items = lst.OrderByDescending(x => x.NombreCliente);
                            break;
                        case "Direccion":
                            items = lst.OrderByDescending(x => x.Direccion);
                            break;
                        case "EmailCliente":
                            items = lst.OrderByDescending(x => x.EmailCliente);
                            break;
                        case "TelefonoCliente":
                            items = lst.OrderByDescending(x => x.TelefonoCliente);
                            break;
                        case "Marca":
                            items = lst.OrderByDescending(x => x.Marca);
                            break;
                        case "Campania":
                            items = lst.OrderByDescending(x => x.Campania);
                            break;
                        case "Producto":
                            items = lst.OrderByDescending(x => x.Producto);
                            break;
                        case "Tono":
                            items = lst.OrderBy(x => x.Tono);
                            break;
                        case "Cantidad":
                            items = lst.OrderByDescending(x => x.Cantidad);
                            break;
                        case "Precio":
                            items = lst.OrderByDescending(x => x.Precio);
                            break;
                        case "MensajeCliente":
                            items = lst.OrderByDescending(x => x.MensajeCliente);
                            break;
                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.CodigoConsultora);
                            break;
                        case "NombreConsultora":
                            items = lst.OrderByDescending(x => x.NombreConsultora);
                            break;
                        case "TelefonoMovilConsultora":
                            items = lst.OrderByDescending(x => x.TelefonoMovilConsultora);
                            break;
                        case "TelefonoFijoConsultora":
                            items = lst.OrderByDescending(x => x.TelefonoFijoConsultora);
                            break;
                        case "EmailConsultora":
                            items = lst.OrderByDescending(x => x.EmailConsultora);
                            break;
                        case "Leido":
                            items = lst.OrderByDescending(x => x.Leido);
                            break;
                    }
                }
                #endregion
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
                               id = a.CodigoConsultora,
                               cell = new string[] 
                               {
                                   a.SolicitudClienteID.ToString(),
                                   a.Estado.ToString(),
                                   Convert.ToDateTime(a.FechaSolicitud.ToString()).ToShortDateString(),
                                   a.NombreCliente.ToString(),
                                   a.Direccion.ToString(),
                                   a.EmailCliente.ToString(),
                                   a.TelefonoCliente.ToString(),
                                   a.Marca.ToString(),
                                   a.Campania.ToString(),
                                   a.Producto.ToString(),
                                   a.Tono.ToString(),
                                   a.Cantidad.ToString(),
                                   a.Precio.ToString(),
                                   a.MensajeCliente.ToString(),
                                   a.CodigoConsultora.ToString(),
                                   a.NombreConsultora.ToString(),
                                   a.TelefonoMovilConsultora.ToString(),
                                   a.TelefonoFijoConsultora.ToString(),
                                   a.EmailConsultora.ToString(),
                                   a.Leido.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("ReportePedidos", "SolicitudCliente");
        }

        public ActionResult ExportarExcelReportePedidos(string fechaInicio, string fechaFin, int estado, string marca, string campania)
        {
            List<BEReportePedidos> lst;

            DateTime fechaInicioSolicitud = Convert.ToDateTime(fechaInicio);
            DateTime fechaFinSolicitud = Convert.ToDateTime(fechaFin);

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetReportePedidos(fechaInicioSolicitud, fechaFinSolicitud, estado, marca, campania, UserData().PaisID).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("SolicitudClienteID", "SolicitudClienteID");
            dic.Add("Estado", "Estado");
            dic.Add("Fecha Solicitud", "FechaSolicitud");
            dic.Add("Nombre Cliente", "NombreCliente");
            dic.Add("Dirección", "Direccion");
            dic.Add("Email Cliente", "EmailCliente");
            dic.Add("Telefono Cliente", "TelefonoCliente");
            dic.Add("Marca", "Marca");
            dic.Add("Campaña", "Campania");
            dic.Add("Producto", "Producto");
            dic.Add("Tono", "Tono");
            dic.Add("Cantidad", "Cantidad");
            dic.Add("Precio", "Precio");
            dic.Add("Msj del Cliente", "MensajeCliente");
            dic.Add("Código Consultora", "CodigoConsultora");
            dic.Add("Nombre Consultora", "NombreConsultora");
            dic.Add("Tlf. Movil Consultora", "TelefonoMovilConsultora");
            dic.Add("Tlf. Fijo Consultora", "TelefonoFijoConsultora");
            dic.Add("Email Consultora", "EmailConsultora");
            dic.Add("Leido", "Leido");

            Util.ExportToExcel("Reporte Pedidos", lst, dic);
            return View();
        }
    }
}
