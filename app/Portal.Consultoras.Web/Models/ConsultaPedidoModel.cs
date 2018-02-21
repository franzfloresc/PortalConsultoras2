using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ConsultaPedidoModel
    {
        public string Nombre { set; get; }
        public IEnumerable<RegionModel> listaRegiones { set; get; }
        public IEnumerable<CampaniaModel> listaCampania { set; get; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
        public IEnumerable<PedidoDetalleModel> listaPedidoBloqueado { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }

        public string vpage { set; get; }
        public string vsortname { set; get; }
        public string vsortorder { set; get; }
        public string vrowNum { set; get; }

        public int PaisID { set; get; }
        public int CampaniaID { set; get; }
        public string PedidoID { get; set; }
        public string CodigoConsultora { get; set; }
        public string Nombres { get; set; }
        public string Direccion { get; set; }
        public string CodigoTerritorio { get; set; }
        public string DescripcionBloqueo { get; set; }
        public int TotalPedidosFacturar { get; set; }
        public int TotalPedidos { get; set; }
        public decimal TotalMontoPedidos { get; set; }
        public string Simbolo { get; set; }
        public short Bloqueado { get; set; }
        public short IndicadorEnviado { get; set; }

        public string Fechaddl_val { get; set; }
        public string EstadoPedidoddl_val { get; set; }
        public string Bloqueadoddl_val { get; set; }
        public string territoriotxt { get; set; }
        public string CodConsultoratxt { get; set; }
        public string territoriotxt_ID { get; set; }
        public string CodConsultoratxt_ID { get; set; }
        public string Usuario { get; set; }
        public string FechaProceso { get; set; }
    }
}