using Portal.Consultoras.Entities.Cupon;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DACuponConsultora: DataAccess
    {
        public DACuponConsultora(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCuponConsultoraByCodigoConsultoraCampaniaId(BECuponConsultora cuponConsultora)
        {
            try
            {
                using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId"))
                {
                    Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, cuponConsultora.CodigoConsultora);
                    Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cuponConsultora.CampaniaId);
                    return Context.ExecuteReader(command);
                }
            }
            catch (Exception ex)
            {
                throw ex;
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

    }
}
