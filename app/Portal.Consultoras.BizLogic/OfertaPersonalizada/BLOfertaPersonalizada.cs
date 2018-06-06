using System;
using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.ShowRoom;

namespace Portal.Consultoras.BizLogic.OfertaPersonalizada
{
    public class BLOfertaPersonalizada
    {
        public BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID)
        {
            BEShowRoomEvento entidad = null;
            var daPedidoWeb = new DAShowRoomEvento(paisID);

            using (IDataReader reader = daPedidoWeb.GetShowRoomEventoByCampaniaID(campaniaID))
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

            using (var reader = new DAShowRoomEvento(paisID).GetShowRoomOfertasConsultoraPersonalizada(campaniaID, codigoConsultora))
            {
                showRoomOfertas = reader.MapToCollection<BEShowRoomOferta>();
            }
            return showRoomOfertas;
        }

        public List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID)
        {
            var lst = new List<BEShowRoomOferta>();
            var daPedidoWeb = new DAShowRoomEvento(paisId);

            using (IDataReader reader = daPedidoWeb.GetProductosCompraPorCompra(EventoID, CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEShowRoomOferta(reader);
                    lst.Add(entidad);
                }
            return lst;
        }
    }
}
