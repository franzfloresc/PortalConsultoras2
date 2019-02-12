using Portal.Consultoras.Entities.Comunicado;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEComunicado
    {
        [DataMember]
        [Column("ComunicadoId")]
        public long ComunicadoId { get; set; }
        [DataMember]
        [Column("Visualizo")]
        public bool Visualizo { get; set; }
        [DataMember]
        [Column("CodigoConsultora")]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [Column("CodigoCampania")]
        public string CodigoCampania { get; set; }
        [DataMember]
        [Column("Accion")]
        public string Accion { get; set; }
        [DataMember]
        [Column("DescripcionAccion")]
        public string DescripcionAccion { get; set; }
        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }
        [DataMember]
        [Column("UrlImagen")]
        public string UrlImagen { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("SegmentacionID")]
        public int? SegmentacionID { get; set; }
        [DataMember]
        [Column("SegmentacionConsultora")]
        public bool SegmentacionConsultora { get; set; }
        [DataMember]
        [Column("SegmentacionRegionZona")]
        public bool SegmentacionRegionZona { get; set; }
        [DataMember]
        [Column("SegmentacionEstadoActividad")]
        public bool SegmentacionEstadoActividad { get; set; }
        [DataMember]
        public List<BEComunicadoVista> Vistas { get; set; }

        [DataMember]
        [Column("FechaInicio")]
        public string FechaInicio { get; set; }

        [DataMember]
        [Column("FechaFin")]
        public string FechaFin { get; set; }

        [DataMember]
        [Column("Titulo")]
        public string Titulo { get; set; }

        [DataMember]
        [Column("Activo")]
        public bool Activo { get; set; }

        [DataMember]
        [Column("Numero")]
        public int Numero { get; set; }

        [DataMember]
        [Column("NombreArchivoCCV")]
        public string NombreArchivoCCV { get; set; }

        [DataMember]
        [Column("TipoDispositivo")]
        public int TipoDispositivo { get; set; }

    }

    







    }
