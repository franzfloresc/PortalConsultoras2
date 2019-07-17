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

        public IDataReader ObtenerDataEncuesta(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerDataEncuesta");
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, codigoConsultora);
            return Context.ExecuteReader(command);
        }
        public int InsEncuesta(BEEncuestaCalificacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarEncuesta");
            Context.Database.AddInParameter(command, "EncuestaId", DbType.Int32, entity.EncuestaId);
            Context.Database.AddInParameter(command, "CanalId", DbType.Int32, entity.CanalId);
            Context.Database.AddInParameter(command, "CodigoCampania", DbType.String, entity.CodigoCampania);
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddInParameter(command, "CreatedBy", DbType.String, entity.CreatedBy);
            Context.Database.AddInParameter(command, "CreateHost", DbType.String, entity.CreateHost);
            Context.Database.AddInParameter(command, "XMLDetalle", DbType.Xml, entity.XMLMotivo);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

    }
}
