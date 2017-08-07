using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionPais : DataAccess
    {
        public DAConfiguracionPais(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetList(BEConfiguracionPais entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPais_GetAll");
            Context.Database.AddInParameter(command, "Codigo", DbType.String, entity.Codigo);
            Context.Database.AddInParameter(command, "CodigoRegion", DbType.String, entity.Detalle.CodigoRegion);
            Context.Database.AddInParameter(command, "CodigoZona", DbType.String, entity.Detalle.CodigoZona);
            Context.Database.AddInParameter(command, "CodigoSeccion", DbType.String, entity.Detalle.CodigoSeccion);
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.Detalle.CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetList(bool tienePerfil)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPaisList");
            Context.Database.AddInParameter(command, "TienePerfil", DbType.Boolean, tienePerfil);
            return Context.ExecuteReader(command);
        }

        public IDataReader Get(int configuracionPaisId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPaisGet");
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.Int32, configuracionPaisId);
            return Context.ExecuteReader(command);
        }

        public IDataReader Update(BEConfiguracionPais entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPaisUpdate");
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.Int32, entity.ConfiguracionPaisID);
            Context.Database.AddInParameter(command, "Codigo", DbType.Boolean, entity.Codigo);
            Context.Database.AddInParameter(command, "Excluyente", DbType.Boolean, entity.Excluyente);
            Context.Database.AddInParameter(command, "Descripcion", DbType.String, entity.Descripcion);
            Context.Database.AddInParameter(command, "Estado", DbType.Boolean, entity.Estado);
            Context.Database.AddInParameter(command, "TienePerfil", DbType.Boolean, entity.TienePerfil);
            Context.Database.AddInParameter(command, "DesdeCampania", DbType.Int32, entity.DesdeCampania);
            Context.Database.AddInParameter(command, "TipoEstrategia", DbType.String, entity.TipoEstrategia);
            Context.Database.AddInParameter(command, "MostrarCampaniaSiguiente", DbType.Boolean, entity.MostrarCampaniaSiguiente);
            Context.Database.AddInParameter(command, "MostrarPagInformativa", DbType.Boolean, entity.MostrarPagInformativa);
            Context.Database.AddInParameter(command, "HImagenFondo", DbType.String, entity.HImagenFondo);
            Context.Database.AddInParameter(command, "HTipoPresentacion", DbType.Int32, entity.HTipoPresentacion);
            Context.Database.AddInParameter(command, "HMaxProductos", DbType.Int32, entity.HMaxProductos);
            Context.Database.AddInParameter(command, "HTipoEstrategia", DbType.String, entity.HTipoEstrategia);

            return Context.ExecuteReader(command);
        }
    }
}
