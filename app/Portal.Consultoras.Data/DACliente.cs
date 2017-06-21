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

        public IDataReader GetClienteByCodigo(long ConsultoraID, int ClienteID, long CodigoCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetClienteByCodigo");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int32, ClienteID);
            Context.Database.AddInParameter(command, "@CodigoCliente", DbType.Int64, CodigoCliente);

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
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, cliente.Celular);
            Context.Database.AddInParameter(command, "@CodigoCliente", DbType.Int64, cliente.CodigoCliente);
            Context.Database.AddInParameter(command, "@Favorito", DbType.Int16, cliente.Favorito);
            Context.Database.AddInParameter(command, "@TipoContactoFavorito", DbType.Int16, cliente.TipoContactoFavorito);

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
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, cliente.Telefono);
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, cliente.Celular);
            Context.Database.AddInParameter(command, "@CodigoCliente", DbType.Int64, cliente.CodigoCliente);
            Context.Database.AddInParameter(command, "@Favorito", DbType.Int16, cliente.Favorito);
            Context.Database.AddInParameter(command, "@TipoContactoFavorito", DbType.Int16, cliente.TipoContactoFavorito);

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

        public bool MovimientoInsertar(BEMovimiento movimiento)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ClienteMovimiento_Insertar"))
            {
                command.CommandType = CommandType.StoredProcedure;

                Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, movimiento.ConsultoraId);
                Context.Database.AddInParameter(command, "@ClienteId", DbType.Int16, movimiento.ClienteId);
                Context.Database.AddInParameter(command, "@CodigoCliente", DbType.Int64, movimiento.CodigoCliente);
                Context.Database.AddInParameter(command, "@Monto", DbType.Decimal, movimiento.Monto);
                Context.Database.AddInParameter(command, "@TipoMovimiento", DbType.String, movimiento.TipoMovimiento);
                Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, movimiento.Fecha);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, movimiento.Descripcion);
                Context.Database.AddInParameter(command, "@Nota", DbType.String, movimiento.Nota);

                using (var reader = Context.ExecuteReader(command))
                {
                    return reader.RecordsAffected == 1;
                }
            }
        }

        public bool MovimientoActualizar(BEMovimiento movimiento)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ClienteMovimiento_Actualizar"))
            {
                command.CommandType = CommandType.StoredProcedure;

                Context.Database.AddInParameter(command, "@ClienteMovimientoId", DbType.Int32, movimiento.ClienteMovimientoId);
                Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, movimiento.ConsultoraId);
                Context.Database.AddInParameter(command, "@ClienteId", DbType.Int16, movimiento.ClienteId);
                Context.Database.AddInParameter(command, "@CodigoCliente", DbType.Int64, movimiento.CodigoCliente);                
                Context.Database.AddInParameter(command, "@Monto", DbType.Decimal, movimiento.Monto);
                Context.Database.AddInParameter(command, "@TipoMovimiento", DbType.String, movimiento.TipoMovimiento);
                Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, movimiento.Fecha);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, movimiento.Descripcion);
                Context.Database.AddInParameter(command, "@Nota", DbType.String, movimiento.Nota);

                using (var reader = Context.ExecuteReader(command))
                {
                    return reader.RecordsAffected == 1;
                }
            }
        }

        public IDataReader MovimientosListar(short clienteId, long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ClienteMovimiento_Listar");

            command.CommandType = CommandType.StoredProcedure;

            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, consultoraId);
            Context.Database.AddInParameter(command, "@ClienteId", DbType.Int16, clienteId);

            return Context.ExecuteReader(command);
        }


        public bool RecordatorioInsertar(BEClienteRecordatorio recordatorio)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ClienteRecordatorio_Insertar"))
            {
                command.CommandType = CommandType.StoredProcedure;

                Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, recordatorio.ConsultoraId);
                Context.Database.AddInParameter(command, "@ClienteId", DbType.Int16, recordatorio.ClienteId);
                Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, recordatorio.Fecha);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, recordatorio.Descripcion);

                using (var reader = Context.ExecuteReader(command))
                {
                    return reader.RecordsAffected == 1;
                }
            }
        }

        public IDataReader RecordatorioObtener(short clienteId, long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ClienteRecordatorio_Listar");

            command.CommandType = CommandType.StoredProcedure;

            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, consultoraId);
            Context.Database.AddInParameter(command, "@ClienteId", DbType.Int16, clienteId);

            return Context.ExecuteReader(command);
        }


        public bool RecordatorioActualizar(BEClienteRecordatorio recordatorio)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ClienteRecordatorio_Actualizar"))
            {
                command.CommandType = CommandType.StoredProcedure;

                Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, recordatorio.ConsultoraId);
                Context.Database.AddInParameter(command, "@ClienteId", DbType.Int16, recordatorio.ClienteId);
                Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, recordatorio.Fecha);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, recordatorio.Descripcion);

                using (var reader = Context.ExecuteReader(command))
                {
                    return reader.RecordsAffected == 1;
                }
            }
        }
        
        public bool RecordatorioEliminar(short clienteId, long consultoraId, int recordatorioId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ClienteRecordatorio_Eliminar"))
            {
                command.CommandType = CommandType.StoredProcedure;

                Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, consultoraId);
                Context.Database.AddInParameter(command, "@ClienteId", DbType.Int16, clienteId);
                Context.Database.AddInParameter(command, "@ClienteRecordatorioId", DbType.Int16, recordatorioId);

                using (var reader = Context.ExecuteReader(command))
                {
                    return reader.RecordsAffected == 1;
                }
            }
        }

    }
}

