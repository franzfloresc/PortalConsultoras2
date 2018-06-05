using System;
using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.ShowRoom;

namespace Portal.Consultoras.BizLogic.Estrategia
{
    public class BLEstrategiaOferta
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


    }
}
