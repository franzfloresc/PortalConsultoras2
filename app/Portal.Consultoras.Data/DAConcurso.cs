using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAConcurso : DataAccess
    {
        public DAConcurso(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader ObtenerConcursosXConsultora(string CodigoCampania, string CodigoConsultora, string CodigoRegion, string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerConcursosXConsultora");
            Context.Database.AddInParameter(command, "@CODIGOCAMPANIA", DbType.String, CodigoCampania);
            Context.Database.AddInParameter(command, "@CODIGOCONSULTORA", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CODIGOREGION", DbType.String, CodigoRegion);
            Context.Database.AddInParameter(command, "@CODIGOZONA", DbType.String, CodigoZona);
            return Context.ExecuteReader(command);
        }

        public void ActualizarInsertarPuntosConcurso(string CodigoConsultora, string CodigoCampania, string CodigoConcursos, string PuntosConcurso)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActualizarInsertarPuntosConcurso");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoConcurso", DbType.String, CodigoConcursos);
            Context.Database.AddInParameter(command, "@PuntosConcurso", DbType.String, PuntosConcurso);
            Context.ExecuteNonQuery(command);
        }

        public IDataReader ObtenerPuntosXConsultoraConcurso(string CodigoCampania, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPuntosXConsultoraConcurso");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, CodigoCampania);
            return Context.ExecuteReader(command);
        }
    }
}
