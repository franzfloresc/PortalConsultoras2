using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEHorario
    {
        [DataMember]
        public int HorarioID { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Resumen { get; set; }
        [DataMember]
        public byte PrimerDiaSemana { get; set; }
        [DataMember]
        public bool HoraISO { get; set; }
        [DataMember]
        public bool HoraIncluyente { get; set; }
        [DataMember]
        public bool EstaDisponible { get; set; }

        public BEHorario(IDataRecord row)
        {
            HorarioID = row.ToInt32("HorarioID");
            Codigo = row.ToString("Codigo");
            Resumen = row.ToString("Resumen");
            PrimerDiaSemana = row.ToByte("PrimerDiaSemana");
            HoraISO = row.ToBoolean("HoraISO");
            HoraIncluyente = row.ToBoolean("HoraIncluyente");
        }
    }
}
