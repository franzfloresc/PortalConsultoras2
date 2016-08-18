using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

//R2004
namespace Portal.Consultoras.Data
{
    public class DAComunicado : DataAccess
    {
        public DAComunicado(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetComunicadoByConsultora(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetComunicadoByConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public void UpdComunicadoByConsultora(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdComunicadoByConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            Context.ExecuteNonQuery(command);
        }

        /*GR-1209*/
        public IDataReader ObtenerComunicadoPorConsultora(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerComunicadoPorConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }
        public void InsertComunicadoByConsultoraVisualizacion(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertComunicadoByConsultoraVisualizacion");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.ExecuteNonQuery(command);
        }

    }
}

