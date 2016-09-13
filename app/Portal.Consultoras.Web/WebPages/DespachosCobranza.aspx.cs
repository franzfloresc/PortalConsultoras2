﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.Controllers;
using EasyCallback;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class DespachosCobranza : Page
    {
        //I cec gr-335
        List<BEProveedorDespachoCobranza> lstProvTmp;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //I cec gr-335
                ObtenerListaProveedores();
                hdtotalIdProveedor.Value = (lstProvTmp.Count - 1).ToString();
                if (lstProvTmp.Count > 0) {
                    ObtenerDespachosCobranza(0);
                    //se le asigna el primer indice para el primero
                    hdidProveedor.Value = "0";
                }
                //F cec gr-335
            }
            
        }

        //I cec gr-335
        private void ObtenerListaProveedores(){
            using (SACServiceClient sv = new SACServiceClient())
            {
                lstProvTmp = sv.GetProveedorDespachoCobranza(9).ToList();
            }        
        }

        private void ObtenerDespachosCobranza(int id)
        {
            List<BEProveedorDespachoCobranza> lst;
            
            BEProveedorDespachoCobranza proveedor = new BEProveedorDespachoCobranza();
            
            //I cec gr-335
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetProveedorDespachoCobranza(9).ToList();
            }

            //proveedor = lst.Where(l => l.ProveedorDespachoCobranzaID == id).FirstOrDefault();
            
            //I cec gr-335
            proveedor = lst[id];

            lblNombreComercial.Text = proveedor.NombreComercial;
            lblRazonSocial.Text= proveedor.RazonSocial;
            lblRFC.Text = proveedor.RFC;

            string[] nombreSocios = proveedor.NombreSocios.Split(new Char[] { '|' });
            lblNombresSocios.Text = saltoLinea(nombreSocios);
            
            string[] representantesLegales = proveedor.RepresentanteLegales.Split(new Char[] { '|' });
            lblRepresentantesLegales.Text = saltoLinea(representantesLegales);

            lblDomicilioFiscal.Text = proveedor.DomicilioFiscal;
            lblDireccion.Text = proveedor.Direccion;

            string[] numerosTelefonicos = proveedor.Telefonos.Split(new Char[] { '|' });
            LblNumerosTelefonicos.Text = saltoLinea(numerosTelefonicos);

            string[] correos = proveedor.CorreosElectronicos.Split(new Char[] { '|' });
            lblCorreosElectronicos.Text = saltoLinea(correos);

            lblPaginaElectronica.Text = proveedor.PaginaElectronica;

            string[] nombreEjecutivos = proveedor.NombreEjecutivos.Split(new Char[] { '|' });
            lblNombresEjecutivos.Text = saltoLinea(nombreEjecutivos);

            //hdidProveedor.Value = id.ToString();
            //hdtotalIdProveedor.Value = lst.Count().ToString();

            //lblNombreComercial.Text = lst.Where(l => l.ProveedorDespachoCobranzaID == 1).Select(x => x.NombreComercial).ToString();
        }



        private string saltoLinea(string[] array)
        {
            string texto = ""; 

            for (int i = 0; i < array.Length ; i++)
            {
                texto += array[i] + " <br /> ";
            }

            return texto;
        }

        protected void btnProveedorSiguiente_Click(object sender, EventArgs e)
        {
            //I cec gr-335
            int id = Convert.ToInt16(hdidProveedor.Value) + 1;
            int idTotal = Convert.ToInt16(hdtotalIdProveedor.Value);

                if (id <= (idTotal))
                {
                    ObtenerDespachosCobranza(id);
                    hdidProveedor.Value = id.ToString();
                }
            //F cec gr-335                
        }

        protected void btnProveedorAnterior_Click(object sender, EventArgs e)
        {
            //I cec gr-335
            int id = Convert.ToInt16(hdidProveedor.Value) - 1;
            int idTotal = Convert.ToInt16(hdtotalIdProveedor.Value);

            if (id <= (idTotal-1) && id >= 0)
            {
                ObtenerDespachosCobranza(id);
                hdidProveedor.Value = id.ToString();
            }
            //F cec gr-335
        }


    }
}