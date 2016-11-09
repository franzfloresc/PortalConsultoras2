using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class SetVentaDigital : System.Web.UI.Page
    {
        public string ImagenCuv = "";
        public string NombreProducto = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string imagen = Request.QueryString["imagen"];
            string nombreProducto = Request.QueryString["nombre"];

            ImagenCuv = imagen;
            NombreProducto = nombreProducto;
        }
    }
}