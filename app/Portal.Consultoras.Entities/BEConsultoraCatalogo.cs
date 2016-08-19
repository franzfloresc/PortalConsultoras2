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

        public string CodigoUsuario { get; set; }
        public int RolId { get; set; }
        public int IdEstadoActividad { get; set; }
        public string AutorizaPedido { get; set; }
        public bool EsAfiliado { get; set; }
        public int UltimaCampania { get; set; }

        public BEConsultoraCatalogo()
        {
            Estado = -1;
        }

        public BEConsultoraCatalogo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                this.CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                this.NombreCompleto = Convert.ToString(row["NombreCompleto"]);

            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                this.IdZona = Convert.ToInt32((row["ZonaID"]).ToString());

            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                this.Correo = Convert.ToString(row["Correo"]);

            if (DataRecord.HasColumn(row, "Celular") && row["Celular"] != DBNull.Value)
                this.TelefonoCelular = Convert.ToString(row["Celular"]);

            if (DataRecord.HasColumn(row, "CodigoZona") && row["CodigoZona"] != DBNull.Value)
                this.CodigoZona = Convert.ToString(row["CodigoZona"]);

            if (DataRecord.HasColumn(row, "FechaInicioFacturacion") && row["FechaInicioFacturacion"] != DBNull.Value)
                this.DiaFacturacion = Convert.ToDateTime((row["FechaInicioFacturacion"]).ToString());

            if (DataRecord.HasColumn(row, "CampaniaActual") && row["CampaniaActual"] != DBNull.Value)
                this.CampaniaActual = Convert.ToInt32((row["CampaniaActual"]).ToString());

            if (DataRecord.HasColumn(row, "HoraCierre") && row["HoraCierre"] != DBNull.Value)
                this.HoraCierre = Convert.ToDateTime(row["HoraCierre"].ToString()).ToShortTimeString();

            if (DataRecord.HasColumn(row, "EstadoActividad") && row["EstadoActividad"] != DBNull.Value)
                this.Estado = Convert.ToInt32((row["EstadoActividad"]).ToString());

            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                this.CodigoUsuario = Convert.ToString((row["CodigoUsuario"]));

            if (DataRecord.HasColumn(row, "Pais") && row["Pais"] != DBNull.Value)
                this.Pais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "IdConsultora") && row["IdConsultora"] != DBNull.Value)
                this.IdConsultora = Convert.ToInt64(row["IdConsultora"]);

            if (DataRecord.HasColumn(row, "CodigoRegion") && row["CodigoRegion"] != DBNull.Value)
                this.CodigoRegion = Convert.ToString(row["CodigoRegion"]);

            if (DataRecord.HasColumn(row, "CodigoSeccion") && row["CodigoSeccion"] != DBNull.Value)
                this.CodigoSeccion = Convert.ToString(row["CodigoSeccion"]);

            if (DataRecord.HasColumn(row, "RolId") && row["RolId"] != DBNull.Value)
                this.RolId = Convert.ToInt32(row["RolId"]);

            if (DataRecord.HasColumn(row, "IdEstadoActividad") && row["IdEstadoActividad"] != DBNull.Value)
                this.IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);

            if (DataRecord.HasColumn(row, "AutorizaPedido") && row["AutorizaPedido"] != DBNull.Value)
                this.AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);

            if (DataRecord.HasColumn(row, "EsAfiliado") && row["EsAfiliado"] != DBNull.Value)
                this.EsAfiliado = Convert.ToBoolean(row["EsAfiliado"]);

            if (DataRecord.HasColumn(row, "UltimaCampania") && row["UltimaCampania"] != DBNull.Value)
                this.UltimaCampania = Convert.ToInt32(row["UltimaCampania"]);

            if (DataRecord.HasColumn(row, "Ubigeo") && row["Ubigeo"] != DBNull.Value)
                this.Ubigeo = Convert.ToString(row["Ubigeo"]);

            if (DataRecord.HasColumn(row, "UnidadGeografica1") && row["UnidadGeografica1"] != DBNull.Value)
                this.UnidadGeografica1 = Convert.ToString(row["UnidadGeografica1"]);

            if (DataRecord.HasColumn(row, "UnidadGeografica2") && row["UnidadGeografica2"] != DBNull.Value)
                this.UnidadGeografica2 = Convert.ToString(row["UnidadGeografica2"]);

            if (DataRecord.HasColumn(row, "UnidadGeografica3") && row["UnidadGeografica3"] != DBNull.Value)
                this.UnidadGeografica3 = Convert.ToString(row["UnidadGeografica3"]);
        }
    }
}