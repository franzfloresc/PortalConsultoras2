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

        public BEProductoAppCatalogo(IDataRecord row)
        {
            CodigoIso = row.ToString("CodigoIso");
            IdMarca = row.ToInt32("IdMarca");
            CodigoMarca = row.ToString("CodigoMarca");
            NombreMarca = row.ToString("NombreMarca");
            CampaniaId = row.ToInt32("CampaniaId");
            Cuv = row.ToString("Cuv");
            CodigoSap = row.ToString("CodigoSap");
            DescripcionComercial = row.ToString("DescripcionComercial");
            NombreComercial = row.ToString("NombreComercial");
            Descripcion = row.ToString("Descripcion");
            PrecioValorizado = row.ToDecimal("PrecioValorizado");
            PrecioCatalogo = row.ToDecimal("PrecioCatalogo");
            Volumen = row.ToString("Volumen");
            Imagen = row.ToString("Imagen");
            Sello = row.ToString("Sello");
        }
    }
}
