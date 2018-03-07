using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAFactorGanancia : DataAccess
    {
        public DAFactorGanancia(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader SelectFactorGanancia()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFactorGanancia");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetFactorGananciaById(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFactorGananciaById");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int16, PaisID);
            return Context.ExecuteReader(command);
        }

        public int Insert(BEFactorGanancia entidad)
        {
            SqlCommand cmd = new SqlCommand("InsFactorGanancia");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PaisID", SqlDbType.TinyInt).Value = entidad.PaisID;
            cmd.Parameters.Add("@RangoMinimo", SqlDbType.Money).Value = entidad.RangoMinimo;
            cmd.Parameters.Add("@RangoMaximo", SqlDbType.Money).Value = entidad.RangoMaximo;
            cmd.Parameters.Add("@Porcentaje", SqlDbType.Decimal).Value = entidad.Porcentaje;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Update(BEFactorGanancia entidad)
        {
            SqlCommand cmd = new SqlCommand("UpdFactorGanancia");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@FactorGananciaID", SqlDbType.Int).Value = entidad.FactorGananciaID;
            cmd.Parameters.Add("@PaisID", SqlDbType.TinyInt).Value = entidad.PaisID;
            cmd.Parameters.Add("@RangoMinimo", SqlDbType.Money).Value = entidad.RangoMinimo;
            cmd.Parameters.Add("@RangoMaximo", SqlDbType.Money).Value = entidad.RangoMaximo;
            cmd.Parameters.Add("@Porcentaje", SqlDbType.Decimal).Value = entidad.Porcentaje;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Delete(int factorGananciaID)
        {
            SqlCommand cmd = new SqlCommand("DelFactorGanancia");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@FactorGananciaID", SqlDbType.Int).Value = factorGananciaID;

            return Context.ExecuteNonQuery(cmd);
        }

        public IDataReader GetFactorGananciaByPaisRango(decimal monto, int paisId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFactorGananciaByPaisRango");
            Context.Database.AddInParameter(command, "@Monto", DbType.Decimal, monto);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisId);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoComercialIndicadorDescuentoByPedidoWebDetalle(int campaniaId, int pedidoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComercialIndicadorDescuentoByPedidoWebDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoId);
            return Context.ExecuteReader(command);
        }

        public int UpdatePedidoWebEstimadoGanancia(int campaniaId, int pedidoId, decimal estimadoGanancia)
        {
            SqlCommand cmd = new SqlCommand("UdpPedidoWebEstimadoGanancia");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = campaniaId;
            cmd.Parameters.Add("@PedidoID", SqlDbType.Int).Value = pedidoId;
            cmd.Parameters.Add("@EstimadoGanancia", SqlDbType.Money).Value = estimadoGanancia;

            return Context.ExecuteNonQuery(cmd);
        }

        public int GetFactorGananciaValidar(int FactorGananciaID, decimal RangoMinimo, decimal RangoMaximo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFactorGananciaValidar");
            Context.Database.AddInParameter(command, "@FactorGananciaID", DbType.Int32, FactorGananciaID);
            Context.Database.AddInParameter(command, "@RangoMinimo", DbType.Decimal, RangoMinimo);
            Context.Database.AddInParameter(command, "@RangoMaximo", DbType.Decimal, RangoMaximo);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }
    }
}