using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;

namespace Portal.Consultoras.Data
{
    public abstract class DataAccess
    {
        //private static string logFileBaseName = null;
        private DbContext context;

        public DataAccess(DataAccess dataAccess)
        {
            context = dataAccess.context;
        }

        public DataAccess()
        {
            this.context = new DbContext();
        }

        public DataAccess(string paisIso)
        {
            string cadenaConexion = paisIso == ""
                ? "ConnectionCatalogo"
                : "Connection" + paisIso;

            this.context = new DbContext(cadenaConexion);
        }

        public DbContext Context
        {
            get { return context; }
        }

        public int NextValueForSequence(string sequenceName)
        {
            return this.NextValueForSequence(sequenceName, "dbo");
        }
        public int NextValueForSequence(string sequenceName, string schemaName)
        {
            string sequence = "[" + schemaName + "].[" + sequenceName + "]";
            DbCommand command = Context.Database.GetSqlStringCommand("SELECT NEXT VALUE FOR " + sequence);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        protected T GetDataValue<T>(IDataReader dr, string columnName)
        {
            var i = dr.GetOrdinal(columnName);

            if (!dr.IsDBNull(i))
                return (T)dr.GetValue(i);
            return default(T);
        }

        protected T GetDataValue<T>(object[] values, int posCol)
        {
            if (values.Length > posCol && values[posCol] != null)
                return (T)values[posCol];
            return default(T);
        }
    }
}