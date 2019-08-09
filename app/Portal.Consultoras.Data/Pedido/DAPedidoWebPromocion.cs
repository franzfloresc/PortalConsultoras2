using Portal.Consultoras.Entities.Pedido;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Pedido
{
    public class DAPedidoWebPromocion : DataAccess
    {
        public DAPedidoWebPromocion(int paisId)
            : base(paisId, EDbSource.Portal)
        { }

        public IDataReader GetCondicionesByPromocion(BEPedidoWebPromocion BEPedidoWebPromocion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCondicionesByPromocion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoWebPromocion.CampaniaID);
            Context.Database.AddInParameter(command, "@CuvPromocion", DbType.String, BEPedidoWebPromocion.CuvPromocion);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPromocionesByCondicion(BEPedidoWebPromocion BEPedidoWebPromocion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPromocionesByCondicion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoWebPromocion.CampaniaID);
            Context.Database.AddInParameter(command, "@CuvCondicion", DbType.String, BEPedidoWebPromocion.CuvCondicion);
            return Context.ExecuteReader(command);
        }

        public bool InsertPedidoWebPromocion(BEPedidoWebPromocion BEPedidoWebPromocion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertPedidoWebPromocion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoWebPromocion.CampaniaID);
            Context.Database.AddInParameter(command, "@CuvCondicion", DbType.String, BEPedidoWebPromocion.CuvCondicion);
            Context.Database.AddInParameter(command, "@CuvPromocion", DbType.String, BEPedidoWebPromocion.CuvPromocion);
            return Convert.ToInt32(Context.ExecuteScalar(command)) > 0;
        }
    }
}
