using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoDescripcion
    {
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public string CUV { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string Descripcion { set; get; }
        [DataMember]
        public decimal PrecioProducto { set; get; }
        [DataMember]
        public int FactorRepeticion { set; get; }
        [DataMember]
        public int IndicadorMontoMinimo { set; get; }
        [DataMember]
        public int IndicadorDigitable { set; get; }
        [DataMember]
        public int IndicadorFaltanteAnunciado { set; get; }
        [DataMember]
        public int IndicadorActivo { set; get; }
        [DataMember]
        public decimal PrecioCatalogo { set; get; }
        [DataMember]
        public decimal PrecioUnitario { set; get; }
        [DataMember]
        public int CodigoCatalogo { set; get; }
        [DataMember]
        public string CodigoTipoOferta { set; get; }

        [DataMember]
        public string RegaloDescripcion { set; get; }

        [DataMember]
        public string RegaloImagenUrl { set; get; }

        [DataMember]
        public string SAP { set; get; }

        [DataMember]
        public int IdMatrizComercial { set; get; }

        public BEProductoDescripcion(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            PaisID = row.ToInt32("PaisID");
            Descripcion = row.ToString("Descripcion");
            PrecioProducto = row.ToDecimal("PrecioProducto");
            FactorRepeticion = row.ToInt32("FactorRepeticion");
            IndicadorMontoMinimo = row.ToInt32("IndicadorMontoMinimo");
            IndicadorDigitable = row.ToInt32("IndicadorDigitable");
            IndicadorActivo = row.ToInt32("IndicadorActivo");
            IndicadorFaltanteAnunciado = row.ToInt32("IndicadorFaltanteAnunciado");
            PrecioCatalogo = row.ToDecimal("PrecioCatalogo");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
            CodigoCatalogo = row.ToInt32("CodigoCatalogo");
            CodigoTipoOferta = row.ToString("CodigoTipoOferta");
            RegaloDescripcion = row.ToString("RegaloDescripcion");
            RegaloImagenUrl = row.ToString("RegaloImagenUrl");
            SAP = row.ToString("SAP");
            IdMatrizComercial = row.ToInt32("IDMATRIZCOMERCIAL");
        }
    }
}
