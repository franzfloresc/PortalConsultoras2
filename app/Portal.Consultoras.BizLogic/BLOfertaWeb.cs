using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLOfertaWeb
    {
        public IList<BEOfertaWeb> GetOfertaWebByCampania(int PaisID, int CampaniaID, int PedidoID, long ConsultoraID)
        {
            var ofertaWeb = new List<BEOfertaWeb>();
            var daOfertaWeb = new DAOfertaWeb(PaisID);

            using (IDataReader reader = daOfertaWeb.GetOfertaWebByCampania(CampaniaID, PedidoID, ConsultoraID))
                while (reader.Read())
                {
                    var entidad = new BEOfertaWeb(reader) { PaisID = PaisID };
                    ofertaWeb.Add(entidad);
                }

            return ofertaWeb;
        }
    }
}
