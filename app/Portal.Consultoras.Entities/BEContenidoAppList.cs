using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoAppList : BaseEntidad
    {
       
        [DataMember]
        public int IdContenidoDeta { get; set; }
        [DataMember]
        public int IdContenido { get; set; }
        [DataMember]
        public string CodigoDetalle { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string RutaContenido { get; set; }
        [DataMember]
        public string Accion { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public bool Estado { get; set; }
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string Region { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string Seccion { get; set; }
        [DataMember]
        public string DetaCodigo { get; set; }
        [DataMember]
        public string DetaAccionDescripcion { get; set; }
        [DataMember]
        public string DetaCodigoDetalleDescripcion { get; set; }
        [DataMember]
        public string Codigo { get; set; }

    }
}
