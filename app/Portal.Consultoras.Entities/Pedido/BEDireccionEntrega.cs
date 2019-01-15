using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEDireccionEntrega
    {
        [DataMember]
        [Column("DireccionEntregaID")]
        public int DireccionEntregaID { get; set; }
        [DataMember]
        [Column("ConsultoraID")]
        public int ConsultoraID { get; set; }
        [DataMember]
        [Column("CampaniaID")]
        public  int CampaniaID { get; set; }
        [DataMember]
        [Column("CampaniaAnteriorID")]
        public int CampaniaAnteriorID { get; set; }
        [DataMember]
        [Column("Ubigeo1")]
        public int Ubigeo1 { get; set; }
        [DataMember]
        [Column("Ubigeo2")]
        public int Ubigeo2 { get; set; }
        [DataMember]
        [Column("Ubigeo3")]
        public int Ubigeo3 { get; set; }
        [DataMember]
        [Column("Ubigeo1Anterior")]
        public int Ubigeo1Anterior { get; set; }
        [DataMember]
        [Column("Ubigeo2Anterior")]
        public int Ubigeo2Anterior { get; set; }
        [DataMember]
        [Column("Ubigeo3Anterior")]
        public int Ubigeo3Anterior { get; set; }
        [DataMember]
        [Column("DireccionAnterior")]
        public string DireccionAnterior { get; set; }
        [DataMember]
        [Column("Direccion")]
        public string Direccion { get; set; }
        [DataMember]
        [Column("Referencia")]
        public string Referencia { get; set; }
        [DataMember]
        [Column("CodigoConsultora")]
        public  string CodigoConsultora { get; set; }
        [DataMember]
        [Column("LatitudAnterior")]
        public decimal LatitudAnterior { get; set; }
        [DataMember]
        [Column("LongitudAnterior")]
        public decimal LongitudAnterior { get; set; }
        [DataMember]
        [Column("Latitud")]
        public decimal Latitud { get; set; }
        [DataMember]
        [Column("Longitud")]
        public decimal Longitud { get; set; }
        [DataMember]
        [Column("UltimafechaActualizacion")]
        public  DateTime? UltimafechaActualizacion { get; set; }
        [DataMember]
        public  string CodigoUsuario { get; set; }
        [DataMember]
        public  int PaisID { get; set; }
        [DataMember]
        public int Resultado { get; set; }
        [DataMember]
        public int Operacion { get; set; }
        [DataMember]
        public string ReferenciaAnterior { get; set; }

    }
}
