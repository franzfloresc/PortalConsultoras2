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
        public List<BEDataConfigEncuesta> ObtenerDataEncuesta(int paisId,string codigoConsultora)
        {
            return bLEncuesta.ObtenerDataEncuesta(paisId,codigoConsultora);
        }
    }


}
