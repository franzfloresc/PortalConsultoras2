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
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioProducto"))
                PrecioProducto = Convert.ToDecimal(row["PrecioProducto"]);
            if (DataRecord.HasColumn(row, "FactorRepeticion"))
                FactorRepeticion = Convert.ToInt32(row["FactorRepeticion"]);
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo"))
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);
            if (DataRecord.HasColumn(row, "IndicadorDigitable"))
                IndicadorDigitable = Convert.ToInt32(row["IndicadorDigitable"]);
            if (DataRecord.HasColumn(row, "IndicadorActivo"))
                IndicadorActivo = Convert.ToInt32(row["IndicadorActivo"]);
            if (DataRecord.HasColumn(row, "IndicadorFaltanteAnunciado"))
                IndicadorFaltanteAnunciado = Convert.ToInt32(row["IndicadorFaltanteAnunciado"]);
            if (DataRecord.HasColumn(row, "PrecioCatalogo"))
                PrecioCatalogo = Convert.ToDecimal(row["PrecioCatalogo"]);
            if (DataRecord.HasColumn(row, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);
            if (DataRecord.HasColumn(row, "CodigoCatalogo"))
                CodigoCatalogo = Convert.ToInt32(row["CodigoCatalogo"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta"))
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);

            if (DataRecord.HasColumn(row, "RegaloDescripcion"))
                RegaloDescripcion = Convert.ToString(row["RegaloDescripcion"]);
            if (DataRecord.HasColumn(row, "RegaloImagenUrl"))
                RegaloImagenUrl = Convert.ToString(row["RegaloImagenUrl"]);
            if (DataRecord.HasColumn(row, "SAP"))
                SAP = Convert.ToString(row["SAP"]);
            if (DataRecord.HasColumn(row, "IDMATRIZCOMERCIAL"))
                IdMatrizComercial = Convert.ToInt32(row["IDMATRIZCOMERCIAL"]);
        }
    }
}
