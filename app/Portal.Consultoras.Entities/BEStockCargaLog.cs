using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEStockCargaLog
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int StockLogID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public int CantidadRegistros { get; set; }
        [DataMember]
        public string UsuarioRegistro { get; set; }
    }
}
