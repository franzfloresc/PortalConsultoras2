using System.Data;
using System.Data.Common;
using System.Runtime.Remoting.Contexts;

namespace Portal.Consultoras.Data
{
    public class DAPedidoRechazado : DataAccess
    {
        public int InsertarPedidoRechazadoXML(string PaisISO, string xml)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GPR.InsertarPedidoRechazadoXML");
            Context.Database.AddInParameter(command, "@PaisISO", DbType.String, PaisISO);
            Context.Database.AddInParameter(command, "@PedidoRechazoXml", DbType.Xml, xml);
            return Context.ExecuteNonQuery(command);
        }
    }
}
