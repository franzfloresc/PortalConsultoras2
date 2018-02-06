using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Comunicado;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLComunicado : IComunicadoBusinessLogic
    {
        public BEComunicado GetComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            BEComunicado oBeComunicado;
            var daComunicado = new DAComunicado(paisID);

            using (IDataReader reader = daComunicado.GetComunicadoByConsultora(CodigoConsultora))
                oBeComunicado = reader.MapToObject<BEComunicado>();

            return oBeComunicado;
        }

        public void UpdComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            var daComunicado = new DAComunicado(paisID);
            daComunicado.UpdComunicadoByConsultora(CodigoConsultora);
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
            List<BEComunicado> lstComunicado;
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
            DAComunicado daComunicado = new DAComunicado(PaisID);
            daComunicado.InsertarComunicadoVisualizado(CodigoConsultora, ComunicadoID);

        }

        public void InsertarDonacionConsultora(int PaisId, string CodigoISO, string CodigoConsultora, string Campania, string IPUsuario)
        {
            DAComunicado daComunicado = new DAComunicado(PaisId);
            daComunicado.InsertarDonacionConsultora(CodigoISO, CodigoConsultora, Campania, IPUsuario);
        }
    }
}