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
            CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            BannerID = Convert.ToInt32(row["BannerID"]);
            GrupoBannerID = Convert.ToInt32(row["GrupoBannerID"]);
            Orden = Convert.ToInt32(row["Orden"]);
            Titulo = Convert.ToString(row["Titulo"]);
            Archivo = Convert.ToString(row["Archivo"]);
            URL = Convert.ToString(row["URL"]);
            FlagGrupoConsultora = Convert.ToBoolean(row["FlagGrupoConsultora"]);
            FlagConsultoraNueva = Convert.ToBoolean(row["FlagConsultoraNueva"]);
            TiempoRotacion = Convert.ToInt32(row["TiempoRotacion"]);
            TipoContenido = Convert.ToInt32(row["TipoContenido"]);
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
