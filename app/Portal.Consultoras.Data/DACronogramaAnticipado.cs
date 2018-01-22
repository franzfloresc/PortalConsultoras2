using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DACronogramaAnticipado : DataAccess
    {
        public DACronogramaAnticipado(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCronogramaByCampania(int CampaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCronogramaByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@TipoCronogramaID", DbType.Int16, TipoCronogramaID);

            return Context.ExecuteReader(command);
        }

        public int InsCronograma(BECronograma cronograma)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCronograma");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cronograma.CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, cronograma.ZonaID);
            Context.Database.AddInParameter(command, "@FechaFact", DbType.Date, cronograma.FechaInicioWeb);
            Context.Database.AddInParameter(command, "@FechaReFact", DbType.Date, cronograma.FechaInicioDD);
            Context.Database.AddInParameter(command, "@CodigoUsuarioRegistro", DbType.String, cronograma.CodigoUsuarioModificacion);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int UpdCronograma(BECronograma cronograma)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdCronograma");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cronograma.CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, cronograma.ZonaID);
            Context.Database.AddInParameter(command, "@TipoCronograma", DbType.Int16, cronograma.TipoCronogramaID);
            Context.Database.AddInParameter(command, "@FechaInicioWeb", DbType.Date, cronograma.FechaInicioWeb);
            Context.Database.AddInParameter(command, "@FechaFinWeb", DbType.Date, cronograma.FechaFinWeb);
            Context.Database.AddInParameter(command, "@FechaInicioDD", DbType.Date, cronograma.FechaInicioDD);
            Context.Database.AddInParameter(command, "@FechaFinDD", DbType.Date, cronograma.FechaFinDD);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, cronograma.CodigoUsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int DelCronograma(BECronograma cronograma)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCronograma");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cronograma.CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, cronograma.ZonaID);

            return Context.ExecuteNonQuery(command);
        }

        public int InsConfiguracionConsultoraDA(BEConfiguracionConsultoraDA configuracionConsultoraDA)
        {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConfiguracionConsultoraDA");
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, configuracionConsultoraDA.ZonaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, configuracionConsultoraDA.ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.String, configuracionConsultoraDA.CampaniaID);
            Context.Database.AddInParameter(command, "@TipoConfiguracion", DbType.Byte, configuracionConsultoraDA.TipoConfiguracion);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, configuracionConsultoraDA.CodigoUsuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));

        }

        public int GetConfiguracionConsultoraDA(BEConfiguracionConsultoraDA configuracionConsultoraDA)
        {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionConsultoraDA");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, configuracionConsultoraDA.ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.String, configuracionConsultoraDA.CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, configuracionConsultoraDA.ZonaID);

            return Convert.ToInt32(Context.ExecuteScalar(command));

        }

        public int GetCronogramaDA(DateTime fechaFacturacion)
        {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCronogramaAnticipada");
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.DateTime, fechaFacturacion);

            return Convert.ToInt32(Context.ExecuteScalar(command));

        }


    }
}
