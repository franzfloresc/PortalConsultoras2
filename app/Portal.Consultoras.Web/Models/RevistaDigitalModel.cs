using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalModel
    {
        public RevistaDigitalModel()
        {
            SuscripcionModel = new RevistaDigitalSuscripcionModel();
            SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel();
            SuscripcionAnterior1Model = new RevistaDigitalSuscripcionModel();
            ListaProductoLan = new List<EstrategiaPedidoModel>();
            ListaProductoNoLan = new List<EstrategiaPedidoModel>();
            ListaTabs = new List<ComunModel>();
            FiltersBySorting = new List<BETablaLogicaDatos>();
            FiltersByCategory = new List<BETablaLogicaDatos>();
            FiltersByBrand = new List<BETablaLogicaDatos>();
            FiltersByPublished = new List<BETablaLogicaDatos>();
            NombreRevista = "SABER MÁS DE {0}ÉSIKA PARA MÍ";
        }

        public bool Success { get; set; }
        public int Activo { get; set; }
        public int EstadoSuscripcion { get; set; }
        public int EstadoAccion { get; set; }
        public List<ComunModel> ListaTabs { get; set; }
        public bool NoVolverMostrar { get; set; }
        public decimal PrecioMin { get; set; }
        public decimal PrecioMax { get; set; }
        public string NombreRevista { get; set; }
        public string Titulo { get; set; }
        public string TituloDescripcion { get; set; }
        public bool IsMobile { get; set; }
        public int CampaniaID { get; set; }
        public int CampaniaMasUno { get; set; }
        public int CampaniaMasDos { get; set; }
        public int CantidadFilas { get; set; }
        public string NumeroContacto { get; set; }
        public bool TieneRDR { get; set; }
        public bool TieneRDC { get; set; }
        public bool TieneRDS { get; set; }
        public MensajeProductoBloqueadoModel MensajeProductoBloqueado { get; set; }

        public List<BETablaLogicaDatos> FiltersBySorting { get; set; }
        public List<BETablaLogicaDatos> FiltersByCategory { get; set; }
        public List<BETablaLogicaDatos> FiltersByBrand { get; set; }
        public List<BETablaLogicaDatos> FiltersByPublished { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionModel { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionAnterior2Model { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionAnterior1Model { get; set; }
        public List<EstrategiaPedidoModel> ListaProductoLan { get; set; }
        public List<EstrategiaPedidoModel> ListaProductoNoLan { get; set; }
    }
}