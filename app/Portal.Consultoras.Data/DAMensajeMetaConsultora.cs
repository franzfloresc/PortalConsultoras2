using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAMensajeMetaConsultora : DataAccess
    {
        public DAMensajeMetaConsultora(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetMensajeMetaConsultora(BEMensajeMetaConsultora entidad)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetMensajeMetaConsultoras_SB2"))
            {
                Context.Database.AddInParameter(command, "@TipoMensaje", DbType.String, entidad.TipoMensaje);

                return Context.ExecuteReader(command);
            }
        }
    }
}