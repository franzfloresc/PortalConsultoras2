using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities.ReservaProl;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAPedidoWebDetalleExplotado : DataAccess
    {
        public DAPedidoWebDetalleExplotado(int paisID) : base(paisID, EDbSource.Portal) {}

        public int DeleteByPedidoID(int campaniaID, int pedidoID)
        {
            SqlCommand cmd = new SqlCommand("DeletePedidoWebDetalleExplotadoByPedidoID");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = campaniaID;
            cmd.Parameters.Add("@PedidoID", SqlDbType.Int).Value = pedidoID;
            return Context.ExecuteNonQuery(cmd);
        }

        public int InsertList(List<BEPedidoWebDetalleExplotado> listPedidoWebDetalleExplotado)
        {
            SqlCommand cmd = new SqlCommand("InsertListPedidoWebDetalleExplotado");
            cmd.CommandType = CommandType.StoredProcedure;

            var parListDetalleExp = new SqlParameter("@ListPedidoWebDetalleExplotado", SqlDbType.Structured);
            parListDetalleExp.TypeName = "dbo.PedidoWebDetalleExplotadoType";
            parListDetalleExp.Value = new GenericDataReader<BEPedidoWebDetalleExplotado>(listPedidoWebDetalleExplotado);
            cmd.Parameters.Add(parListDetalleExp);

            return Context.ExecuteNonQuery(cmd);
        }
    }
}
