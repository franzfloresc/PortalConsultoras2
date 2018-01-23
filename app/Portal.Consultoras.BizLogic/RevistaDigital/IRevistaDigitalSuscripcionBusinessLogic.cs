using Portal.Consultoras.Entities.RevistaDigital;

namespace Portal.Consultoras.BizLogic.RevistaDigital
{
    public interface IRevistaDigitalSuscripcionBusinessLogic
    {
        int Desuscripcion(BERevistaDigitalSuscripcion entidad);
        BERevistaDigitalSuscripcion Single(BERevistaDigitalSuscripcion entidad);
        BERevistaDigitalSuscripcion SingleActiva(BERevistaDigitalSuscripcion entidad);
        int Suscripcion(BERevistaDigitalSuscripcion entidad);
    }
}