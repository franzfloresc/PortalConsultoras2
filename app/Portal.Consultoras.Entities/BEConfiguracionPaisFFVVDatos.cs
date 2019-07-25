﻿using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPaisFFVVDatos : BaseEntidad
    {
        [DataMember]
        [Column("ID")]
        public int ID { get; set; }

        [DataMember]
        [Column("CodPais")]
        public string CodPais { get; set; }

        [DataMember]
        [Column("DesarrolloNivelCumplimientoHabilitado")]
        public int DesarrolloNivelCumplimientoHabilitado { get; set; }

        [DataMember]
        [Column("EdicionFichaConsultoraHabilitado")]
        public int EdicionFichaConsultoraHabilitado { get; set; }

        [DataMember]
        [Column("MinimoNumeroDigitosTelefonoTrabajoConsultora")]
        public int MinimoNumeroDigitosTelefonoTrabajoConsultora { get; set; }

        [DataMember]
        [Column("MaximoNumeroDigitosTelefonoTrabajoConsultora")]
        public int MaximoNumeroDigitosTelefonoTrabajoConsultora { get; set; }

        [DataMember]
        [Column("DiasCobranza")]
        public int DiasCobranza { get; set; }

        [DataMember]
        [Column("FlagDigitoVerificador")]
        public bool FlagDigitoVerificador { get; set; }

        [DataMember]
        [Column("FlagGeo")]
        public bool FlagGeo { get; set; }

        [DataMember]
        [Column("FlagHanna")]
        public bool FlagHanna { get; set; }

        [DataMember]
        [Column("FlagPC")]
        public bool FlagPC { get; set; }

        [DataMember]
        [Column("FlagRDD")]
        public bool FlagRDD { get; set; }

        [DataMember]
        [Column("FlagGanaMas")]
        public bool FlagGanaMas { get; set; }

        [DataMember]
        [Column("FlagPDV")]
        public bool FlagPDV { get; set; }

        [DataMember]
        [Column("FlagConfZonasUnete")]
        public bool FlagConfZonasUnete { get; set; }






        [DataMember]
        [Column("CodigoISO")]
        public string CodigoISO { get; set; }

    }
}
