using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBannerInfo
    {
        protected int miGrupoBannerID;
        protected string msTitulo;
        protected string msArchivo;
        protected string msURL;
        protected int miTiempoRotacion;
        protected int miTipoContenido;
        protected int miPaginaNueva;
        protected string msNombre;
        protected int miCampaniaID;
        protected int miOrden;
        protected int miBannerID;
        protected string msTituloComentario;
        protected string msTextoComentario;
		protected int miTipoAccion;
        protected string miCUVpedido;
        protected int miCantCUVpedido;

        public BEBannerInfo(BEBanner banner)
        {
            miGrupoBannerID = banner.GrupoBannerID;
            msTitulo = banner.Titulo;
            msArchivo = banner.Archivo;
            msURL = banner.URL;
            miTiempoRotacion = banner.TiempoRotacion;
            miTipoContenido = banner.TipoContenido;
            miPaginaNueva = banner.PaginaNueva;
            msNombre = banner.Nombre;
            miCampaniaID = banner.CampaniaID;
            miOrden = banner.Orden;
            miBannerID = banner.BannerID;
            msTituloComentario = banner.TituloComentario;
            msTextoComentario = banner.TextoComentario;
			miTipoAccion = banner.TipoAccion;
            miCUVpedido = banner.CuvPedido;
            miCantCUVpedido = banner.CantCuvPedido;
        }

        [DataMember]
        public int GrupoBannerID
        {
            get { return miGrupoBannerID; }
            set { miGrupoBannerID = value; }
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
        public int CampaniaID
        {
            get { return miCampaniaID; }
            set { miCampaniaID = value; }
        }

        [DataMember]
        public int Orden
        {
            get { return miOrden; }
            set { miOrden = value; }
        }

        [DataMember]
        public int BannerID
        {
            get { return miBannerID; }
            set { miBannerID = value; }
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

        //RQ_SB - R2133
        [DataMember]
        public int Segmento { get; set; }

        //RQ_SB - R2133
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
