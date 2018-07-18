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
            PAIS = row.ToString("PAIS");
            PERIODO = row.ToString("PERIODO");
            ZONA = row.ToString("ZONA");
            CUENTA = row.ToString("CUENTA");
            CUV = row.ToString("CUV");
            TIPO_OFETA = row.ToString("TIPO_OFETA");
            UNIDADES = row.ToString("UNIDADES");
            VENTA_NETA = row.ToString("VENTA_NETA");
            PRODUCTO = row.ToString("PRODUCTO");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            Descripcion = DataRecord.GetColumn<string>(row, "Descripcion");
            Marca = DataRecord.GetColumn<string>(row, "Marca");
            Categoria = DataRecord.GetColumn<string>(row, "Categoria");
        }
    }
}
