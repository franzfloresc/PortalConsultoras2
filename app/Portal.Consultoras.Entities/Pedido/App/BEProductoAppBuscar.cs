using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido.App
{
    [DataContract]
    public class BEProductoAppBuscar
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CodigoDescripcion { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public int Criterio { get; set; }
        [DataMember]
        public int RowCount { get; set; }
        [DataMember]
        public bool ValidarOpt { get; set; }

        [DataMember]
        public bool EsShowRoom { get; set; }
        [DataMember]
        public BERevistaDigital RevistaDigital { get; set; }

        [DataMember]
        public string CodigosRevistaImpresa { get; set; }
        [DataMember]
        public bool OptBloqueoProductoDigital { get; set; }

        [DataMember]
        public BEOfertaDelDia OfertaDelDiaModel { get; set; }

        [DataMember]
        public BEGuiaNegocio GuiaNegocio { get; set; }
    }
}
