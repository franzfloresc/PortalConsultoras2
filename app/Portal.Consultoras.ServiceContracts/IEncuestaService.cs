using Portal.Consultoras.Entities.Encuesta;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.ServiceContracts
{
    public interface IEncuestaService
    {
        List<BEDataConfigEncuesta> ObtenerDataEncuesta(int paisId, int encuestaId);
    }
}
