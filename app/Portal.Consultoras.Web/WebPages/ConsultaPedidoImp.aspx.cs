using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;

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
                string[] lst = param.Split(new char[] { ';' });

                string Campaniaddl = lst[0];
                string Zonaddl = lst[2];
                string Paisddl = lst[3];
                string territoriotxt = lst[5];
                string EstadoPedidoddl = lst[6];
                string CodConsultoratxt = lst[7];
                string Bloqueadoddl = lst[8];

                string Campaniaddl_val = lst[9];
                string Regionddl_val = "";
                string Zonaddl_val = lst[11];
                string Paisddl_val = lst[12];
                string EstadoPedidoddl_val = lst[14];
                string Bloqueadoddl_val = lst[15];
                string territoriotxt_ID = lst[16];
                string CodConsultoratxt_ID = lst[17];
                string Usuario = lst[18];
                string TotalPedidos = lst[19];
                string PorFacturar = lst[20];

                lblUsuario.Text = Usuario;
                spTotalPedidos.InnerText = TotalPedidos;
                spPorFacturar.InnerText = PorFacturar;
                ddlCampania.Items.Add(new ListItem { Text = Campaniaddl, Value = Campaniaddl_val }); ddlCampania.SelectedIndex = 0;
                ddlPais.Items.Add(new ListItem { Text = Paisddl, Value = Paisddl_val }); ddlPais.SelectedIndex = 0;
                ddlZonas.Items.Add(new ListItem { Text = Zonaddl, Value = Zonaddl_val }); ddlZonas.SelectedIndex = 0;
                ddlEstadoPedido.Items.Add(new ListItem { Text = EstadoPedidoddl, Value = EstadoPedidoddl_val }); ddlZonas.SelectedIndex = 0;
                ddlBloqueado.Items.Add(new ListItem { Text = Bloqueadoddl, Value = Bloqueadoddl_val }); ddlZonas.SelectedIndex = 0;
                txtCodConsultora.Text = CodConsultoratxt;
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
                        PaisID = Convert.ToInt32(Paisddl_val),
                        CodigoZona = Zonaddl_val,
                        CodigoConsultora = CodConsultoratxt_ID,
                        CampaniaID = (string.IsNullOrEmpty(Campaniaddl_val)) ? 0 : Convert.ToInt32(Campaniaddl_val),
                        EstadoPedido = Convert.ToByte(EstadoPedidoddl_val),
                        Bloqueado = Convert.ToInt16(Bloqueadoddl_val)
                    };

                    int? regionid = null;
                    if (!string.IsNullOrEmpty(Regionddl_val))
                        regionid = int.Parse(Regionddl_val);

                    int? territorioid = null;
                    if (!string.IsNullOrEmpty(territoriotxt_ID))
                        territorioid = int.Parse(territoriotxt_ID);

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