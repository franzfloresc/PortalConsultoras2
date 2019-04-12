using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAContenidoAppResumen : DataAccess
    {
        public DAContenidoAppResumen(int paisId)
            : base(paisId, EDbSource.Portal)
        {

        }

        public IDataReader GetContenidoApp(string CodigoConsultora)
        {

            using (var command = Context.Database.GetStoredProcCommand("dbo.Lista_BannerAPP"))
            {
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);

                return Context.ExecuteReader(command);
            }
        }

        public void CheckContenidoApp(string CodigoConsultora, int idContenidoDetalle)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.MarcaContenidoVisto"))
            {
                Context.Database.AddInParameter(command, "@IdContenidoDeta", DbType.Int32, idContenidoDetalle);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);

                var reader = Context.ExecuteReader(command);

                var data = reader.RecordsAffected;

                reader.Close();
            }
        }
    }
}
