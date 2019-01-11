using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class SolicitudCreditoImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string parametros = Request.QueryString["parametros"];
            string param = Util.DesencriptarQueryString(parametros);
            string[] lst = param.Split(';');

            ddlPais.Items.Add(new ListItem(lst[13]));
            int paisId = int.Parse(lst[0]);
            string fechaSolicitud = lst[1];
            ddlZonas.Items.Add(new ListItem(lst[12]));
            string seccion = lst[3];
            string numDocumento = lst[4];
            string estadoPedido = lst[5];
            string sortname = lst[7];
            string sortorder = lst[8];
            string codZona = lst[12];
            string tipoSolicitud = lst[14];
            lblNombrePais.Text = lst[11];
            imgBandera.ImageUrl = "../Content/Banderas/" + lst[10];
            imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + lst[10];
            txtDocumento.Text = numDocumento;
            txtSeccion.Text = seccion;
            txtFechaSolicitud.Text = fechaSolicitud;
            ddlEstadoSolicitud.SelectedValue = estadoPedido;

            List<BESolicitudCredito> lstDetalle;

            using (SACServiceClient srv = new SACServiceClient())
            {
                Nullable<DateTime> fecha = null;
                if (!string.IsNullOrEmpty(fechaSolicitud))
                    fecha = Convert.ToDateTime(fechaSolicitud);

                BESolicitudCredito solicitud = new BESolicitudCredito()
                {
                    PaisID = paisId,
                    FechaCreacion = fecha,
                    CodigoZona = codZona,
                    CodigoTerritorio = seccion,
                    NumeroDocumento = numDocumento,
                    CodigoLote = int.Parse(estadoPedido),
                    TipoSolicitud = tipoSolicitud,
                    CodigoConsultora = null
                };
                lstDetalle = srv.GetSolicitudCreditos(solicitud).ToList();
            }

            IEnumerable<BESolicitudCredito> items = lstDetalle;
            #region Sort Section
            if (sortorder == "asc")
            {
                switch (sortname)
                {
                    case "CodigoZona":
                        items = lstDetalle.OrderBy(x => x.CodigoZona);
                        break;
                    case "SolicitudCreditoID":
                        items = lstDetalle.OrderBy(x => x.SolicitudCreditoID);
                        break;
                    case "CodigoConsultoraRecomienda":
                        items = lstDetalle.OrderBy(x => x.CodigoConsultoraRecomienda);
                        break;
                    case "Nombres":
                        items = lstDetalle.OrderBy(x => x.NombreConsultoraRecomienda);
                        break;
                    case "NumeroDocumento":
                        items = lstDetalle.OrderBy(x => x.NumeroDocumento);
                        break;
                    case "CodigoConsultora":
                        items = lstDetalle.OrderBy(x => x.CodigoConsultora);
                        break;
                    case "TipoSolicitud":
                        items = lstDetalle.OrderBy(x => x.TipoSolicitud);
                        break;
                    case "FechaSolicitud":
                        items = lstDetalle.OrderBy(x => x.FechaCreacion);
                        break;
                    case "Estado":
                        items = lstDetalle.OrderBy(x => x.CodigoLote);
                        break;
                }
            }
            else
            {
                switch (sortname)
                {
                    case "CodigoZona":
                        items = lstDetalle.OrderByDescending(x => x.CodigoZona);
                        break;
                    case "SolicitudCreditoID":
                        items = lstDetalle.OrderByDescending(x => x.SolicitudCreditoID);
                        break;
                    case "CodigoConsultora":
                        items = lstDetalle.OrderByDescending(x => x.CodigoConsultoraRecomienda);
                        break;
                    case "Nombres":
                        items = lstDetalle.OrderByDescending(x => x.NombreConsultoraRecomienda);
                        break;
                    case "NumeroDocumento":
                        items = lstDetalle.OrderByDescending(x => x.NumeroDocumento);
                        break;
                    case "FechaSolicitud":
                        items = lstDetalle.OrderByDescending(x => x.FechaCreacion);
                        break;
                    case "Estado":
                        items = lstDetalle.OrderByDescending(x => x.CodigoLote);
                        break;
                }
            }
            #endregion

            StringBuilder sb = new StringBuilder();
            sb.Append("<table>");
            sb.Append("<thead><tr><th>Zona</th><th>ID Interno</th><th>Cod. Consultora que<br />Refiere</th><th>Nombre</th><th>Doc. Identidad</th><th>Cod. Consultora</th><th>Fecha</th><th>Estado</th><th>Tipo</th></tr></thead>");
            sb.Append("<tbody>");
            foreach (var item in items)
            {
                if (paisId == Constantes.PaisID.PuertoRico)
                {
                    sb.Append("<tr>");
                    sb.Append("<td>" + item.CodigoZona + "</td>");
                    sb.Append("<td>" + item.SolicitudCreditoID.ToString() + "</td>");
                    sb.Append("<td>" + item.CodigoConsultoraRecomienda + "</td>");
                    sb.Append("<td>" + item.NombreConsultoraRecomienda + "</td>");
                    if (item.NumeroDocumento.Length > 4)
                    {
                        sb.Append("<td>" + String.Format("*****{0}", item.NumeroDocumento.Remove(0, 5)) + "</td>");
                    }
                    else
                    {
                        sb.Append("<td>" + "" + "</td>");
                    }
                    sb.Append("<td>" + item.CodigoConsultora + "</td>");
                    sb.Append("<td>" + (item.FechaCreacion == null ? "" : Convert.ToDateTime(item.FechaCreacion).ToString("dd/MM/yyyy hh:mm tt")) + "</td>");
                    sb.Append("<td>" + (item.CodigoLote > 0 ? "ENVIADO" : "PENDIENTE") + "</td>");
                    sb.Append("<td>" + item.TipoSolicitud + "</td>");
                    sb.Append("</tr>");
                }
                else
                {
                    sb.Append("<tr>");
                    sb.Append("<td>" + item.CodigoZona + "</td>");
                    sb.Append("<td>" + item.SolicitudCreditoID.ToString() + "</td>");
                    sb.Append("<td>" + item.CodigoConsultoraRecomienda + "</td>");
                    sb.Append("<td>" + item.NombreConsultoraRecomienda + "</td>");
                    sb.Append("<td>" + item.NumeroDocumento + "</td>");
                    sb.Append("<td>" + item.CodigoConsultora + "</td>");
                    sb.Append("<td>" + (item.FechaCreacion == null ? "" : Convert.ToDateTime(item.FechaCreacion).ToString("dd/MM/yyyy hh:mm tt")) + "</td>");
                    sb.Append("<td>" + (item.CodigoLote > 0 ? "ENVIADO" : "PENDIENTE") + "</td>");
                    sb.Append("<td>" + item.TipoSolicitud + "</td>");
                    sb.Append("</tr>");
                }
            }
            sb.Append("</tbody>");
            sb.Append("</table>");

            lTabla.Text = sb.ToString();
        }
    }
}