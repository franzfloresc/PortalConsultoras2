﻿using System;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivoNivel
    {
        [Column("CodigoConcurso")]
        [DataMember]
        public string CodigoConcurso { get; set; }
        [Column("CodigoNivel")]
        [DataMember]
        public int CodigoNivel { get; set; }
        [Column("PuntosNivel")]
        [DataMember]
        public int PuntosNivel { get; set; }
        [Column("PuntosFaltantes")]
        [DataMember]
        public int PuntosFaltantes { get; set; }
        [Column("IndicadorPremiacionPedido")]
        [DataMember]
        public bool IndicadorPremiacionPedido { get; set; }
        [Column("MontoPremiacionPedido")]
        [DataMember]
        public decimal MontoPremiacionPedido { get; set; }
        [Column("IndicadorBelCenter")]
        [DataMember]
        public bool IndicadorBelCenter { get; set; }
        [Column("FechaVentaRetail")]
        [DataMember]
        public DateTime? FechaVentaRetail { get; set; }
        [Column("IndicadorNivelElectivo")]
        [DataMember]
        public bool IndicadorNivelElectivo { get; set; }
        [Column("PuntosExigidos")]
        [DataMember]
        public int PuntosExigidos { get; set; }
        [Column("PuntosExigidosFaltantes")]
        [DataMember]
        public int PuntosExigidosFaltantes { get; set; }
        [DataMember]
        public string CodigoPremio { get; set; }
        [DataMember]
        public string DescripcionPremio { get; set; }
        [DataMember]
        public string NumeroPremio { get; set; }

        public BEIncentivoNivel()
        {

        }
    }
}