using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAEscalaDescuento : DataAccess
    {
        public DAEscalaDescuento(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetEscalaDescuento()
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetEscalaDescuento_SB2"))
            {
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetParametriaOfertaFinal(string algoritmo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetParametriaOfertaFinal_SB2");
            Context.Database.AddInParameter(command, "@Algoritmo", DbType.String, algoritmo);

            return Context.ExecuteReader(command);
        }

        public IDataReader ListarEscalaDescuentoZona(int campaniaID, string region, string zona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEscalaDescuentoZona");
            Context.Database.AddInParameter(command, "CampaniaId", DbType.String, campaniaID);
            Context.Database.AddInParameter(command, "CodRegion", DbType.String, region);
            Context.Database.AddInParameter(command, "CodZona", DbType.String, zona);
            return Context.ExecuteReader(command);
        }

    }
}