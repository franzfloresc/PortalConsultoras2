﻿using System;
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
        OnPremise = 4,
        Cliente = 5
    }
    
    public abstract class DataAccess
    {
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
        }

        public DataAccess(EDbSource dbSource)
        {
            string connectionKey = dbSource.ToString();

            if (ExistInConfig(connectionKey))
            {
                context = new DbContext(connectionKey);
            }
        }

        private static bool ExistInConfig(string connectionStringName)
        {
            return ConfigurationManager.ConnectionStrings[connectionStringName] != null;
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