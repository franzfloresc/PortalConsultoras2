using System.Data;
using System.Data.Common;
using System.Runtime.Remoting.Contexts;

namespace Portal.Consultoras.Data
{
    public class DAPedidoRechazado : DataAccess
    {
        public DAPedidoRechazado(int paisID)
            : base(paisID, EDbSource.Portal)
        { }

        public int InsertarPedidoRechazadoXML(string estado, string mensaje, string xml)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GPR.InsertarPedidoRechazadoXML");
            Context.Database.AddInParameter(command, "@Estado", DbType.String, estado);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@PedidoRechazoXml", DbType.Xml, xml);
            return Context.ExecuteNonQuery(command);
        }
    }
}
