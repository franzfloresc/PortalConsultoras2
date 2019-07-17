using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEDescargaArchivoSinMarcar
    {
        [DataMember]
        [Column("dtPedidosCabWeb")]
        public DataTable dtPedidosCabWeb { get; set; }

        [DataMember]
        [Column("dtPedidosDetWeb")]
        public DataTable dtPedidosDetWeb { get; set; }

        [DataMember]
        [Column("dtPedidosCabDD")]
        public DataTable dtPedidosCabDD { get; set; }

        [DataMember]
        [Column("dtPedidosDetDD")]
        public DataTable dtPedidosDetDD { get; set; }

        [DataMember]
        [Column("msnRespuesta")]
        public string msnRespuesta { get; set; }

        [DataMember]
        [Column("headerTemplate")]
        public BETemplateSinMarcar[] headerTemplate { get; set; }

        [DataMember]
        [Column("detailTemplate")]
        public BETemplateSinMarcar[] detailTemplate { get; set; }

        [DataMember]
        [Column("codigoPais")]
        public string codigoPais { get; set; }

        [DataMember]
        [Column("fechaProceso")]
        public string fechaProceso { get; set; }

        [DataMember]
        [Column("lote")]
        public int lote { get; set; }

        [DataMember]
        [Column("origen")]
        public string origen { get; set; }

    }
}
