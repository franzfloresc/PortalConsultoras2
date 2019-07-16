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
        #region Reporte
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
        #endregion

        #region MisPedidos
        public List<BEEncuestaPedido> GetEncuestaByConsultora(BEEncuestaPedido bEncuesta)
        {
            var dAEncuestaReporte = new DAEncuesta(bEncuesta.PaisID);
            var lista = new List<BEEncuestaPedido>();
            using (var reader = dAEncuestaReporte.GetEncuestaByConsultora(bEncuesta))
            {
                while (reader.Read())
                {
                    lista.Add(new BEEncuestaPedido(reader));
                }
            }

            return lista;
        }
        #endregion
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

    }
}
