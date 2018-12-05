using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEActivarPremioNuevas
    {
        [DataMember]
        [Column("CodigoPrograma")]
        public string CodigoPrograma { get; set; }
        [DataMember]
        [Column("AnioCampanaIni")]
        public int AnioCampanaIni { get; set; }
        [DataMember]
        [Column("AnioCampanaFin")]
        public int AnioCampanaFin { get; set; }
        [DataMember]
        [Column("Nivel")]
        public string Nivel { get; set; }
        [DataMember]
        [Column("ActivePremioAuto")]
        public bool ActivePremioAuto { get; set; }
        [DataMember]
        [Column("ActivePremioElectivo")]
        public bool ActivePremioElectivo { get; set; }
        [DataMember]
        [Column("ActiveMonto")]
        public bool ActiveMonto { get; set; }
        [DataMember]
        [Column("ActiveTooltip")]
        public bool ActiveTooltip { get; set; }
        [DataMember]
        [Column("FechaCreate")]
        public DateTime FechaCreate { get; set; }
    }
}
