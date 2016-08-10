using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

//R2004
namespace Portal.Consultoras.BizLogic
{
    public class BLComunicado
    {
        public BEComunicado GetComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            BEComunicado oBEComunicado = null;
            var DAComunicado = new DAComunicado(paisID);

            using (IDataReader reader = DAComunicado.GetComunicadoByConsultora(CodigoConsultora))
                if (reader.Read())
                {
                    oBEComunicado = new BEComunicado(reader);
                }

            return oBEComunicado;
        }

        public void UpdComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            var DAComunicado = new DAComunicado(paisID);
            DAComunicado.UpdComunicadoByConsultora(CodigoConsultora);
        }

        /**GR 1209 Obtener comunicado configurable en la tabla */
        public BEComunicado ObtenerComunicadoPorConsultora(int paisID, string CodigoConsultora)
        {

            BEComunicado oBEComunicado = null;
            var DAComunicado = new DAComunicado(paisID);

            using (IDataReader reader = DAComunicado.ObtenerComunicadoPorConsultora(CodigoConsultora))
                if (reader.Read())
                {
                    oBEComunicado = new BEComunicado(reader);
                }

            return oBEComunicado;
        }


        public void InsertComunicadoByConsultoraVisualizacion(int PaisID, string CodigoConsultora)
        {
            var DAComunicado = new DAComunicado(PaisID);
            DAComunicado.InsertComunicadoByConsultoraVisualizacion(CodigoConsultora);

        }
    }
}
