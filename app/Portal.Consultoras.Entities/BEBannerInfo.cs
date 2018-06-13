using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBannerInfo
    {
        public BEBannerInfo(BEBanner banner)
        {
            GrupoBannerID = banner.GrupoBannerID;
            Titulo = banner.Titulo;
            Archivo = banner.Archivo;
            URL = banner.URL;
            TiempoRotacion = banner.TiempoRotacion;
            TipoContenido = banner.TipoContenido;
            PaginaNueva = banner.PaginaNueva;
            Nombre = banner.Nombre;
            CampaniaID = banner.CampaniaID;
            Orden = banner.Orden;
            BannerID = banner.BannerID;
            TituloComentario = banner.TituloComentario;
            TextoComentario = banner.TextoComentario;
            TipoAccion = banner.TipoAccion;
            CuvPedido = banner.CuvPedido;
            CantCuvPedido = banner.CantCuvPedido;
        }

        [DataMember]
        public int GrupoBannerID { get; set; }

        [DataMember]
        public string Titulo { get; set; }

        [DataMember]
        public string Archivo { get; set; }

        [DataMember]
        public string URL { get; set; }

        [DataMember]
        public int TiempoRotacion { get; set; }

        [DataMember]
        public int TipoContenido { get; set; }

        [DataMember]
        public int PaginaNueva { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public int BannerID { get; set; }

        [DataMember]
        public string TituloComentario { get; set; }

        [DataMember]
        public string TextoComentario { get; set; }

        [DataMember]
        public int TipoAccion { get; set; }

        [DataMember]
        public string CuvPedido { get; set; }

        [DataMember]
        public int CantCuvPedido { get; set; }

        [DataMember]
        public int Segmento { get; set; }

        [DataMember]
        public string ConfiguracionZona { get; set; }
    }

    [DataContract]
    public class BEBannerOrden
    {
        [DataMember]
        public int BannerID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int Orden { get; set; }
    }
}
