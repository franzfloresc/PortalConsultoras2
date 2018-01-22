using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionParametroCarga : DataAccess
    {
        public DAConfiguracionParametroCarga(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCampaniasActivasConfiguracionParametroCarga(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniasActivas");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public int InsConfiguracionParametroCarga(BEConfiguracionParametroCarga entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConfiguracionParametroCarga");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, entidad.ZonaID);
            Context.Database.AddInParameter(command, "@ValidacionActiva", DbType.Boolean, entidad.ValidacionActiva);
            Context.Database.AddInParameter(command, "@DiasParametroCarga", DbType.Int16, entidad.DiasParametroCarga);
            return Context.ExecuteNonQuery(command);
        }

        public int DelConfiguracionParametroCarga(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelConfiguracionParametroCarga");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetRegionZonaDiasParametroCarga(int RegionID, int ZonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetRegionZonaParametroCargaJerarquia");
            Context.Database.AddInParameter(command, "@region", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@zona", DbType.Int32, ZonaID);

            return Context.ExecuteReader(command);
        }

        public int UpdConfiguracionParametroCargaPedido(BEConfiguracionParametroCarga entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdConfiguracionParametroCargaPedido");
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, entidad.ZonaID);
            Context.Database.AddInParameter(command, "@DiasParametroCarga", DbType.Int16, entidad.DiasParametroCarga);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetConfiguracionParametroCarga(int campaniaID, int zonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionParametroCarga");
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@zona", DbType.Int32, zonaID);

            return Context.ExecuteReader(command);
        }
    }
}
