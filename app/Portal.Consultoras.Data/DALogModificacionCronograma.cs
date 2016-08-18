using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DALogModificacionCronograma : DataAccess
    {
        public DALogModificacionCronograma(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetLogModificacionCronograma(int paisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetLogModificacionCronograma");
            return Context.ExecuteReader(command);
        }

        public int InsLogModificacionCronograma(string CodigoUsuario, BELogModificacionCronograma entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsLogModificacionCronograma");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, CodigoUsuario);
            Context.Database.AddInParameter(command, "@CodigosRegionZona", DbType.String, entidad.CodigosRegionZona);
            Context.Database.AddInParameter(command, "@DiasDuracionCronogramaAnterior", DbType.Int16, entidad.DiasDuracionCronogramaAnterior);
            Context.Database.AddInParameter(command, "@DiasDuracionCronogramaActual", DbType.Int16, entidad.DiasDuracionCronogramaActual);

            return Context.ExecuteNonQuery(command);
        }

    }
}
