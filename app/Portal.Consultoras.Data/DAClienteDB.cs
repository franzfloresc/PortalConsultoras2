using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAClienteDB : DataAccess
    {
        public DAClienteDB()
            : base(EDbSource.Cliente)
        {

        }

        #region Cliente
        public long InsertCliente(BEClienteDB cliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertCliente");

            Context.Database.AddInParameter(command, "@Apellidos", DbType.String, cliente.Apellidos);
            Context.Database.AddInParameter(command, "@Nombres", DbType.String, cliente.Nombres);
            Context.Database.AddInParameter(command, "@Alias", DbType.String, cliente.Alias);
            Context.Database.AddInParameter(command, "@Foto", DbType.String, cliente.Foto);
            Context.Database.AddInParameter(command, "@FechaNacimiento", DbType.String, cliente.FechaNacimiento);
            Context.Database.AddInParameter(command, "@Sexo", DbType.String, cliente.Sexo);
            Context.Database.AddInParameter(command, "@Documento", DbType.String, cliente.Documento);
            Context.Database.AddInParameter(command, "@Origen", DbType.String, cliente.Origen);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int16, cliente.PaisID);

            return Convert.ToInt64(Context.ExecuteScalar(command));
        }

        public bool UpdateCliente(BEClienteDB cliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateCliente");

            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, cliente.CodigoCliente);
            Context.Database.AddInParameter(command, "@Apellidos", DbType.String, cliente.Apellidos);
            Context.Database.AddInParameter(command, "@Nombres", DbType.String, cliente.Nombres);
            Context.Database.AddInParameter(command, "@Alias", DbType.String, cliente.Alias);
            Context.Database.AddInParameter(command, "@Foto", DbType.String, cliente.Foto);
            Context.Database.AddInParameter(command, "@FechaNacimiento", DbType.String, cliente.FechaNacimiento);
            Context.Database.AddInParameter(command, "@Sexo", DbType.String, cliente.Sexo);
            Context.Database.AddInParameter(command, "@Documento", DbType.String, cliente.Documento);
            Context.Database.AddInParameter(command, "@Origen", DbType.String, cliente.Origen);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int16, cliente.PaisID);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public List<BEClienteDB> GetCliente(short TipoContactoID, string Valor, int PaisID)
        {
            var list = new List<BEClienteDB>();

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCliente");

            Context.Database.AddInParameter(command, "@TipoContactoID", DbType.Int16, TipoContactoID);
            Context.Database.AddInParameter(command, "@Valor", DbType.String, Valor);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int16, PaisID);

            using (var reader = Context.ExecuteReader(command))
            {
                while (reader.Read())
                {
                    var entity = new BEClienteDB
                    {
                        CodigoCliente = GetDataValue<long>(reader, "ClienteID"),
                        Apellidos = GetDataValue<string>(reader, "Apellidos"),
                        Nombres = GetDataValue<string>(reader, "Nombres"),
                        Alias = GetDataValue<string>(reader, "Alias"),
                        Foto = GetDataValue<string>(reader, "Foto"),
                        FechaNacimiento = GetDataValue<string>(reader, "FechaNacimiento"),
                        Sexo = GetDataValue<string>(reader, "Sexo"),
                        Documento = GetDataValue<string>(reader, "Documento"),
                        Origen = GetDataValue<string>(reader, "Origen"),
                    };

                    list.Add(entity);
                }
            }

            return list;
        }

        public List<BEClienteContactoDB> GetClienteByClienteID(string Clientes, int PaisID)
        {
            var list = new List<BEClienteContactoDB>();

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetClienteByClienteID");

            Context.Database.AddInParameter(command, "@Clientes", DbType.String, Clientes);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int16, PaisID);

            using (var reader = Context.ExecuteReader(command))
            {
                while (reader.Read())
                {
                    var entity = new BEClienteContactoDB
                    {
                        CodigoCliente = GetDataValue<long>(reader, "ClienteID"),
                        Apellidos = GetDataValue<string>(reader, "Apellidos"),
                        Nombres = GetDataValue<string>(reader, "Nombres"),
                        Alias = GetDataValue<string>(reader, "Alias"),
                        Foto = GetDataValue<string>(reader, "Foto"),
                        FechaNacimiento = GetDataValue<string>(reader, "FechaNacimiento"),
                        Sexo = GetDataValue<string>(reader, "Sexo"),
                        Documento = GetDataValue<string>(reader, "Documento"),
                        Origen = GetDataValue<string>(reader, "Origen"),

                        ContactoClienteID = GetDataValue<long>(reader, "ContactoClienteID"),
                        TipoContactoID = GetDataValue<short>(reader, "TipoContactoID"),
                        Valor = GetDataValue<string>(reader, "Valor")
                    };

                    list.Add(entity);
                }
            }

            return list;
        }
        #endregion

        #region Contacto
        public long InsertContactoCliente(BEClienteContactoDB contactoCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertContactoCliente");

            Context.Database.AddInParameter(command, "@TipoContactoID", DbType.Int16, contactoCliente.TipoContactoID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, contactoCliente.CodigoCliente);
            Context.Database.AddInParameter(command, "@Valor", DbType.String, contactoCliente.Valor);

            return Convert.ToInt64(Context.ExecuteScalar(command));
        }

        public bool UpdateContactoCliente(BEClienteContactoDB contactoCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateContactoCliente");

            Context.Database.AddInParameter(command, "@TipoContactoID", DbType.Int16, contactoCliente.TipoContactoID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, contactoCliente.CodigoCliente);
            Context.Database.AddInParameter(command, "@Valor", DbType.String, contactoCliente.Valor);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public List<BEClienteContactoDB> GetContactoCliente(BEClienteContactoDB contactoCliente)
        {
            var list = new List<BEClienteContactoDB>();

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetContactoCliente");

            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, contactoCliente.CodigoCliente);
            Context.Database.AddInParameter(command, "@TipoContactoID", DbType.Int16, contactoCliente.TipoContactoID);

            using (var reader = Context.ExecuteReader(command))
            {
                while (reader.Read())
                {
                    var entity = new BEClienteContactoDB
                    {
                        ContactoClienteID = GetDataValue<long>(reader, "ContactoClienteID"),
                        TipoContactoID = GetDataValue<short>(reader, "TipoContactoID"),
                        CodigoCliente = GetDataValue<long>(reader, "ClienteID"),
                        Valor = GetDataValue<string>(reader, "Valor")
                    };

                    list.Add(entity);
                }
            }

            return list;
        }
        #endregion
    }
}
