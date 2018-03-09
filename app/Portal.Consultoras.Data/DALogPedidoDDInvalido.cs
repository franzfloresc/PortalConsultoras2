namespace Portal.Consultoras.Data
{
    using Portal.Consultoras.Entities;
    using System;
    using System.Data;
    using System.Data.Common;

    public class DALogPedidoDDInvalido : DataAccess
    {
        public DALogPedidoDDInvalido(int paisID)
            : base(paisID, EDbSource.Digitacion)
        { }

        public IDataReader SelectLogPedidosInvalidos(DateTime fechaRegistro)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetLogPedidosDDInvalidos");
            Context.Database.AddInParameter(command, "@FechaRegistro", DbType.DateTime, fechaRegistro);
            return Context.ExecuteReader(command);
        }

        public void UpdLogPedidoInvalido(DateTime fechaRegistro)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdLogPedidoDDInvalido");
            Context.Database.AddInParameter(command, "@FechaRegistro", DbType.DateTime, fechaRegistro);
            Context.ExecuteNonQuery(command);
        }

        public void InsLogPedidoDDInvalido(BELogPedidoDDInvalido beLogPedidoDDInvalido)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsLogPedidoDDInvalido");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, beLogPedidoDDInvalido.CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, beLogPedidoDDInvalido.CodigoUsuario);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, beLogPedidoDDInvalido.CampaniaID);
            Context.Database.AddInParameter(command, "@NombreConsultora", DbType.String, beLogPedidoDDInvalido.NombreConsultora);

            Context.ExecuteNonQuery(command);
        }
    }
}