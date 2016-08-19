using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraCatalogo : DataAccess
    {
        public DAConsultoraCatalogo(int paisID)
            : base(paisID, EDbSource.Portal)
        {
            //
        }

        public IDataReader GetConsultoraCatalogo(int pais, string codigoConsultora, bool parametroEsDocumento, int tipoFiltroUbigeo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraCatalogo");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int64, pais);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, codigoConsultora);
            Context.Database.AddInParameter(command, "@ParametroEsDocumento", DbType.Boolean, parametroEsDocumento);
            Context.Database.AddInParameter(command, "@TipoFiltroUbigeo", DbType.Int32, tipoFiltroUbigeo);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultorasCatalogosPorUbigeo(int paisId, string codigoUbigeo, int marcaId, int tipoFiltroUbigeo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultorasCatalogosPorUbigeo");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@CodigoUbigeo", DbType.String, codigoUbigeo);
            Context.Database.AddInParameter(command, "@MarcaId", DbType.Int32, marcaId);
            Context.Database.AddInParameter(command, "@tipoFiltroUbigeo", DbType.Int32, tipoFiltroUbigeo);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(int paisId, string codigoUbigeo, string nombres, string apellidos, int marcaId, int tipoFiltroUbigeo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@CodigoUbigeo", DbType.String, codigoUbigeo);
            Context.Database.AddInParameter(command, "@Nombres", DbType.String, nombres);
            Context.Database.AddInParameter(command, "@Apellidos", DbType.String, apellidos);
            Context.Database.AddInParameter(command, "@MarcaId", DbType.Int32, marcaId);
            Context.Database.AddInParameter(command, "@tipoFiltroUbigeo", DbType.Int32, tipoFiltroUbigeo);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos(int paisId, string codigoUbigeo, string nombres, string apellidos, int marcaId, int tipoFiltroUbigeo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@CodigoUbigeo", DbType.String, codigoUbigeo);
            Context.Database.AddInParameter(command, "@Nombres", DbType.String, nombres);
            Context.Database.AddInParameter(command, "@Apellidos", DbType.String, apellidos);
            Context.Database.AddInParameter(command, "@MarcaId", DbType.Int32, marcaId);
            Context.Database.AddInParameter(command, "@tipoFiltroUbigeo", DbType.Int32, tipoFiltroUbigeo);

            return Context.ExecuteReader(command);
        }
    }
}
