using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

// R2073 - Toda la clase
namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoFacturado
    {
        public List<BEPedidoFacturado> GetPedidosFacturadosCabecera(int PaisId, string CodigoConsultora)
        {
            var lista = new List<BEPedidoFacturado>();
            var DAPedidoFacturado = new DAPedidoFacturado(PaisId);

            using (IDataReader reader = DAPedidoFacturado.GetPedidosFacturadosCabecera(CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoFacturado(reader, 1);

                    lista.Add(entidad);
                }

            return lista;
        }

        public List<BEPedidoFacturado> GetPedidosFacturadosDetalle(int PaisId, string Campania, string Region, string Zona, string CodigoConsultora)
        {
            var lista = new List<BEPedidoFacturado>();
            var DAPedidoFacturado = new DAPedidoFacturado(PaisId);

            using (IDataReader reader = DAPedidoFacturado.GetPedidosFacturadosDetalle(Campania, Region, Zona, CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoFacturado(reader);

                    lista.Add(entidad);
                }

            return lista;
        }
    }
}
