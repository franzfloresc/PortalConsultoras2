using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLMensajeCUV
    {
        public IList<BEMensajeCUV> GetMensajesCUVsByPaisAndCampania(int CampaniaID, int PaisID)
        {
            var mensajes = new List<BEMensajeCUV>();
            var DAMensajeCUV = new DAMensajeCUV(PaisID);

            using (IDataReader reader = DAMensajeCUV.GetMensajesCUVsByPaisAndCampania(CampaniaID, PaisID))
                while (reader.Read())
                {
                    var mensaje = new BEMensajeCUV(reader);
                    mensaje.PaisID = PaisID;
                    mensajes.Add(mensaje);
                }
            /*
            return (from venta in mensajes
                    where venta.CUV.Contains(codigo)
                    select venta).Take(rowCount).ToList();
            */
            return mensajes.ToList();
        }

        public bool SetMensajesCUVsByPaisAndCampania(int parametroID, int paisID, int campaniaID, string mensaje, string cuvs)
        {
            var DAMensajeCUV = new DAMensajeCUV(paisID);
            return DAMensajeCUV.SetMensajesCUVsByPaisAndCampania(parametroID, paisID, campaniaID, mensaje, cuvs);
        }

        public void DeleteMensajesCUVsByPaisAndCampania(int parametroID, int paisID)
        {
            var DAMensajeCUV = new DAMensajeCUV(paisID);
            DAMensajeCUV.DeleteMensajesCUVsByPaisAndCampania(parametroID);
        }

        public BEMensajeCUV GetMensajeByCUV(int paisID,  int campaniaID, string cuv)
        {
            var DAMensajeCUV = new DAMensajeCUV(paisID);
            return DAMensajeCUV.GetMensajeByCUV(paisID, campaniaID, cuv);
        }

    }
}
