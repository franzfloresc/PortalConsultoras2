﻿using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class BienvenidaHomeModel
    {
        public string NombreCompleto { get; set; }
        public string EMail { get; set; }
        public string Telefono { get; set; }
        public string TelefonoTrabajo { get; set; }
        public string Celular { get; set; }
        /*2116 -INICIO*/
        public string m_Apellidos { get; set; }
        public string m_Nombre { get; set; }
        /*2116-FIN  */

        public int PaisID { get; set; }
        public int IndicadorContrato { get; set; }
        public int CambioClave { get; set; }
        public bool EmailActivo { get; set; }
        public int Lider { get; set; }
        public bool PortalLideres { get; set; }
        public string LogoLideres { get; set; }
        public string SobreNombre { get; set; }
        public string CodigoConsultora { get; set; }
        public int CampaniaActual { get; set; }
        public string PrefijoPais { get; set; }
        public string CampanaInvitada { get; set; }
        public string InscritaFlexipago { get; set; }
        public int IndicadorFlexipago { get; set; }
        public string InvitacionRechazada { get; set; }
        public string CodigoUsuario { get; set; }
        public string BotonClave { get; set; }
        public string BotonTexto { get; set; }
        public string BotonAnalytics { get; set; }
        public string UrlFlexipagoCL { get; set; }
        public string NroCampana { get; set; }
        public string rutaChile { get; set; }
        public string ContratoActualizarDatos { get; set; }
        public int VisualizoComunicado { get; set; }
        public int VisualizoComunicadoConfigurable { get; set; }
        public string UrlChileEncriptada { get; set; }
        public int ValidaSuenioNavidad { get; set; }
        public int ValidaSegmento { get; set; }
        public int ValidaTiempoVentana { get; set; }
        public int ValidaDatosActualizados { get; set; }
        public int PrimeraVezSession { get; set; }
        public int PrimeraVez { get; set; }
        public string NombreConsultora { get; set; }
        public int CantProductosCarouselLiq { get; set; }

        public decimal MontoAhorroCatalogo { get; set; }

        public decimal MontoAhorroRevista { get; set; }

        public decimal MontoDescuento { get; set; }

        public decimal MontoEscala { get; set; }

        public string Simbolo { get; set; }

        public string UrlImagenCompartirCatalogo { get; set; }

        public IList<BEEscalaDescuento> ListaEscalaDescuento { get; set; }

        public decimal MontoDeuda { get; set; }

        public string FechaVencimiento { get; set; }

        public int VioVideoBienvenidaModel { get; set; }

        public int VioTutorialDesktop { get; set; }

        public decimal MontoPedido { get; set; }

        public int CatalogoPersonalizadoDesktop { get; set; }

        public string ImagenUsuario { get; set; }

        public BarraConsultoraModel DataBarra { get; set; }
        public bool EsCatalogoPersonalizadoZonaValida { get; set; }

        public int VioTutorialSalvavidas { get; set; }

        public int limiteMaximoTelef{ get; set; }

        public int limiteMinimoTelef { get; set; }        
        #region Propiedades para POPUps
        public int TipoPopUpMostrar { get; set; }
        // DemandaAnticipada
        public string MensajeFechaDA { get; set; }
        // Actualizar datos
        public int MostrarPopupActualizarDatosXPais { get; set; }
        #endregion

        public int ShowRoomMostrarLista { get; set; }
        public string ShowRoomBannerUrl { get; set; }
        public int CampaniaMasDos { get; set; }
        public int TieneCupon { get; set; }
        public int TieneMasVendidos { get; set; }
    }
}