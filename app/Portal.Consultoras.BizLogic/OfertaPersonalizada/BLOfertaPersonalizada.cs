using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.ShowRoom;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic.OfertaPersonalizada
{
    public class BLOfertaPersonalizada
    {
        public BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID)
        {
            BEShowRoomEvento entidad = null;
            var da = new DAShowRoomEvento(paisID);

            using (IDataReader reader = da.GetShowRoomEventoByCampaniaID(campaniaID))
            {
                if (reader.Read())
                {
                    entidad = new BEShowRoomEvento(reader);
                }
            }
            return entidad;
        }

        public IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            List<BEShowRoomOferta> showRoomOfertas;
            var da = new DAShowRoomEvento(paisID);

            using (var reader = da.GetShowRoomOfertasConsultoraPersonalizada(campaniaID, codigoConsultora))
            {
                showRoomOfertas = reader.MapToCollection<BEShowRoomOferta>();
            }
            return showRoomOfertas;
        }

        public List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID)
        {
            var lst = new List<BEShowRoomOferta>();
            var da = new DAShowRoomEvento(paisId);

            using (IDataReader reader = da.GetProductosCompraPorCompra(EventoID, CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEShowRoomOferta(reader);
                    lst.Add(entidad);
                }
            return lst;
        }
    }
}
