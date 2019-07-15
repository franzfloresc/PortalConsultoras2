using Portal.Consultoras.BizLogic.Encuesta;
using Portal.Consultoras.Entities.Encuesta;
using Portal.Consultoras.ServiceContracts;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{

    public class EncuetaService : IEncuestaService 
    {
        private readonly BLEncuesta bLEncuesta;
        public EncuetaService()
        {
            if (bLEncuesta == null)
                bLEncuesta = new BLEncuesta();

        }
        public List<BEDataConfigEncuesta> ObtenerDataEncuesta(int paisId, int encuestaId)
        {
            return bLEncuesta.ObtenerDataEncuesta(paisId, encuestaId);
        }
    }


}
