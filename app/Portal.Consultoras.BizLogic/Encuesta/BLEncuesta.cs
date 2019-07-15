using Portal.Consultoras.Common;
using Portal.Consultoras.Data.Encuesta;
using Portal.Consultoras.Entities.Encuesta;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Encuesta
{
    public class BLEncuesta : IEncuestaBusinessLogic
    {
        public List<BEDataConfigEncuesta> ObtenerDataEncuesta(int paisId, int encuestaId)
        {
            List<BEDataConfigEncuesta> listaDataConfigEncuesta = new List<BEDataConfigEncuesta>();
            using (IDataReader reader = new DAEncuesta(paisId).ObtenerDataEncuesta(encuestaId))
            {
                while (reader.Read())
                {
                    listaDataConfigEncuesta.Add(new BEDataConfigEncuesta(reader));
                }
            }
            return listaDataConfigEncuesta;
        }
    }

    public interface IEncuestaBusinessLogic
    {
        List<BEDataConfigEncuesta> ObtenerDataEncuesta(int paisId, int encuestaId);
    }
}
