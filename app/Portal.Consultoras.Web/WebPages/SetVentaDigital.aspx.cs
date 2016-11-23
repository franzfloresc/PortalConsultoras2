using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class SetVentaDigital : System.Web.UI.Page
    {
        public static string ImagenCuv = "";

        public static string NombreProducto = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string imagen = Request.QueryString["imagen"];
            string nombre = Request.QueryString["nombre"];

            //ImagenCuv = imagen;
            //NombreProducto = nombre;

            HtmlMeta meta1 = new HtmlMeta();
            meta1.Name = "og:image";
            meta1.Attributes.Add("property", "og:image");
            meta1.Content = imagen;

            HtmlMeta meta2 = new HtmlMeta();
            meta2.Name = "og:title";
            meta2.Attributes.Add("property", "og:title");
            meta2.Content = "Comparte el Pack de Somos Belcorp";

            HtmlMeta meta3 = new HtmlMeta();
            meta3.Name = "og:image:secure_url";
            meta3.Attributes.Add("property", "og:image:secure_url");
            meta3.Content = imagen;

            HtmlMeta meta4 = new HtmlMeta();
            meta4.Name = "og:site_name";
            meta4.Attributes.Add("property", "og:site_name");
            meta4.Content = "Somos Belcorp";

            HtmlMeta meta5 = new HtmlMeta();
            meta5.Name = "og:description";
            meta5.Attributes.Add("property", "og:description");
            meta5.Content = nombre;

            HtmlMeta meta6 = new HtmlMeta();
            meta6.Name = "og:type";
            meta6.Attributes.Add("property", "og:type");
            meta6.Content = "article";

            Page.Header.Controls.Add(meta1);
            Page.Header.Controls.Add(meta2);
            Page.Header.Controls.Add(meta3);
            Page.Header.Controls.Add(meta4);
            Page.Header.Controls.Add(meta5);
            Page.Header.Controls.Add(meta6);
            //imgCuv.Content = imagen;
            //imgCuvSecure.Content = imagen;
            //nombreCuv.Content = nombre;
            imgCuvProducto.Src = imagen;

            pNombreProducto.InnerHtml = nombre;
        }
    }
}