using Portal.Consultoras.Entities.RevistaDigital;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.RevistaDigital
{
    public class DARevistaDigitalSuscripcion : DataAccess
    {
        public DARevistaDigitalSuscripcion(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }
        
        public int Suscripcion(BERevistaDigitalSuscripcion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RevistaDigitalSuscripcion_Registro");

            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "EstadoRegistro", DbType.Int32, entity.EstadoRegistro);
            Context.Database.AddInParameter(command, "EstadoEnvio", DbType.Int32, entity.EstadoEnvio);
            Context.Database.AddInParameter(command, "Origen", DbType.String, entity.Origen);
            Context.Database.AddInParameter(command, "IsoPais", DbType.String, entity.IsoPais);
            Context.Database.AddInParameter(command, "CodigoZona", DbType.String, entity.CodigoZona);
            Context.Database.AddInParameter(command, "EMail", DbType.String, entity.EMail);
            Context.Database.AddInParameter(command, "CampaniaEfectiva", DbType.Int32, entity.CampaniaEfectiva);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 0);
            

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public int Desuscripcion(BERevistaDigitalSuscripcion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RevistaDigitalSuscripcion_Registro");

            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "EstadoRegistro", DbType.Int32, entity.EstadoRegistro);
            Context.Database.AddInParameter(command, "EstadoEnvio", DbType.Int32, entity.EstadoEnvio);
            Context.Database.AddInParameter(command, "Origen", DbType.String, entity.Origen);
            Context.Database.AddInParameter(command, "IsoPais", DbType.String, entity.IsoPais);
            Context.Database.AddInParameter(command, "CodigoZona", DbType.String, entity.CodigoZona);
            Context.Database.AddInParameter(command, "EMail", DbType.String, entity.EMail);
            Context.Database.AddInParameter(command, "CampaniaEfectiva", DbType.Int32, entity.CampaniaEfectiva);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);
            

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public IDataReader Single(BERevistaDigitalSuscripcion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RevistaDigitalSuscripcion_Single");
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader SingleActiva(BERevistaDigitalSuscripcion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RevistaDigitalSuscripcion_SingleActiva");
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);

            return Context.ExecuteReader(command);
        }
    }
}
