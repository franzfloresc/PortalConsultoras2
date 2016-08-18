using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DACliente : DataAccess
    {
        public DACliente(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetClienteById(long ConsultoraID, int ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetClienteById");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int32, ClienteID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetClienteByNombre(long ConsultoraID, string Nombre)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetClienteByNombre");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, Nombre);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetClienteByConsultora(long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetClienteByConsultora");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public int InsCliente(BECliente cliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCliente");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, cliente.ConsultoraID);
            Context.Database.AddOutParameter(command, "@ClienteID", DbType.Int32, 4);
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, cliente.Nombre);
            Context.Database.AddInParameter(command, "@eMail", DbType.AnsiString, cliente.eMail);
            Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, cliente.Activo);
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, cliente.Telefono);//R20150903
            
            Context.ExecuteNonQuery(command);
            cliente.ClienteID = Convert.ToInt32(command.Parameters["@ClienteID"].Value);
            return cliente.ClienteID;
        }

        public int UpdCliente(BECliente cliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdCliente");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, cliente.ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int32, cliente.ClienteID);
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, cliente.Nombre);
            Context.Database.AddInParameter(command, "@eMail", DbType.AnsiString, cliente.eMail);
            Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, cliente.Activo);

            return Context.ExecuteNonQuery(command);
        }

        public int DelCliente(long ConsultoraID, int ClienteID, out bool Deleted)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCliente");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int32, ClienteID);
            Context.Database.AddOutParameter(command, "@Deleted", DbType.Boolean, 1);

            int result = Context.ExecuteNonQuery(command);
            Deleted = Convert.ToBoolean(command.Parameters["@Deleted"].Value);
            return result;
        }

        public int CheckClienteByConsultora(long ConsultoraID, string Nombre)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CheckClienteNombreByConsultora");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@Nombre", DbType.String, Nombre);

            int result = Convert.ToInt32(Context.ExecuteScalar(command));
            return result;
        }

        public int UndoCliente(long ConsultoraID, int ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UndoChangesCliente");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int32, ClienteID);

            return Context.ExecuteNonQuery(command);
        }

        public void InsCatalogoCampania(string CodigoConsultora, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.insCatalogoCampania");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CampaniaID);

            Context.ExecuteNonQuery(command);
        }
    }
}

