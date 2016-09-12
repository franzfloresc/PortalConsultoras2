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
        public List<BEComunicado> ObtenerComunicadoPorConsultora(int paisID, string CodigoConsultora)
        {
            List<BEComunicado> oBEComunicados = new List<BEComunicado>();
            var DAComunicado = new DAComunicado(paisID);

            using (IDataReader reader = DAComunicado.ObtenerComunicadoPorConsultora(CodigoConsultora))
                while (reader.Read())
                {
                    oBEComunicados.Add(new BEComunicado(reader));
                }

            return oBEComunicados;
        }


        public void InsertarComunicadoVisualizado(int PaisID, string CodigoConsultora, int ComunicadoID)
        {
            DAComunicado DAComunicado = new DAComunicado(PaisID);
            DAComunicado.InsertarComunicadoVisualizado(CodigoConsultora, ComunicadoID);

        }

        public void InsertarDonacionConsultora(int PaisId, string CodigoISO, string CodigoConsultora, string Campania, string IPUsuario)
        {
            DAComunicado DAComunicado = new DAComunicado(PaisId);
            DAComunicado.InsertarDonacionConsultora(CodigoISO, CodigoConsultora, Campania, IPUsuario);
        }

    }
}
