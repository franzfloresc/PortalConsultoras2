using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLSolicitudCliente
    {
        #region Private Functions

        private string ToUpperFirstLetter(string source)
        {
            if (string.IsNullOrEmpty(source))
                return string.Empty;
            char[] letters = source.ToCharArray();
            letters[0] = char.ToUpper(letters[0]);
            return new string(letters);
        }

        private void EnviarEmailSolicitudCliente(int paisID, BEConsultoraSolicitudCliente consultoraSolicitudCliente, BEResultadoSolicitud resultado)
        {
            BESolicitudCliente solicitudCliente = GetSolicitudClienteWithoutMarcaBySolicitudId(paisID, resultado.Resultado);            
            // SACService ServiceSAC = new SACService();            
            var TablaLogDatos = new BLTablaLogicaDatos();
               // List<BETablaLogicaDatos> TablaLogicaDatosMail = TablaLogDatos.GetTablaLogicaDatos(paisID, 57);
            List<BETablaLogicaDatos> tablalogicaDatos = TablaLogDatos.GetTablaLogicaDatos(paisID, 56);

                String emailOculto = string.Empty;// TablaLogicaDatosMail.FirstOrDefault(x => x.TablaLogicaDatosID == 5701).Descripcion;
            String horas = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo;

            if (consultoraSolicitudCliente != null)
            {
                try
                {
                    string asunto = "Un nuevo cliente te eligió como Consultora Online";
                    StringBuilder mensajeCorreo = new StringBuilder();

                    DateTime fechaMaxima = solicitudCliente.FechaSolicitud.AddDays(1);
                    var culture = new System.Globalization.CultureInfo("es-PE");
                    var dia = culture.DateTimeFormat.GetDayName(fechaMaxima.DayOfWeek);
                    var mes = culture.DateTimeFormat.GetMonthName(fechaMaxima.Month);

                    dia = ToUpperFirstLetter(dia);
                    mes = ToUpperFirstLetter(mes);

                    string contextoBase = System.Configuration.ConfigurationManager.AppSettings["CONTEXTO_BASE"];

                    string fechaFormato = String.Format("{0} {1} de {2} - {3}", dia, fechaMaxima.ToString("dd"), mes, fechaMaxima.ToString("hh:mm tt"));
                    string carpetaPais = "Correo/CCC";
                    string spacerGif = ConfigS3.GetUrlFileS3(carpetaPais, "spacer.gif", string.Empty);

                    mensajeCorreo.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif;\">");
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine("<td style=\"text-align:center;\">");
                    mensajeCorreo.AppendLine("<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
                    mensajeCorreo.AppendLine(String.Format("<tr><td colspan=\"7\"><img src=\"{0}\" width=\"682\" height=\"117\" alt=\"\"></td><tr>", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_01.png", string.Empty)));
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine(String.Format("<td><img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_03.png", string.Empty)));
                    mensajeCorreo.AppendLine("<td colspan=\"3\" style=\"text-align:left; padding-top:50px; padding-bottom:20px; font-size:18px;\">");
                    mensajeCorreo.AppendLine(String.Format("Hola, {0}<br/><br/>", consultoraSolicitudCliente.Nombre));
                    mensajeCorreo.AppendLine("¡Un nuevo cliente te ha elegido como su Consultora para");
                    mensajeCorreo.AppendLine("hacerte un pedido!<br/><br/>");
                    mensajeCorreo.AppendLine("Cliente:<br/>");
                    mensajeCorreo.AppendLine(String.Format("<span style=\"font-weight:bold;\">{0}</span>  <br/><br/>", solicitudCliente.NombreCompleto));
                    mensajeCorreo.AppendLine("Fecha límite para aceptar o rechazar el pedido:<br/>");
                    mensajeCorreo.AppendLine(String.Format("<span style=\"font-weight:bold;\">{0}</span><br/><br/>", fechaFormato));
                    mensajeCorreo.AppendLine("Atiende su pedido y conviértete en su Consultora, ¡crear");
                    mensajeCorreo.AppendLine("una excelente relación depende de ti!");
                    mensajeCorreo.AppendLine("</td>");
                    mensajeCorreo.AppendLine(String.Format("<td colspan=\"3\"><img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_05.png", string.Empty)));
                    mensajeCorreo.AppendLine("</tr>");
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine("<td colspan=\"7\" style=\"text-align:center; padding-top:30px; padding-bottom:50px\">");
                    mensajeCorreo.AppendLine(String.Format("<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=SolicitudPedido\" target=\"_blank\"><img src=\"{1}\" width=\"201\" height=\"38\" border=\"0\" alt=\"Ver pedido\"></a>", contextoBase, ConfigS3.GetUrlFileS3(carpetaPais, "7-Mailing_03.png", string.Empty)));
                    mensajeCorreo.AppendLine("</td>");
                    mensajeCorreo.AppendLine("</tr>");
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine("<td colspan=\"7\" style=\"background-color:#acbbc9;\">");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_12.png", string.Empty)));
                    mensajeCorreo.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>", ConfigS3.GetUrlFileS3(carpetaPais, "Facebook.png", string.Empty)));
                    mensajeCorreo.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>", ConfigS3.GetUrlFileS3(carpetaPais, "Youtube.png", string.Empty)));
                    mensajeCorreo.AppendLine("</td>");
                    mensajeCorreo.AppendLine("</tr>");
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine("<td colspan=\"7\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");
                    mensajeCorreo.AppendLine("¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>");
                    mensajeCorreo.AppendLine("</td>");
                    mensajeCorreo.AppendLine("</tr>");
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine("<td>");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"1\" alt=\"\"></td>", spacerGif));
                    mensajeCorreo.AppendLine("<td>");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"192\" height=\"1\" alt=\"\"></td>", spacerGif));
                    mensajeCorreo.AppendLine("<td>");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"201\" height=\"1\" alt=\"\"></td>", spacerGif));
                    mensajeCorreo.AppendLine("<td>");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"164\" height=\"1\" alt=\"\"></td>", spacerGif));
                    mensajeCorreo.AppendLine("<td>");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"1\" alt=\"\"></td>", spacerGif));
                    mensajeCorreo.AppendLine("<td>");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"1\" alt=\"\"></td>", spacerGif));
                    mensajeCorreo.AppendLine("<td>");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"18\" height=\"1\" alt=\"\"></td>", spacerGif));
                    mensajeCorreo.AppendLine("</tr>");
                    mensajeCorreo.AppendLine("</table>");
                    mensajeCorreo.AppendLine("</td>");
                    mensajeCorreo.AppendLine("</tr>");
                    mensajeCorreo.AppendLine("</table>");

                    Common.Util.EnviarMail("no-responder@somosbelcorp.com", consultoraSolicitudCliente.Email, emailOculto, asunto, mensajeCorreo.ToString(), true, "Consultora Online Belcorp");
                }
                catch (Exception)
                {
                    //resultado.Mensaje = string.Format("No se pudo enviar correo: {0}", ex.ToString());
                }
            }
        }

        #endregion
        
        public BEResultadoSolicitud InsertarSolicitudCliente(int paisID, BEEntradaSolicitudCliente entidadSolicitud)
        {
            BEResultadoSolicitud resultado = null;
            try
            {
                var DASolicitudCliente = new DASolicitudCliente(paisID);
                IEnumerable<BESolicitudClienteDetalle> listaSolicitudDetalle = null;
                if (entidadSolicitud.DetalleSolicitud == null) listaSolicitudDetalle = new List<BESolicitudClienteDetalle>().ToList();
                else listaSolicitudDetalle = entidadSolicitud.DetalleSolicitud.ToList();

                using (IDataReader reader = DASolicitudCliente.InsertarSolicitudCliente(entidadSolicitud, listaSolicitudDetalle))
                {
                    while (reader.Read())
                    {
                        resultado = new BEResultadoSolicitud(reader);
                    }
                }

                BEConsultoraSolicitudCliente consultoraSolicitudCliente = GetConsultoraSolicitudCliente(paisID, int.Parse(entidadSolicitud.ConsultoraID.ToString()), entidadSolicitud.CodigoConsultora, entidadSolicitud.MarcaID);
                this.EnviarEmailSolicitudCliente(paisID, consultoraSolicitudCliente, resultado);
                return resultado;
            }
            catch (Exception ex)
            {
                resultado = new BEResultadoSolicitud(0, ex.Message.ToString());
                return resultado;
            }
        }

        public BEResultadoSolicitud InsertarSolicitudClienteAppCatalogo(int paisID, BESolicitudClienteAppCatalogo entidadSolicitud)
        {
            BEResultadoSolicitud resultado = null;
            try
            {
                var DASolicitudCliente = new DASolicitudCliente(paisID);
                using (IDataReader reader = DASolicitudCliente.InsertarSolicitudClienteAppCliente(entidadSolicitud))
                {
                    while (reader.Read()) { resultado = new BEResultadoSolicitud(reader); }
                }

                BEConsultoraSolicitudCliente consultoraSolicitudCliente = GetConsultoraSolicitudCliente(paisID, int.Parse(entidadSolicitud.ConsultoraID.ToString()), entidadSolicitud.CodigoConsultora, 0);
                this.EnviarEmailSolicitudCliente(paisID, consultoraSolicitudCliente, resultado);
                return resultado;
            }
            catch (Exception ex)
            {
                resultado = new BEResultadoSolicitud(0, ex.Message.ToString());
                return resultado;
            }
        }
        
        //JLCS
        public BESolicitudCliente GetSolicitudClienteBySolicitudId(int paisID, long solicitudClienteId)
        {
            BESolicitudCliente solicitudCliente = null;
            var DASolicitudCliente = new DASolicitudCliente(paisID);

            using (IDataReader reader = DASolicitudCliente.GetSolicitudClienteBySolicitudId(solicitudClienteId))
            {
                while (reader.Read())
                {
                    solicitudCliente = new BESolicitudCliente(reader);
                }
            }

            return solicitudCliente;
        }

        public BESolicitudCliente GetSolicitudClienteWithoutMarcaBySolicitudId(int paisID, long solicitudClienteId)
        {
            BESolicitudCliente solicitudCliente = null;
            var DASolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = DASolicitudCliente.GetSolicitudClienteWithoutMarcaBySolicitudId(solicitudClienteId))
            {
                while (reader.Read()) { solicitudCliente = new BESolicitudCliente(reader); }
            }
            return solicitudCliente;
        }

        //JLCS - 2319
        public List<BESolicitudClienteDetalle> GetSolicitudClienteDetalleBySolicitudId(int paisID, long solicitudClienteId)
        {
            List<BESolicitudClienteDetalle> solicitudClientes = new List<BESolicitudClienteDetalle>();
            var DASolicitudCliente = new DASolicitudCliente(paisID);

            using (IDataReader reader = DASolicitudCliente.GetSolicitudClienteDetalleBySolicitudId(solicitudClienteId))
            {
                while (reader.Read())
                {
                    solicitudClientes.Add(new BESolicitudClienteDetalle(reader));
                }
            }

            return solicitudClientes;
        }

        /*R2613-LR*/
        public BEConsultoraSolicitudCliente GetConsultoraSolicitudCliente(int paisID, int consultoraid, string codigo, int marcaId)
        {
            BEConsultoraSolicitudCliente consultorasolicitudCliente = null;
            var DASolicitudCliente = new DASolicitudCliente(paisID);

            using (IDataReader reader = DASolicitudCliente.GetConsultoraSolicitudCliente(consultoraid, codigo, marcaId))
            {
                while (reader.Read())
                {
                    consultorasolicitudCliente = new BEConsultoraSolicitudCliente(reader);

                }
            }
            return consultorasolicitudCliente;
        }
        
        /*R2613-LR*/
        public void EnviarEmail(string From, String To, String CCO, String Subject, String Message, bool isHTML)
        {
            Common.Util.EnviarMail(From, To, CCO, Subject, Message, isHTML);
        }


        //JCLS -2319
        public void UpdSolicitudCliente(int paisID, BESolicitudCliente entidadSolicitud)
        {
            var DASolicitudCliente = new DASolicitudCliente(paisID);
            DASolicitudCliente.UpdSolicitudCliente(entidadSolicitud.SolicitudClienteID, entidadSolicitud.Estado, entidadSolicitud.MensajeaCliente, entidadSolicitud.UsuarioModificacion);
        }

        public void RechazarSolicitudCliente(int paisID, long solicitudId, bool definitivo, int opcionRechazo, string razonMotivoRechazo)
        {
            var DASolicitudCliente = new DASolicitudCliente(paisID);
            DASolicitudCliente.RechazarSolicitudCliente(solicitudId, definitivo, opcionRechazo, razonMotivoRechazo);
        }

        public BESolicitudNuevaConsultora ReasignarSolicitudCliente(int paisID, long solicitudId, string codigoUbigeo, string campania, int marcaId, int opcionRechazo, string razonMotivoRechazo)
        {
            BESolicitudNuevaConsultora consultoraReasignada = null;

            var DASolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = DASolicitudCliente.ReasignarSolicitudCliente(solicitudId, codigoUbigeo, campania, paisID, marcaId, opcionRechazo, razonMotivoRechazo))
            {
                while (reader.Read())
                {
                    consultoraReasignada = new BESolicitudNuevaConsultora(reader);
                }
            }

            return consultoraReasignada;
        }

        public void CancelarSolicitudCliente(int paisID, long solicitudId, int opcionCancelacion, string razonMotivoCancelacion)
        {
            var DASolicitudCliente = new DASolicitudCliente(paisID);
            DASolicitudCliente.CancelarSolicitudCliente(solicitudId,opcionCancelacion,razonMotivoCancelacion);
        }


        /* R2319 - AAHA 02022015 - Parte 6 - Inicio */
        public int EnviarSolicitudClienteaGZ(int paisID, BESolicitudCliente entidadSolicitudCliente)
        {
            var DASolicitudCliente = new DASolicitudCliente(paisID);
            return DASolicitudCliente.EnviarSolicitudClienteaGZ(entidadSolicitudCliente);
        }
        public List<BESolicitudCliente> BuscarSolicitudAnuladasRechazadas(int paisID, BESolicitudCliente entidadSolicitudCliente)
        {
            var listaSolicitudes = new List<BESolicitudCliente>();
            var DASolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = DASolicitudCliente.BuscarSolicitudAnuladasRechazadas(entidadSolicitudCliente))
            {
                while (reader.Read())
                {
                    var solicitud = new BESolicitudCliente(reader);
                    listaSolicitudes.Add(solicitud);
                }
            }
            return listaSolicitudes;
        }
        public BESolicitudCliente DetalleSolicitudAnuladasRechazadas(int paisID, BESolicitudCliente entidadSolicitudCliente)
        {
            var DASolicitudCliente = new DASolicitudCliente(paisID);

            var resultadoSolicitudCliente = new BESolicitudCliente();
            var listaDetalleSolicitudCliente = new List<BESolicitudClienteDetalle>();

            using (IDataReader reader = DASolicitudCliente.CabeceraSolicitudAnuladasRechazadas(entidadSolicitudCliente))
            {
                while (reader.Read())
                {
                    resultadoSolicitudCliente = new BESolicitudCliente(reader);
                }
            }

            using (IDataReader reader = DASolicitudCliente.DetalleSolicitudAnuladasRechazadas(entidadSolicitudCliente))
            {
                while (reader.Read())
                {
                    var solicitudClienteDetalle = new BESolicitudClienteDetalle(reader);
                    listaDetalleSolicitudCliente.Add(solicitudClienteDetalle);
                }
            }

            if (resultadoSolicitudCliente != null)
            {
                resultadoSolicitudCliente.DetalleSolicitud = listaDetalleSolicitudCliente;
            }

            return resultadoSolicitudCliente;
        }
        /* R2319 - AAHA 02022015 - Parte 6 - Fin */

        public List<BEEstadoSolicitudCliente> GetEstadoSolicitudCliente(int paisID)
        {
            var EstadoSolicitudCliente = new List<BEEstadoSolicitudCliente>();
            var DASolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = DASolicitudCliente.GetEstadoSolicitudCliente())
            {
                while (reader.Read())
                {
                    var solicitud = new BEEstadoSolicitudCliente(reader);
                    EstadoSolicitudCliente.Add(solicitud);
                }
            }
            return EstadoSolicitudCliente;

        }

        public List<BEReporteAfiliados> GetReporteAfiliado(DateTime FechaIni, DateTime FechaFin, int paisID)
        {
            List<BEReporteAfiliados> listaReporteAfiliados = new List<BEReporteAfiliados>();
            DASolicitudCliente daSolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = daSolicitudCliente.ReporteAfiliados(FechaIni, FechaFin))
            {
                while (reader.Read())
                {
                    var reporteAfiliados = new  BEReporteAfiliados(reader);
                    listaReporteAfiliados.Add(reporteAfiliados);
                }
            }

             return listaReporteAfiliados;
        }      

        public List<BEReportePedidos> GetReportePedidos(DateTime FechaIni, DateTime FechaFin, int estado, string marca, string campania,int paisID)
        {
            List<BEReportePedidos> listaReportePedidos = new List<BEReportePedidos>();
            DASolicitudCliente DASolicitudCliente = new DASolicitudCliente(paisID);
             using (IDataReader reader =  DASolicitudCliente.ReportePedidos(FechaIni, FechaFin,estado,marca,campania))
            {
                while (reader.Read())
                {
                    var reporteAfiliados = new BEReportePedidos(reader);
                    listaReportePedidos.Add(reporteAfiliados);
                }
            }

            return listaReportePedidos;
        }      


    }
}
