using Portal.Consultoras.BizLogic.RevistaDigital;
using Portal.Consultoras.Entities.RevistaDigital;
using Portal.Consultoras.ServiceContracts;

namespace Portal.Consultoras.Service
{
    public class RevistaDigitalService : IRevistaDigitalService
    {
        private BLRevistaDigitalSuscripcion BLRevistaDigitalSuscripcion;

        public RevistaDigitalService()
        {
            BLRevistaDigitalSuscripcion = new BLRevistaDigitalSuscripcion();
        }

        public int Suscripcion(BERevistaDigitalSuscripcion entidad)
        {
            return BLRevistaDigitalSuscripcion.Suscripcion(entidad);
        }

        public int Desuscripcion(BERevistaDigitalSuscripcion entidad)
        {
            return BLRevistaDigitalSuscripcion.Desuscripcion(entidad);
        }

        public BERevistaDigitalSuscripcion GetSuscripcion(BERevistaDigitalSuscripcion entidad)
        {
            return BLRevistaDigitalSuscripcion.Single(entidad);
        }
    }
}
