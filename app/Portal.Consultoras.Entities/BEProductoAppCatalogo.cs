using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(datarec, "CodigoIso"))
                CodigoIso = Convert.ToString(datarec["CodigoIso"]);

            if (DataRecord.HasColumn(datarec, "IdMarca"))
                IdMarca = Convert.ToInt32(datarec["IdMarca"]);

            if (DataRecord.HasColumn(datarec, "CodigoMarca"))
                CodigoMarca = Convert.ToString(datarec["CodigoMarca"]);

            if (DataRecord.HasColumn(datarec, "NombreMarca"))
                NombreMarca = Convert.ToString(datarec["NombreMarca"]);

            if (DataRecord.HasColumn(datarec, "CampaniaId"))
                CampaniaId = Convert.ToInt32(datarec["CampaniaId"]);

            if (DataRecord.HasColumn(datarec, "Cuv"))
                Cuv = Convert.ToString(datarec["Cuv"]);

            if (DataRecord.HasColumn(datarec, "CodigoSap"))
                CodigoSap = Convert.ToString(datarec["CodigoSap"]);

            if (DataRecord.HasColumn(datarec, "DescripcionComercial"))
                DescripcionComercial = Convert.ToString(datarec["DescripcionComercial"]);

            if (DataRecord.HasColumn(datarec, "NombreComercial"))
                NombreComercial = Convert.ToString(datarec["NombreComercial"]);

            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = Convert.ToString(datarec["Descripcion"]);

            if (DataRecord.HasColumn(datarec, "PrecioValorizado"))
                PrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);

            if (DataRecord.HasColumn(datarec, "PrecioCatalogo"))
                PrecioCatalogo = Convert.ToDecimal(datarec["PrecioCatalogo"]);

            if (DataRecord.HasColumn(datarec, "Volumen"))
                Volumen = Convert.ToString(datarec["Volumen"]);

            if (DataRecord.HasColumn(datarec, "Imagen"))
                Imagen = Convert.ToString(datarec["Imagen"]);

            if (DataRecord.HasColumn(datarec, "Sello"))
                Sello = Convert.ToString(datarec["Sello"]);
        }
    }
}