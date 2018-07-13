using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
            string id = Request.QueryString["id"];

            var array = id.Split('_');

            string codigoIso = array[0] ?? "";
            string idShowroomCadena = array[1] ?? "";
            string campania = array[2] ?? "";
            string redSocial = array[3] ?? "";

            int idShowRoom;
            bool esId = int.TryParse(idShowroomCadena, out idShowRoom);

            int idFinal = esId ? idShowRoom : 0;

            int idCampania;
            bool esCampania = int.TryParse(campania, out idCampania);

            int idCampaniaFinal = esCampania ? idCampania : 0;

            int paisId = Util.GetPaisID(codigoIso);

            BEShowRoomOferta ofertaShowRoom;

            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                ofertaShowRoom = sv.GetShowRoomOfertaById(paisId, idFinal);                
            }

            if (ofertaShowRoom != null)
            {
                if (string.IsNullOrEmpty(ofertaShowRoom.ImagenProducto))
                {
                    ofertaShowRoom.ImagenMini = "";
                    ofertaShowRoom.ImagenProducto = "";
                }
                else
                {
                    ofertaShowRoom.ImagenMini = ConfigCdn.GetUrlFileCdn(carpetaPais, ofertaShowRoom.ImagenMini);
                    ofertaShowRoom.ImagenProducto = ConfigCdn.GetUrlFileCdn(carpetaPais, ofertaShowRoom.ImagenProducto);
                }

                List<BEShowRoomOfertaDetalle> listaDetalle;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaDetalle = sv.GetProductosShowRoomDetalle(paisId, idCampaniaFinal, ofertaShowRoom.CUV).ToList();
                }

                var txtBuil = new StringBuilder();
                var contadorDetalle = 1;
                foreach (var detalle in listaDetalle)
                {
                    txtBuil.Append(contadorDetalle == listaDetalle.Count ? detalle.NombreProducto : detalle.NombreProducto + " + ");
                    contadorDetalle++;
                }

                var subTitulo = txtBuil.ToString();

                HtmlMeta meta1 = new HtmlMeta();
                meta1.Name = "og:image";
                meta1.Attributes.Add("property", "og:image");
                meta1.Content = redSocial == "W" ? ofertaShowRoom.ImagenMini : ofertaShowRoom.ImagenProducto;

                HtmlMeta meta2 = new HtmlMeta();
                meta2.Name = "og:title";
                meta2.Attributes.Add("property", "og:title");
                meta2.Content = ofertaShowRoom.Descripcion + ": " + subTitulo + ".";

                HtmlMeta meta3 = new HtmlMeta();
                meta3.Name = "og:image:secure_url";
                meta3.Attributes.Add("property", "og:image:secure_url");
                meta3.Content = redSocial == "W" ? ofertaShowRoom.ImagenMini : ofertaShowRoom.ImagenProducto;

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
                imgCuvProducto.Src = ofertaShowRoom.ImagenProducto;

                pNombreProducto.InnerHtml = ofertaShowRoom.Descripcion;
                pSubtituloProducto.InnerHtml = subTitulo + ".";
            }            
        }
    }
}