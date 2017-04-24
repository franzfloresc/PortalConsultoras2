using Portal.Consultoras.Entities.RevistaDigital;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IRevistaDigitalService
    {
        [OperationContract]
        int Suscripcion(BERevistaDigitalSuscripcion entidad);

        [OperationContract]
        int Desuscripcion(BERevistaDigitalSuscripcion entidad);
        
        [OperationContract]
        BERevistaDigitalSuscripcion GetSuscripcion(BERevistaDigitalSuscripcion entidad);
    }
}
