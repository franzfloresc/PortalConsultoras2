using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionPortal : DataAccess
    {
        public DAConfiguracionPortal(int paisID)
            : base(paisID, EDbSource.Portal)
        { }

        public IDataReader ObtenerConfiguracionPortal(int paisID)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("GetConfiguracionPortal"))
            {
                Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
                return Context.ExecuteReader(command);
            }
        }

        public int ActualizarConfiguracionPortal(BEConfiguracionPortal ConfiguracionPortal)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdConfiguracionPortal");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, ConfiguracionPortal.PaisID);
            Context.Database.AddInParameter(command, "@EsquemaDAConsultora", DbType.Byte, ConfiguracionPortal.EsquemaDAConsultora);
            Context.Database.AddInParameter(command, "@EstadoSimplificacionCUV", DbType.Byte, ConfiguracionPortal.EstadoSimplificacionCUV);
            Context.Database.AddInParameter(command, "@TipoProcesoCarga", DbType.Byte, ConfiguracionPortal.TipoProcesoCarga);

            return Context.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Obtener la configuracion de los pedidos asociados para Pack Nuevas.
        /// </summary>
        /// <param name="CodigoPrograma"></param>
        /// <returns></returns>
        public IDataReader ObtenerConfiguracionPackNueva(string CodigoPrograma)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("GetConfiguracionPackNueva"))
            {
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, CodigoPrograma);
                return Context.ExecuteReader(command);
            }
        }

    }
}
