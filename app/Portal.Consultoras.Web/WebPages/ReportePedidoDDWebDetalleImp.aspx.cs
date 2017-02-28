using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceOSBBelcorpPedido;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ReportePedidoDDWebDetalleImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string parametros = Request.QueryString["parametros"];
            string param = Util.DesencriptarQueryString(parametros);
            string[] lst = param.Split(new char[] { ';' });
            string PaisISO = lst[0];
            string CampaniaCod = lst[1];
            string ConsultoraCod = lst[2];
            string ConsultoraNombre = lst[3];
            string UsuarioNombre = lst[4];
            string Origen = lst[5];
            string Validado = lst[6];
            string Saldo = lst[7];
            string Importe = lst[8];
            string ImporteConDescuento = lst[9];
            string page = lst[10];
            string sortname = lst[11];
            string sortorder = lst[12];
            string rowNum = lst[13];
            string usuario = lst[14];
            string simbolo = lst[15];
            string TipoProceso = lst[18];
            int PaisID = Convert.ToInt32(lst[19]);
            string MotivoRechazo = lst[20];

            Usuario.Text = usuario;
            lblCampaniaCod.Text = CampaniaCod;
            lblConsultoraCod.Text = ConsultoraCod;
            lblConsultoraNombre.Text = ConsultoraNombre;
            //lblUsuarioNombre.Text = UsuarioNombre;
            lblOrigen.Text = Origen;
            lblValidado.Text = Validado;
            lblSaldo.Text = Saldo;
            lblMotivoRechazo.Text = MotivoRechazo;

            /* Los importes ya vienen formateados */
            lblImporte.Text = Importe;
            lblImporteConDescuento.Text = ImporteConDescuento;
            /* Los importes ya vienen formateados */

            //lblImporte.Text = Importe;
            //if (vZonaID == "" || vZonaID == "-- Todas --") vZonaID = "0";
            //if (vConsultora == "") vConsultora = "0";

            List<BEPedidoDDWebDetalle> lstDetalle = new List<BEPedidoDDWebDetalle>();

            //ServiceOSBBelcorp.BusinessService BusinessService = new BusinessService();
            //ServiceOSBBelcorp.pedidoWebAnteriorDetalleBean[] lista;
            //PedidoBS BusinessService = new PedidoBS();
            //ServiceOSBBelcorpPedido.pedidoWebAnteriorDetalleBean[] lista;
            //lista = BusinessService.obtenerPedidoClienteDD("ECL", 201302, "4376323", "0", "0", "0");
            //lista = BusinessService.obtenerPedidoWebAnteriorDetalle("201303", "PE", "0", "0", "032054889");

            //string ISOWS = string.Empty;
            //if (PaisISO.Equals("PE"))
            //    ISOWS = "PE";
            //else if (PaisISO.Equals("CL"))
            //    ISOWS = "CLE";
            //else if (PaisISO.Equals("EC"))
            //    ISOWS = "ECL";

            //if (lst[17] == "SRV")
            //{
            //    lista = BusinessService.obtenerPedidoWebAnteriorDetalle(CampaniaCod, PaisISO, "0", "0", ConsultoraCod);

            //    if (lista != null)
            //    {
            //        foreach (var pedidoWebAnteriorDetalleBean in lista)
            //        {
            //            if (string.IsNullOrEmpty(pedidoWebAnteriorDetalleBean.cuv.Trim()) == false)
            //            {
            //                lstDetalle.Add(new BEPedidoDDWebDetalle
            //                {
            //                    CUV = pedidoWebAnteriorDetalleBean.cuv,
            //                    Descripcion = pedidoWebAnteriorDetalleBean.descripcion,
            //                    Cantidad = pedidoWebAnteriorDetalleBean.cantidad,
            //                    PrecioUnitario = Convert.ToDecimal(pedidoWebAnteriorDetalleBean.precioUnidad),
            //                    PrecioTotal = Convert.ToDecimal(pedidoWebAnteriorDetalleBean.importeTotal),
            //                });
            //            }
            //        }
            //    }
            //}
            //else
            //{
            List<BEPedidoDDWebDetalle> lstPedidosDDWebNoFacturados;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstPedidosDDWebNoFacturados = sv.GetPedidosWebDDNoFacturadosDetalle(PaisID, PaisISO, Convert.ToInt32(CampaniaCod), ConsultoraCod, TipoProceso).ToList();
            }

            if (lstPedidosDDWebNoFacturados != null)
            {
                lstDetalle = (from c in lstPedidosDDWebNoFacturados
                              where string.IsNullOrEmpty(c.CUV.Trim()) == false
                              select new BEPedidoDDWebDetalle
                              {
                                  CUV = c.CUV,
                                  Descripcion = c.Descripcion,
                                  Cantidad = c.Cantidad,
                                  PrecioUnitario = c.PrecioUnitario,
                                  PrecioTotal = c.PrecioTotal
                              }).ToList();
            }
            //}

            imgBandera.ImageUrl = "../Content/Banderas/" + lst[15];
            imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + lst[15];
            lblNombrePais.Text = lst[16];

            StringBuilder sb = new StringBuilder();
            sb.Append("<table>");
            sb.Append("<thead><tr><th>Cod. Venta</th><th>Descripción</th><th>Cantidad</th><th>Precio Unitario</th><th>Precio Total</th></tr></thead>");
            sb.Append("<tbody>");
            foreach (var item in lstDetalle)
            {
                sb.Append("<tr>");
                sb.Append("<td>" + item.CUV + "</td>");
                sb.Append("<td>" + item.Descripcion + "</td>");
                sb.Append("<td><span>" + item.Cantidad + "</span></td>");
                // validación pais colombia req. 1478
                if (PaisID == 4)
                {
                    sb.Append("<td>" + simbolo + " " + item.PrecioUnitario.ToString("#,##0").Replace(',','.') + "</td>");
                    sb.Append("<td>" + simbolo + " " + item.PrecioTotal.ToString("#,##0").Replace(',', '.') + "</td>");
                }
                else
                {
                    sb.Append("<td>" + simbolo + " " + item.PrecioUnitario.ToString("0.00") + "</td>");
                    sb.Append("<td>" + simbolo + " " + item.PrecioTotal.ToString("0.00") + "</td>");
                }
                sb.Append("</tr>");
            }
            sb.Append("</tbody>");
            sb.Append("</table>");

            lTabla.Text = sb.ToString();
        }
    }
}