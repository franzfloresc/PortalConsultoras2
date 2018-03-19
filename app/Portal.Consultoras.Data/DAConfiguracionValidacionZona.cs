using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionValidacionZona : DataAccess
    {
        public DAConfiguracionValidacionZona(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCampaniasActivas(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniasActivas");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public int InsConfiguracionValidacionZona(BEConfiguracionValidacionZona entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConfiguracionValidacionZona");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, entidad.ZonaID);
            Context.Database.AddInParameter(command, "@ValidacionActiva", DbType.Boolean, entidad.ValidacionActiva);
            Context.Database.AddInParameter(command, "@DiasDuracionCronograma", DbType.Int16, entidad.DiasDuracionCronograma);
            return Context.ExecuteNonQuery(command);
        }

        public int DelConfiguracionValidacionZona(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelConfiguracionValidacionZona");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetRegionZonaDiasDuracionCronograma(int RegionID, int ZonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetRegionZonaCronogramaJerarquia");
            Context.Database.AddInParameter(command, "@region", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@zona", DbType.Int32, ZonaID);

            return Context.ExecuteReader(command);
        }

        public int UpdConfiguracionValidacionZonaCronograma(BEConfiguracionValidacionZona entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdConfiguracionValidacionZonaCronograma");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, entidad.ZonaID);
            Context.Database.AddInParameter(command, "@DiasDuracionCronograma", DbType.Int16, entidad.DiasDuracionCronograma);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetConfiguracionValidacionZona(int campaniaID, int zonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionValidacionZona");
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@zona", DbType.Int32, zonaID);

            return Context.ExecuteReader(command);
        }
    }
}