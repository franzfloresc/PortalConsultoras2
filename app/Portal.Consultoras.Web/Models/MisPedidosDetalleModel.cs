using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class MisPedidosDetalleModel
    {
        public List<BEMisPedidosDetalle> ListaDetalle { get; set; }
        public List<MisPedidosDetalleModel2> ListaDetalle2 { get; set; }

        public BEMisPedidos MiPedido { get; set; }

        public string Registros { get; set; }
        public string RegistrosDe { get; set; }
        public string RegistrosTotal { get; set; }
        public string Pagina { get; set; }
        public string PaginaDe { get; set; }

        public int PedidoId { get; set; }
        public int PedidoDetalleId { get; set; }
        public string OpcionAcepta { get; set; }
    }

    [Serializable()]
    public class MisPedidosDetalleModel2
    {
        public long PedidoDetalleId { get; set; }
        public long PedidoId { get; set; }
        public string Producto { get; set; }
        public string Tono { get; set; }
        public int MarcaID { get; set; }
        public string Marca { get; set; }
        public string CUV { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal PrecioTotal { get; set; }
        public string MedioContacto { get; set; }
        public int EstaEnRevista { get; set; }
        public int TieneStock { get; set; }
        public string MensajeValidacion { get; set; }
        public int TipoAtencion { get; set; }
        public int PedidoWebID { get; set; }
        public int PedidoWebDetalleID { get; set; }
        public string CodigoIso { get; set; }

        public string FormatoPrecioUnitario
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioUnitario, CodigoIso);
            }
        }

        public string FormatoPrecioTotal
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioTotal, CodigoIso);
            }
        }
    }
}