﻿using Portal.Consultoras.Common;
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
        /// <summary>
        /// campaña que realizo la suscripcion o desuscripcion
        /// </summary>
        public string CampaniaSuscripcion { get; set; }
        /// <summary>
        /// campaña que se tomara efecto la suscripción
        /// </summary>
        public string CampaniaActiva { get; set; }
        /// <summary>
        /// CampaniaActual + CantidadCampaniaEfectiva
        /// </summary>
        public string CampaniaFuturoActiva { get; set; }

        public bool NoVolverMostrar { get; set; }
        public int EstadoSuscripcion { get; set; }
        public string NumeroContacto { get; set; }

        public RevistaDigitalSuscripcionModel SuscripcionModel { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionEfectiva { get; set; }

        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }

        public int EstadoAccion { get; set; }
        public List<ComunModel> ListaTabs { get; set; }
        public string Titulo { get; set; }
        public string TituloDescripcion { get; set; }
        public int Campania { get; set; }
        public int CampaniaMasUno { get; set; }
        public int CampaniaMasDos { get; set; }
        public bool BloqueoRevistaImpresa { get; set; }

        public RevistaDigitalSuscripcionModel SuscripcionAnterior2Model { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionAnterior1Model { get; set; }

        public bool EsSuscritaInactiva()
        {
            return TieneRDC && EsSuscrita && !EsActiva;
        }

        public bool EsSuscritaActiva()
        {
            return TieneRDC && EsSuscrita && EsActiva;
        }

        public bool EsNoSuscritaInactiva()
        {
            return TieneRDC && !EsSuscrita && !EsActiva;
        }
        
        public bool EsNoSuscritaActiva()
        {
            return TieneRDC && !EsSuscrita && EsActiva;
        }
    }
}