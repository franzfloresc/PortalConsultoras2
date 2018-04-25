using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
        public string Descripcion { get; set; }
        [DataMember]
        public string Marca { get; set; }
        [DataMember]
        public string Categoria { get; set; }
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

            Descripcion = DataRecord.GetColumn<string>(row, "Descripcion");
            Marca = DataRecord.GetColumn<string>(row, "Marca");
            Categoria = DataRecord.GetColumn<string>(row, "Categoria");
        }
    }
}
