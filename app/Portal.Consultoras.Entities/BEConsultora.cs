using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultora
    {

        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public string SegundoNombre { get; set; }
        [DataMember]
        public string PrimerApellido { get; set; }
        [DataMember]
        public string SegundoApellido { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public DateTime FechaNacimiento { get; set; }
        [DataMember]
        public string Genero { get; set; }
        [DataMember]
        public string EstadoCivil { get; set; }
        [DataMember]
        public string PrimerPedido { get; set; }
        [DataMember]
        public string KitNueva { get; set; }
        [DataMember]
        public string AutorizaPedido { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public decimal MontoUltimoPedido { get; set; }
        [DataMember]
        public string EstatusCapacitacion { get; set; }
        [DataMember]
        public decimal MontoFlexipago { get; set; }
        [DataMember]
        public int CampaniaPrimeraID { get; set; }
        [DataMember]
        public int SeccionID { get; set; }
        [DataMember]
        public string EstadoConsultora { get; set; }
        [DataMember]
        public DateTime FechaIngreso { get; set; }
        [DataMember]
        public int TerritorioID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public string UltimaCampanaFacturada { get; set; }
        [DataMember]
        public decimal MontoSaldoActual { get; set; }
        [DataMember]
        public string EstadoBloqueado { get; set; }
        [DataMember]
        public string AnoCampanaIngreso { get; set; }
        [DataMember]
        public Boolean IndicadorPasoPedido { get; set; }
        [DataMember]
        public Boolean ModificacionDatosBB { get; set; }
        [DataMember]
        public string IndicadorPROL { get; set; }
        [DataMember]
        public int IdEstadoDatamart { get; set; }
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public int SegmentoID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoUbigeo { get; set; }

        public BEConsultora()
        {

        }

        public BEConsultora(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "Codigo"))
                Codigo = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "PrimerNombre"))
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "SegundoNombre"))
                SegundoNombre = Convert.ToString(row["SegundoNombre"]);
            if (DataRecord.HasColumn(row, "PrimerApellido"))
                PrimerApellido = Convert.ToString(row["PrimerApellido"]);
            if (DataRecord.HasColumn(row, "SegundoApellido"))
                SegundoApellido = Convert.ToString(row["SegundoApellido"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "FechaNacimiento"))
                FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
            if (DataRecord.HasColumn(row, "Genero"))
                Genero = Convert.ToString(row["Genero"]);
            if (DataRecord.HasColumn(row, "EstadoCivil"))
                EstadoCivil = Convert.ToString(row["EstadoCivil"]);
            if (DataRecord.HasColumn(row, "PrimerPedido"))
                PrimerPedido = Convert.ToString(row["PrimerPedido"]);
            if (DataRecord.HasColumn(row, "KitNueva"))
                KitNueva = Convert.ToString(row["KitNueva"]);
            if (DataRecord.HasColumn(row, "AutorizaPedido"))
                AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);
            if (DataRecord.HasColumn(row, "Email"))
                Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "MontoUltimoPedido"))
                MontoUltimoPedido = Convert.ToDecimal(row["MontoUltimoPedido"]);
            if (DataRecord.HasColumn(row, "EstatusCapacitacion"))
                EstatusCapacitacion = Convert.ToString(row["EstatusCapacitacion"]);
            if (DataRecord.HasColumn(row, "MontoFlexiPago"))
                MontoFlexipago = Convert.ToDecimal(row["MontoFlexiPago"]);
            if (DataRecord.HasColumn(row, "CampaniaPrimeraID"))
                CampaniaPrimeraID = Convert.ToInt32(row["CampaniaPrimeraID"]);
            if (DataRecord.HasColumn(row, "SeccionID"))
                SeccionID = Convert.ToInt32(row["SeccionID"]);
            if (DataRecord.HasColumn(row, "EstadoConsultora"))
                EstadoConsultora = Convert.ToString(row["EstadoConsultora"]);
            if (DataRecord.HasColumn(row, "FechaIngreso"))
                FechaIngreso = Convert.ToDateTime(row["FechaIngreso"]);
            if (DataRecord.HasColumn(row, "TerritorioID"))
                TerritorioID = Convert.ToInt32(row["TerritorioID"]);
            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "RegionID"))
                RegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "UltimaCampanaFacturada"))
                UltimaCampanaFacturada = Convert.ToString(row["UltimaCampanaFacturada"]);
            if (DataRecord.HasColumn(row, "MontoSaldoActual"))
                MontoSaldoActual = Convert.ToDecimal(row["MontoSaldoActual"]);
            if (DataRecord.HasColumn(row, "EstadoBloqueado"))
                EstadoBloqueado = Convert.ToString(row["EstadoBloqueado"]);
            if (DataRecord.HasColumn(row, "AnoCampanaIngreso"))
                AnoCampanaIngreso = Convert.ToString(row["AnoCampanaIngreso"]);
            if (DataRecord.HasColumn(row, "IndicadorPasoPedido"))
                IndicadorPasoPedido = Convert.ToBoolean(row["IndicadorPasoPedido"]);
            if (DataRecord.HasColumn(row, "ModificacionDatosBB"))
                ModificacionDatosBB = Convert.ToBoolean(row["ModificacionDatosBB"]);
            if (DataRecord.HasColumn(row, "IndicadorPROL"))
                IndicadorPROL = Convert.ToString(row["IndicadorPROL"]);
            if (DataRecord.HasColumn(row, "IdEstadoDatamart"))
                IdEstadoDatamart = Convert.ToInt32(row["IdEstadoDatamart"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad"))
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "SegmentoID"))
                SegmentoID = Convert.ToInt32(row["SegmentoID"]);
            if (DataRecord.HasColumn(row, "CodigoUbigeo"))
                CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
        }
    }
}
