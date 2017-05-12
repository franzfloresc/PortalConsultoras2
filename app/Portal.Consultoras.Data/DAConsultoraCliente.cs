using System;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraCliente : DataAccess
    {
        public DAConsultoraCliente(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public long InsertConsultoraCliente(BEConsultoraCliente consultoraCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.InsertConsultoraCliente");

            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraCliente.ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, consultoraCliente.ClienteID);
            Context.Database.AddInParameter(command, "@Favorito", DbType.Int16, consultoraCliente.Favorito);

            return Convert.ToInt64(Context.ExecuteScalar(command));
        }

        public bool DeleteConsultoraCliente(long ConsultoraID, long ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.DeleteConsultoraCliente");

            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, ClienteID);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public List<BEAnotacion> GetConsultoraCliente(long ConsultoraID)
        {
            var list = new List<BEAnotacion>();

            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.GetConsultoraCliente");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            using (var reader = Context.ExecuteReader(command))
            {
                while (reader.Read())
                {
                    var entity = new BEAnotacion
                    {
                        ConsultoraClienteID = GetDataValue<long>(reader, "ConsultoraClienteID"),
                        ConsultoraID = GetDataValue<long>(reader, "ConsultoraID"),
                        ClienteID = GetDataValue<long>(reader, "ClienteID"),
                        Favorito = GetDataValue<short>(reader, "Favorito"),

                        AnotacionID = GetDataValue<long>(reader, "AnotacionID"),
                        Descripcion = GetDataValue<string>(reader, "Descripcion")
                    };

                    list.Add(entity);
                }
            }

            return list;
        }

        #region Anotacion
        public bool InsertAnotacion(BEAnotacion anotacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.InsertAnotacion");

            Context.Database.AddInParameter(command, "@ConsultoraClienteID", DbType.Int64, anotacion.ConsultoraClienteID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, anotacion.Descripcion);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public bool UpdateAnotacion(BEAnotacion anotacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.UpdateAnotacion");

            Context.Database.AddInParameter(command, "@AnotacionID", DbType.Int64, anotacion.AnotacionID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, anotacion.Descripcion);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public bool DeleteAnotacion(long AnotacionID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.DeleteAnotacion");

            Context.Database.AddInParameter(command, "@AnotacionID", DbType.Int64, AnotacionID);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public IDataReader GetAnotacion(long ConsultoraClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.GetAnotacion");
            Context.Database.AddInParameter(command, "@ConsultoraClienteID", DbType.Int64, ConsultoraClienteID);

            return Context.ExecuteReader(command);
        }
        #endregion
    }
}