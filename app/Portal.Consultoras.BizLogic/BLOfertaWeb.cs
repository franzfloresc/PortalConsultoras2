using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLOfertaWeb
    {
        public IList<BEOfertaWeb> GetOfertaWebByCampania(int PaisID, int CampaniaID, int PedidoID, long ConsultoraID)
        {
            var ofertaWeb = new List<BEOfertaWeb>();
            var DAOfertaWeb = new DAOfertaWeb(PaisID);

            using (IDataReader reader = DAOfertaWeb.GetOfertaWebByCampania(CampaniaID, PedidoID, ConsultoraID))
                while (reader.Read())
                {
                    var entidad = new BEOfertaWeb(reader);
                    entidad.PaisID = PaisID;
                    ofertaWeb.Add(entidad);
                }

            return ofertaWeb;
        }
    }
}
