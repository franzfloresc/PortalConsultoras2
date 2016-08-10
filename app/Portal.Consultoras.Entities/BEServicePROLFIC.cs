using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEServicePROLFIC
    {
        [DataMember]
        public string PAIS { get; set; }
        [DataMember]
        public string PERIODO { get; set; }
        [DataMember]
        public string ZONA { get; set; }
        [DataMember]
        public string CUENTA { get; set; }
        [DataMember]
        public string COD_ESTR { get; set; }
        [DataMember]
        public string VAL_I18N { get; set; }
        [DataMember]
        public string NUM_OFER { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string TIPO_OFETA { get; set; }
        [DataMember]
        public string UNIDADES { get; set; }
        [DataMember]
        public string VENTA_NETA { get; set; }
        [DataMember]
        public string PRODUCTO { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        public BEServicePROLFIC()
        { }

        public BEServicePROLFIC(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "PAIS"))
                PAIS = Convert.ToString(row["PAIS"]);
            if (DataRecord.HasColumn(row, "PERIODO"))
                PERIODO = Convert.ToString(row["PERIODO"]);
            if (DataRecord.HasColumn(row, "ZONA"))
                ZONA = Convert.ToString(row["ZONA"]);
            if (DataRecord.HasColumn(row, "CUENTA"))
                CUENTA = Convert.ToString(row["CUENTA"]);
            if (DataRecord.HasColumn(row, "COD_ESTR"))
                COD_ESTR = Convert.ToString(row["COD_ESTR"]);
            if (DataRecord.HasColumn(row, "VAL_I18N"))
                VAL_I18N = Convert.ToString(row["VAL_I18N"]);
            if (DataRecord.HasColumn(row, "NUM_OFER"))
                NUM_OFER = Convert.ToString(row["NUM_OFER"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "TIPO_OFETA"))
                TIPO_OFETA = Convert.ToString(row["TIPO_OFETA"]);
            if (DataRecord.HasColumn(row, "UNIDADES"))
                UNIDADES = Convert.ToString(row["UNIDADES"]);
            if (DataRecord.HasColumn(row, "VENTA_NETA"))
                VENTA_NETA = Convert.ToString(row["VENTA_NETA"]);
            if (DataRecord.HasColumn(row, "PRODUCTO"))
                PRODUCTO = Convert.ToString(row["PRODUCTO"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
        }
    }
}
