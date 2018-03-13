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
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "PaisID") && row["PaisID"] != DBNull.Value)
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioProducto") && row["PrecioProducto"] != DBNull.Value)
                PrecioProducto = Convert.ToDecimal(row["PrecioProducto"]);
            if (DataRecord.HasColumn(row, "FactorRepeticion") && row["FactorRepeticion"] != DBNull.Value)
                FactorRepeticion = Convert.ToInt32(row["FactorRepeticion"]);
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo") && row["IndicadorMontoMinimo"] != DBNull.Value)
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);
            if (DataRecord.HasColumn(row, "IndicadorDigitable") && row["IndicadorDigitable"] != DBNull.Value)
                IndicadorDigitable = Convert.ToInt32(row["IndicadorDigitable"]);
            if (DataRecord.HasColumn(row, "IndicadorActivo") && row["IndicadorActivo"] != DBNull.Value)
                IndicadorActivo = Convert.ToInt32(row["IndicadorActivo"]);
            if (DataRecord.HasColumn(row, "IndicadorFaltanteAnunciado") && row["IndicadorFaltanteAnunciado"] != DBNull.Value)
                IndicadorFaltanteAnunciado = Convert.ToInt32(row["IndicadorFaltanteAnunciado"]);
            if (DataRecord.HasColumn(row, "PrecioCatalogo") && row["PrecioCatalogo"] != DBNull.Value)
                PrecioCatalogo = Convert.ToDecimal(row["PrecioCatalogo"]);
            if (DataRecord.HasColumn(row, "PrecioUnitario") && row["PrecioUnitario"] != DBNull.Value)
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);
            if (DataRecord.HasColumn(row, "CodigoCatalogo") && row["CodigoCatalogo"] != DBNull.Value)
                CodigoCatalogo = Convert.ToInt32(row["CodigoCatalogo"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta") && row["CodigoTipoOferta"] != DBNull.Value)
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);

            if (DataRecord.HasColumn(row, "RegaloDescripcion") && row["RegaloDescripcion"] != DBNull.Value)
                RegaloDescripcion = Convert.ToString(row["RegaloDescripcion"]);
            if (DataRecord.HasColumn(row, "RegaloImagenUrl") && row["RegaloImagenUrl"] != DBNull.Value)
                RegaloImagenUrl = Convert.ToString(row["RegaloImagenUrl"]);
            if (DataRecord.HasColumn(row, "SAP") && row["SAP"] != DBNull.Value)
                SAP = Convert.ToString(row["SAP"]);
            if (DataRecord.HasColumn(row, "IDMATRIZCOMERCIAL") && row["IDMATRIZCOMERCIAL"] != DBNull.Value)
                IdMatrizComercial = Convert.ToInt32(row["IDMATRIZCOMERCIAL"]);
        }
    }
}
