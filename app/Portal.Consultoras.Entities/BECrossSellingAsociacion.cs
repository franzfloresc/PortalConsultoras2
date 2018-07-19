using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECrossSellingAsociacion
    {
        [DataMember]
        public int CrossSellingAsociacionID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int NroOrden { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal PrecioOferta { get; set; }
        [DataMember]
        public string CUVAsociado { get; set; }

        [DataMember]
        public string CUVAsociado2 { get; set; }

        [DataMember]
        public string CodigoSegmento { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string EtiquetaPrecio { get; set; }
        public BECrossSellingAsociacion(IDataRecord row)
        {
            CrossSellingAsociacionID = row.ToInt32("CrossSellingAsociacionID");
            NroOrden = row.ToInt32("NroOrden");
            CodigoCampania = row.ToString("CodigoCampania");
            CUV = row.ToString("CUV");
            Descripcion = row.ToString("Descripcion");
            PrecioOferta = row.ToDecimal("PrecioOferta");
            CUVAsociado = row.ToString("CUVAsociado");
            CUVAsociado2 = row.ToString("CUVAsociado2");
            CodigoSegmento = row.ToString("CodigoSegmento");
            CampaniaID = row.ToInt32("CampaniaID");
            EtiquetaPrecio = row.ToString("EtiquetaPrecio", string.Empty);
        }
    }
}
