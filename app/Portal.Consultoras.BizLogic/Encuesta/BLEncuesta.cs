using Portal.Consultoras.Data.Encuesta;
using Portal.Consultoras.Entities.Encuesta;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Encuesta
{
    public class BLEncuesta
    {
        public List<BEEncuestaReporte> GetReporteEncuestaSatisfaccion(BEEncuestaReporte bEncuesta)
        {
            var dAEncuestaReporte = new DAEncuesta(bEncuesta.PaisID);
            var lista = new List<BEEncuestaReporte>();
            using (var reader = dAEncuestaReporte.GetReporteEncuestaSatisfaccion(bEncuesta))
            {
                while (reader.Read())
                {
                    lista.Add(new BEEncuestaReporte(reader));
                }
            }

            return lista;
        }

    }
}
