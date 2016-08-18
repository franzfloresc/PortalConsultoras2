using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoReporteLider
    {
        public BEPedidoReporteLiderIndicador GetPedidosReporteLiderIndicador(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {

            var DAPedidoReporteLider = new DAPedidoReporteLider(paisID);
            var entidad = new BEPedidoReporteLiderIndicador();

            using (IDataReader reader = DAPedidoReporteLider.GetPedidosReporteLiderIndicador(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
                while (reader.Read())
                {
                    entidad = new BEPedidoReporteLiderIndicador(reader);
                }

            return entidad;
        }
        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosValidados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            var listado = new List<BEPedidoReporteLiderListado>();
            var DAPedidoReporteLider = new DAPedidoReporteLider(paisID);

            using (IDataReader reader = DAPedidoReporteLider.GetPedidosReporteLiderPedidosValidados(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
                while (reader.Read())
                {
                    var entidad = new BEPedidoReporteLiderListado(reader);
                    listado.Add(entidad);
                }

            return listado;
        }

        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosNoValidados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            var listado = new List<BEPedidoReporteLiderListado>();
            var DAPedidoReporteLider = new DAPedidoReporteLider(paisID);

            using (IDataReader reader = DAPedidoReporteLider.GetPedidosReporteLiderPedidosNoValidados(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
                while (reader.Read())
                {
                    var entidad = new BEPedidoReporteLiderListado(reader);
                    listado.Add(entidad);
                }

            return listado;
        }

        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosRechazados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            var listado = new List<BEPedidoReporteLiderListado>();
            var DAPedidoReporteLider = new DAPedidoReporteLider(paisID);

            using (IDataReader reader = DAPedidoReporteLider.GetPedidosReporteLiderPedidosRechazados(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
                while (reader.Read())
                {
                    var entidad = new BEPedidoReporteLiderListado(reader);
                    listado.Add(entidad);
                }

            return listado;
        }

        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosFacturados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            var listado = new List<BEPedidoReporteLiderListado>();
            var DAPedidoReporteLider = new DAPedidoReporteLider(paisID);

            using (IDataReader reader = DAPedidoReporteLider.GetPedidosReporteLiderPedidosFacturados(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
                while (reader.Read())
                {
                    var entidad = new BEPedidoReporteLiderListado(reader);
                    listado.Add(entidad);
                }

            return listado;
        }
    }
}
