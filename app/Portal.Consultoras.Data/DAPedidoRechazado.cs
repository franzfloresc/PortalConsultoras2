using System.Data;
using System.Data.Common;

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

        public int UpdatePedidoRechazadoVisualizado(long logGPRValidacionId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GPR.UpdLogGPRValidacionVisualizado");
            Context.Database.AddInParameter(command, "@ProcesoValidacionPedidoRechazadoID", DbType.Int64, logGPRValidacionId);
            return Context.ExecuteNonQuery(command);
        }
    }
}