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

        public IDataReader GetBannerCodigo(string codigo, BEUsuario itmFilter)
        {

            using (var command = Context.Database.GetStoredProcCommand("[dbo].Lista_BannerLanzamientoAPP"))
            {
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, itmFilter.CodigoConsultora);
                Context.Database.AddInParameter(command, "@Codigo", DbType.String, codigo);
                Context.Database.AddInParameter(command, "@Capania", DbType.String, itmFilter.CampaniaID);
                Context.Database.AddInParameter(command, "@Zona", DbType.String, itmFilter.CodigoZona);
                Context.Database.AddInParameter(command, "@Region", DbType.String, itmFilter.CodigorRegion);
                Context.Database.AddInParameter(command, "@Seccion", DbType.String, itmFilter.Seccion);

                return Context.ExecuteReader(command);
            }
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

                Context.ExecuteNonQuery(command);
            }
        }
    }
}
