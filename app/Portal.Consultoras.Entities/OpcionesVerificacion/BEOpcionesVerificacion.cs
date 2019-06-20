﻿using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
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
        public int IntentosSms { get; set; }
        [DataMember]
        public bool OpcionChat { get; set; }
        [DataMember]
        public bool OpcionContrasena { get; set; }
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

        //INI HD-3897
        [DataMember]
        public bool OpcionConfirmarEmail { get; set; }
        [DataMember]
        public bool OpcionConfirmarSms { get; set; }
        //FIN HD-3897
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
            OpcionContrasena = row.ToBoolean("OpcionContrasena");
            IntentosSms = row.ToInt32("IntentosSms");
            //INI HD-3897
            OpcionConfirmarEmail = row.HasColumn("OpcionConfirmarEmail")  &&  row.ToBoolean("OpcionConfirmarEmail");
            OpcionConfirmarSms = row.HasColumn("OpcionConfirmarSms") && row.ToBoolean("OpcionConfirmarSms");
            //FIN HD-3897
        }
    }

    [DataContract]
    public class BEUsuarioDatos
    {

        [DataMember]
        [Column("CodigoUsuario")]
        public string CodigoUsuario { get; set; }
        [DataMember]
        [Column("CodigoConsultora")]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [Column("Cantidad")]
        public int Cantidad { get; set; }
        [DataMember]
        [Column("PrimerNombre")]
        public string PrimerNombre { get; set; }
        [DataMember]
        [Column("IdEstadoActividad")]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        [Column("Celular")]
        public string Celular { get; set; }
        [DataMember]
        [Column("Correo")]
        public string Correo { get; set; }
        [DataMember]
        [Column("RegionID")]
        public int RegionID { get; set; }
        [DataMember]
        [Column("ZonaID")]
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
        public bool OpcionDesabilitado { get; set; }
        [DataMember]
        public string DescripcionHorario { get; set; }
        [DataMember]
        public bool OpcionChat { get; set; }
        [DataMember]
        public int OpcionVerificacionSMS { get; set; }
        [DataMember]
        public int OpcionVerificacionCorreo { get; set; }
        [DataMember]
        [Column("OpcionCambioClave")]
        public int OpcionCambioClave { get; set; }
        [DataMember]
        public int IntentosRestanteSms { get; set; }

        public BEUsuarioDatos()
        {
            IntentosRestanteSms = -1;
        }

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
            OpcionCambioClave = row.ToInt32("OpcionCambioClave");
            IntentosRestanteSms = -1;
        }

        [Required]
        [StringLength(6, ErrorMessage = "La contraseña debe tener 6 o más caracteres combinado con letras y números")]
        [RegularExpression("([a-zA-Z]{1,})([@$!%*#?&]{1,})([0-9]{1,})", ErrorMessage = "La contraseña debe tener 6 o más caracteres combinado con letras y números")]
        public string Contrasenia { get; set; }
    }


}
