using Portal.Consultoras.Entities.CaminoBrillante;
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

        public IDataReader GetBeneficiosCaminoBrillante(string codigoNivel)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBeneficioCaminoBrillante");
            Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, codigoNivel);
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

        public void InsBeneficioCaminoBrillante(BEBeneficioCaminoBrillante entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsBeneficioCaminoBrillante");
            Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, entidad.CodigoNivel);
            Context.Database.AddInParameter(command, "@CodigoBeneficio", DbType.String, entidad.CodigoBeneficio);
            Context.Database.AddInParameter(command, "@NombreBeneficio", DbType.AnsiString, entidad.NombreBeneficio);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entidad.Descripcion);
            Context.Database.AddInParameter(command, "@UrlIcono", DbType.String, entidad.Icono);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entidad.Orden);
            Context.Database.AddInParameter(command, "@Estado", DbType.Boolean, entidad.Estado);
            Context.ExecuteScalar(command);
        }

        public void DelBeneficioCaminoBrillante(string CodigoNivel, string CodigoBeneficio)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelBeneficioCaminoBrillante");
            Context.Database.AddInParameter(command, "@CodigoNivel", DbType.AnsiString, CodigoNivel);
            Context.Database.AddInParameter(command, "@CodigoBeneficio", DbType.AnsiString, CodigoBeneficio);
            Context.ExecuteScalar(command);
        }

        public IDataReader GetConsultoraCaminoBrillante(long consultoraId, int periodoCB, int campania, int nivelCB)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraCaminoBrillante");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraId);
            Context.Database.AddInParameter(command, "@PeriodoCB", DbType.Int32, periodoCB);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, campania);
            Context.Database.AddInParameter(command, "@NivelCB", DbType.Int32, nivelCB);
            return Context.ExecuteReader(command);
        }

        public int UpdConsultoraCaminoBrillanteAnim(long consultoraId, string KeyName, string valor, string repeat)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdConsultoraCaminoBrillanteAnim");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraId);
            Context.Database.AddInParameter(command, "@KeyName", DbType.AnsiString, KeyName);
            Context.Database.AddInParameter(command, "@Val", DbType.AnsiString, valor);
            Context.Database.AddInParameter(command, "@Rep", DbType.AnsiString, repeat);
            return Context.ExecuteNonQuery(command);
        }


        public IDataReader GetMontoExigenciaCaminoBrillante(string CodigoCampania, string CodigoRegion, string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMontoExigenciaCaminoBrillante");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.AnsiString, CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.AnsiString, CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, CodigoZona);
            return Context.ExecuteReader(command);
        }

        #region Exigencia Monto Incentivos
        public void InsIncentivosMontoExigencia(BEIncentivosMontoExigencia entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsIncentivosMontoExigencia");
            Context.Database.AddInParameter(command, "@MontoID", DbType.Int32, entidad.MontoID);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, entidad.CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, entidad.CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, entidad.CodigoZona);
            Context.Database.AddInParameter(command, "@Monto", DbType.Decimal, entidad.Monto);
            Context.Database.AddInParameter(command, "@AlcansoIncentivo", DbType.String, entidad.AlcansoIncentivo);
            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetIncentivosMontoExigencia(BEIncentivosMontoExigencia entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetIncentivosMontoExigencia");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, entidad.CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, entidad.CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, entidad.CodigoZona);
            return Context.ExecuteReader(command);
        }

        public void DelIncentivosMontoExigencia(BEIncentivosMontoExigencia entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelIncentivosMontoExigencia");
            Context.Database.AddInParameter(command, "@MontoID", DbType.Int32, entidad.MontoID);
            Context.ExecuteNonQuery(command);
        }

        public string GetMontoMinimoPorPais()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMontoMinimoPorPais");
            return Convert.ToString(Context.ExecuteScalar(command));
        }
        #endregion
    }
}