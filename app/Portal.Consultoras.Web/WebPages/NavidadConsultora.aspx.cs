using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class NavidadConsultora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (IsPostBack) return;

                string query = Convert.ToString(Request.QueryString["comparte"]);
                string[] words = query.Split('-');
                int imagenId = Convert.ToInt32(words[0]);
                int paisId = Convert.ToInt32(words[1]);

                if (imagenId == 0 || paisId == 0) return;

                NavidadConsultoraModel modelo = new NavidadConsultoraModel();
                List<BENavidadConsultora> resultado;
                BENavidadConsultora parametro = new BENavidadConsultora
                {
                    PaisId = paisId,
                    ImagenId = imagenId
                };
                using (ContenidoServiceClient servicio = new ContenidoServiceClient())
                {
                    resultado = servicio.SeleccionarNavidadConsultora(parametro).ToList();
                }

                var carpetaPais = Globals.UrlNavidadConsultora;
                var registro = resultado.FirstOrDefault();
                if (registro != null)
                {
                    modelo.UrlImagen = ConfigCdn.GetUrlFileCdn(carpetaPais, registro.NombreImg);
                    modelo.ImagenId = registro.ImagenId;
                }

                HtmlMeta metaImage = new HtmlMeta();
                metaImage.Attributes.Add("property", "og:image");
                metaImage.Attributes.Add("content", modelo.UrlImagen);
                Header.Controls.Add(metaImage);
            }
            catch
            {
            }

        }
    }
}