using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;

namespace Portal.Consultoras.Data
{
    public class DAResumenCampania : DataAccess
    {
        public DAResumenCampania(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPedidoWebAcumulado(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebAcumulado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetSaldoPendiente(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSaldoPendiente");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductosSolicitados(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductosSolicitados");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetValorAPagar(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetValorAPagar");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetFlexipago(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFlexipago");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetDeudaTotal(int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDeudaTotal");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);
            return Context.ExecuteReader(command);
        }

        public DateTime GetFechaVencimiento(string codigoIso, int campaniaId, string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFechaVencimiento");
            Context.Database.AddInParameter(command, "@CodigoIso", DbType.String, codigoIso);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);

            var resultado = Context.ExecuteScalar(command);

            resultado = resultado ?? "";

            DateTime fecha;

            var esFecha = DateTime.TryParse(resultado.ToString(), out fecha);

            return esFecha ? fecha : DateTime.MinValue;            
        }

    }
}
