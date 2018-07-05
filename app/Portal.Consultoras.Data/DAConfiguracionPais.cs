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
            using (var command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPais_GetAll"))
            {
                Context.Database.AddInParameter(command, "DesdeCampania", DbType.Int32, entity.DesdeCampania);
                Context.Database.AddInParameter(command, "Codigo", DbType.String, entity.Codigo);
                Context.Database.AddInParameter(command, "CodigoRegion", DbType.String, entity.Detalle.CodigoRegion);
                Context.Database.AddInParameter(command, "CodigoZona", DbType.String, entity.Detalle.CodigoZona);
                Context.Database.AddInParameter(command, "CodigoSeccion", DbType.String, entity.Detalle.CodigoSeccion);
                Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.Detalle.CodigoConsultora);

                return Context.ExecuteReader(command);
            }
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

        public IDataReader Get(string codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPais_GetByCode");
            Context.Database.AddInParameter(command, "Codigo", DbType.String, codigo);
            return Context.ExecuteReader(command);
        }

        public IDataReader Update(BEConfiguracionPais entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPaisUpdate");
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.Int32, entity.ConfiguracionPaisID);
            Context.Database.AddInParameter(command, "Excluyente", DbType.Boolean, entity.Excluyente);
            Context.Database.AddInParameter(command, "Estado", DbType.Boolean, entity.Estado);
            Context.Database.AddInParameter(command, "DesdeCampania", DbType.Int32, entity.DesdeCampania);
            Context.Database.AddInParameter(command, "MobileTituloMenu", DbType.String, entity.MobileTituloMenu);
            Context.Database.AddInParameter(command, "DesktopTituloMenu", DbType.String, entity.DesktopTituloMenu);
            Context.Database.AddInParameter(command, "Logo", DbType.String, entity.Logo);
            Context.Database.AddInParameter(command, "Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "DesktopTituloBanner", DbType.String, entity.DesktopTituloBanner);
            Context.Database.AddInParameter(command, "MobileTituloBanner", DbType.String, entity.MobileTituloBanner);
            Context.Database.AddInParameter(command, "DesktopSubTituloBanner", DbType.String, entity.DesktopSubTituloBanner);
            Context.Database.AddInParameter(command, "MobileSubTituloBanner", DbType.String, entity.MobileSubTituloBanner);
            Context.Database.AddInParameter(command, "DesktopFondoBanner", DbType.String, entity.DesktopFondoBanner);
            Context.Database.AddInParameter(command, "MobileFondoBanner", DbType.String, entity.MobileFondoBanner);
            Context.Database.AddInParameter(command, "DesktopLogoBanner", DbType.String, entity.DesktopLogoBanner);
            Context.Database.AddInParameter(command, "MobileLogoBanner", DbType.String, entity.MobileLogoBanner);
            Context.Database.AddInParameter(command, "UrlMenu", DbType.String, entity.UrlMenu);
            Context.Database.AddInParameter(command, "OrdenBpt", DbType.Int32, entity.OrdenBpt);
            Context.Database.AddInParameter(command, "MobileOrden", DbType.Int32, entity.MobileOrden);
            Context.Database.AddInParameter(command, "MobileOrdenBPT", DbType.Int32, entity.MobileOrdenBpt);
            return Context.ExecuteReader(command);
        }
    }
}