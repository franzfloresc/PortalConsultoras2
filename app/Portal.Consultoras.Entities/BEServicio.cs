using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEServicio
    {
        [DataMember]
        public int ServicioId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Url { get; set; }
        [DataMember]
        public bool PaginaNueva { get; set; }
        [DataMember]
        public string PaginaNuevaDescripcion { get; set; }

        public BEServicio()
        {
        }

        public BEServicio(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ServicioId") && row["ServicioId"] != DBNull.Value)
                ServicioId = Convert.ToInt32(row["ServicioId"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Url") && row["Url"] != DBNull.Value)
                Url = Convert.ToString(row["Url"]);
            if (DataRecord.HasColumn(row, "PaginaNueva") && row["PaginaNueva"] != DBNull.Value)
                PaginaNueva = Convert.ToBoolean(row["PaginaNueva"]);
            if (DataRecord.HasColumn(row, "PaginaNuevaDescripcion") && row["PaginaNuevaDescripcion"] != DBNull.Value)
                PaginaNuevaDescripcion = Convert.ToString(row["PaginaNuevaDescripcion"]);
        }
    }
}
