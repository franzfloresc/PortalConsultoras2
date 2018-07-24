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
            ConsultoraID = row.ToInt64("ConsultoraID");
            Codigo = row.ToString("Codigo");
            PrimerNombre = row.ToString("PrimerNombre");
            SegundoNombre = row.ToString("SegundoNombre");
            PrimerApellido = row.ToString("PrimerApellido");
            SegundoApellido = row.ToString("SegundoApellido");
            NombreCompleto = row.ToString("NombreCompleto");
            FechaNacimiento = row.ToDateTime("FechaNacimiento");
            Genero = row.ToString("Genero");
            EstadoCivil = row.ToString("EstadoCivil");
            PrimerPedido = row.ToString("PrimerPedido");
            KitNueva = row.ToString("KitNueva");
            AutorizaPedido = row.ToString("AutorizaPedido");
            Email = row.ToString("Email");
            MontoUltimoPedido = row.ToDecimal("MontoUltimoPedido");
            EstatusCapacitacion = row.ToString("EstatusCapacitacion");
            MontoFlexipago = row.ToDecimal("MontoFlexiPago");
            CampaniaPrimeraID = row.ToInt32("CampaniaPrimeraID");
            SeccionID = row.ToInt32("SeccionID");
            EstadoConsultora = row.ToString("EstadoConsultora");
            FechaIngreso = row.ToDateTime("FechaIngreso");
            TerritorioID = row.ToInt32("TerritorioID");
            ZonaID = row.ToInt32("ZonaID");
            RegionID = row.ToInt32("RegionID");
            UltimaCampanaFacturada = row.ToString("UltimaCampanaFacturada");
            MontoSaldoActual = row.ToDecimal("MontoSaldoActual");
            EstadoBloqueado = row.ToString("EstadoBloqueado");
            AnoCampanaIngreso = row.ToString("AnoCampanaIngreso");
            IndicadorPasoPedido = row.ToBoolean("IndicadorPasoPedido");
            ModificacionDatosBB = row.ToBoolean("ModificacionDatosBB");
            IndicadorPROL = row.ToString("IndicadorPROL");
            IdEstadoDatamart = row.ToInt32("IdEstadoDatamart");
            IdEstadoActividad = row.ToInt32("IdEstadoActividad");
            SegmentoID = row.ToInt32("SegmentoID");
            CodigoUbigeo = row.ToString("CodigoUbigeo");
        }
    }
}
