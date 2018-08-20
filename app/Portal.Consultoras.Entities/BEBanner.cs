using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBanner
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int BannerID { get; set; }

        [DataMember]
        public int GrupoBannerID { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public string Titulo { get; set; }

        [DataMember]
        public string Archivo { get; set; }

        [DataMember]
        public string URL { get; set; }

        [DataMember]
        public bool FlagGrupoConsultora { get; set; }

        [DataMember]
        public int[] Paises { get; set; }

        [DataMember]
        public bool UdpSoloBanner { get; set; }

        [DataMember]
        public bool FlagConsultoraNueva { get; set; }

        [DataMember]
        public int TiempoRotacion { get; set; }

        [DataMember]
        public int TipoContenido { get; set; }

        [DataMember]
        public int PaginaNueva { get; set; }

        [DataMember]
        public string Nombre { get; set; }

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
        public BEBannerSegmentoZona[] PaisesSegZona { get; set; }


        public BEBanner()
        {
            PaisesSegZona = new BEBannerSegmentoZona[0];
        }

        public BEBanner(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            BannerID = row.ToInt32("BannerID");
            GrupoBannerID = row.ToInt32("GrupoBannerID");
            Orden = row.ToInt32("Orden");
            Titulo = row.ToString("Titulo");
            Archivo = row.ToString("Archivo");
            URL = row.ToString("URL");
            FlagGrupoConsultora = row.ToBoolean("FlagGrupoConsultora");
            FlagConsultoraNueva = row.ToBoolean("FlagConsultoraNueva");
            TiempoRotacion = row.ToInt32("TiempoRotacion");
            TipoContenido = row.ToInt32("TipoContenido");
            Nombre = row.ToString("Nombre");
            PaginaNueva = row.ToInt32("PaginaNueva");
            TituloComentario = row.ToString("TituloComentario");
            TextoComentario = row.ToString("TextoComentario");
            TipoAccion = row.ToInt32("TipoAccion");
            CuvPedido = row.ToString("CuvPedido");
            CantCuvPedido = row.ToInt32("CantCuvPedido");
            PaisesSegZona = new BEBannerSegmentoZona[0];
        }
    }
}
