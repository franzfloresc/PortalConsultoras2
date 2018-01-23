using System.Collections.Generic;
using System.Data;
using System.Linq;

using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Comunicado;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLComunicado : IComunicadoBusinessLogic
    {
        public BEComunicado GetComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            BEComunicado oBEComunicado = null;
            var DAComunicado = new DAComunicado(paisID);

            using (IDataReader reader = DAComunicado.GetComunicadoByConsultora(CodigoConsultora))
                oBEComunicado = reader.MapToObject<BEComunicado>();

            return oBEComunicado;
        }

        public void UpdComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            var DAComunicado = new DAComunicado(paisID);
            DAComunicado.UpdComunicadoByConsultora(CodigoConsultora);
        }

        /**GR 1209 Obtener comunicado configurable en la tabla */
        /// <summary>
        /// Obtener los comunicados por consultora y tipo de dispositivo(Desktop o Mobile).
        /// </summary>
        /// <param name="PaisID"></param>
        /// <param name="CodigoConsultora"></param>
        /// <param name="TipoDispositivo"></param>
        /// <returns></returns>
        public List<BEComunicado> ObtenerComunicadoPorConsultora(int paisID, string CodigoConsultora, short TipoDispositivo)
        {
            var lstComunicado = new List<BEComunicado>();
            var lstComunicadoVista = new List<BEComunicadoVista>();

            using (var reader = new DAComunicado(paisID).ObtenerComunicadoPorConsultora(CodigoConsultora, TipoDispositivo))
            {
                lstComunicado = reader.MapToCollection<BEComunicado>();

                if (reader.NextResult()) lstComunicadoVista = reader.MapToCollection<BEComunicadoVista>();

                foreach(var item in lstComunicado)
                {
                    item.Vistas = lstComunicadoVista.Where(x => x.ComunicadoId == item.ComunicadoId).ToList();
                }
            }

            return lstComunicado;
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