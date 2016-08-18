using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class CatalogoVirtual : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = Convert.ToString(Request.QueryString["DocumentId"]);
                string DocumentId = query.Substring(2, query.Length - 2);
                string TipoCatalogo = query.Substring(0, 2);

                string Titulo = string.Empty;
                string Descripcion = string.Empty;
                var ImageCatalogo = "https://image.issuu.com/" + DocumentId + "/jpg/page_1_thumb_medium.jpg";

                switch (TipoCatalogo)
                {
                    case "LB":
                        Titulo = "Catálogo L'Bel";
                        Descripcion = "Mira las novedades de esta campaña en el catálogo online L´Bel. El mejor cuidado para tu piel, fragancias, maquillaje y cuidado corporal.";
                        break;
                    case "CY":
                        Titulo = "Catálogo CyZone";
                        Descripcion = "Mira lo último en maquillaje, moda y accesorios.¡No te pierdas las promociones que Cyzone tiene para ti!";
                        break;
                    case "ES":
                        Titulo = "Catálogo Esika";
                        Descripcion = "Encuentra los mejores productos de belleza a precios irresistibles. Entérate de nuestras novedades y pídelas a tu consultora. ¡Muchas ofertas te están esperando!";
                        break;
                    case "FI":
                        Titulo = "Catálogo Esika by Finart";
                        Descripcion = "Encuentra los mejores productos a precios irresistibles. Entérate de nuestras novedades y pídelas a tu consultora. ¡Muchas ofertas te están esperando!";
                        break;
                }

                HtmlMeta metaTitle = new HtmlMeta();
                metaTitle.Attributes.Add("property", "og:title");
                metaTitle.Attributes.Add("content", Titulo);
                Header.Controls.Add(metaTitle);

                HtmlMeta metaDescripcion = new HtmlMeta();
                metaDescripcion.Attributes.Add("property", "og:description");
                metaDescripcion.Attributes.Add("content", Descripcion);
                Header.Controls.Add(metaDescripcion);

                HtmlMeta metaImage = new HtmlMeta();
                metaImage.Attributes.Add("property", "og:image");
                metaImage.Attributes.Add("content", ImageCatalogo);
                Header.Controls.Add(metaImage);

                HtmlMeta metaSite = new HtmlMeta();
                metaSite.Attributes.Add("property", "og:site_name");
                metaSite.Attributes.Add("content", "Somos Belcorp");
                Header.Controls.Add(metaSite);
            }
        }
    }
}
