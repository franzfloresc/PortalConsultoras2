using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAPedidoWebDetalleExplotado : DataAccess
    {
        public DAPedidoWebDetalleExplotado(int paisID) : base(paisID, EDbSource.Portal) {}

        public int DeleteByPedidoID(int pedidoID)
        {
            SqlCommand cmd = new SqlCommand("DeletePedidoWebDetalleExplotadoByPedidoID");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PedidoID", SqlDbType.Int).Value = pedidoID;
            return Context.ExecuteNonQuery(cmd);
        }

        public int InsertList(List<DEPedidoWebDetalleExplotado> listPedidoWebDetalleExplotado)
        {
            SqlCommand cmd = new SqlCommand("InsertListPedidoWebDetalleExplotado");
            cmd.CommandType = CommandType.StoredProcedure;

            var parListPalabra = new SqlParameter("@ListPedidoWebDetalleExplotado", SqlDbType.Structured);
            parListPalabra.TypeName = "dbo.PedidoWebDetalleExplotadoType";
            parListPalabra.Value = new GenericDataReader<DEPedidoWebDetalleExplotado>(listPedidoWebDetalleExplotado);
            cmd.Parameters.Add(parListPalabra);

            return Context.ExecuteNonQuery(cmd);
        }
    }
}
