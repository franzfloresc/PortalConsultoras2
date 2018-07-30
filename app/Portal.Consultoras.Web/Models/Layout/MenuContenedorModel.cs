using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Web.Models.Layout
{
    [Serializable]
    public class MenuContenedorModel
    {
        public string Codigo { get; set; }
        public int CampaniaId { get; set; }
        public int CampaniaX0 { get; set; }
        public int CampaniaX1 { get; set; }
        public bool MostrarMenuFlotante { get; set; }
        public string OrigenPantalla { get; set; }
        public string CampaniaX0ConFormato
        {
            get
            {
                return (CampaniaX0 % 100).ToString("00");
            }
        }
        public string CampaniaX1ConFormato
        {
            get
            {
                return (CampaniaX1 % 100).ToString("00");
            }
        }
        public ConfiguracionPaisModel ConfiguracionPais { get; set; }

        public string NombreOrigenPantalla
        {
            get
            {
                switch (OrigenPantalla)
                {
                    case Constantes.OrigenPantallaWeb.DContenedorHome:
                    case Constantes.OrigenPantallaWeb.MContenedorHome:
                    case Constantes.OrigenPantallaWeb.DContenedorHomeRevisar:
                    case Constantes.OrigenPantallaWeb.MContenedorHomeRevisar:
                        return "Home";
                    case Constantes.OrigenPantallaWeb.DRevistaDigital:
                    case Constantes.OrigenPantallaWeb.MRevistaDigital:
                    case Constantes.OrigenPantallaWeb.DRevistaDigitalRevisar:
                    case Constantes.OrigenPantallaWeb.MRevistaDigitalRevisar:
                        return "Ofertas para mí";
                    case Constantes.OrigenPantallaWeb.DShowRoom:
                    case Constantes.OrigenPantallaWeb.MShowRoom:
                    case Constantes.OrigenPantallaWeb.DShowRoomIntriga:
                    case Constantes.OrigenPantallaWeb.MShowRoomIntriga:
                        return "Showroom";
                    case Constantes.OrigenPantallaWeb.DRevistaDigitalInfo:
                    case Constantes.OrigenPantallaWeb.MRevistaDigitalInfo:
                        return "Saber más";
                    case Constantes.OrigenPantallaWeb.DRevistaDigitalDetalle:
                    case Constantes.OrigenPantallaWeb.MRevistaDigitalDetalle:
                        return "Detalle Lan";
                    case Constantes.OrigenPantallaWeb.DGuiaNegocio:
                    case Constantes.OrigenPantallaWeb.MGuiaNegocio:
                        return "Guia de Negocio";
                    case Constantes.OrigenPantallaWeb.DHerramientaVenta:
                    case Constantes.OrigenPantallaWeb.MHerramientaVenta:
                        return "Herramientas de Venta";
                    default: return "";
                }
            }
        }
    }
}