using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarBannerPedidoModel
    {
        public int BannerPedidoID { get; set; }
        public int PaisID { set; get; }
        public string PaisNombre { set; get; }
        public int CampaniaIDInicio { set; get; }
        public int CampaniaIDFin { set; get; }
        public int PosicionBannerPedido { set; get; }
        public long ConsultoraID { set; get; }
        public string ArchivoPortada { set; get; }
        public string ArchivoPortadaAnterior { set; get; }
        public string Archivo { set; get; }
        public string Url { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public IEnumerable<CampaniaModel> listaCampania { set; get; }
        public IEnumerable<PosicionBannerPedidoModel> listaPoscionBannerPedido { set; get; }
        public string grupoUrlPDF { get; set; }
        public string grupoTipoUrl { get; set; }

        public AdministrarBannerPedidoModel()
        {
            this.Archivo = string.Empty;
            this.Url = string.Empty;
        }
    }
}