using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEKitCaminoBrillante
    {
        //Quitar
        public int EstrategiaId { get; set; }
        public int TipoEstrategia { get; set; }
        public int OrigenPedido { get; set; }
        public string Cuv { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        public string Marca { get; set; }
        public string DescripcionOferta { get; set; }
        public string Imagen { get; set; }
        //Ok
        //public string CodigoKit { get; set; }
        //public string CodigoSap { get; set; }
        public string Nivel { get; set; }
        public int Digitable { get; set; }


        //Nueva Estructura
        public int EstrategiaID { get; set; }
        public string CodigoEstrategia { get; set; }
        public string CodigoKit { get; set; }
        public string CodigoSap { get; set; }
        public string CUV { get; set; }
        public string DescripcionCUV { get; set; }
        public string DescripcionCortaCUV { get; set; }
        public int MarcaID { get; set; }
        public string DescripcionMarca { get; set; }
        public string CodigoNivel { get; set; }
        public string DescripcionNivel { get; set; }
        public decimal PrecioValorizado { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public decimal Ganancia { get; set; }
        public string FotoProductoSmall { get; set; }
        public string FotoProductoMedium { get; set; }
        public string TipoEstrategiaID { get; set; }
        public int OrigenPedidoWebFicha { get; set; }
        public bool FlagSeleccionado { get; set; }
        public int FlagDigitable { get; set; }
        public bool FlagHabilitado { get; set; }
    }
}
