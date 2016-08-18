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
    public enum EDbSource : int
    {
        Portal = 1,
        ODS = 2,
        Digitacion = 3,
        OnPremise = 4
    }
    
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

        public DataAccess(int paisID, EDbSource dbSource)
        {
            var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
            var element = section.Countries[paisID];
            string dbname = (dbSource == EDbSource.ODS) ? element.OdsName : (dbSource == EDbSource.Digitacion) ? element.DDName : (dbSource == EDbSource.OnPremise) ? element.OPName : element.DbName;
            this.context = new DbContext(dbname);

            /*if (logFileBaseName == null)
            {
                string logPath = ConfigurationManager.AppSettings["DataAccessErrorLogPath"];
                if (!string.IsNullOrEmpty(logPath))
                    logFileBaseName = System.IO.Path.Combine(logPath, "DataAccessErrors");
                else
                    logFileBaseName = string.Empty;
            }

            if (logFileBaseName != string.Empty)
                this.context.LogFileName = logFileBaseName + "-" + DateTime.Now.ToString("yyyyMMdd") + ".log";*/
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