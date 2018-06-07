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

        public BEBanner(IDataRecord datarec)
        {
            CampaniaID = Convert.ToInt32(datarec["CampaniaID"]);
            BannerID = Convert.ToInt32(datarec["BannerID"]);
            GrupoBannerID = Convert.ToInt32(datarec["GrupoBannerID"]);
            Orden = Convert.ToInt32(datarec["Orden"]);
            Titulo = datarec["Titulo"].ToString();
            Archivo = datarec["Archivo"].ToString();
            URL = datarec["URL"].ToString();
            FlagGrupoConsultora = Convert.ToBoolean(datarec["FlagGrupoConsultora"]);
            FlagConsultoraNueva = Convert.ToBoolean(datarec["FlagConsultoraNueva"]);
            TiempoRotacion = Convert.ToInt32(datarec["TiempoRotacion"]);
            TipoContenido = Convert.ToInt32(datarec["TipoContenido"]);
            if (DataRecord.HasColumn(datarec, "Nombre"))
                Nombre = Convert.ToString(datarec["Nombre"]);
            if (DataRecord.HasColumn(datarec, "PaginaNueva"))
                PaginaNueva = Convert.ToInt32(datarec["PaginaNueva"]);
            if (DataRecord.HasColumn(datarec, "TituloComentario"))
                TituloComentario = Convert.ToString(datarec["TituloComentario"]);
            if (DataRecord.HasColumn(datarec, "TextoComentario"))
                TextoComentario = Convert.ToString(datarec["TextoComentario"]);
            if (DataRecord.HasColumn(datarec, "TipoAccion"))
                TipoAccion = Convert.ToInt32(datarec["TipoAccion"]);
            if (DataRecord.HasColumn(datarec, "CuvPedido"))
                CuvPedido = Convert.ToString(datarec["CuvPedido"]);
            if (DataRecord.HasColumn(datarec, "CantCuvPedido"))
                CantCuvPedido = Convert.ToInt32(datarec["CantCuvPedido"]);

            PaisesSegZona = new BEBannerSegmentoZona[0];
        }
    }
}