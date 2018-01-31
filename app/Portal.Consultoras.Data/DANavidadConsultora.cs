using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DANavidadConsultora : DataAccess
    {
        public DANavidadConsultora(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public int InsertarNavidadConsultora(BENavidadConsultora entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsNavidadConsultora");
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, entidad.PaisId);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, entidad.CampaniaId);
            Context.Database.AddInParameter(command, "@NombreImg", DbType.String, entidad.NombreImg);
            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int EliminarNavidadConsultora(BENavidadConsultora entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelNavidadConsultora");
            Context.Database.AddInParameter(command, "@ImagenId", DbType.Int32, entidad.ImagenId);
            return Context.ExecuteNonQuery(command);
        }

        public int EditarNavidadConsultora(BENavidadConsultora entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdNavidadConsultora");
            Context.Database.AddInParameter(command, "@ImagenId", DbType.Int32, entidad.ImagenId);
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, entidad.PaisId);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, entidad.CampaniaId);
            Context.Database.AddInParameter(command, "@NombreImg", DbType.String, entidad.NombreImg);
            return Context.ExecuteNonQuery(command);
        }

        public IDataReader BuscarNavidadConsultora(BENavidadConsultora entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNavidadConsultora");
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, entidad.PaisId);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, entidad.CampaniaId);
            return Context.ExecuteReader(command);
        }

        public IDataReader SeleccionarNavidadConsultora(BENavidadConsultora entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.SelNavidadConsultora");
            Context.Database.AddInParameter(command, "@ImagenId", DbType.Int32, entidad.ImagenId);
            return Context.ExecuteReader(command);
        }
    }
}
