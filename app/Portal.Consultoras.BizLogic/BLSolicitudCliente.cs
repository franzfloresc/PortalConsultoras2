using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Transactions;

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

            String emailOculto = string.Empty;
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
                    string spacerGif = ConfigCdn.GetUrlFileCdn(carpetaPais, "spacer.gif");

                    mensajeCorreo.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif;\">");
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine("<td style=\"text-align:center;\">");
                    mensajeCorreo.AppendLine("<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
                    mensajeCorreo.AppendLine(String.Format("<tr><td colspan=\"7\"><img src=\"{0}\" width=\"682\" height=\"117\" alt=\"\"></td><tr>", ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_01.png")));
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine(String.Format("<td><img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_03.png")));
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
                    mensajeCorreo.AppendLine(String.Format("<td colspan=\"3\"><img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_05.png")));
                    mensajeCorreo.AppendLine("</tr>");
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine("<td colspan=\"7\" style=\"text-align:center; padding-top:30px; padding-bottom:50px\">");                    
                    mensajeCorreo.AppendLine(String.Format("			<a href=\"{0}Pedido/Index?lanzarTabConsultoraOnline=true\" target=\"_blank\"><img src=\"{1}\" width=\"201\" height=\"38\" border=\"0\" alt=\"Ver pedido\"></a>", contextoBase, ConfigCdn.GetUrlFileCdn(carpetaPais, "7-Mailing_03.png")));
                    mensajeCorreo.AppendLine("</td>");
                    mensajeCorreo.AppendLine("</tr>");
                    mensajeCorreo.AppendLine("<tr>");
                    mensajeCorreo.AppendLine("<td colspan=\"7\" style=\"background-color:#acbbc9;\">");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">", ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_12.png")));
                    mensajeCorreo.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>", ConfigCdn.GetUrlFileCdn(carpetaPais, "Facebook.png")));
                    mensajeCorreo.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
                    mensajeCorreo.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>", ConfigCdn.GetUrlFileCdn(carpetaPais, "Youtube.png")));
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

                    Util.EnviarMail("no-responder@somosbelcorp.com", consultoraSolicitudCliente.Email, emailOculto, asunto, mensajeCorreo.ToString(), true, "Consultora Online Belcorp");
                }
                catch (Exception) { }
            }
        }

        #endregion

        public BEResultadoSolicitud InsertarSolicitudCliente(int paisID, BEEntradaSolicitudCliente entidadSolicitud)
        {
            BEResultadoSolicitud resultado = null;
            try
            {
                var daSolicitudCliente = new DASolicitudCliente(paisID);
                IEnumerable<BESolicitudClienteDetalle> listaSolicitudDetalle = entidadSolicitud.DetalleSolicitud == null
                    ? new List<BESolicitudClienteDetalle>().ToList()
                    : entidadSolicitud.DetalleSolicitud.ToList();

                using (IDataReader reader = daSolicitudCliente.InsertarSolicitudCliente(entidadSolicitud, listaSolicitudDetalle))
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
                resultado = new BEResultadoSolicitud(0, ex.Message);
                return resultado;
            }
        }

        public BEResultadoSolicitud InsertarSolicitudClienteAppCatalogo(int paisID, BESolicitudClienteAppCatalogo entidadSolicitud)
        {
            BEResultadoSolicitud resultado = null;
            try
            {
                var daSolicitudCliente = new DASolicitudCliente(paisID);
                using (IDataReader reader = daSolicitudCliente.InsertarSolicitudClienteAppCliente(entidadSolicitud))
                {
                    while (reader.Read()) { resultado = new BEResultadoSolicitud(reader); }
                }
                return resultado;
            }
            catch (Exception ex)
            {
                resultado = new BEResultadoSolicitud(0, ex.Message);
                return resultado;
            }
        }

        public BESolicitudCliente GetSolicitudClienteBySolicitudId(int paisID, long solicitudClienteId)
        {
            BESolicitudCliente solicitudCliente = null;
            var daSolicitudCliente = new DASolicitudCliente(paisID);

            using (IDataReader reader = daSolicitudCliente.GetSolicitudClienteBySolicitudId(solicitudClienteId))
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
            var daSolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = daSolicitudCliente.GetSolicitudClienteWithoutMarcaBySolicitudId(solicitudClienteId))
            {
                while (reader.Read()) { solicitudCliente = new BESolicitudCliente(reader); }
            }
            return solicitudCliente;
        }

        public List<BESolicitudClienteDetalle> GetSolicitudClienteDetalleBySolicitudId(int paisID, long solicitudClienteId)
        {
            List<BESolicitudClienteDetalle> solicitudClientes = new List<BESolicitudClienteDetalle>();
            var daSolicitudCliente = new DASolicitudCliente(paisID);

            using (IDataReader reader = daSolicitudCliente.GetSolicitudClienteDetalleBySolicitudId(solicitudClienteId))
            {
                while (reader.Read())
                {
                    solicitudClientes.Add(new BESolicitudClienteDetalle(reader));
                }
            }

            return solicitudClientes;
        }

        public BEConsultoraSolicitudCliente GetConsultoraSolicitudCliente(int paisID, int consultoraid, string codigo, int marcaId)
        {
            BEConsultoraSolicitudCliente consultorasolicitudCliente = null;
            var daSolicitudCliente = new DASolicitudCliente(paisID);

            using (IDataReader reader = daSolicitudCliente.GetConsultoraSolicitudCliente(consultoraid, codigo, marcaId))
            {
                while (reader.Read())
                {
                    consultorasolicitudCliente = new BEConsultoraSolicitudCliente(reader);

                }
            }
            return consultorasolicitudCliente;
        }

        public void EnviarEmail(string From, String To, String CCO, String Subject, String Message, bool isHTML)
        {
            Util.EnviarMail(From, To, CCO, Subject, Message, isHTML);
        }

        public void UpdSolicitudCliente(int paisID, BESolicitudCliente entidadSolicitud)
        {
            var daSolicitudCliente = new DASolicitudCliente(paisID);
            daSolicitudCliente.UpdSolicitudCliente(entidadSolicitud.SolicitudClienteID, entidadSolicitud.Estado, entidadSolicitud.MensajeaCliente, entidadSolicitud.UsuarioModificacion);
        }

        public void UpdSolicitudClienteDetalle(int paisID, BESolicitudClienteDetalle entidadSolicitudDet)
        {
            var daSolicitudCliente = new DASolicitudCliente(paisID);
            daSolicitudCliente.UpdSolicitudClienteDetalle(entidadSolicitudDet.SolicitudClienteDetalleID, entidadSolicitudDet.TipoAtencion, entidadSolicitudDet.PedidoWebID, entidadSolicitudDet.PedidoWebDetalleID);
        }

        public void RechazarSolicitudCliente(int paisID, long solicitudId, bool definitivo, int opcionRechazo, string razonMotivoRechazo)
        {
            var daSolicitudCliente = new DASolicitudCliente(paisID);
            daSolicitudCliente.RechazarSolicitudCliente(solicitudId, definitivo, opcionRechazo, razonMotivoRechazo);
        }

        public BESolicitudNuevaConsultora ReasignarSolicitudCliente(int paisID, long solicitudId, string codigoUbigeo, string campania, int marcaId, int opcionRechazo, string razonMotivoRechazo)
        {
            BESolicitudNuevaConsultora consultoraReasignada = null;

            var daSolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = daSolicitudCliente.ReasignarSolicitudCliente(solicitudId, codigoUbigeo, campania, paisID, marcaId, opcionRechazo, razonMotivoRechazo))
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
            var daSolicitudCliente = new DASolicitudCliente(paisID);
            daSolicitudCliente.CancelarSolicitudCliente(solicitudId, opcionCancelacion, razonMotivoCancelacion);
        }

        public string CancelarSolicitudClienteYRemoverPedido(int paisID, int campaniaID, long consultoraID, string codigoUsuario, long solicitudId, int opcionCancelacion, string razonMotivoCancelacion)
        {
            try
            {
                BEMisPedidos miPedido = new BLConsultoraOnline().GetPedidoClienteOnlineBySolicitudClienteId(paisID, solicitudId);
                if (Convert.ToInt32(miPedido.Campania) != campaniaID) return "Este pedido no pertenece a la campaña vigente. Sólo se pueden cancelar los pedidos de la campaña vigente";
                if (miPedido.Estado != "A") return "Este pedido no se encuentra aceptado.";

                DAPedidoWeb dAPedidoWeb = new DAPedidoWeb(paisID);
                DAPedidoWebDetalle dAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

                #region Consultora Programa Nuevas

                BEConsultorasProgramaNuevas beConsultoraProgramaNuevas = null;
                var daConsultoraProgramaNuevas = new DAConsultorasProgramaNuevas(paisID);

                using (IDataReader reader = daConsultoraProgramaNuevas.GetConsultorasProgramaNuevasByConsultoraIdAndCampania(consultoraID, campaniaID.ToString()))
                {
                    if (reader.Read())
                        beConsultoraProgramaNuevas = new BEConsultorasProgramaNuevas(reader);
                }

                int numeroPedido = 0;
                string codigoPrograma = "";
                if (beConsultoraProgramaNuevas != null)
                {
                    numeroPedido = beConsultoraProgramaNuevas.ConsecutivoNueva;
                    codigoPrograma = beConsultoraProgramaNuevas.CodigoPrograma ?? "";
                }

                #endregion

                var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                {
                    PaisId = paisID,
                    CampaniaId = campaniaID,
                    ConsultoraId = consultoraID,
                    Consultora = "",
                    CodigoPrograma = codigoPrograma,
                    NumeroPedido = numeroPedido
                };

                List<BEPedidoWebDetalle> olstPedidoWebDetalle = new BLPedidoWebDetalle().GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();
                List<BEMisPedidosDetalle> listDetallesClienteOnline = new BLConsultoraOnline().GetMisPedidosDetalle(paisID, solicitudId.ToInt()).ToList();
                listDetallesClienteOnline = listDetallesClienteOnline.Where(d => d.PedidoWebDetalleID != 0).ToList();

                TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted };
                using (TransactionScope transactionScope = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    if (listDetallesClienteOnline.Count > 0 && olstPedidoWebDetalle.Count > 0)
                    {
                        int pedidoId = olstPedidoWebDetalle.First().PedidoID;

                        foreach (var item in listDetallesClienteOnline)
                        {
                            var detalle = olstPedidoWebDetalle.FirstOrDefault(d => d.PedidoID == item.PedidoWebID && d.PedidoDetalleID == item.PedidoWebDetalleID);
                            if (detalle == null) continue;

                            if (detalle.Cantidad > item.Cantidad)
                            {
                                detalle.Cantidad -= item.Cantidad;
                                detalle.ImporteTotal = detalle.Cantidad * detalle.PrecioUnidad;
                                detalle.Flag = 1;
                                detalle.Stock = item.Cantidad;

                                dAPedidoWebDetalle.UpdPedidoWebDetalle(detalle);
                                switch (detalle.TipoOfertaSisID)
                                {
                                    case Constantes.ConfiguracionOferta.ShowRoom:
                                        new DAShowRoomEvento(paisID).UpdOfertaShowRoomStockActualizar(detalle.CampaniaID, detalle.CUV, detalle.Stock, detalle.Flag);
                                        break;
                                    case Constantes.ConfiguracionOferta.Liquidacion:
                                    case Constantes.ConfiguracionOferta.Accesorizate:
                                        new DAOfertaProducto(paisID).UpdOfertaProductoStockActualizar(detalle.TipoOfertaSisID, detalle.CampaniaID, detalle.CUV, detalle.Stock, detalle.Flag);
                                        break;
                                }
                            }
                            else
                            {
                                olstPedidoWebDetalle.Remove(detalle);
                                dAPedidoWebDetalle.DelPedidoWebDetalle(detalle.CampaniaID, detalle.PedidoID, detalle.PedidoDetalleID, detalle.TipoOfertaSisID, "");
                                switch (detalle.TipoOfertaSisID)
                                {
                                    case Constantes.ConfiguracionOferta.ShowRoom:
                                        new DAShowRoomEvento(paisID).UpdOfertaShowRoomStockEliminar(detalle.CampaniaID, detalle.CUV, detalle.Cantidad);
                                        break;
                                    case Constantes.ConfiguracionOferta.Liquidacion:
                                    case Constantes.ConfiguracionOferta.Accesorizate:
                                        new DAOfertaProducto(paisID).UpdOfertaProductoStockEliminar(detalle.TipoOfertaSisID, detalle.CampaniaID, detalle.CUV, detalle.Cantidad);
                                        break;
                                }
                            }
                        }

                        int totalClientes = olstPedidoWebDetalle.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
                        decimal importeTotal = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                        dAPedidoWeb.UpdPedidoWebTotales(campaniaID, pedidoId, totalClientes, importeTotal, codigoUsuario);
                    }
                    this.CancelarSolicitudCliente(paisID, solicitudId, opcionCancelacion, razonMotivoCancelacion);
                    transactionScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisID.ToString());
                return "Ocurrió un error al intentar cancelar la solicutd de pedido";
            }
            return "";
        }

        public List<BEMotivoSolicitud> GetMotivosRechazo(int paisID)
        {
            List<BEMotivoSolicitud> motivosRechazos = (List<BEMotivoSolicitud>)CacheManager<BEMotivoSolicitud>.GetData(paisID, ECacheItem.MotivoSolicitud);
            if (motivosRechazos == null || motivosRechazos.Count == 0)
            {
                motivosRechazos = new List<BEMotivoSolicitud>();

                var daSolicitudCliente = new DASolicitudCliente(paisID);

                using (IDataReader reader = daSolicitudCliente.GetMotivosRechazo())
                {
                    while (reader.Read()) motivosRechazos.Add(new BEMotivoSolicitud(reader));
                }
                CacheManager<BEMotivoSolicitud>.AddData(paisID, ECacheItem.MotivoSolicitud, motivosRechazos);
            }
            return motivosRechazos;
        }

        public int EnviarSolicitudClienteaGZ(int paisID, BESolicitudCliente entidadSolicitudCliente)
        {
            var daSolicitudCliente = new DASolicitudCliente(paisID);
            return daSolicitudCliente.EnviarSolicitudClienteaGZ(entidadSolicitudCliente);
        }

        public List<BESolicitudCliente> BuscarSolicitudAnuladasRechazadas(int paisID, BESolicitudCliente entidadSolicitudCliente)
        {
            var listaSolicitudes = new List<BESolicitudCliente>();
            var daSolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = daSolicitudCliente.BuscarSolicitudAnuladasRechazadas(entidadSolicitudCliente))
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
            var daSolicitudCliente = new DASolicitudCliente(paisID);

            var resultadoSolicitudCliente = new BESolicitudCliente();
            var listaDetalleSolicitudCliente = new List<BESolicitudClienteDetalle>();

            using (IDataReader reader = daSolicitudCliente.CabeceraSolicitudAnuladasRechazadas(entidadSolicitudCliente))
            {
                while (reader.Read())
                {
                    resultadoSolicitudCliente = new BESolicitudCliente(reader);
                }
            }

            using (IDataReader reader = daSolicitudCliente.DetalleSolicitudAnuladasRechazadas(entidadSolicitudCliente))
            {
                while (reader.Read())
                {
                    var solicitudClienteDetalle = new BESolicitudClienteDetalle(reader);
                    listaDetalleSolicitudCliente.Add(solicitudClienteDetalle);
                }
            }

            resultadoSolicitudCliente.DetalleSolicitud = listaDetalleSolicitudCliente;

            return resultadoSolicitudCliente;
        }

        public List<BEEstadoSolicitudCliente> GetEstadoSolicitudCliente(int paisID)
        {
            var estadoSolicitudCliente = new List<BEEstadoSolicitudCliente>();
            var daSolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = daSolicitudCliente.GetEstadoSolicitudCliente())
            {
                while (reader.Read())
                {
                    var solicitud = new BEEstadoSolicitudCliente(reader);
                    estadoSolicitudCliente.Add(solicitud);
                }
            }
            return estadoSolicitudCliente;

        }

        public List<BEReporteAfiliados> GetReporteAfiliado(DateTime FechaIni, DateTime FechaFin, int paisID)
        {
            List<BEReporteAfiliados> listaReporteAfiliados = new List<BEReporteAfiliados>();
            DASolicitudCliente daSolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = daSolicitudCliente.ReporteAfiliados(FechaIni, FechaFin))
            {
                while (reader.Read())
                {
                    var reporteAfiliados = new BEReporteAfiliados(reader);
                    listaReporteAfiliados.Add(reporteAfiliados);
                }
            }

            return listaReporteAfiliados;
        }

        public List<BEReportePedidos> GetReportePedidos(DateTime FechaIni, DateTime FechaFin, int estado, string marca, string campania, int paisID)
        {
            List<BEReportePedidos> listaReportePedidos = new List<BEReportePedidos>();
            DASolicitudCliente daSolicitudCliente = new DASolicitudCliente(paisID);
            using (IDataReader reader = daSolicitudCliente.ReportePedidos(FechaIni, FechaFin, estado, marca, campania))
            {
                while (reader.Read())
                {
                    var reporteAfiliados = new BEReportePedidos(reader);
                    listaReportePedidos.Add(reporteAfiliados);
                }
            }

            return listaReportePedidos;
        }

        #region AppCatalogo

        public BEResultadoMisPedidosAppCatalogo GetPedidosAppCatalogo(int paisID, long consultoraID, string dispositivoID, int tipoUsuario, int campania)
        {
            BEResultadoMisPedidosAppCatalogo resultado;
            try
            {
                resultado = new BEResultadoMisPedidosAppCatalogo(false, "OK");
                var daMisPedidos = new DAConsultoraOnline(paisID);
                var misPedidos = new List<BEMisPedidosAppCatalogo>();

                IDataReader reader;

                if (tipoUsuario == 1) reader = daMisPedidos.GetPedidosClienteAppCatalogo(dispositivoID, campania);
                else reader = daMisPedidos.GetPedidosConsultoraAppCatalogo(consultoraID, campania);

                using (reader)
                {
                    while (reader.Read())
                    {
                        var entidad = new BEMisPedidosAppCatalogo(reader);
                        misPedidos.Add(entidad);
                    }
                }
                resultado.Data = misPedidos;
                return resultado;
            }
            catch (Exception ex)
            {
                resultado = new BEResultadoMisPedidosAppCatalogo(true, ex.Message);
                return resultado;
            }
        }

        public BEResultadoPedidoDetalleAppCatalogo GetPedidoDetalle(int PaisID, long PedidoID)
        {
            BEResultadoPedidoDetalleAppCatalogo resultado;
            try
            {
                resultado = new BEResultadoPedidoDetalleAppCatalogo(false, "OK");

                var daMisPedidos = new DAConsultoraOnline(PaisID);
                var miPedidoDetalles = new List<BEMisPedidosDetalleAppCatalogo>();

                using (IDataReader reader = daMisPedidos.GetDetallePedidoAppCatalogo(PedidoID))
                {
                    while (reader.Read())
                    {
                        var entidad = new BEMisPedidosDetalleAppCatalogo(reader);
                        miPedidoDetalles.Add(entidad);
                    }
                    resultado.Data = miPedidoDetalles;
                }
                return resultado;
            }
            catch (Exception ex)
            {
                resultado = new BEResultadoPedidoDetalleAppCatalogo(true, ex.Message);
                return resultado;
            }
        }

        #endregion
    }
}
