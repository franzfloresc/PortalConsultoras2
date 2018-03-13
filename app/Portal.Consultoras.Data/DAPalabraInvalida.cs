using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPalabraInvalida : DataAccess
    {
        public DAPalabraInvalida(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public List<string> GetAll()
        {
            var listTexto = new List<string>();
            using (DbCommand dbCommand = Context.Database.GetStoredProcCommand("dbo.GetAllPalabraInvalida"))
            {
                using (IDataReader reader = Context.Database.ExecuteReader(dbCommand))
                {
                    while (reader.Read()) listTexto.Add(Convert.ToString(reader["Palabra"]));
                }
            }
            return listTexto;
        }
    }
}