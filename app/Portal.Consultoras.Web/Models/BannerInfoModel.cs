namespace Portal.Consultoras.Web.Models
{
    public class BannerInfoModel
    {
        public int GrupoBannerID { get; set; }
        public string Titulo { get; set; }
        public string Archivo { get; set; }
        public string URL { get; set; }
        public int TiempoRotacion { get; set; }
        public int TipoContenido { get; set; }
        public int PaginaNueva { get; set; }
        public string Nombre { get; set; }
        public int CampaniaID { get; set; }
        public int Orden { get; set; }
        public int BannerID { get; set; }
        public string TituloComentario { get; set; }
        public string TextoComentario { get; set; }
        public int TipoAccion { get; set; }
        public string CUVpedido { get; set; }
        public int CantCUVpedido { get; set; }

        public string Clase { get; set; }
        public string Codigo { get; set; }
    }
}