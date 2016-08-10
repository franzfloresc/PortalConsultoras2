using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IConsultoraWebService
    {
        [OperationContract]
        List<BEConsultoraUbigeo> GetConsultorasPorUbigeo(string codigoPais, string codigoUbigeo, string campania, int marcaId);
    }
}
