using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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

        [DataMember(Order = 11)]
        public long IdConsultora { get; set; }

        [DataMember(Order = 12)]
        public string CodigoRegion { get; set; }

        [DataMember(Order = 13)]
        public string CodigoSeccion { get; set; }

        [DataMember(Order = 14)]
        public string Ubigeo { get; set; }

        [DataMember(Order = 15)]
        public string UnidadGeografica1 { get; set; }

        [DataMember(Order = 16)]
        public string UnidadGeografica2 { get; set; }

        [DataMember(Order = 17)]
        public string UnidadGeografica3 { get; set; }

        [DataMember(Order = 18)]
        public int CampaniaActualID { get; set; }

        [DataMember(Order = 19)]
        public int IdEstadoActividad { get; set; }

        public string CodigoUsuario { get; set; }
        public int RolId { get; set; }

        public string AutorizaPedido { get; set; }
        public bool EsAfiliado { get; set; }
        public int UltimaCampania { get; set; }

        public BEConsultoraCatalogo()
        {
            Estado = -1;
        }

        public BEConsultoraCatalogo(IDataRecord row)
        {
            CodigoConsultora = row.ToString("CodigoConsultora");
            NombreCompleto = row.ToString("NombreCompleto");
            if (DataRecord.HasColumn(row, "ZonaID"))
                IdZona = Convert.ToInt32((row["ZonaID"]).ToString());
            Correo = row.ToString("Correo");
            TelefonoCelular = row.ToString("Celular");
            CodigoZona = row.ToString("CodigoZona");
            if (DataRecord.HasColumn(row, "FechaInicioFacturacion"))
                DiaFacturacion = Convert.ToDateTime((row["FechaInicioFacturacion"]).ToString());
            if (DataRecord.HasColumn(row, "CampaniaActual"))
                CampaniaActual = Convert.ToInt32((row["CampaniaActual"]).ToString());
            if (DataRecord.HasColumn(row, "HoraCierre"))
                HoraCierre = Convert.ToDateTime(row["HoraCierre"]).ToShortTimeString();
            if (DataRecord.HasColumn(row, "EstadoActividad"))
                Estado = Convert.ToInt32((row["EstadoActividad"]).ToString());
            CodigoUsuario = row.ToString("CodigoUsuario");
            Pais = row.ToString("Pais");
            IdConsultora = row.ToInt64("IdConsultora");
            CodigoRegion = row.ToString("CodigoRegion");
            CodigoSeccion = row.ToString("CodigoSeccion");
            RolId = row.ToInt32("RolId");
            IdEstadoActividad = row.ToInt32("IdEstadoActividad");
            AutorizaPedido = row.ToString("AutorizaPedido");
            EsAfiliado = row.ToBoolean("EsAfiliado");
            UltimaCampania = row.ToInt32("UltimaCampania");
            Ubigeo = row.ToString("Ubigeo");
            UnidadGeografica1 = row.ToString("UnidadGeografica1");
            UnidadGeografica2 = row.ToString("UnidadGeografica2");
            UnidadGeografica3 = row.ToString("UnidadGeografica3");
            CampaniaActualID = row.ToInt32("CampaniaActualID");
        }
    }
}
