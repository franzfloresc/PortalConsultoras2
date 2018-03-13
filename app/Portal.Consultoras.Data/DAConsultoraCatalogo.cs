using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraCatalogo : DataAccess
    {
        public DAConsultoraCatalogo(int paisID)
            : base(paisID, EDbSource.Portal)
        {
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

        public int InsLogClienteRegistraConsultoraCatalogo(int consultoraId, string codigoConsultora,
            int campaniaId, string tipoBusqueda, int conoceConsultora, string codigoDispositivo, string soDispotivivo,
            string unidadGeo1, string unidadGeo2, string unidadGeo3, string nombreCliente, string emailCliente,
            string telefonoCliente, int nuevaConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("AppCatalogos.InsLogClienteRegistraConsultora");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@TipoBusqueda", DbType.String, tipoBusqueda);
            Context.Database.AddInParameter(command, "@ConoceConsultora", DbType.Int32, conoceConsultora);
            Context.Database.AddInParameter(command, "@CodigoDispositivo", DbType.String, codigoDispositivo);
            Context.Database.AddInParameter(command, "@SODispositivo", DbType.String, soDispotivivo);
            Context.Database.AddInParameter(command, "@UnidadGeo1", DbType.String, unidadGeo1);
            Context.Database.AddInParameter(command, "@UnidadGeo2", DbType.String, unidadGeo2);
            Context.Database.AddInParameter(command, "@UnidadGeo3", DbType.String, unidadGeo3);
            Context.Database.AddInParameter(command, "@NombreCliente", DbType.String, nombreCliente);
            Context.Database.AddInParameter(command, "@EmailCliente", DbType.String, emailCliente);
            Context.Database.AddInParameter(command, "@TelefonoCliente", DbType.String, telefonoCliente);
            Context.Database.AddInParameter(command, "@NuevaConsultora", DbType.Int32, nuevaConsultora);
            Context.Database.AddOutParameter(command, "@IdRegistro", DbType.Int32, 0);

            Context.ExecuteNonQuery(command);

            return (int)Context.Database.GetParameterValue(command, "@IdRegistro");

        }
    }
}