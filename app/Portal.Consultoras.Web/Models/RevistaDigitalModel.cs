using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalModel
    {
        public RevistaDigitalModel()
        {
            SuscripcionModel = new RevistaDigitalSuscripcionModel();
            SuscripcionEfectiva = new RevistaDigitalSuscripcionModel();
            ListaTabs = new List<ComunModel>();
            EstadoRdcAnalytics = "(not available)";

            SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel();
            SuscripcionAnterior1Model = new RevistaDigitalSuscripcionModel();
        }

        public int ConfiguracionPaisID { get; set; }
        public int CampaniaID { get; set; }
        public int BloquearDiasAntesFacturar { get; set; }
        public int CantidadCampaniaEfectiva { get; set; }
        public string NombreComercialActiva { get; set; }
        public string NombreComercialNoActiva { get; set; }
        public string LogoComercialActiva { get; set; }
        public string LogoComercialNoActiva { get; set; }

        public string EstadoRdcAnalytics { get; set; }

        public bool TieneRDR { get; set; }
        public bool TieneRDC { get; set; }
        public bool TieneRDS { get; set; }
        public bool EsActiva { get; set; }
        public bool EsSuscrita { get; set; }

        public string NombreConsultora { get; set; }
        public string CampaniaActual { get; set; }
        public string CampaniaSuscripcion { get; set; }
        public string CampaniaActiva { get; set; } // CampaniaSuscripcion + CantidadCampaniaEfectiva
        public string CampaniaFuturoActiva { get; set; } // CampaniaActual + CantidadCampaniaEfectiva

        public RevistaDigitalSuscripcionModel SuscripcionModel { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionEfectiva { get; set; }

        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }

        public int EstadoSuscripcion { get; set; }
        public int EstadoAccion { get; set; }
        public List<ComunModel> ListaTabs { get; set; }
        public bool NoVolverMostrar { get; set; }
        public string Titulo { get; set; }
        public string TituloDescripcion { get; set; }
        public int Campania { get; set; }
        public int CampaniaMasUno { get; set; }
        public int CampaniaMasDos { get; set; }
        public string NumeroContacto { get; set; }
        public bool BloqueoRevistaImpresa { get; set; }

        public RevistaDigitalSuscripcionModel SuscripcionAnterior2Model { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionAnterior1Model { get; set; }
    }
}