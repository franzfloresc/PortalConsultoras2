using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IConsultoraWebService
    {
        [OperationContract]
        List<BEConsultoraUbigeo> GetConsultorasPorUbigeo(string codigoPais, string codigoUbigeo, string campania, int marcaId);
    }
}
