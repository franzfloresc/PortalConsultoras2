using Portal.Consultoras.Entities.RevistaDigital;

namespace Portal.Consultoras.Entities
{
    public class BERevistaDigital
    {
        public BERevistaDigital()
        {
            SuscripcionModel = new BERevistaDigitalSuscripcion();
            SuscripcionEfectiva = new BERevistaDigitalSuscripcion();
        }

        public int CantidadCampaniaEfectiva { get; set; }
        public bool TieneRDC { get; set; }
        public bool EsActiva { get; set; }
        public bool EsSuscrita { get; set; }

        public BERevistaDigitalSuscripcion SuscripcionModel { get; set; }
        public BERevistaDigitalSuscripcion SuscripcionEfectiva { get; set; }

        public bool BloqueoRevistaImpresa { get; set; }
        public int? BloquearRevistaImpresaGeneral { get; set; }
    }
}
