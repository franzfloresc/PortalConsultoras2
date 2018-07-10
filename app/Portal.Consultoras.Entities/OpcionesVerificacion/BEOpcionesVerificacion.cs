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
        {}

        public BEOpcionesVerificacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "OrigenID") && row["OrigenID"] != DBNull.Value)
                OrigenID = Convert.ToInt32(row["OrigenID"]);
            if (DataRecord.HasColumn(row, "OrigenDescripcion") && row["OrigenDescripcion"] != DBNull.Value)
                OrigenDescripcion = Convert.ToString(row["OrigenDescripcion"]);
            if (DataRecord.HasColumn(row, "OpcionEmail") && row["OpcionEmail"] != DBNull.Value)
                OpcionEmail = Convert.ToBoolean(row["OpcionEmail"]);
            if (DataRecord.HasColumn(row, "OpcionSms") && row["OpcionSms"] != DBNull.Value)
                OpcionSms = Convert.ToBoolean(row["OpcionSms"]);
            if (DataRecord.HasColumn(row, "OpcionChat") && row["OpcionChat"] != DBNull.Value)
                OpcionChat = Convert.ToBoolean(row["OpcionChat"]);
            if (DataRecord.HasColumn(row, "OpcionBelcorpResponde") && row["OpcionBelcorpResponde"] != DBNull.Value)
                OpcionBelcorpResponde = Convert.ToBoolean(row["OpcionBelcorpResponde"]);
            if (DataRecord.HasColumn(row, "IncluyeFiltros") && row["IncluyeFiltros"] != DBNull.Value)
                IncluyeFiltros = Convert.ToBoolean(row["IncluyeFiltros"]);
            if (DataRecord.HasColumn(row, "TieneZonas") && row["TieneZonas"] != DBNull.Value)
                TieneZonas = Convert.ToBoolean(row["TieneZonas"]);
            if (DataRecord.HasColumn(row, "Activo") && row["Activo"] != DBNull.Value)
                Activo = Convert.ToBoolean(row["Activo"]);
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
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value)
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrimerNombre") && row["PrimerNombre"] != DBNull.Value)
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad") && row["IdEstadoActividad"] != DBNull.Value)
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "Celular") && row["Celular"] != DBNull.Value)
                Celular = Convert.ToString(row["Celular"]);
            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "RegionID") && row["RegionID"] != DBNull.Value)
                RegionID = Convert.ToInt32(row["RegionID"]);
        }
    }
}
