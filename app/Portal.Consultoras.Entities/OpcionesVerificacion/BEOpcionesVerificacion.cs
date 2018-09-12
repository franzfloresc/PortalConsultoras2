using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.OpcionesVerificacion
{
    [DataContract]
    public class BEOpcionesVerificacion
    {
        [DataMember]
        public int OrigenID { get; set; }
        [DataMember]
        public string OrigenDescripcion { get; set; }
        [DataMember]
        public bool OpcionEmail { get; set; }
        [DataMember]
        public bool OpcionSms { get; set; }
        [DataMember]
        public bool OpcionChat { get; set; }
        [DataMember]
        public bool OpcionBelcorpResponde { get; set; }
        [DataMember]
        public bool IncluyeFiltros { get; set; }
        [DataMember]
        public bool TieneAlcanse { get; set; }
        [DataMember]
        public bool Activo { get; set; }
        [DataMember]
        public List<BEZonasOpcionesVerificacion> lstZonas { get; set; }
        [DataMember]
        public bool TieneZonas { get; set; }
        [DataMember]
        public BEZonasOpcionesVerificacion oZona { get; set; }
        [DataMember]
        public List<BEFiltrosOpcionesVerificacion> lstFiltros { get; set; }

        public BEOpcionesVerificacion()
        { }

        public BEOpcionesVerificacion(IDataRecord row)
        {
            OrigenID = row.ToInt32("OrigenID");
            OrigenDescripcion = row.ToString("OrigenDescripcion");
            OpcionEmail = row.ToBoolean("OpcionEmail");
            OpcionSms = row.ToBoolean("OpcionSms");
            OpcionChat = row.ToBoolean("OpcionChat");
            OpcionBelcorpResponde = row.ToBoolean("OpcionBelcorpResponde");
            IncluyeFiltros = row.ToBoolean("IncluyeFiltros");
            TieneZonas = row.ToBoolean("TieneZonas");
            Activo = row.ToBoolean("Activo");
            TieneAlcanse = row.ToBoolean("TieneAlcanse");

        }
    }

    [DataContract]
    public class BEUsuarioDatos
    {
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public string Celular { get; set; }
        [DataMember]
        public string Correo { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public int OrigenID { get; set; }
        [DataMember]
        public string OrigenDescripcion { get; set; }
        [DataMember]
        public int MostrarOpcion { get; set; }
        [DataMember]
        public string MensajeSaludo { get; set; }
        [DataMember]
        public int campaniaID { get; set; }
        [DataMember]
        public string CorreoEnmascarado { get; set; }
        [DataMember]
        public string CelularEnmascarado { get; set; }
        [DataMember]
        public string TelefonoCentral { get; set; }
        [DataMember]
        public string OpcionCorreoActiva { get; set; }
        [DataMember]
        public string OpcionSmsActiva { get; set; }
        [DataMember]
        public string OpcionCorreoDesabilitado { get; set; }
        [DataMember]
        public string OpcionSmsDesabilitado { get; set; }
        [DataMember]
        public int HoraRestanteCorreo { get; set; }
        [DataMember]
        public int HoraRestanteSms { get; set; }
        [DataMember]
        public bool EsMobile { get; set; }
        [DataMember]
        public string CodigoIso { get; set; }
        [DataMember]
        public bool opcionHabilitar { get { return true; } set { } }
        [DataMember]
        public bool OpcionDesabilitado { get; set; }
        [DataMember]
        public string DescripcionHorario { get; set; }
        [DataMember]
        public bool OpcionChat { get; set; }
        [DataMember]
        public BEBelcorpResponde BelcorpResponde { get; set; }

        public BEUsuarioDatos()
        { }

        public BEUsuarioDatos(IDataRecord row)
        {
            
            CodigoUsuario = row.ToString("CodigoUsuario");
            
            CodigoConsultora = row.ToString("CodigoConsultora");
            
            Cantidad = row.ToInt32("Cantidad");
            
            PrimerNombre = row.ToString("PrimerNombre");
            
            IdEstadoActividad = row.ToInt32("IdEstadoActividad");
            
            Celular = row.ToString("Celular");
            
            Correo = row.ToString("Correo");
            
            ZonaID = row.ToInt32("ZonaID");
            
            RegionID = row.ToInt32("RegionID");

            CodigoConsultora = row.ToString("CodigoConsultora");
        }
    }
}
