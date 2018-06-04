using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class SolicitudClienteController : BaseController
    {
        public ActionResult Index(string Campania, string Estado, string paginacion)
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "SolicitudCliente/Index"))
                return RedirectToAction("Index", "Bienvenida");

            var solicitudClienteModel = new SolicitudClienteModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises()
            };

            if (!string.IsNullOrEmpty(Campania) && !string.IsNullOrEmpty(Estado))
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
                lst = UserData().RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(UserData().PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private List<BEEstadoSolicitudCliente> DropDowListEstado(int paisId)
        {
            List<BEEstadoSolicitudCliente> listaEstadoSolicitudCliente = new List<BEEstadoSolicitudCliente>();

            BEEstadoSolicitudCliente estadoSeleccione = new BEEstadoSolicitudCliente
            {
                EstadoSolicitudClienteID = -1,
                Descripcion = "-- Selecione Estado --",
                TipoEstado = "",
                Activo = true
            };
            listaEstadoSolicitudCliente.Add(estadoSeleccione);


            BEEstadoSolicitudCliente estadoSolicitudCliente =
                new BEEstadoSolicitudCliente
                {
                    EstadoSolicitudClienteID = 0,
                    Descripcion = "Todos",
                    TipoEstado = "T",
                    Activo = true
                };
            listaEstadoSolicitudCliente.Add(estadoSolicitudCliente);


            using (SACServiceClient sv = new SACServiceClient())
            {
                listaEstadoSolicitudCliente.AddRange(sv.GetEstadoSolicitudCliente(paisId).ToList());
            }

            return listaEstadoSolicitudCliente;
        }

        public ActionResult Detalle(string SolicitudClienteId, string Estado, string paginacion)
        {
            BESolicitudCliente entidadCliente;

            var paramSolicitudCliente = new BESolicitudCliente
            {
                SolicitudClienteID = Convert.ToInt64(SolicitudClienteId)
            };

            using (SACServiceClient sv = new SACServiceClient())
            {
                entidadCliente = sv.DetalleSolicitudAnuladasRechazadas(UserData().PaisID, paramSolicitudCliente);
            }

            SolicitudClienteModel modelSolicitudCliente = new SolicitudClienteModel
            {
                UnidadGeografica1 = entidadCliente.UnidadGeografica1,
                UnidadGeografica2 = entidadCliente.UnidadGeografica2,
                UnidadGeografica3 = entidadCliente.UnidadGeografica3,
                TipoDistribucion = entidadCliente.TipoDistribucion,
                Seccion = entidadCliente.Seccion,
                NombreConsultoraAsignada = entidadCliente.NombreConsultoraAsignada,
                CorreoConsultoraAsginada = entidadCliente.CorreoConsultoraAsginada,
                NombreCliente = entidadCliente.NombreCompleto,
                EmailCliente = entidadCliente.Email,
                TelefonoCliente = entidadCliente.Telefono,
                Mensaje = entidadCliente.Mensaje,
                listaDetalle = entidadCliente.DetalleSolicitud.ToList(),
                NombreGZ = entidadCliente.NombreGZ,
                EmailGZ = entidadCliente.EmailGZ,
                Direccion = entidadCliente.Direccion,
                MensajeaGZ = entidadCliente.MensajeaGZ,
                Campania = entidadCliente.Campania,
                Estado = entidadCliente.Estado,
                Paginacion = paginacion
            };

            decimal sumaTotal = 0;
            foreach (var item in modelSolicitudCliente.listaDetalle)
                sumaTotal += (item.Precio * item.Cantidad);
            
            ViewBag.MontoTotal = sumaTotal.ToString();
            ViewBag.MarcaID = entidadCliente.MarcaID;
            ViewBag.TieneDetalle = (entidadCliente.DetalleSolicitud != null) ? entidadCliente.DetalleSolicitud.ToList().Count : 0;

            string tipoDistribucion = String.Format("_{0}", modelSolicitudCliente.TipoDistribucion >= 1 ? modelSolicitudCliente.TipoDistribucion : 1);
            string desConfig = Constantes.ConfiguracionManager.DES_UBIGEO + UserData().CodigoISO + tipoDistribucion;
            string descripcionUnidad = GetConfiguracionManager(desConfig);
            string[] arrayUnidades = descripcionUnidad.Split(',');
            ViewBag.UnidadGeografica1 = arrayUnidades[0] + ":";
            ViewBag.UnidadGeografica2 = arrayUnidades[1] + ":";
            ViewBag.UnidadGeografica3 = arrayUnidades[2] + ":";

            return View("Detalle", modelSolicitudCliente);

        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string CampaniaID, string PaisID, string Consulta, int Estado, string Paginacion)
        {
            if (ModelState.IsValid)
            {
                Paginacion = Util.Trim(Paginacion);
                int outVal;
                int.TryParse(Paginacion, out outVal);

                if (page == 1 && outVal > 0)
                {
                    page = outVal;
                }

                List<BESolicitudCliente> lst;

                if (Consulta == "1")
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        var paramSolicitudCliente = new BESolicitudCliente
                        {
                            Campania = CampaniaID,
                            EstadoSolicitudClienteId = Estado
                        };
                        lst = sv.BuscarSolicitudAnuladasRechazadas(UserData().PaisID, paramSolicitudCliente).ToList();
                    }
                }
                else
                {
                    lst = new List<BESolicitudCliente>();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

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
                List<BESolicitudClienteDetalle> lst;

                var paramSolicitudCliente = new BESolicitudCliente
                {
                    SolicitudClienteID = Convert.ToInt64(SolicitudClienteID)
                };

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.DetalleSolicitudAnuladasRechazadas(UserData().PaisID, paramSolicitudCliente).DetalleSolicitud.ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BESolicitudClienteDetalle> items = lst;
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

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
                                   a.Tono,
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
                BESolicitudCliente entidadCliente;
                string correoOculto;
                var solicitudCliente = new BESolicitudCliente
                {
                    SolicitudClienteID = Convert.ToInt64(SolicitudClienteId),
                    NombreGZ = NombreGZ,
                    EmailGZ = EmailGZ,
                    MensajeaGZ = MensajeaGZ,
                    UsuarioModificacion = UserData().CodigoUsuario
                };

                using (SACServiceClient sv = new SACServiceClient())
                {
                    var listSegmentos = sv.GetTablaLogicaDatos(UserData().PaisID, 57).ToList();
                    correoOculto = (from item in listSegmentos where item.TablaLogicaDatosID == 5701 select item.Descripcion).First();
                    resultado = sv.EnviarSolicitudClienteaGZ(UserData().PaisID, solicitudCliente);
                    entidadCliente = sv.DetalleSolicitudAnuladasRechazadas(UserData().PaisID, solicitudCliente);
                }

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
            cuerpoMensaje.Append("<p>A continuación te adjuntamos sus datos y pedido para que puedan atenderlo a la brevedad.</p>");
            cuerpoMensaje.Append(String.Format("<p style=\"line-height:22px\">Cliente: {0}<br />", entidadSolicitud.NombreCompleto));
            cuerpoMensaje.Append(String.Format("Correo electrónico: {0}<br />", entidadSolicitud.Email));
            cuerpoMensaje.Append(String.Format("Teléfono: {0}<br />", entidadSolicitud.Telefono));


            string tipoDistribucion = String.Format("_{0}", entidadSolicitud.TipoDistribucion >= 1 ? entidadSolicitud.TipoDistribucion : 1);
            string desConfig = Constantes.ConfiguracionManager.DES_UBIGEO + UserData().CodigoISO + tipoDistribucion;
            string descripcionUnidad = GetConfiguracionManager(desConfig);
            string[] arrayUnidades = descripcionUnidad.Split(',');

            if (arrayUnidades[0] != "")
                cuerpoMensaje.Append(String.Format("{1}: {0}<br />", entidadSolicitud.UnidadGeografica1, arrayUnidades[0]));
            if (arrayUnidades[1] != "")
                cuerpoMensaje.Append(String.Format("{1}: {0}<br />", entidadSolicitud.UnidadGeografica2, arrayUnidades[1]));
            if (arrayUnidades[2] != "")
                cuerpoMensaje.Append(String.Format("{1}: {0}<br />", entidadSolicitud.UnidadGeografica3, arrayUnidades[2]));

            cuerpoMensaje.Append(String.Format("Dirección: {0}<br />", entidadSolicitud.Direccion));
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
                        cuerpoMensaje.Append(String.Format("<td>{0}</td>", item.Tono));
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

            var paramSolicitudCliente = new BESolicitudCliente
            {
                Campania = CampaniaID,
                EstadoSolicitudClienteId = Estado
            };

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.BuscarSolicitudAnuladasRechazadas(UserData().PaisID, paramSolicitudCliente).ToList();
            }


            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Campaña", "Campania"},
                {"Nombre del Cliente", "NombreCompleto"},
                {"Fecha de la Solicitud", "FechaSolicitud"},
                {"Marca", "MarcaNombre"},
                {"Estado", "Estado"},
                {"Sección", "Seccion"},
                {"Enviado", "EnviadoGZ"}
            };
            Util.ExportToExcel("Solicitud Cliente", lst, dic);
            return View();
        }

        public List<BETablaLogicaDatos> ConsultarTipodeUnidadGeografica()
        {

            List<BETablaLogicaDatos> listaColumna;

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
            ViewBag.UnidadGeografica2 = listaColumna.Where(l => l.Codigo == "02").Select(c => c.Descripcion).FirstOrDefault();
            ViewBag.UnidadGeografica3 = listaColumna.Where(l => l.Codigo == "03").Select(c => c.Descripcion).FirstOrDefault();
            ViewBag.HdConsulta = 0;

            return View();
        }

        public ActionResult ConsultarReportesAfiliados(string sidx, string sord, int page, int rows, string fechaInicio, string fechaFin, string Consulta)
        {
            if (ModelState.IsValid)
            {

                List<BEReporteAfiliados> lst;
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

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                BEPager pag = Util.PaginadorGenerico(grid, lst);

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
                                   a.CodigoConsultora,
                                   a.CodigoUbigeo,
                                   a.UnidadGeografica1,
                                   a.UnidadGeografica2,
                                   a.UnidadGeografica3,
                                   a.NombreCompleto,
                                   a.EsAfiliado.ToString(),
                                   a.Segmento,
                                   a.AnoCampanaIngreso,
                                   a.FechaCreacionString,
                                   a.FechaModificacionString
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

            string unidadGeografica1 = listaColumna.Where(l => l.Codigo == "01").Select(c => c.Descripcion).FirstOrDefault();
            string unidadGeografica2 = listaColumna.Where(l => l.Codigo == "02").Select(c => c.Descripcion).FirstOrDefault();
            string unidadGeografica3 = listaColumna.Where(l => l.Codigo == "03").Select(c => c.Descripcion).FirstOrDefault();

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Código", "CodigoConsultora"},
                {"Código Ubigeo", "CodigoUbigeo"},
                {unidadGeografica1, "UnidadGeografica1"},
                {unidadGeografica2, "UnidadGeografica2"},
                {unidadGeografica3, "UnidadGeografica3"},
                {"Nombre Completo", "NombreCompleto"},
                {"Es Afiliado", "EsAfiliado"},
                {"Segmento", "Segmento"},
                {"Año Campaña Ingreso", "AnoCampanaIngreso"},
                {"Fecha Creación", "FechaCreacionString"},
                {"Fecha Modificación", "FechaModificacionString"}
            };
            Util.ExportToExcel("Reporte Afiliadas", lst, dic);
            return View();
        }

        public ActionResult ReportePedidos(string Campania)
        {
            var solicitudClienteModel = new SolicitudClienteModel
            {
                listaEstadoSolicitudCliente = DropDowListEstado(UserData().PaisID),
                listaCampania = DropDowListCampanias(UserData().PaisID),
                listaMarcas = GetDescripcionMarca()
            };

            return View(solicitudClienteModel);
        }

        public Dictionary<int, string> GetDescripcionMarca()
        {

            Dictionary<int, string> dicMarcas = new Dictionary<int, string>
            {
                {1, "Lbel"}, {2, "Esika"}, {3, "Cyzone"}, {6, "Finart"}
            };

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

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                BEPager pag = Util.PaginadorGenerico(grid, lst);

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
                                   a.Estado,
                                   Convert.ToDateTime(a.FechaSolicitud.ToString()).ToShortDateString(),
                                   a.NombreCliente,
                                   a.Direccion,
                                   a.EmailCliente,
                                   a.TelefonoCliente,
                                   a.Marca,
                                   a.Campania,
                                   a.Producto,
                                   a.Tono,
                                   a.Cantidad.ToString(),
                                   a.Precio.ToString(),
                                   a.MensajeCliente,
                                   a.CodigoConsultora,
                                   a.NombreConsultora,
                                   a.TelefonoMovilConsultora,
                                   a.TelefonoFijoConsultora,
                                   a.EmailConsultora,
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

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"SolicitudClienteID", "SolicitudClienteID"},
                {"Estado", "Estado"},
                {"Fecha Solicitud", "FechaSolicitud"},
                {"Nombre Cliente", "NombreCliente"},
                {"Dirección", "Direccion"},
                {"Email Cliente", "EmailCliente"},
                {"Telefono Cliente", "TelefonoCliente"},
                {"Marca", "Marca"},
                {"Campaña", "Campania"},
                {"Producto", "Producto"},
                {"Tono", "Tono"},
                {"Cantidad", "Cantidad"},
                {"Precio", "Precio"},
                {"Msj del Cliente", "MensajeCliente"},
                {"Código Consultora", "CodigoConsultora"},
                {"Nombre Consultora", "NombreConsultora"},
                {"Tlf. Movil Consultora", "TelefonoMovilConsultora"},
                {"Tlf. Fijo Consultora", "TelefonoFijoConsultora"},
                {"Email Consultora", "EmailConsultora"},
                {"Leido", "Leido"}
            };

            Util.ExportToExcel("Reporte Pedidos", lst, dic);
            return View();
        }
    }
}
