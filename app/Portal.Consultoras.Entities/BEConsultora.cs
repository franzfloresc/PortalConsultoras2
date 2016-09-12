using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

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
            if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value)
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "Codigo") && row["Codigo"] != DBNull.Value)
                Codigo = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "PrimerNombre") && row["PrimerNombre"] != DBNull.Value)
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "SegundoNombre") && row["SegundoNombre"] != DBNull.Value)
                SegundoNombre = Convert.ToString(row["SegundoNombre"]);
            if (DataRecord.HasColumn(row, "PrimerApellido") && row["PrimerApellido"] != DBNull.Value)
                PrimerApellido = Convert.ToString(row["PrimerApellido"]);
            if (DataRecord.HasColumn(row, "SegundoApellido") && row["SegundoApellido"] != DBNull.Value)
                SegundoApellido = Convert.ToString(row["SegundoApellido"]);
            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "FechaNacimiento") && row["FechaNacimiento"] != DBNull.Value)
                FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
            if (DataRecord.HasColumn(row, "Genero") && row["Genero"] != DBNull.Value)
                Genero = Convert.ToString(row["Genero"]);
            if (DataRecord.HasColumn(row, "EstadoCivil") && row["EstadoCivil"] != DBNull.Value)
                EstadoCivil = Convert.ToString(row["EstadoCivil"]);
            if (DataRecord.HasColumn(row, "PrimerPedido") && row["PrimerPedido"] != DBNull.Value)
                PrimerPedido = Convert.ToString(row["PrimerPedido"]);
            if (DataRecord.HasColumn(row, "KitNueva") && row["KitNueva"] != DBNull.Value)
                KitNueva = Convert.ToString(row["KitNueva"]);
            if (DataRecord.HasColumn(row, "AutorizaPedido") && row["AutorizaPedido"] != DBNull.Value)
                AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);
            if (DataRecord.HasColumn(row, "Email") && row["Email"] != DBNull.Value)
                Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "MontoUltimoPedido") && row["MontoUltimoPedido"] != DBNull.Value)
                MontoUltimoPedido = Convert.ToDecimal(row["MontoUltimoPedido"]);
            if (DataRecord.HasColumn(row, "EstatusCapacitacion") && row["EstatusCapacitacion"] != DBNull.Value)
                EstatusCapacitacion = Convert.ToString(row["EstatusCapacitacion"]);
            if (DataRecord.HasColumn(row, "MontoFlexiPago") && row["MontoFlexiPago"] != DBNull.Value)
                MontoFlexipago = Convert.ToDecimal(row["MontoFlexiPago"]);
            if (DataRecord.HasColumn(row, "CampaniaPrimeraID") && row["CampaniaPrimeraID"] != DBNull.Value)
                CampaniaPrimeraID = Convert.ToInt32(row["CampaniaPrimeraID"]);
            if (DataRecord.HasColumn(row, "SeccionID") && row["SeccionID"] != DBNull.Value)
                SeccionID = Convert.ToInt32(row["SeccionID"]);
            if (DataRecord.HasColumn(row, "EstadoConsultora") && row["EstadoConsultora"] != DBNull.Value)
                EstadoConsultora = Convert.ToString(row["EstadoConsultora"]);
            if (DataRecord.HasColumn(row, "FechaIngreso") && row["FechaIngreso"] != DBNull.Value)
                FechaIngreso = Convert.ToDateTime(row["FechaIngreso"]);
            if (DataRecord.HasColumn(row, "TerritorioID") && row["TerritorioID"] != DBNull.Value)
                TerritorioID = Convert.ToInt32(row["TerritorioID"]);
            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "RegionID") && row["RegionID"] != DBNull.Value)
                RegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "UltimaCampanaFacturada") && row["UltimaCampanaFacturada"] != DBNull.Value)
                UltimaCampanaFacturada = Convert.ToString(row["UltimaCampanaFacturada"]);
            if (DataRecord.HasColumn(row, "MontoSaldoActual") && row["MontoSaldoActual"] != DBNull.Value)
                MontoSaldoActual = Convert.ToDecimal(row["MontoSaldoActual"]);
            if (DataRecord.HasColumn(row, "EstadoBloqueado") && row["EstadoBloqueado"] != DBNull.Value)
                EstadoBloqueado = Convert.ToString(row["EstadoBloqueado"]);
            if (DataRecord.HasColumn(row, "AnoCampanaIngreso") && row["AnoCampanaIngreso"] != DBNull.Value)
                AnoCampanaIngreso = Convert.ToString(row["AnoCampanaIngreso"]);
            if (DataRecord.HasColumn(row, "IndicadorPasoPedido") && row["IndicadorPasoPedido"] != DBNull.Value)
                IndicadorPasoPedido = Convert.ToBoolean(row["IndicadorPasoPedido"]);
            if (DataRecord.HasColumn(row, "ModificacionDatosBB") && row["ModificacionDatosBB"] != DBNull.Value)
                ModificacionDatosBB = Convert.ToBoolean(row["ModificacionDatosBB"]);
            if (DataRecord.HasColumn(row, "IndicadorPROL") && row["IndicadorPROL"] != DBNull.Value)
                IndicadorPROL = Convert.ToString(row["IndicadorPROL"]);
            if (DataRecord.HasColumn(row, "IdEstadoDatamart") && row["IdEstadoDatamart"] != DBNull.Value)
                IdEstadoDatamart = Convert.ToInt32(row["IdEstadoDatamart"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad") && row["IdEstadoActividad"] != DBNull.Value)
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "SegmentoID") && row["SegmentoID"] != DBNull.Value)
                SegmentoID = Convert.ToInt32(row["SegmentoID"]);
            if (DataRecord.HasColumn(row, "CodigoUbigeo") && row["CodigoUbigeo"] != DBNull.Value)
                CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
        }


    }


    




}
