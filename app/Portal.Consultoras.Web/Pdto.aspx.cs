using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceODS;
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace Portal.Consultoras.Web
{
    public partial class Pdto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string id = Request.QueryString["id"];
                var array = id.Split('_');

                string codigoIso = array[0] ?? "";
                string idProducto = array[1] ?? "";
                
                int idProComp;
                bool esId = int.TryParse(idProducto, out idProComp);
                int idFinal = esId ? idProComp : 0;
                
                int paisId = Util.GetPaisID(codigoIso);

                BEProductoCompartido objProComp;

                using (ODSServiceClient svc = new ODSServiceClient())
                {
                    objProComp = svc.GetProductoCompartido(paisId, idFinal);
                }

                if (objProComp != null)
                {
                    string productoCompPalanca = objProComp.PcPalanca;
                    var arrayDetalle = objProComp.PcDetalle.Split('|');

                    string rutaImagen = "";
                    string marcaDesc = "";
                    string nomProducto = "";
                    string volumen = "";
                    string descProducto = "";

                    //desconcatenar detalle
                    if (arrayDetalle.Length > 0)
                    {
                        rutaImagen = Convert.ToString(arrayDetalle[0] ?? "");
                        marcaDesc = Convert.ToString(arrayDetalle[2] ?? "");
                        nomProducto = Convert.ToString(arrayDetalle[3] ?? "");

                        if (productoCompPalanca == "FAV")
                        {
                            volumen = Convert.ToString(arrayDetalle.Length > 4 ? arrayDetalle[4] ?? "" : "");
                            descProducto = Convert.ToString(arrayDetalle.Length > 5 ? arrayDetalle[5] ?? "" : "");
                        }
                    }

                    HtmlMeta meta1 = new HtmlMeta();
                    meta1.Name = "og:image";
                    meta1.Attributes.Add("property", "og:image");
                    meta1.Content = rutaImagen;

                    HtmlMeta meta2 = new HtmlMeta();
                    meta2.Name = "og:title";
                    meta2.Attributes.Add("property", "og:title");
                    meta2.Content = nomProducto;

                    HtmlMeta meta3 = new HtmlMeta();
                    meta3.Name = "og:image:secure_url";
                    meta3.Attributes.Add("property", "og:image:secure_url");
                    meta3.Content = rutaImagen;

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


                    imgCuvProducto.Src = rutaImagen;
                    pMarcaProducto.InnerHtml = marcaDesc;
                    pNombreProducto.InnerHtml = nomProducto;
                    pVolumenProducto.InnerHtml = volumen;
                    pDescripcionProducto.InnerHtml = descProducto;
                    pMensaje1.Visible = false;
                }
                else
                {
                    imgCuvProducto.Visible = false;
                    pMensaje1.InnerHtml = "Producto no encontrado. Contacte a su Consultora.";
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "Pdto - Page_Load");
                imgCuvProducto.Visible = false;
                pMensaje1.InnerHtml = "Producto no encontrado. Contacte a su Consultora.";
            }           
        }
    }
}