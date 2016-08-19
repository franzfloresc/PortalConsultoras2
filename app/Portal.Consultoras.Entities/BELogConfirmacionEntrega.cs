using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    /* EPD-665 - INICIO */
    [DataContract]
    public class BELogConfirmacionEntrega
    {
        [DataMember]
        public string PaisISO { get; set; }
        [DataMember]
        public int LogTipoReg { get; set; }
        [DataMember]
        public DateTime LogFechaReg { get; set; }
        [DataMember]
        public int LogResult { get; set; }
        [DataMember]
        public int ConfirmacionEntregaId { get; set; }
        [DataMember]
        public int IdentificadorEntrega { get; set; }
        [DataMember]
        public string NumeroPedido { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public DateTime Fecha { get; set; }
        [DataMember]
        public string Latitud { get; set; }
        [DataMember]
        public string Longitud { get; set; }
        [DataMember]
        public string TipoEntrega { get; set; }
        [DataMember]
        public string Novedad { get; set; }
        [DataMember]
        public string Observacion { get; set; }
        [DataMember]
        public string CodigoPlataforma { get; set; }
        [DataMember]
        public string Foto1 { get; set; }
        [DataMember]
        public string Foto2 { get; set; }
        [DataMember]
        public string Foto3 { get; set; }
        [DataMember]
        public string Firma { get; set; }
    }

    /* EPD-665 - FIN */
}
