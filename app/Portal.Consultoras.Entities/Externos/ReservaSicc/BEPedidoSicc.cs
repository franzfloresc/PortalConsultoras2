namespace Portal.Consultoras.Entities.Externos.ReservaSicc
{
    public class BEPedidoSicc
    {
        public string codigoCliente { get; set; }
        public string codigoPais { get; set; }
        public string codigoPeriodo { get; set; }
        public string codigoVentaGanador { get; set; }
        public string estadoPedidoMontoMaximo { get; set; }
        public string estadoPedidoMontoMinimo { get; set; }
        public string formaPagoGanador { get; set; }
        public string indValiProl { get; set; }
        public string montoTotalDcto { get; set; }
        public string montoBaseDcto { get; set; }
        public string montoBaseDctoAcum { get; set; }
        public string montoMaximo { get; set; }
        public string montoPedidoMontoMaximo { get; set; }
        public string montoPedidoMontoMinimo { get; set; }
        public string montoTiendaVirtual { get; set; }
        public string montoVentaRetail { get; set; }
        public string oidOfertaGanador { get; set; }
        public string oidProductoGanador { get; set; }
        public string porcDescFijoAlca { get; set; }
        public string porcDescVariAlca { get; set; }
        public string precioGanador { get; set; }
        public string valRangFinaVari { get; set; }
        public string valRangInicVari { get; set; }
        public string indDeuda { get; set; }
        public string montoDeuda { get; set; }
        public string montoTotalOporAhorro { get; set; }
        public string indEnvioSap { get; set; }
        public string oidPedidoSap { get; set; }
        public int exitCode { get; set; }
        public BEDetalleSicc[] posiciones { get; set; }
        public BEIncentivoSicc[] incentivos { get; set; }
    }
}
