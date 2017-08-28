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
            if (DataRecord.HasColumn(row, "HorarioID")) HorarioID = Convert.ToInt32(row["HorarioID"]);
            if (DataRecord.HasColumn(row, "Codigo")) Codigo = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "Resumen")) Resumen = Convert.ToString(row["Resumen"]);
            if (DataRecord.HasColumn(row, "PrimerDiaSemana")) PrimerDiaSemana = Convert.ToByte(row["PrimerDiaSemana"]);
            if (DataRecord.HasColumn(row, "HoraISO")) HoraISO = Convert.ToBoolean(row["HoraISO"]);
            if (DataRecord.HasColumn(row, "HoraIncluyente")) HoraIncluyente = Convert.ToBoolean(row["HoraIncluyente"]);
        }
    }
}
