using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DASuenioNavidad : DataAccess
    {
        public DASuenioNavidad(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader ListarSuenioNavidad(BESuenioNavidad entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarSuenioNavidad");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, entidad.CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public void RegistrarSuenioNavidad(BESuenioNavidad entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RegistrarSuenioNavidad");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, entidad.ConsultoraID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entidad.Descripcion);
            Context.Database.AddInParameter(command, "@Canal", DbType.AnsiString, entidad.Canal);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.AnsiString, entidad.UsuarioCreacion);

            Context.ExecuteNonQuery(command);
        }

        public int ValidarSuenioNavidad(BESuenioNavidad entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarSuenioNavidad");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, entidad.ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);

            return Convert.ToInt32(Context.ExecuteScalar(command).ToString());
        }

    }
}