using Portal.Consultoras.Web.ServiceZonificacion;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class BannerModel
    {
        public int CampaniaID { get; set; }
        public int GrupoBannerID { get; set; }
        [RegularExpression("[0-9]{1,}", ErrorMessage = "Debe ingresar solo números.")]
        [Required(ErrorMessage = "Debe ingresar Tiempo de Rotación.")]
        public int TiempoRotacion { get; set; }
        public int BannerID { get; set; }
        public string Titulo { get; set; }
        public string Archivo { get; set; }
        public string URL { get; set; }
        public int Orden { get; set; }
        public bool FlagGrupoConsultora { get; set; }
        public bool FlagConsultoraNueva { get; set; }
        public int[] Paises { get; set; }
        public bool UdpSoloBanner { get; set; }
        public int Ancho { get; set; }
        public int Alto { get; set; }
        public int TipoContenido { get; set; }
        public int TipoAccion { get; set; }
        public int PaginaNueva { get; set; }
        public string TituloComentario { get; set; }
        public string TextoComentario { get; set; }

        [RegularExpression("[0-9]{1,}", ErrorMessage = "Debe ingresar CUV valido.")]
        [Required(ErrorMessage = "Debe ingresar CUV.")]
        public string CUV { get; set; }
        [RegularExpression("[0-9]{1,}", ErrorMessage = "Debe ingresar cantidad valida.")]
        [Range(1, 99, ErrorMessage = "Valor debe estar entre 0 y 99")]
        [Required(ErrorMessage = "Debe ingresar Cantidad de Pedido.")]
        public int cantidadPedido { get; set; }
        public string NombreCorto { get; set; }
        public List<BECampania> DropDownListCampania { get; set; }
        public List<BETipoContenido> DropDownListTipoContenido { get; set; }
        public List<BETipoAccion> DropDownListTipoAccion { get; set; }
        public List<BEPaginaNueva> DropDownListPaginaNueva { get; set; }

        public string ImagenActualizar { get; set; }
        public string Accion { get; set; }
    }

    public class BETipoContenido
    {
        public int TipoContenido { get; set; }
        public string TipoContenidoNombre { get; set; }
    }
    public class BETipoAccion
    {
        public int TipoAccion { get; set; }
        public string TipoAccionNombre { get; set; }
    }
    public class BEPaginaNueva
    {
        public int PaginaNueva { get; set; }
        public string PaginaNuevaNombre { get; set; }
    }
    public class BETipoReporte
    {
        public int TipoReporteId { get; set; }
        public string Nombre { get; set; }
    }
}
