using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBanner
    {
        private int miCampaniaID;
        private int miBannerID;
        private int miGrupoBannerID;
        private int miOrden;
        private string msTitulo;
        private string msArchivo;
        private string msURL;
        private bool mbFlagGrupoConsultora;
        private bool mbFlagConsultoraNueva;
        private int[] miPaises;
        private bool mbUdpSoloBanner;
        private int miTiempoRotacion;
        private int miTipoContenido;
        private int miPaginaNueva;
        private string msNombre;
        private string msTituloComentario;
        private string msTextoComentario;
        private int miTipoAccion;
        private string miCUVpedido;
        private int miCantCUVpedido;

        public BEBanner(IDataRecord datarec)
        {
            miCampaniaID = Convert.ToInt32(datarec["CampaniaID"]);
            miBannerID = Convert.ToInt32(datarec["BannerID"]);
            miGrupoBannerID = Convert.ToInt32(datarec["GrupoBannerID"]);
            miOrden = Convert.ToInt32(datarec["Orden"]);
            msTitulo = datarec["Titulo"].ToString();
            msArchivo = datarec["Archivo"].ToString();
            msURL = datarec["URL"].ToString();
            mbFlagGrupoConsultora = Convert.ToBoolean(datarec["FlagGrupoConsultora"]);
            mbFlagConsultoraNueva = Convert.ToBoolean(datarec["FlagConsultoraNueva"]);
            miTiempoRotacion = Convert.ToInt32(datarec["TiempoRotacion"]);
            miTipoContenido = Convert.ToInt32(datarec["TipoContenido"]);
            if (DataRecord.HasColumn(datarec, "Nombre"))
                Nombre = Convert.ToString(datarec["Nombre"]);
            if (DataRecord.HasColumn(datarec, "PaginaNueva"))
                PaginaNueva = Convert.ToInt32(datarec["PaginaNueva"]);
            if (DataRecord.HasColumn(datarec, "TituloComentario"))
                TituloComentario = Convert.ToString(datarec["TituloComentario"]);
            if (DataRecord.HasColumn(datarec, "TextoComentario"))
                TextoComentario = Convert.ToString(datarec["TextoComentario"]);
            if (DataRecord.HasColumn(datarec, "TipoAccion"))
                miTipoAccion = Convert.ToInt32(datarec["TipoAccion"]);
            if (DataRecord.HasColumn(datarec, "CuvPedido"))
                miCUVpedido = Convert.ToString(datarec["CuvPedido"]);
            if (DataRecord.HasColumn(datarec, "CantCuvPedido"))
                miCantCUVpedido = Convert.ToInt32(datarec["CantCuvPedido"]);

            PaisesSegZona = new BEBannerSegmentoZona[0];
        }

        public BEBanner()
        {
            PaisesSegZona = new BEBannerSegmentoZona[0];
        }

        [DataMember]
        public int CampaniaID
        {
            get { return miCampaniaID; }
            set { miCampaniaID = value; }
        }
        [DataMember]
        public int BannerID
        {
            get { return miBannerID; }
            set { miBannerID = value; }
        }
        [DataMember]
        public int GrupoBannerID
        {
            get { return miGrupoBannerID; }
            set { miGrupoBannerID = value; }
        }
        [DataMember]
        public int Orden
        {
            get { return miOrden; }
            set { miOrden = value; }
        }
        [DataMember]
        public string Titulo
        {
            get { return msTitulo; }
            set { msTitulo = value; }
        }
        [DataMember]
        public string Archivo
        {
            get { return msArchivo; }
            set { msArchivo = value; }
        }
        [DataMember]
        public string URL
        {
            get { return msURL; }
            set { msURL = value; }
        }
        [DataMember]
        public bool FlagGrupoConsultora
        {
            get { return mbFlagGrupoConsultora; }
            set { mbFlagGrupoConsultora = value; }
        }
        [DataMember]
        public int[] Paises
        {
            get { return miPaises; }
            set { miPaises = value; }
        }

        [DataMember]
        public bool UdpSoloBanner
        {
            get { return mbUdpSoloBanner; }
            set { mbUdpSoloBanner = value; }
        }

        [DataMember]
        public bool FlagConsultoraNueva
        {
            get { return mbFlagConsultoraNueva; }
            set { mbFlagConsultoraNueva = value; }
        }

        [DataMember]
        public int TiempoRotacion
        {
            get { return miTiempoRotacion; }
            set { miTiempoRotacion = value; }
        }
        [DataMember]
        public int TipoContenido
        {
            get { return miTipoContenido; }
            set { miTipoContenido = value; }
        }
        [DataMember]
        public int PaginaNueva
        {
            get { return miPaginaNueva; }
            set { miPaginaNueva = value; }
        }
        [DataMember]
        public string Nombre
        {
            get { return msNombre; }
            set { msNombre = value; }
        }
        [DataMember]
        public string TituloComentario
        {
            get { return msTituloComentario; }
            set { msTituloComentario = value; }
        }
        [DataMember]
        public string TextoComentario
        {
            get { return msTextoComentario; }
            set { msTextoComentario = value; }
        }
        [DataMember]
        public int TipoAccion
        {
            get { return miTipoAccion; }
            set { miTipoAccion = value; }
        }
        [DataMember]
        public string CuvPedido
        {
            get { return miCUVpedido; }
            set { miCUVpedido = value; }
        }

        [DataMember]
        public int CantCuvPedido
        {
            get { return miCantCUVpedido; }
            set { miCantCUVpedido = value; }
        }

        [DataMember]
        public BEBannerSegmentoZona[] PaisesSegZona { get; set; }
    }
}