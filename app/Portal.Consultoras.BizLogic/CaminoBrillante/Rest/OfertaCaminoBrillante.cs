using System.Runtime.Serialization;

namespace Portal.Consultoras.BizLogic.CaminoBrillante.Rest
{
    [DataContract]
    public class OfertaCaminoBrillante
    {
        [DataMember(Name = "ISOPAIS")]
        public string IsoPais { get; set; }
        [DataMember(Name = "CODIGOKIT")]
        public string CodigoKit { get; set; }
        [DataMember(Name = "CUV")]
        public string Cuv { get; set; }
        [DataMember(Name = "CODIGOSAP")]
        public string CodigoSap { get; set; }
        [DataMember(Name = "DESCRIPCION")]
        public string Descripcion { get; set; }
        [DataMember(Name = "PRECIO")]
        public decimal Precio { get; set; }
        [DataMember(Name = "MARCA")]
        public string Marca { get; set; }
        [DataMember(Name = "DIGITABLE")]
        public int Digitable { get; set; }
        [DataMember(Name = "DESCRIPCIONOFERTA")]
        public string DescripcionOferta { get; set; }
        [DataMember(Name = "NIVEL")]
        public string Nivel { get; set; }

    }

}
