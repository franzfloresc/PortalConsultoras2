using System;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraCatalogo
    {

        [DataMember(Order = 0)]
        public string Pais { get; set; }

        [DataMember(Order = 1)]
        public string CodigoConsultora { get; set; }

        [DataMember(Order = 2)]
        public string NombreCompleto { get; set; }

        [DataMember(Order = 3)]
        public string Correo { get; set; }

        [DataMember(Order = 4)]
        public string TelefonoCelular { get; set; }

        [DataMember(Order = 5)]
        public string CodigoZona { get; set; }

        [DataMember(Order = 6)]
        public int IdZona { get; set; }

        [DataMember(Order = 7)]
        public int CampaniaActual { get; set; }

        [DataMember(Order = 8)]
        public DateTime DiaFacturacion { get; set; }

        [DataMember(Order = 9)]
        public string HoraCierre { get; set; }

        [DataMember(Order = 10)]
        public int Estado { get; set; }

        //[DataMember(Order = 11)]
        public string CodigoUsuario { get; set; }


        public BEConsultoraCatalogo() {
            Estado = -1;
        }

        public BEConsultoraCatalogo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);

            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                IdZona = Convert.ToInt32((row["ZonaID"]).ToString());

            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                Correo = Convert.ToString(row["Correo"]);

            if (DataRecord.HasColumn(row, "Celular") && row["Celular"] != DBNull.Value)
                TelefonoCelular = Convert.ToString(row["Celular"]);

            if (DataRecord.HasColumn(row, "CodigoZona") && row["CodigoZona"] != DBNull.Value)
                CodigoZona = Convert.ToString(row["CodigoZona"]);

            if (DataRecord.HasColumn(row, "FechaInicioFacturacion") && row["FechaInicioFacturacion"] != DBNull.Value)
                DiaFacturacion = Convert.ToDateTime((row["FechaInicioFacturacion"]).ToString());

            if (DataRecord.HasColumn(row, "CampaniaActual") && row["CampaniaActual"] != DBNull.Value)
                CampaniaActual = Convert.ToInt32((row["CampaniaActual"]).ToString());

            if (DataRecord.HasColumn(row, "HoraCierre") && row["HoraCierre"] != DBNull.Value)
                HoraCierre = Convert.ToDateTime(row["HoraCierre"].ToString()).ToShortTimeString();

            if (DataRecord.HasColumn(row, "EstadoActividad") && row["EstadoActividad"] != DBNull.Value)
                Estado = Convert.ToInt32((row["EstadoActividad"]).ToString());

            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString((row["CodigoUsuario"]));

            if (DataRecord.HasColumn(row, "Pais") && row["Pais"] != DBNull.Value)
                Pais = Convert.ToString(row["Pais"]);
        }
    }
}
