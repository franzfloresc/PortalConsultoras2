using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ConsultaPedidoImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string parametros = Request.QueryString["parametros"];
                string param = Util.DesencriptarQueryString(parametros);
                string[] lst = param.Split(';');

                string campaniaddl = lst[0];
                string zonaddl = lst[2];
                string paisddl = lst[3];
                string territoriotxt = lst[5];
                string estadoPedidoddl = lst[6];
                string codConsultoratxt = lst[7];
                string bloqueadoddl = lst[8];

                string campaniaddlVal = lst[9];
                //string regionddlVal = "";
                string zonaddlVal = lst[11];
                string paisddlVal = lst[12];
                string estadoPedidoddlVal = lst[14];
                string bloqueadoddlVal = lst[15];
                string territoriotxtId = lst[16];
                string codConsultoratxtId = lst[17];
                string usuario = lst[18];
                string totalPedidos = lst[19];
                string porFacturar = lst[20];

                lblUsuario.Text = usuario;
                spTotalPedidos.InnerText = totalPedidos;
                spPorFacturar.InnerText = porFacturar;
                ddlCampania.Items.Add(new ListItem { Text = campaniaddl, Value = campaniaddlVal }); ddlCampania.SelectedIndex = 0;
                ddlPais.Items.Add(new ListItem { Text = paisddl, Value = paisddlVal }); ddlPais.SelectedIndex = 0;
                ddlZonas.Items.Add(new ListItem { Text = zonaddl, Value = zonaddlVal }); ddlZonas.SelectedIndex = 0;
                ddlEstadoPedido.Items.Add(new ListItem { Text = estadoPedidoddl, Value = estadoPedidoddlVal }); ddlZonas.SelectedIndex = 0;
                ddlBloqueado.Items.Add(new ListItem { Text = bloqueadoddl, Value = bloqueadoddlVal }); ddlZonas.SelectedIndex = 0;
                txtCodConsultora.Text = codConsultoratxt;
                txtTerritorio.Text = territoriotxt;
                imgBandera.ImageUrl = "../Content/Banderas/" + lst[21];
                imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + lst[21];
                lblNombrePais.Text = lst[22];

                StringBuilder sb = new StringBuilder();
                sb.Append("<table>");
                sb.Append("<thead><tr><th>Cod. Zona</th><th>Cod. Consultora</th><th>Nombre</th><th>Monto Pedido</th><th>Saldo Deuda</th><th>Pedido Bloqueado</th></tr></thead>");
                sb.Append("<tbody>");
                List<BEPedidoWeb> lista;
                using (PedidoServiceClient srv = new PedidoServiceClient())
                {
                    BEPedidoWeb pedido = new BEPedidoWeb()
                    {
                        PaisID = Convert.ToInt32(paisddlVal),
                        CodigoZona = zonaddlVal,
                        CodigoConsultora = codConsultoratxtId,
                        CampaniaID = (string.IsNullOrEmpty(campaniaddlVal)) ? 0 : Convert.ToInt32(campaniaddlVal),
                        EstadoPedido = Convert.ToByte(estadoPedidoddlVal),
                        Bloqueado = Convert.ToInt16(bloqueadoddlVal)
                    };

                    int? regionid = null;
                    //if (!string.IsNullOrEmpty(regionddlVal))
                    //    regionid = int.Parse(regionddlVal);

                    int? territorioid = null;
                    if (!string.IsNullOrEmpty(territoriotxtId))
                        territorioid = int.Parse(territoriotxtId);

                    lista = srv.SelectPedidosWebByFilter(pedido, "01012013", regionid, territorioid).ToList();
                }
                foreach (var item in lista)
                {
                    sb.Append("<tr>");
                    sb.Append("<td>" + item.CodigoZona + "</td>");
                    sb.Append("<td>" + item.CodigoConsultora + "</td>");
                    sb.Append("<td>" + item.Nombres + "</td>");
                    // validación pais colombia req. 1478
                    if (lblNombrePais.Text.ToLower() == "colombia")
                    {
                        sb.Append("<td>" + Convert.ToDecimal(item.MontoPedido).ToString("#,##0").Replace(',', '.') + "</td>");
                        sb.Append("<td>" + Convert.ToDecimal(item.SaldoDeuda).ToString("#,##0").Replace(',','.') + "</td>");
                    }
                    else
                    {
                        sb.Append("<td>" + Convert.ToDecimal(item.MontoPedido).ToString("0.00") + "</td>");
                        sb.Append("<td>" + Convert.ToDecimal(item.SaldoDeuda).ToString("0.00") + "</td>");
                    }
                    if (item.Bloqueado == 1)
                        sb.Append("<td><center><input type='checkbox' name='chk' value='' checked></center></td>");
                    else
                        sb.Append("<td><center><input type='checkbox' name='chk' value=''></center></td>");
                    sb.Append("</tr>");
                }
                sb.Append("</tbody>");
                sb.Append("</table>");

                lTabla.Text = sb.ToString();
            }
            
        }
    }
}