using Portal.Consultoras.Entities.Encuesta;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IEncuestaService
    {
        [OperationContract]
        List<BEDataConfigEncuesta> ObtenerDataEncuesta(int paisId,string codigoConsultora);

        [OperationContract]
        int InsEncuesta(BEEncuestaCalificacion entity, int paisId);
    }
}
