using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAProductoPalabra : DataAccess
    {
        public DAProductoPalabra(int paisID) : base(paisID, EDbSource.Portal) { }

        public Dictionary<string, long> GetByCampaniaID(int campaniaID)
        {
            DbCommand dbCommand = Context.Database.GetStoredProcCommand("dbo.GetProductoPalabraByCampaniaID", campaniaID);
            dbCommand.CommandTimeout = 300;

            var listPalabraConteo = new Dictionary<string, long>();
            using (IDataReader reader = Context.ExecuteReader(dbCommand))
            {
                while (reader.Read())
                {
                    listPalabraConteo.Add(Convert.ToString(reader["Palabra"]), Convert.ToInt64(reader["Conteo"]));
                }
            }
            return listPalabraConteo;
        }
    }
}