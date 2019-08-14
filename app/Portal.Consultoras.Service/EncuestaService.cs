using Portal.Consultoras.BizLogic.Encuesta;
using Portal.Consultoras.Entities.Encuesta;
using Portal.Consultoras.ServiceContracts;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{

    public class EncuestaService : IEncuestaService 
    {
        private readonly BLEncuesta bLEncuesta;
        public EncuestaService()
        {
            if (bLEncuesta == null)
                bLEncuesta = new BLEncuesta();

        }

        public int InsEncuesta(BEEncuestaCalificacion entity, int paisId)
        {
            return bLEncuesta.InsEncuesta(entity, paisId);
        }

        public List<BEDataConfigEncuesta> ObtenerDataEncuesta(int paisId,string codigoConsultora, int verificarEncuestado)
        {
            return bLEncuesta.ObtenerDataEncuesta(paisId,codigoConsultora, verificarEncuestado);
        }
    }
}
