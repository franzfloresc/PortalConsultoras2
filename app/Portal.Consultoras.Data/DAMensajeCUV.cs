using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAMensajeCUV : DataAccess
    {
        public DAMensajeCUV(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetMensajesCUVsByPaisAndCampania(int CampaniaID, int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMensajesCUVs");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public bool SetMensajesCUVsByPaisAndCampania(int parametroID, int paisID, int campaniaID, string mensaje, string cuvs)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.SetMensajesCUVs");
            Context.Database.AddInParameter(command, "@ParametroID", DbType.Int32, parametroID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@cuvs", DbType.String, cuvs);

            Context.ExecuteNonQuery(command);
            return true;
        }

        public void DeleteMensajesCUVsByPaisAndCampania(int parametroID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DeleteMensajesCUVs");
            Context.Database.AddInParameter(command, "@ParametroID", DbType.Int32, parametroID);

            Context.ExecuteNonQuery(command);
        }

        public BEMensajeCUV GetMensajeByCUV(int paisID, int campaniaID, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMensajesByCUV");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, cuv);

            IDataReader dr = Context.ExecuteReader(command);

            string mensaje = "";
            while (dr.Read())
            {
                mensaje = dr.GetString(0);
            }

            BEMensajeCUV beMensajeCuv = new BEMensajeCUV { Mensaje = mensaje };
            return beMensajeCuv;
        }

    }
}