using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

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
        //ITG - 1890 Inicio
        [DataMember]
        public decimal PrecioCatalogo { set; get; }
        //ITG - 1890 Fin
        [DataMember]
        public decimal PrecioUnitario { set; get; } //RQ 2612 EGL
        [DataMember]
        public int CodigoCatalogo { set; get; } //R20151007
        [DataMember]
        public string CodigoTipoOferta { set; get; } //R20151007

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
            //ITG - 1890 Inicio
            if (DataRecord.HasColumn(row, "PrecioCatalogo") && row["PrecioCatalogo"] != DBNull.Value)
                PrecioCatalogo = Convert.ToDecimal(row["PrecioCatalogo"]);
            //ITG - 1890 Fin
            if (DataRecord.HasColumn(row, "PrecioUnitario") && row["PrecioUnitario"] != DBNull.Value) //RQ 2612 EGL
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);
            //R20151007 - Inicio
            if (DataRecord.HasColumn(row, "CodigoCatalogo") && row["CodigoCatalogo"] != DBNull.Value)
                CodigoCatalogo = Convert.ToInt32(row["CodigoCatalogo"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta") && row["CodigoTipoOferta"] != DBNull.Value)
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            //R20151007 - Fin
        }
    }
}
