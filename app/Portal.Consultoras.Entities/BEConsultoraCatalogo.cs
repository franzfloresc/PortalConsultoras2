﻿using Portal.Consultoras.Common;
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
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);

            if (DataRecord.HasColumn(row, "ZonaID"))
                IdZona = Convert.ToInt32((row["ZonaID"]).ToString());

            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);

            if (DataRecord.HasColumn(row, "Celular"))
                TelefonoCelular = Convert.ToString(row["Celular"]);

            if (DataRecord.HasColumn(row, "CodigoZona"))
                CodigoZona = Convert.ToString(row["CodigoZona"]);

            if (DataRecord.HasColumn(row, "FechaInicioFacturacion"))
                DiaFacturacion = Convert.ToDateTime((row["FechaInicioFacturacion"]).ToString());

            if (DataRecord.HasColumn(row, "CampaniaActual"))
                CampaniaActual = Convert.ToInt32((row["CampaniaActual"]).ToString());

            if (DataRecord.HasColumn(row, "HoraCierre"))
                HoraCierre = Convert.ToDateTime(row["HoraCierre"]).ToShortTimeString();

            if (DataRecord.HasColumn(row, "EstadoActividad"))
                Estado = Convert.ToInt32((row["EstadoActividad"]).ToString());

            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);

            if (DataRecord.HasColumn(row, "Pais"))
                Pais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "IdConsultora"))
                IdConsultora = Convert.ToInt64(row["IdConsultora"]);

            if (DataRecord.HasColumn(row, "CodigoRegion"))
                CodigoRegion = Convert.ToString(row["CodigoRegion"]);

            if (DataRecord.HasColumn(row, "CodigoSeccion"))
                CodigoSeccion = Convert.ToString(row["CodigoSeccion"]);

            if (DataRecord.HasColumn(row, "RolId"))
                RolId = Convert.ToInt32(row["RolId"]);

            if (DataRecord.HasColumn(row, "IdEstadoActividad"))
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);

            if (DataRecord.HasColumn(row, "AutorizaPedido"))
                AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);

            if (DataRecord.HasColumn(row, "EsAfiliado"))
                EsAfiliado = Convert.ToBoolean(row["EsAfiliado"]);

            if (DataRecord.HasColumn(row, "UltimaCampania"))
                UltimaCampania = Convert.ToInt32(row["UltimaCampania"]);

            if (DataRecord.HasColumn(row, "Ubigeo"))
                Ubigeo = Convert.ToString(row["Ubigeo"]);

            if (DataRecord.HasColumn(row, "UnidadGeografica1"))
                UnidadGeografica1 = Convert.ToString(row["UnidadGeografica1"]);

            if (DataRecord.HasColumn(row, "UnidadGeografica2"))
                UnidadGeografica2 = Convert.ToString(row["UnidadGeografica2"]);

            if (DataRecord.HasColumn(row, "UnidadGeografica3"))
                UnidadGeografica3 = Convert.ToString(row["UnidadGeografica3"]);

            if (DataRecord.HasColumn(row, "CampaniaActualID"))
                CampaniaActualID = Convert.ToInt32(row["CampaniaActualID"]);

            if (DataRecord.HasColumn(row, "IdEstadoActividad"))
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
        }
    }
}