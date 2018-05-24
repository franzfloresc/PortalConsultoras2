using System;
using System.Web.UI.HtmlControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class CatalogoVirtual : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = Convert.ToString(Request.QueryString["DocumentId"]);
                string documentId = query.Substring(2, query.Length - 2);
                string tipoCatalogo = query.Substring(0, 2);

                string titulo = string.Empty;
                string descripcion = string.Empty;
                var imageCatalogo = "https://image.issuu.com/" + documentId + "/jpg/page_1_thumb_medium.jpg";

                switch (tipoCatalogo)
                {
                    case "LB":
                        titulo = "Catálogo L'Bel";
                        descripcion = "Mira las novedades de esta campaña en el catálogo online L´Bel. El mejor cuidado para tu piel, fragancias, maquillaje y cuidado corporal.";
                        break;
                    case "CY":
                        titulo = "Catálogo CyZone";
                        descripcion = "Mira lo último en maquillaje, moda y accesorios.¡No te pierdas las promociones que Cyzone tiene para ti!";
                        break;
                    case "ES":
                        titulo = "Catálogo Esika";
                        descripcion = "Encuentra los mejores productos de belleza a precios irresistibles. Entérate de nuestras novedades y pídelas a tu consultora. ¡Muchas ofertas te están esperando!";
                        break;
                    case "FI":
                        titulo = "Catálogo Esika by Finart";
                        descripcion = "Encuentra los mejores productos a precios irresistibles. Entérate de nuestras novedades y pídelas a tu consultora. ¡Muchas ofertas te están esperando!";
                        break;
                }

                HtmlMeta metaTitle = new HtmlMeta();
                metaTitle.Attributes.Add("property", "og:title");
                metaTitle.Attributes.Add("content", titulo);
                Header.Controls.Add(metaTitle);

                HtmlMeta metaDescripcion = new HtmlMeta();
                metaDescripcion.Attributes.Add("property", "og:description");
                metaDescripcion.Attributes.Add("content", descripcion);
                Header.Controls.Add(metaDescripcion);

                HtmlMeta metaImage = new HtmlMeta();
                metaImage.Attributes.Add("property", "og:image");
                metaImage.Attributes.Add("content", imageCatalogo);
                Header.Controls.Add(metaImage);

                HtmlMeta metaSite = new HtmlMeta();
                metaSite.Attributes.Add("property", "og:site_name");
                metaSite.Attributes.Add("content", "Somos Belcorp");
                Header.Controls.Add(metaSite);
            }
        }
    }
}
