using System;
using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BaseEntidad
    {
        [DataMember]
        public int PaisID { get; set; }

        public object GetField(IDataRecord row, string field)
        {
            if (row.HasColumn(field) && row[field] != DBNull.Value) return row[field];
            return new object();
        }
        public string GetFieldString(IDataRecord row, string field)
        {
            return Convert.ToString(GetField(row, field));
        }
        public int GetFieldInt(IDataRecord row, string field)
        {
            return Convert.ToInt32(GetField(row, field));
        }
        public short GetFieldShort(IDataRecord row, string field)
        {
            return Convert.ToInt16(GetField(row, field));
        }
        public DateTime GetFieldDate(IDataRecord row, string field)
        {
            return Convert.ToDateTime(GetField(row, field));
        }
        public decimal GetFieldDecimal(IDataRecord row, string field)
        {
            return Convert.ToDecimal(GetField(row, field));
        }
        public bool GetFieldBool(IDataRecord row, string field)
        {
            return Convert.ToBoolean(GetField(row, field));
        }
    }
}
