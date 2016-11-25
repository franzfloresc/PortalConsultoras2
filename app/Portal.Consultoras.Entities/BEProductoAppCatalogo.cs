using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoAppCatalogo
    {
        [DataMember]
        public string CodigoIso { get; set; }

        [DataMember]
        public int IdMarca { get; set; }

        [DataMember]
        public string CodigoMarca { get; set; }

        [DataMember]
        public string NombreMarca { get; set; }

        [DataMember]
        public int CampaniaId { get; set; }

        [DataMember]
        public string Cuv { get; set; }

        [DataMember]
        public string CodigoSap { get; set; }

        [DataMember]
        public string DescripcionComercial { get; set; }

        [DataMember]
        public string NombreComercial { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public decimal PrecioValorizado { get; set; }

        [DataMember]
        public decimal PrecioCatalogo { get; set; }

        [DataMember]
        public string Volumen { get; set; }

        [DataMember]
        public string Imagen { get; set; }

        [DataMember]
        public string Sello { get; set; }

        public BEProductoAppCatalogo()
        {

        }

        public BEProductoAppCatalogo(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CodigoIso") && datarec["CodigoIso"] != DBNull.Value)
                CodigoIso = Convert.ToString(datarec["CodigoIso"]);

            if (DataRecord.HasColumn(datarec, "IdMarca") && datarec["IdMarca"] != DBNull.Value)
                IdMarca = Convert.ToInt32(datarec["IdMarca"]);

            if (DataRecord.HasColumn(datarec, "CodigoMarca") && datarec["CodigoMarca"] != DBNull.Value)
                CodigoMarca = Convert.ToString(datarec["CodigoMarca"]);

            if (DataRecord.HasColumn(datarec, "NombreMarca") && datarec["NombreMarca"] != DBNull.Value)
                NombreMarca = Convert.ToString(datarec["NombreMarca"]);

            if (DataRecord.HasColumn(datarec, "CampaniaId") && datarec["CampaniaId"] != DBNull.Value)
                CampaniaId = Convert.ToInt32(datarec["CampaniaId"]);

            if (DataRecord.HasColumn(datarec, "Cuv") && datarec["Cuv"] != DBNull.Value)
                Cuv = Convert.ToString(datarec["Cuv"]);

            if (DataRecord.HasColumn(datarec, "CodigoSap") && datarec["CodigoSap"] != DBNull.Value)
                CodigoSap = Convert.ToString(datarec["CodigoSap"]);

            if (DataRecord.HasColumn(datarec, "DescripcionComercial") && datarec["DescripcionComercial"] != DBNull.Value)
                DescripcionComercial = Convert.ToString(datarec["DescripcionComercial"]);

            if (DataRecord.HasColumn(datarec, "NombreComercial") && datarec["NombreComercial"] != DBNull.Value)
                NombreComercial = Convert.ToString(datarec["NombreComercial"]);

            if (DataRecord.HasColumn(datarec, "Descripcion") && datarec["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(datarec["Descripcion"]);

            if (DataRecord.HasColumn(datarec, "PrecioValorizado") && datarec["PrecioValorizado"] != DBNull.Value)
                PrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);

            if (DataRecord.HasColumn(datarec, "PrecioCatalogo") && datarec["PrecioCatalogo"] != DBNull.Value)
                PrecioCatalogo = Convert.ToDecimal(datarec["PrecioCatalogo"]);

            if (DataRecord.HasColumn(datarec, "Volumen") && datarec["Volumen"] != DBNull.Value)
                Volumen = Convert.ToString(datarec["Volumen"]);

            if (DataRecord.HasColumn(datarec, "Imagen") && datarec["Imagen"] != DBNull.Value)
                Imagen = Convert.ToString(datarec["Imagen"]);

            if (DataRecord.HasColumn(datarec, "Sello") && datarec["Sello"] != DBNull.Value)
                Sello = Convert.ToString(datarec["Sello"]);
        }
    }
}