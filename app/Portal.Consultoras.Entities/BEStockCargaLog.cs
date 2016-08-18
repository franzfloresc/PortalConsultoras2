using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

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
