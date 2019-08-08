using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Portal.Consultoras.Common;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEEncuestaReporte
    {
        [DataMember]
        public string EncuestaResultadoId { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string Consultora { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string Region { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string Calificacion { get; set; }
        [DataMember]
        public string Motivo { get; set; }

        public BEEncuestaReporte(IDataRecord row)
        {
            CodigoCampania = row.ToString("CodigoCampania");
            Consultora = row.ToString("Consultora");
            CodigoConsultora = row.ToString("CodigoConsultora");
            RegionID = row.ToInt32("RegionID");
            ZonaID = row.ToInt32("ZonaID");
            Region = row.ToString("Region");
            Zona = row.ToString("Zona");
            Motivo = row.ToString("Motivo");
            Calificacion = row.ToString("Calificacion");
            EncuestaResultadoId = row.ToString("EncuestaResultadoId");

        }

    }
}
