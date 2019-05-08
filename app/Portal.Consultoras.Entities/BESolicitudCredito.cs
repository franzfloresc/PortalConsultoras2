namespace Portal.Consultoras.Entities
{
    using Portal.Consultoras.Common;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BESolicitudCredito
    {
        #region Propiedades Internas

        [DataMember]
        public int SolicitudCreditoID { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string TipoSolicitud { get; set; }

        [DataMember]
        public string CodigoUbigeo { get; set; }

        [DataMember]
        public bool IndicadorActivo { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public DateTime? FechaCreacion { get; set; }

        [DataMember]
        public int CodigoLote { get; set; }

        [DataMember]
        public string Estado { get; set; }

        [DataMember]
        public string FuenteIngreso { get; set; }

        [DataMember]
        public string NumeroPreimpreso { get; set; }

        [DataMember]
        public string CodigoIso { get; set; }

        #endregion

        #region Propiedades: Datos de la Inscripcion

        [DataMember]
        public string CodigoZona { get; set; }

        [DataMember]
        public string CodigoTerritorio { get; set; }

        [DataMember]
        public int TipoContacto { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CodigoConsultoraRecomienda { get; set; }

        [DataMember]
        public string NombreConsultoraRecomienda { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public string CodigoPremio { get; set; }

        #endregion

        #region Propiedades: Datos Personales de la Solicitante

        [DataMember]
        public string ApellidoPaterno { get; set; }

        [DataMember]
        public string ApellidoMaterno { get; set; }

        [DataMember]
        public string PrimerNombre { get; set; }

        [DataMember]
        public string SegundoNombre { get; set; }

        [DataMember]
        public string TipoDocumento { get; set; }

        [DataMember]
        public string NumeroDocumento { get; set; }

        [DataMember]
        public string Sexo { get; set; }

        [DataMember]
        public DateTime? FechaNacimiento { get; set; }

        [DataMember]
        public string EstadoCivil { get; set; }

        [DataMember]
        public string NivelEducativo { get; set; }

        [DataMember]
        public int CodigoOtrasMarcas { get; set; }

        [DataMember]
        public string TipoNacionalidad { get; set; }

        [DataMember]
        public string NumeroRFC { get; set; }


        #endregion

        #region Propiedades: Datos del Contacto

        [DataMember]
        public string Telefono { get; set; }

        [DataMember]
        public string Celular { get; set; }

        [DataMember]
        public string CorreoElectronico { get; set; }

        #endregion

        #region Propiedades: Direccion de la Solicitante

        [DataMember]
        public string Direccion { get; set; }

        [DataMember]
        public string Referencia { get; set; }

        [DataMember]
        public string Ciudad { get; set; }

        [DataMember]
        public string TipoVia { get; set; }

        [DataMember]
        public string PoblacionVilla { get; set; }

        [DataMember]
        public string CodigoPostal { get; set; }

        [DataMember]
        public string Colonia { get; set; }

        #endregion

        #region Propiedades: Direccion Entrega de la Zona

        [DataMember]
        public string DireccionEntrega { get; set; }

        [DataMember]
        public string ReferenciaEntrega { get; set; }

        [DataMember]
        public string TelefonoEntrega { get; set; }

        [DataMember]
        public string CelularEntrega { get; set; }

        [DataMember]
        public string ObservacionEntrega { get; set; }

        #endregion

        #region Propiedades: Referencia Familiar

        [DataMember]
        public string ApellidoFamiliar { get; set; }

        [DataMember]
        public string NombreFamiliar { get; set; }

        [DataMember]
        public string DireccionFamiliar { get; set; }

        [DataMember]
        public string TelefonoFamiliar { get; set; }

        [DataMember]
        public string CelularFamiliar { get; set; }

        [DataMember]
        public int TipoVinculoFamiliar { get; set; }

        #endregion

        #region Propiedades: Referencia No Familiar

        [DataMember]
        public string ApellidoNoFamiliar { get; set; }

        [DataMember]
        public string NombreNoFamiliar { get; set; }

        [DataMember]
        public string DireccionNoFamiliar { get; set; }

        [DataMember]
        public string TelefonoNoFamiliar { get; set; }

        [DataMember]
        public string CelularNoFamiliar { get; set; }

        [DataMember]
        public int TipoVinculoNoFamiliar { get; set; }

        #endregion

        #region Propiedades: Referencia del Aval

        [DataMember]
        public string ApellidoPaternoAval { get; set; }

        [DataMember]
        public string ApellidoMaternoAval { get; set; }

        [DataMember]
        public string PrimerNombreAval { get; set; }

        [DataMember]
        public string SegundoNombreAval { get; set; }

        [DataMember]
        public string DireccionAval { get; set; }

        [DataMember]
        public string TelefonoAval { get; set; }

        [DataMember]
        public string CelularAval { get; set; }

        [DataMember]
        public string TipoDocumentoAval { get; set; }

        [DataMember]
        public string NumeroDocumentoAval { get; set; }

        [DataMember]
        public int TipoVinculoAval { get; set; }

        #endregion

        #region Propiedades: Meta de Consultoras

        [DataMember]
        public decimal MontoMeta { get; set; }

        [DataMember]
        public string TipoMeta { get; set; }

        [DataMember]
        public string DescripcionMeta { get; set; }

        #endregion

        #region  Propiedades: Retorno generacion codigo

        [DataMember]
        public string DescripcionRechazo { get; set; }


        [DataMember]
        public string Municipio { get; set; }

        [DataMember]
        public string Localidad { get; set; }

        #endregion

        public BESolicitudCredito()
        {
        }

        public BESolicitudCredito(IDataRecord row, IList<string> columns)
        {
            foreach (var column in columns)
            {
                switch (column)
                {
                    case "SolicitudCreditoID":
                        SolicitudCreditoID = row.ToInt32("SolicitudCreditoID");
                        break;
                    case "PaisID":
                        PaisID = row.ToInt32("PaisID");
                        break;
                    case "TipoSolicitud":
                        TipoSolicitud = row.ToString("TipoSolicitud");
                        break;
                    case "FuenteIngreso":
                        FuenteIngreso = row.ToString("FuenteIngreso");
                        break;
                    case "NumeroPreimpreso":
                        NumeroPreimpreso = row.ToString("NumeroPreimpreso");
                        break;
                    case "CodigoIso":
                        CodigoIso = row.ToString("CodigoIso");
                        break;
                    case "CodigoZona":
                        CodigoZona = row.ToString("CodigoZona");
                        break;
                    case "CodigoTerritorio":
                        CodigoTerritorio = row.ToString("CodigoTerritorio");
                        break;
                    case "TipoContacto":
                        TipoContacto = row.ToInt32("TipoContacto");
                        break;
                    case "CampaniaID":
                        CampaniaID = row.ToInt32("CampaniaID");
                        break;
                    case "CodigoConsultoraRecomienda":
                        CodigoConsultoraRecomienda = row.ToString("CodigoConsultoraRecomienda");
                        break;
                    case "NombreConsultoraRecomienda":
                        NombreConsultoraRecomienda = row.ToString("NombreConsultoraRecomienda");
                        break;
                    case "CodigoConsultora":
                        CodigoConsultora = row.ToString("CodigoConsultora");
                        break;
                    case "CodigoPremio":
                        CodigoPremio = row.ToString("CodigoPremio");
                        break;
                    case "ApellidoPaterno":
                        ApellidoPaterno = row.ToString("ApellidoPaterno");
                        break;
                    case "ApellidoMaterno":
                        ApellidoMaterno = row.ToString("ApellidoMaterno");
                        break;
                    case "PrimerNombre":
                        PrimerNombre = row.ToString("PrimerNombre");
                        break;
                    case "SegundoNombre":
                        SegundoNombre = row.ToString("SegundoNombre");
                        break;
                    case "TipoDocumento":
                        TipoDocumento = row.ToString("TipoDocumento");
                        break;
                    case "NumeroDocumento":
                        NumeroDocumento = row.ToString("NumeroDocumento");
                        break;
                    case "Sexo":
                        Sexo = row.ToString("Sexo");
                        break;
                    case "FechaNacimiento":
                        FechaNacimiento = row.ToDateTime("FechaNacimiento");
                        break;
                    case "EstadoCivil":
                        EstadoCivil = row.ToString("EstadoCivil");
                        break;
                    case "NivelEducativo":
                        NivelEducativo = row.ToString("NivelEducativo");
                        break;
                    case "CodigoOtrasMarcas":
                        CodigoOtrasMarcas = row.ToInt32("CodigoOtrasMarcas");
                        break;
                    case "TipoNacionalidad":
                        TipoNacionalidad = row.ToString("TipoNacionalidad");
                        break;
                    case "Telefono":
                        Telefono = row.ToString("Telefono");
                        break;
                    case "Celular":
                        Celular = row.ToString("Celular");
                        break;
                    case "CorreoElectronico":
                        CorreoElectronico = row.ToString("CorreoElectronico");
                        break;
                    case "Direccion":
                        Direccion = row.ToString("Direccion");
                        break;
                    case "Referencia":
                        Referencia = row.ToString("Referencia");
                        break;
                    case "CodigoUbigeo":
                        CodigoUbigeo = row.ToString("CodigoUbigeo");
                        break;
                    case "Ciudad":
                        Ciudad = row.ToString("Ciudad");
                        break;
                    case "TipoVia":
                        TipoVia = row.ToString("TipoVia");
                        break;
                    case "PoblacionVilla":
                        PoblacionVilla = row.ToString("PoblacionVilla");
                        break;
                    case "CodigoPostal":
                        CodigoPostal = row.ToString("CodigoPostal");
                        break;
                    case "DireccionEntrega":
                        DireccionEntrega = row.ToString("DireccionEntrega");
                        break;
                    case "ReferenciaEntrega":
                        ReferenciaEntrega = row.ToString("ReferenciaEntrega");
                        break;
                    case "TelefonoEntrega":
                        TelefonoEntrega = row.ToString("TelefonoEntrega");
                        break;
                    case "CelularEntrega":
                        CelularEntrega = row.ToString("CelularEntrega");
                        break;
                    case "ObservacionEntrega":
                        ObservacionEntrega = row.ToString("ObservacionEntrega");
                        break;
                    case "ApellidoFamiliar":
                        ApellidoFamiliar = row.ToString("ApellidoFamiliar");
                        break;
                    case "NombreFamiliar":
                        NombreFamiliar = row.ToString("NombreFamiliar");
                        break;
                    case "DireccionFamiliar":
                        DireccionFamiliar = row.ToString("DireccionFamiliar");
                        break;
                    case "TelefonoFamiliar":
                        TelefonoFamiliar = row.ToString("TelefonoFamiliar");
                        break;
                    case "CelularFamiliar":
                        CelularFamiliar = row.ToString("CelularFamiliar");
                        break;
                    case "TipoVinculoFamiliar":
                        TipoVinculoFamiliar = row.ToInt32("TipoVinculoFamiliar");
                        break;
                    case "ApellidoNoFamiliar":
                        ApellidoNoFamiliar = row.ToString("ApellidoNoFamiliar");
                        break;
                    case "NombreNoFamiliar":
                        NombreNoFamiliar = row.ToString("NombreNoFamiliar");
                        break;
                    case "DireccionNoFamiliar":
                        DireccionNoFamiliar = row.ToString("DireccionNoFamiliar");
                        break;
                    case "TelefonoNoFamiliar":
                        TelefonoNoFamiliar = row.ToString("TelefonoNoFamiliar");
                        break;
                    case "CelularNoFamiliar":
                        CelularNoFamiliar = row.ToString("CelularNoFamiliar");
                        break;
                    case "TipoVinculoNoFamiliar":
                        TipoVinculoNoFamiliar = row.ToInt32("TipoVinculoNoFamiliar");
                        break;
                    case "ApellidoPaternoAval":
                        ApellidoPaternoAval = row.ToString("ApellidoPaternoAval");
                        break;
                    case "ApellidoMaternoAval":
                        ApellidoMaternoAval = row.ToString("ApellidoMaternoAval");
                        break;
                    case "PrimerNombreAval":
                        PrimerNombreAval = row.ToString("PrimerNombreAval");
                        break;
                    case "SegundoNombreAval":
                        SegundoNombreAval = row.ToString("SegundoNombreAval");
                        break;
                    case "DireccionAval":
                        DireccionAval = row.ToString("DireccionAval");
                        break;
                    case "TelefonoAval":
                        TelefonoAval = row.ToString("TelefonoAval");
                        break;
                    case "CelularAval":
                        CelularAval = row.ToString("CelularAval");
                        break;
                    case "TipoDocumentoAval":
                        TipoDocumentoAval = row.ToString("TipoDocumentoAval");
                        break;
                    case "NumeroDocumentoAval":
                        NumeroDocumentoAval = row.ToString("NumeroDocumentoAval");
                        break;
                    case "TipoVinculoAval":
                        TipoVinculoAval = row.ToInt32("TipoVinculoAval");
                        break;
                    case "MontoMeta":
                        MontoMeta = row.ToDecimal("MontoMeta");
                        break;
                    case "TipoMeta":
                        TipoMeta = row.ToString("TipoMeta");
                        break;
                    case "DescripcionMeta":
                        DescripcionMeta = row.ToString("DescripcionMeta");
                        break;
                    case "IndicadorActivo":
                        IndicadorActivo = row.ToBoolean("IndicadorActivo");
                        break;
                    case "UsuarioCreacion":
                        UsuarioCreacion = row.ToString("UsuarioCreacion");
                        break;
                    case "FechaCreacion":
                        FechaCreacion = row.ToDateTime("FechaCreacion");
                        break;
                    case "CodigoLote":
                        CodigoLote = row.ToInt32("CodigoLote");
                        break;
                    case "Estado":
                        Estado = row.ToString("Estado");
                        break;
                    case "DescripcionRechazo":
                        DescripcionRechazo = row.ToString("DescripcionRechazo");
                        break;
                    case "Municipio":
                        Municipio = row.ToString("Municipio");
                        break;
                    case "Localidad":
                        Localidad = row.ToString("Localidad");
                        break;
                    case "Colonia":
                        Colonia = row.ToString("Colonia");
                        break;
                    default:
                        break;
                }
            }
        }
    }
}
