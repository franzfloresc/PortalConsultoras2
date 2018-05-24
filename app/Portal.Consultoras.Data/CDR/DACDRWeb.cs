using Portal.Consultoras.Entities.CDR;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DACDRWeb : DataAccess
    {
        public DACDRWeb(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsCDRWeb(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCDRWeb");
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);
            Context.Database.AddInParameter(command, "PedidoID", DbType.Int32, entity.PedidoID);
            Context.Database.AddInParameter(command, "PedidoNumero", DbType.Int32, entity.PedidoNumero);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "ConsultoraID", DbType.Int32, entity.ConsultoraID);
            Context.Database.AddInParameter(command, "Importe", DbType.Decimal, entity.Importe);
            Context.Database.AddInParameter(command, "TipoDespacho", DbType.Boolean, entity.TipoDespacho);
            Context.Database.AddInParameter(command, "FleteDespacho", DbType.Decimal, entity.FleteDespacho);
            Context.Database.AddInParameter(command, "MensajeDespacho", DbType.String, entity.MensajeDespacho);
            Context.Database.AddInParameter(command, "EsMovilOrigen", DbType.Boolean, entity.EsMovilOrigen);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public int DelCDRWeb(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCDRWeb");
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public IDataReader GetCDRWeb(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWeb");
            Context.Database.AddInParameter(command, "ConsultoraID", DbType.Int64, entity.ConsultoraID);
            Context.Database.AddInParameter(command, "PedidoID", DbType.Int32, entity.PedidoID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCDRWebMobile(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebMobile");
            Context.Database.AddInParameter(command, "ConsultoraID", DbType.Int64, entity.ConsultoraID);
            Context.Database.AddInParameter(command, "PedidoID", DbType.Int32, entity.PedidoID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);

            return Context.ExecuteReader(command);
        }

        public int UpdEstadoCDRWeb(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdEstadoCDRWeb");
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);
            Context.Database.AddInParameter(command, "Estado", DbType.Int32, entity.Estado);

            Context.Database.AddInParameter(command, "TipoDespacho", DbType.Boolean, entity.TipoDespacho);
            Context.Database.AddInParameter(command, "FleteDespacho", DbType.Decimal, entity.FleteDespacho);
            Context.Database.AddInParameter(command, "MensajeDespacho", DbType.String, entity.MensajeDespacho);

            Context.Database.AddInParameter(command, "EsMovilFin", DbType.Boolean, entity.EsMovilFin);

            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public IDataReader GetCDRWebDetalleReporte(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebDetalleReporte");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, entity.RegionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, entity.ZonaID);
            Context.Database.AddInParameter(command, "@ConsultoraCodigo", DbType.String, entity.ConsultoraCodigo);
            Context.Database.AddInParameter(command, "@EstadoCDR", DbType.Int32, entity.Estado);
            Context.Database.AddInParameter(command, "@TipoConsultora", DbType.Int32, entity.TipoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetMontoFletePorZonaId(int ZonaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMontoFletePorZonaId");
            Context.Database.AddInParameter(command, "ZonaId", DbType.Int32, ZonaId);
            return Context.ExecuteReader(command);
        }
    }
}