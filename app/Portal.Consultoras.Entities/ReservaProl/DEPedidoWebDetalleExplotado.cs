namespace Portal.Consultoras.Entities.ReservaProl
{
    public class DEPedidoWebDetalleExplotado
    {
        public int CampaniaID { get; set; }
        public int PedidoID { get; set; }
        public string CodigoSap { get; set; }
        public string CUV { get; set; }
        public decimal? EscalaDescuento { get; set; }
        public decimal? FactorCuadre { get; set; }
        public int FactorRepeticion { get; set; }
        public string GrupoDescuento { get; set; }
        public decimal? ImporteDescuento1 { get; set; }
        public decimal? ImporteDescuento2 { get; set; }
        public bool IndAccion { get; set; }
        public bool IndLimiteVenta { get; set; }
        public bool IndRecuperacion { get; set; }
        public int? NumUnidOrig { get; set; }
        public int? NumSeccionDetalle { get; set; }
        public string Observaciones { get; set; }
        public int IdCatalogo { get; set; }
        public int IdDetaOferta { get; set; }
        public int IdEstrategia { get; set; }
        public int? IdFormaPago { get; set; }
        public int? IdGrupoOferta { get; set; }
        public int? IdIndicadorCuadre { get; set; }
        public int? IdNiveOferta { get; set; }
        public int? IdNiveOfertaGratis { get; set; }
        public int? IdNiveOfertaRango { get; set; }
        public int? IdOferta { get; set; }
        public int? IdPosicion { get; set; }
        public int IdProducto { get; set; }
        public int? IdSubTipoPosicion { get; set; }
        public int? IdTipoPosicion { get; set; }
        public int Pagina { get; set; }
        public decimal? PorcentajeDescuento { get; set; }
        public decimal? PrecioCatalogo { get; set; }
        public decimal? PrecioContable { get; set; }
        public decimal? PrecioPublico { get; set; }
        public decimal? PrecioUnitario { get; set; }
        public string Ranking { get; set; }
        public int UnidadesDemandadas { get; set; }
        public int UnidadesPorAtender { get; set; }
        public string ValCodiOrig { get; set; }
    }
}
