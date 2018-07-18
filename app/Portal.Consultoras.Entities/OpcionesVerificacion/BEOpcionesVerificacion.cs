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
        public bool TieneZonas { get; set; }
        [DataMember]
        public bool Activo { get; set; }
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


        public BEUsuarioDatos()
        { }

        public BEUsuarioDatos(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrimerNombre"))
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad"))
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "Celular"))
                Celular = Convert.ToString(row["Celular"]);
            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "RegionID"))
                RegionID = Convert.ToInt32(row["RegionID"]);
        }
    }
}
