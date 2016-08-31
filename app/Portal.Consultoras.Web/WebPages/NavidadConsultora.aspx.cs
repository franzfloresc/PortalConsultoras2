using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class NavidadConsultora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string query = Convert.ToString(Request.QueryString["comparte"]);
                    string[] words = query.Split('-');
                    int ImagenId = Convert.ToInt32(words[0]);
                    int PaisId = Convert.ToInt32(words[1]);

                    if (ImagenId != 0 && PaisId != 0)
                    {
                        NavidadConsultoraModel modelo = new NavidadConsultoraModel();
                        List<BENavidadConsultora> resultado = new List<BENavidadConsultora>();
                        BENavidadConsultora registro = new BENavidadConsultora();
                        using (ContenidoServiceClient servicio = new ContenidoServiceClient())
                        {
                            BENavidadConsultora parametro = new BENavidadConsultora();
                            parametro.PaisId = PaisId;
                            parametro.ImagenId = ImagenId;
                            resultado = servicio.SeleccionarNavidadConsultora(parametro).ToList();
                        }
                        var carpetaPais = Globals.UrlNavidadConsultora;
                        registro = resultado.FirstOrDefault();
                        modelo.UrlImagen = ConfigS3.GetUrlFileS3(carpetaPais, registro.NombreImg, "");
                        modelo.ImagenId = registro.ImagenId;

                        HtmlMeta metaImage = new HtmlMeta();
                        metaImage.Attributes.Add("property", "og:image");
                        metaImage.Attributes.Add("content", modelo.UrlImagen);
                        Header.Controls.Add(metaImage);
                    }
                }
                catch { 
                
                }

            }

        }
    }
}