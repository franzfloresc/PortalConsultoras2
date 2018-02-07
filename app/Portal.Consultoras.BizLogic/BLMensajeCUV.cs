using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLMensajeCUV
    {
        public IList<BEMensajeCUV> GetMensajesCUVsByPaisAndCampania(int CampaniaID, int PaisID)
        {
            var mensajes = new List<BEMensajeCUV>();
            var daMensajeCuv = new DAMensajeCUV(PaisID);

            using (IDataReader reader = daMensajeCuv.GetMensajesCUVsByPaisAndCampania(CampaniaID, PaisID))
                while (reader.Read())
                {
                    var mensaje = new BEMensajeCUV(reader) {PaisID = PaisID};
                    mensajes.Add(mensaje);
                }
            return mensajes.ToList();
        }

        public bool SetMensajesCUVsByPaisAndCampania(int parametroID, int paisID, int campaniaID, string mensaje, string cuvs)
        {
            var daMensajeCuv = new DAMensajeCUV(paisID);
            return daMensajeCuv.SetMensajesCUVsByPaisAndCampania(parametroID, paisID, campaniaID, mensaje, cuvs);
        }

        public void DeleteMensajesCUVsByPaisAndCampania(int parametroID, int paisID)
        {
            var daMensajeCuv = new DAMensajeCUV(paisID);
            daMensajeCuv.DeleteMensajesCUVsByPaisAndCampania(parametroID);
        }

        public BEMensajeCUV GetMensajeByCUV(int paisID,  int campaniaID, string cuv)
        {
            var daMensajeCuv = new DAMensajeCUV(paisID);
            return daMensajeCuv.GetMensajeByCUV(paisID, campaniaID, cuv);
        }

    }
}
