using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DADupla : DataAccess
    {
        public DADupla(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetDupla(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDupla");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Context.ExecuteReader(command);
        }

        public int InsDupla(BEDupla dupla)
        {
	        DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsDupla");
	        Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, dupla.CodigoUsuario);
	        Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, dupla.Nombre);
	        Context.Database.AddInParameter(command, "@SegundoNombre", DbType.AnsiString, dupla.SegundoNombre);
	        Context.Database.AddInParameter(command, "@ApellidoPaterno", DbType.AnsiString, dupla.ApellidoPaterno);
	        Context.Database.AddInParameter(command, "@ApellidoMaterno", DbType.AnsiString, dupla.ApellidoMaterno);
	        Context.Database.AddInParameter(command, "@Sobrenombre", DbType.AnsiString, dupla.Sobrenombre);
	        Context.Database.AddInParameter(command, "@FechaNacimiento", DbType.Date, dupla.FechaNacimiento);
	        Context.Database.AddInParameter(command, "@eMail", DbType.AnsiString, dupla.eMail);
	        Context.Database.AddInParameter(command, "@Sexo", DbType.AnsiString, dupla.Sexo);
	        Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, dupla.Telefono);
	        Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, dupla.Celular);
	        Context.Database.AddInParameter(command, "@Direccion", DbType.AnsiString, dupla.Direccion);
	        Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, dupla.Activo);

	        return Context.ExecuteNonQuery(command);
        }

        public int UpdDupla(BEDupla dupla)
        {
	        DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdDupla");
	        Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, dupla.CodigoUsuario);
	        Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, dupla.Nombre);
	        Context.Database.AddInParameter(command, "@SegundoNombre", DbType.AnsiString, dupla.SegundoNombre);
	        Context.Database.AddInParameter(command, "@ApellidoPaterno", DbType.AnsiString, dupla.ApellidoPaterno);
	        Context.Database.AddInParameter(command, "@ApellidoMaterno", DbType.AnsiString, dupla.ApellidoMaterno);
	        Context.Database.AddInParameter(command, "@Sobrenombre", DbType.AnsiString, dupla.Sobrenombre);
	        Context.Database.AddInParameter(command, "@FechaNacimiento", DbType.Date, dupla.FechaNacimiento);
	        Context.Database.AddInParameter(command, "@eMail", DbType.AnsiString, dupla.eMail);
	        Context.Database.AddInParameter(command, "@Sexo", DbType.AnsiString, dupla.Sexo);
	        Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, dupla.Telefono);
	        Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, dupla.Celular);
	        Context.Database.AddInParameter(command, "@Direccion", DbType.AnsiString, dupla.Direccion);
	        Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, dupla.Activo);

	        return Context.ExecuteNonQuery(command);
        }
    }
}
