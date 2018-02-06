using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoReporteLider
    {
        public BEPedidoReporteLiderIndicador GetPedidosReporteLiderIndicador(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            var daPedidoReporteLider = new DAPedidoReporteLider(paisID);
            var entidad = new BEPedidoReporteLiderIndicador();

            using (IDataReader reader = daPedidoReporteLider.GetPedidosReporteLiderIndicador(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
                while (reader.Read())
                {
                    entidad = new BEPedidoReporteLiderIndicador(reader);
                }

            return entidad;
        }

        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosValidados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            var listado = new List<BEPedidoReporteLiderListado>();
            var daPedidoReporteLider = new DAPedidoReporteLider(paisID);

            using (IDataReader reader = daPedidoReporteLider.GetPedidosReporteLiderPedidosValidados(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
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
            var daPedidoReporteLider = new DAPedidoReporteLider(paisID);

            using (IDataReader reader = daPedidoReporteLider.GetPedidosReporteLiderPedidosNoValidados(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
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
            var daPedidoReporteLider = new DAPedidoReporteLider(paisID);

            using (IDataReader reader = daPedidoReporteLider.GetPedidosReporteLiderPedidosRechazados(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
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
            var daPedidoReporteLider = new DAPedidoReporteLider(paisID);

            using (IDataReader reader = daPedidoReporteLider.GetPedidosReporteLiderPedidosFacturados(ConsultoraLiderID, CodigoPais, CodigoCampaniaActual))
                while (reader.Read())
                {
                    var entidad = new BEPedidoReporteLiderListado(reader);
                    listado.Add(entidad);
                }

            return listado;
        }
    }
}
