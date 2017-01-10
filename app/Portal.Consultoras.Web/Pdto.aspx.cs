using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceODS;

namespace Portal.Consultoras.Web
{
    public partial class Pdto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            var array = id.Split('_');

            string codigoIso = array[0] ?? "";
            string idProducto = array[1] ?? "";

            //Validando si es Número Entero.
            int idProComp = 0;
            bool esId = int.TryParse(idProducto, out idProComp);
            int idFinal = esId ? idProComp : 0;

            //Obteniendo PaísID..
            int paisId = Util.GetPaisID(codigoIso);

            BEProductoCompartido objProComp = new BEProductoCompartido();

            using (ODSServiceClient svc = new ODSServiceClient())
            {
                objProComp = svc.GetProductoCompartido(paisId, idFinal);
            }

            if (objProComp != null)
            {
                int ProductoCompID = objProComp.PcID;
                int ProductoCompCampaniaID = objProComp.PcCampaniaID;
                string ProductoCompCUV = objProComp.PcCuv;
                string ProductoCompPalanca = objProComp.PcPalanca;
                var ArrayDetalle = objProComp.PcDetalle.Split('|');
                string ProductoCompApp = objProComp.PcApp;

                string RutaImagen = "";
                string MarcaID = "";
                string MarcaDesc = "";
                string NomProducto = "";
                string Volumen = "";
                string DescProducto = "";

                //desconcatenar detalle
                if (ArrayDetalle.Length > 0)
                {
                    RutaImagen = Convert.ToString(ArrayDetalle[0]);
                    MarcaID = Convert.ToString(ArrayDetalle[1]);
                    MarcaDesc = Convert.ToString(ArrayDetalle[2]);
                    NomProducto = Convert.ToString(ArrayDetalle[3]);
                    Volumen = Convert.ToString(ArrayDetalle[4]);
                    DescProducto = Convert.ToString(ArrayDetalle[5]);
                }

                string subTitulo = "Este es el Subtitulo";

                HtmlMeta meta1 = new HtmlMeta();
                meta1.Name = "og:image";
                meta1.Attributes.Add("property", "og:image");
                meta1.Content = RutaImagen;

                HtmlMeta meta2 = new HtmlMeta();
                meta2.Name = "og:title";
                meta2.Attributes.Add("property", "og:title");
                meta2.Content = DescProducto + ": " + subTitulo + ".";

                HtmlMeta meta3 = new HtmlMeta();
                meta3.Name = "og:image:secure_url";
                meta3.Attributes.Add("property", "og:image:secure_url");
                meta3.Content = RutaImagen;

                HtmlMeta meta4 = new HtmlMeta();
                meta4.Name = "og:site_name";
                meta4.Attributes.Add("property", "og:site_name");
                meta4.Content = "Somos Belcorp";

                HtmlMeta meta5 = new HtmlMeta();
                meta5.Name = "og:description";
                meta5.Attributes.Add("property", "og:description");
                meta5.Content = "Míralo Aquí";

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


                imgCuvProducto.Src = RutaImagen; 
                pMarcaProducto.InnerHtml = MarcaDesc;
                pNombreProducto.InnerHtml = NomProducto;
                pVolumenProducto.InnerHtml = Volumen;
                pDescripcionProducto.InnerHtml = DescProducto;
            }
        }
    }
}