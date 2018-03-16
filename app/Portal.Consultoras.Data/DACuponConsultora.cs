using Portal.Consultoras.Entities.Cupon;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DACuponConsultora : DataAccess
    {
        public DACuponConsultora(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCuponConsultoraByCodigoConsultoraCampaniaId(BECuponConsultora cuponConsultora)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId"))
            {
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, cuponConsultora.CodigoConsultora);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cuponConsultora.CampaniaId);
                return Context.ExecuteReader(command);
            }

        }

        public void UpdateCuponConsultoraEstadoCupon(BECuponConsultora cuponConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateCuponConsultoraEstadoCupon");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, cuponConsultora.CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cuponConsultora.CampaniaId);
            Context.Database.AddInParameter(command, "@EstadoCupon", DbType.Int32, cuponConsultora.EstadoCupon);

            Context.ExecuteNonQuery(command);
        }

        public void UpdateCuponConsultoraEnvioCorreo(BECuponConsultora cuponConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateCuponConsultoraEnvioCorreo");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, cuponConsultora.CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cuponConsultora.CampaniaId);
            Context.Database.AddInParameter(command, "@EnvioCorreo", DbType.Boolean, cuponConsultora.EnvioCorreo);

            Context.ExecuteNonQuery(command);
        }

        public void CrearCuponConsultora(BECuponConsultora cuponConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CrearCuponConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, cuponConsultora.CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, cuponConsultora.CampaniaId);
            Context.Database.AddInParameter(command, "@CuponId", DbType.Int32, cuponConsultora.CuponId);
            Context.Database.AddInParameter(command, "@ValorAsociado", DbType.Decimal, cuponConsultora.ValorAsociado);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, cuponConsultora.UsuarioCreacion);

            Context.ExecuteNonQuery(command);
        }

        public void ActualizarCuponConsultora(BECuponConsultora cuponConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActualizarCuponConsultora");
            Context.Database.AddInParameter(command, "@CuponConsultoraId", DbType.Int32, cuponConsultora.CuponConsultoraId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, cuponConsultora.CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, cuponConsultora.CampaniaId);
            Context.Database.AddInParameter(command, "@CuponId", DbType.Int32, cuponConsultora.CuponId);
            Context.Database.AddInParameter(command, "@ValorAsociado", DbType.Decimal, cuponConsultora.ValorAsociado);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, cuponConsultora.UsuarioModificacion);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader ListarCuponConsultorasPorCupon(int paisId, int cuponId)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarCuponConsultorasPorCuponId"))
            {
                Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
                Context.Database.AddInParameter(command, "@CuponId", DbType.Int32, cuponId);

                return Context.ExecuteReader(command);
            }
        }

        public int InsertarCuponConsultorasXML(int cuponId, int campaniaId, string xml)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarCuponConsultoraCargaMasiva"))
            {
                Context.Database.AddInParameter(command, "@CuponId", DbType.Int32, cuponId);
                Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, campaniaId);
                Context.Database.AddInParameter(command, "@CuponConsultorasXml", DbType.Xml, xml);

                return Context.ExecuteNonQuery(command);
            }
        }
    }
}