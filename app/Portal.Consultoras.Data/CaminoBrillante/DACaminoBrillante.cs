using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CaminoBrillante
{
    public class DACaminoBrillante : DataAccess
    {
        public DACaminoBrillante(int paisID) : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetBeneficiosCaminoBrillante()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBeneficioCaminoBrillante");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetDemostradoresCaminoBrillante(int campaniaId, int nivelId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDemostradoresCaminoBrillante");
            Context.Database.AddInParameter(command, "@AnoCampania", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@NivelCaminoBrillante", DbType.Int32, nivelId);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConfiguracionMedallaCaminoBrillante()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionMedallaCaminoBrillante");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetKitsCaminoBrillante(int periodoId, int campaniaId, string cuvsStringList)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetKitsCaminoBrillante");
            Context.Database.AddInParameter(command, "@Periodo", DbType.Int32, periodoId);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@CuvsStringList", DbType.Xml, cuvsStringList);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebDetalleCaminoBrillante(int periodoId, int campaniaId, long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleCaminoBrillante");
            Context.Database.AddInParameter(command, "@Periodo", DbType.Int32, periodoId);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraId);
            return Context.ExecuteReader(command);
        }

        public decimal GetMontoMinimoEscala(long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMontoMinimoEscala");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraId);
            return Convert.ToDecimal(Context.ExecuteScalar(command) ?? 0.0);
        }

        public IDataReader GetCuvsCaminoBrillante(int campaniaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCuvsCaminoBrillante");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            return Context.ExecuteReader(command);
        }




        #region Exigencia Monto Incentivos
        public IDataReader InsIncentivosMontoExigencia(int periodoId, int campaniaId, long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleCaminoBrillante");
            Context.Database.AddInParameter(command, "@Periodo", DbType.Int32, periodoId);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraId);
            return Context.ExecuteReader(command);
        }
        #endregion
    }
}