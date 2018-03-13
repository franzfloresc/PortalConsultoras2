using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLResumenCampania
    {
        public IList<BEResumenCampania> GetPedidoWebAcumulado(int paisID, int CampaniaID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var daProductofaltante = new DAResumenCampania(paisID);

            using (IDataReader reader = daProductofaltante.GetPedidoWebAcumulado(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var prodfal = new BEResumenCampania(reader) { PaisID = paisID };
                    productos.Add(prodfal);
                }

            return productos;
        }

        public IList<BEResumenCampania> GetSaldoPendiente(int paisID, int CampaniaID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var daProductofaltante = new DAResumenCampania(paisID);

            using (IDataReader reader = daProductofaltante.GetSaldoPendiente(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var prodfal = new BEResumenCampania(reader) { PaisID = paisID };
                    productos.Add(prodfal);
                }

            return productos;
        }

        public IList<BEResumenCampania> GetProductosSolicitados(int paisID, int CampaniaID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var daProductofaltante = new DAResumenCampania(paisID);

            using (IDataReader reader = daProductofaltante.GetProductosSolicitados(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var prodfal = new BEResumenCampania(reader) { PaisID = paisID };
                    productos.Add(prodfal);
                }

            return productos;
        }

        public IList<BEResumenCampania> GetValorAPagar(int paisID, int CampaniaID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var daResumenCampania = new DAResumenCampania(paisID);

            using (IDataReader reader = daResumenCampania.GetValorAPagar(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var resCampania = new BEResumenCampania(reader) { PaisID = paisID };
                    productos.Add(resCampania);
                }

            return productos;
        }

        public List<BEResumenCampania> GetFlexipago(int paisID, int ConsultoraID, int CampaniaID)
        {
            var productos = new List<BEResumenCampania>();
            var daResumenCampania = new DAResumenCampania(paisID);

            using (IDataReader reader = daResumenCampania.GetFlexipago(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var resCampania = new BEResumenCampania(reader) { PaisID = paisID };
                    productos.Add(resCampania);
                }
            return productos;
        }

        public IList<BEResumenCampania> GetDeudaTotal(int paisID, int ConsultoraID)
        {
            var productos = new List<BEResumenCampania>();
            var daResumenCampania = new DAResumenCampania(paisID);

            using (IDataReader reader = daResumenCampania.GetDeudaTotal(ConsultoraID))
                while (reader.Read())
                {
                    var resCampania = new BEResumenCampania(reader) { PaisID = paisID };
                    productos.Add(resCampania);
                }

            return productos;
        }

        public decimal GetMontoDeuda(int paisID, int campaniaID, int consultoraID, string codigoUsuario, bool revisarHana)
        {
            try
            {
                if (revisarHana && new BLPais().EsPaisHana(paisID))
                {
                    var datosConsultoraHana = new BLUsuario().GetDatosConsultoraHana(paisID, codigoUsuario, campaniaID);
                    if (datosConsultoraHana != null) return datosConsultoraHana.MontoDeuda;
                    return 0;
                }

                string paisIso = Util.GetPaisISO(paisID);
                bool esPaisDeudaTotal = new List<string> { Constantes.CodigosISOPais.Colombia, Constantes.CodigosISOPais.Peru }.Contains(paisIso);
                List<BEResumenCampania> infoDeuda = esPaisDeudaTotal ? GetDeudaTotal(paisID, consultoraID).ToList() :
                    GetSaldoPendiente(paisID, campaniaID, consultoraID).ToList();

                if (infoDeuda.Count > 0) return infoDeuda[0].SaldoPendiente;
                return 0;
            }
            catch { return 0; }
        }
    }
}
