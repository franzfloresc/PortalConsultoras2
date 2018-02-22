using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class DespachosCobranza : Page
    {
        List<BEProveedorDespachoCobranza> lstProvTmp;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ObtenerListaProveedores();
                hdtotalIdProveedor.Value = (lstProvTmp.Count - 1).ToString();
                if (lstProvTmp.Count > 0)
                {
                    ObtenerDespachosCobranza(0);
                    hdidProveedor.Value = "0";
                }
            }

        }

        private void ObtenerListaProveedores()
        {
            using (SACServiceClient sv = new SACServiceClient())
            {
                lstProvTmp = sv.GetProveedorDespachoCobranza(9).ToList();
            }
        }

        private void ObtenerDespachosCobranza(int id)
        {
            List<BEProveedorDespachoCobranza> lst;

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetProveedorDespachoCobranza(9).ToList();
            }

            var proveedor = lst[id];

            lblNombreComercial.Text = proveedor.NombreComercial;
            lblRazonSocial.Text = proveedor.RazonSocial;
            lblRFC.Text = proveedor.RFC;

            string[] nombreSocios = proveedor.NombreSocios.Split('|');
            lblNombresSocios.Text = saltoLinea(nombreSocios);

            string[] representantesLegales = proveedor.RepresentanteLegales.Split('|');
            lblRepresentantesLegales.Text = saltoLinea(representantesLegales);

            lblDomicilioFiscal.Text = proveedor.DomicilioFiscal;
            lblDireccion.Text = proveedor.Direccion;

            string[] numerosTelefonicos = proveedor.Telefonos.Split('|');
            LblNumerosTelefonicos.Text = saltoLinea(numerosTelefonicos);

            string[] correos = proveedor.CorreosElectronicos.Split('|');
            lblCorreosElectronicos.Text = saltoLinea(correos);

            lblPaginaElectronica.Text = proveedor.PaginaElectronica;

            string[] nombreEjecutivos = proveedor.NombreEjecutivos.Split('|');
            lblNombresEjecutivos.Text = saltoLinea(nombreEjecutivos);

        }



        private string saltoLinea(string[] array)
        {
            var txtBuil = new StringBuilder();
            for (int i = 0; i < array.Length; i++)
            {
                txtBuil.Append(array[i] + " <br /> ");
            }
            return txtBuil.ToString();
        }

        protected void btnProveedorSiguiente_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt16(hdidProveedor.Value) + 1;
            int idTotal = Convert.ToInt16(hdtotalIdProveedor.Value);

            if (id <= idTotal)
            {
                ObtenerDespachosCobranza(id);
                hdidProveedor.Value = id.ToString();
            }
        }

        protected void btnProveedorAnterior_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt16(hdidProveedor.Value) - 1;
            int idTotal = Convert.ToInt16(hdtotalIdProveedor.Value);

            if (id <= (idTotal - 1) && id >= 0)
            {
                ObtenerDespachosCobranza(id);
                hdidProveedor.Value = id.ToString();
            }
        }

    }
}