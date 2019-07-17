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
    public class BLEncuesta
    {
        public List<BEDataConfigEncuesta> ObtenerDataEncuesta(int paisId,string codigoConsultora)
        {
            List<BEDataConfigEncuesta> listaDataConfigEncuesta = new List<BEDataConfigEncuesta>();
            using (IDataReader reader = new DAEncuesta(paisId).ObtenerDataEncuesta(codigoConsultora))
            {
                while (reader.Read())
                {
                    listaDataConfigEncuesta.Add(new BEDataConfigEncuesta(reader));
                }
            }
            return listaDataConfigEncuesta;
        }

        public int InsEncuesta(BEEncuestaCalificacion entity,int paisId)
        {
            return  new DAEncuesta(paisId).InsEncuesta(entity);
        }
    }
}
