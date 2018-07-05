using Portal.Consultoras.Entities.RevistaDigital;

namespace Portal.Consultoras.Entities
{
    public class BERevistaDigital
    {
        public BERevistaDigital()
        {
            SuscripcionModel = new BERevistaDigitalSuscripcion();
            SuscripcionEfectiva = new BERevistaDigitalSuscripcion();
            BloquearRevistaImpresaGeneral = null;
        }

        public int CantidadCampaniaEfectiva { get; set; }
        public bool TieneRDC { get; set; }
        public bool EsActiva { get; set; }
        public bool TieneRDCR { get; set; }
        public bool EsSuscrita { get; set; }

        public BERevistaDigitalSuscripcion SuscripcionModel { get; set; }
        public BERevistaDigitalSuscripcion SuscripcionEfectiva { get; set; }

        public bool BloqueoRevistaImpresa { get; set; }
        public int? BloquearRevistaImpresaGeneral { get; set; }
        public bool ActivoMdo { get; set; }

        public bool BloqueoProductoDigital { get; set; }

        public bool SociaEmpresariaExperienciaGanaMas { get; set; }

        public bool EsSuscritaActiva()
        {
            return TieneRDC && EsSuscrita && EsActiva;
        }

        public bool TieneRevistaDigital()
        {
            return TieneRDC;
        }
    }
}
