using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

// R2073 - Toda la clase
namespace Portal.Consultoras.Data
{
    public class DAPedidoFacturado : DataAccess
    {
        public DAPedidoFacturado(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPedidosFacturadosCabecera(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosFacturadosCabecera");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosFacturadosDetalle(string Campania, string Region, string Zona, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosFacturadosDetalle");
            Context.Database.AddInParameter(command, "@Campania", DbType.AnsiString, Campania);
            Context.Database.AddInParameter(command, "@Region", DbType.AnsiString, Region);
            Context.Database.AddInParameter(command, "@Zona", DbType.AnsiString, Zona);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            return Context.ExecuteReader(command);
        }

    }
}
