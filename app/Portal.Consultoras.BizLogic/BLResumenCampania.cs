using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLResumenCampania
    {
        public IList<BEResumenCampania> GetPedidoWebAcumulado(int paisID, int CampaniaID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var DAproductofaltante = new DAResumenCampania(paisID);

            using (IDataReader reader = DAproductofaltante.GetPedidoWebAcumulado(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var prodfal = new BEResumenCampania(reader);
                    prodfal.PaisID = paisID;
                    productos.Add(prodfal);
                }

            return productos;
        }

        public IList<BEResumenCampania> GetSaldoPendiente(int paisID, int CampaniaID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var DAproductofaltante = new DAResumenCampania(paisID);

            using (IDataReader reader = DAproductofaltante.GetSaldoPendiente(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var prodfal = new BEResumenCampania(reader);
                    prodfal.PaisID = paisID;
                    productos.Add(prodfal);
                }

            return productos;
        }

        public IList<BEResumenCampania> GetProductosSolicitados(int paisID, int CampaniaID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var DAproductofaltante = new DAResumenCampania(paisID);

            using (IDataReader reader = DAproductofaltante.GetProductosSolicitados(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var prodfal = new BEResumenCampania(reader);
                    prodfal.PaisID = paisID;
                    productos.Add(prodfal);
                }

            return productos;
        }


        public IList<BEResumenCampania> GetValorAPagar(int paisID, int CampaniaID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var DAResumenCampania = new DAResumenCampania(paisID);

            using (IDataReader reader = DAResumenCampania.GetValorAPagar(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var resCampania = new BEResumenCampania(reader);
                    resCampania.PaisID = paisID;
                    productos.Add(resCampania);
                }

            return productos;
        }

        public List<BEResumenCampania> GetFlexipago(int paisID, int ConsultoraID, int CampaniaID)
        {
            var productos = new List<BEResumenCampania>();
            var DAResumenCampania = new DAResumenCampania(paisID);

            using (IDataReader reader = DAResumenCampania.GetFlexipago(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var resCampania = new BEResumenCampania(reader);
                    resCampania.PaisID = paisID;
                    productos.Add(resCampania);
                }
            return productos;
        }

        public IList<BEResumenCampania> GetDeudaTotal(int paisID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var DAResumenCampania = new DAResumenCampania(paisID);

            using (IDataReader reader = DAResumenCampania.GetDeudaTotal(ConsultoraID))
                while (reader.Read())
                {
                    var resCampania = new BEResumenCampania(reader);
                    resCampania.PaisID = paisID;
                    productos.Add(resCampania);
                }

            return productos;
        }     
    }
}
