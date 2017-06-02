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
            SuscripcionAnteriorModel = new RevistaDigitalSuscripcionModel();
            ListaProducto = new List<EstrategiaPedidoModel>();
            ListaTabs = new List<ComunModel>();
            FiltersBySorting = new List<BETablaLogicaDatos>();
            FiltersByCategory = new List<BETablaLogicaDatos>();
            FiltersByBrand = new List<BETablaLogicaDatos>();
            FiltersByPublished = new List<BETablaLogicaDatos>();
            NombreRevista = "QUÉ ES ESIKA PARA MÍ";
        }

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
        public int CampaniaMasUno { get; set; }
        public int CampaniaMasDos { get; set; }
        public string NumeroContacto { get; set; }
        

        public List<BETablaLogicaDatos> FiltersBySorting { get; set; }
        public List<BETablaLogicaDatos> FiltersByCategory { get; set; }
        public List<BETablaLogicaDatos> FiltersByBrand { get; set; }
        public List<BETablaLogicaDatos> FiltersByPublished { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionModel { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionAnteriorModel { get; set; }
        public List<EstrategiaPedidoModel> ListaProducto { get; set; }
    }
}