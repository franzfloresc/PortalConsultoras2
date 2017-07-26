using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;

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
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEscalaDescuento_SB2");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetParametriaOfertaFinal(string algoritmo)
        {            
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetParametriaOfertaFinal_SB2");
            Context.Database.AddInParameter(command, "@Algoritmo", DbType.String, algoritmo);

            return Context.ExecuteReader(command);
        }        
    }
}
