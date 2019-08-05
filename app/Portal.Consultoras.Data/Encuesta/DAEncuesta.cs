using Portal.Consultoras.Entities.Encuesta;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Encuesta
{
    public class DAEncuesta :DataAccess
    {

        public DAEncuesta(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }
        #region Reporte
        public IDataReader GetReporteEncuestaSatisfaccion(BEEncuestaReporte bEncuesta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.EncuestaResultadoDetalle_List");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, bEncuesta.CodigoCampania);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, bEncuesta.RegionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, bEncuesta.ZonaID);
            return Context.ExecuteReader(command);
        }
        #endregion
        #region MisPedidos
        public IDataReader GetEncuestaByConsultora(BEEncuestaPedido bEncuesta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.EncuestaResultado_ListbyConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, bEncuesta.CodigoConsultora);
            return Context.ExecuteReader(command);
        }
        #endregion
        public IDataReader ObtenerDataEncuesta(string codigoConsultora,int verificarEncuestado)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerDataEncuesta");
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, codigoConsultora);
            Context.Database.AddInParameter(command, "VerificarEncuestado", DbType.Int32, verificarEncuestado);
            return Context.ExecuteReader(command);
        }
        public int InsEncuesta(BEEncuestaCalificacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarEncuesta");
            Context.Database.AddInParameter(command, "EncuestaId", DbType.Int32, entity.EncuestaId);
            Context.Database.AddInParameter(command, "EncuestaCalificacionId", DbType.Int32, entity.EncuestaCalificacionId);
            Context.Database.AddInParameter(command, "CanalId", DbType.Int32, entity.CanalId);
            Context.Database.AddInParameter(command, "CodigoCampania", DbType.String, entity.CodigoCampania);
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddInParameter(command, "CreatedBy", DbType.String, entity.CreatedBy);
            Context.Database.AddInParameter(command, "CreateHost", DbType.String, entity.CreateHost);
            Context.Database.AddInParameter(command, "XMLDetalle", DbType.Xml, entity.XMLMotivo);
            Context.Database.AddInParameter(command, "EncuestaCalificacionId", DbType.Int32, entity.EncuestaCalificacionId);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

    }
}
