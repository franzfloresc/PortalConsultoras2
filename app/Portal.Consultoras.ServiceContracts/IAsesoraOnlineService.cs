using Portal.Consultoras.Entities.AsesoraOnline;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IAsesoraOnlineService
    {
        [OperationContract]
        int EnviarFormulario(string paisISO, BEAsesoraOnline entidad);
    }
}
