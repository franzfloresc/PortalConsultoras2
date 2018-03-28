namespace Portal.Consultoras.Entities
{
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
                        if (row["SolicitudCreditoID"] != DBNull.Value)
                            SolicitudCreditoID = Convert.ToInt32(row["SolicitudCreditoID"]);
                        break;
                    case "PaisID":
                        if (row["PaisID"] != DBNull.Value)
                            PaisID = Convert.ToInt32(row["PaisID"]);
                        break;
                    case "TipoSolicitud":
                        if (row["TipoSolicitud"] != DBNull.Value)
                            TipoSolicitud = Convert.ToString(row["TipoSolicitud"]);
                        break;
                    case "FuenteIngreso":
                        if (row["FuenteIngreso"] != DBNull.Value)
                            FuenteIngreso = Convert.ToString(row["FuenteIngreso"]);
                        break;
                    case "NumeroPreimpreso":
                        if (row["NumeroPreimpreso"] != DBNull.Value)
                            NumeroPreimpreso = Convert.ToString(row["NumeroPreimpreso"]);
                        break;
                    case "CodigoIso":
                        if (row["CodigoIso"] != DBNull.Value)
                            CodigoIso = Convert.ToString(row["CodigoIso"]);
                        break;
                    case "CodigoZona":
                        if (row["CodigoZona"] != DBNull.Value)
                            CodigoZona = Convert.ToString(row["CodigoZona"]);
                        break;
                    case "CodigoTerritorio":
                        if (row["CodigoTerritorio"] != DBNull.Value)
                            CodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);
                        break;
                    case "TipoContacto":
                        if (row["TipoContacto"] != DBNull.Value)
                            TipoContacto = Convert.ToInt32(row["TipoContacto"]);
                        break;
                    case "CampaniaID":
                        if (row["CampaniaID"] != DBNull.Value)
                            CampaniaID = Convert.ToInt32(row["CampaniaID"]);
                        break;
                    case "CodigoConsultoraRecomienda":
                        if (row["CodigoConsultoraRecomienda"] != DBNull.Value)
                            CodigoConsultoraRecomienda = Convert.ToString(row["CodigoConsultoraRecomienda"]);
                        break;
                    case "NombreConsultoraRecomienda":
                        if (row["NombreConsultoraRecomienda"] != DBNull.Value)
                            NombreConsultoraRecomienda = Convert.ToString(row["NombreConsultoraRecomienda"]);
                        break;
                    case "CodigoConsultora":
                        if (row["CodigoConsultora"] != DBNull.Value)
                            CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
                        break;
                    case "CodigoPremio":
                        if (row["CodigoPremio"] != DBNull.Value)
                            CodigoPremio = Convert.ToString(row["CodigoPremio"]);
                        break;
                    case "ApellidoPaterno":
                        if (row["ApellidoPaterno"] != DBNull.Value)
                            ApellidoPaterno = Convert.ToString(row["ApellidoPaterno"]);
                        break;
                    case "ApellidoMaterno":
                        if (row["ApellidoMaterno"] != DBNull.Value)
                            ApellidoMaterno = Convert.ToString(row["ApellidoMaterno"]);
                        break;
                    case "PrimerNombre":
                        if (row["PrimerNombre"] != DBNull.Value)
                            PrimerNombre = Convert.ToString(row["PrimerNombre"]);
                        break;
                    case "SegundoNombre":
                        if (row["SegundoNombre"] != DBNull.Value)
                            SegundoNombre = Convert.ToString(row["SegundoNombre"]);
                        break;
                    case "TipoDocumento":
                        if (row["TipoDocumento"] != DBNull.Value)
                            TipoDocumento = Convert.ToString(row["TipoDocumento"]);
                        break;
                    case "NumeroDocumento":
                        if (row["NumeroDocumento"] != DBNull.Value)
                            NumeroDocumento = Convert.ToString(row["NumeroDocumento"]);
                        break;
                    case "Sexo":
                        if (row["Sexo"] != DBNull.Value)
                            Sexo = Convert.ToString(row["Sexo"]);
                        break;
                    case "FechaNacimiento":
                        if (row["FechaNacimiento"] != DBNull.Value)
                            FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
                        break;
                    case "EstadoCivil":
                        if (row["EstadoCivil"] != DBNull.Value)
                            EstadoCivil = Convert.ToString(row["EstadoCivil"]);
                        break;
                    case "NivelEducativo":
                        if (row["NivelEducativo"] != DBNull.Value)
                            NivelEducativo = Convert.ToString(row["NivelEducativo"]);
                        break;
                    case "CodigoOtrasMarcas":
                        if (row["CodigoOtrasMarcas"] != DBNull.Value)
                            CodigoOtrasMarcas = Convert.ToInt32(row["CodigoOtrasMarcas"]);
                        break;
                    case "TipoNacionalidad":
                        if (row["TipoNacionalidad"] != DBNull.Value)
                            TipoNacionalidad = Convert.ToString(row["TipoNacionalidad"]);
                        break;
                    case "Telefono":
                        if (row["Telefono"] != DBNull.Value)
                            Telefono = Convert.ToString(row["Telefono"]);
                        break;
                    case "Celular":
                        if (row["Celular"] != DBNull.Value)
                            Celular = Convert.ToString(row["Celular"]);
                        break;
                    case "CorreoElectronico":
                        if (row["CorreoElectronico"] != DBNull.Value)
                            CorreoElectronico = Convert.ToString(row["CorreoElectronico"]);
                        break;
                    case "Direccion":
                        if (row["Direccion"] != DBNull.Value)
                            Direccion = Convert.ToString(row["Direccion"]);
                        break;
                    case "Referencia":
                        if (row["Referencia"] != DBNull.Value)
                            Referencia = Convert.ToString(row["Referencia"]);
                        break;
                    case "CodigoUbigeo":
                        if (row["CodigoUbigeo"] != DBNull.Value)
                            CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
                        break;
                    case "Ciudad":
                        if (row["Ciudad"] != DBNull.Value)
                            Ciudad = Convert.ToString(row["Ciudad"]);
                        break;
                    case "TipoVia":
                        if (row["TipoVia"] != DBNull.Value)
                            TipoVia = Convert.ToString(row["TipoVia"]);
                        break;
                    case "PoblacionVilla":
                        if (row["PoblacionVilla"] != DBNull.Value)
                            PoblacionVilla = Convert.ToString(row["PoblacionVilla"]);
                        break;
                    case "CodigoPostal":
                        if (row["CodigoPostal"] != DBNull.Value)
                            CodigoPostal = Convert.ToString(row["CodigoPostal"]);
                        break;
                    case "DireccionEntrega":
                        if (row["DireccionEntrega"] != DBNull.Value)
                            DireccionEntrega = Convert.ToString(row["DireccionEntrega"]);
                        break;
                    case "ReferenciaEntrega":
                        if (row["ReferenciaEntrega"] != DBNull.Value)
                            ReferenciaEntrega = Convert.ToString(row["ReferenciaEntrega"]);
                        break;
                    case "TelefonoEntrega":
                        if (row["TelefonoEntrega"] != DBNull.Value)
                            TelefonoEntrega = Convert.ToString(row["TelefonoEntrega"]);
                        break;
                    case "CelularEntrega":
                        if (row["CelularEntrega"] != DBNull.Value)
                            CelularEntrega = Convert.ToString(row["CelularEntrega"]);
                        break;
                    case "ObservacionEntrega":
                        if (row["ObservacionEntrega"] != DBNull.Value)
                            ObservacionEntrega = Convert.ToString(row["ObservacionEntrega"]);
                        break;
                    case "ApellidoFamiliar":
                        if (row["ApellidoFamiliar"] != DBNull.Value)
                            ApellidoFamiliar = Convert.ToString(row["ApellidoFamiliar"]);
                        break;
                    case "NombreFamiliar":
                        if (row["NombreFamiliar"] != DBNull.Value)
                            NombreFamiliar = Convert.ToString(row["NombreFamiliar"]);
                        break;
                    case "DireccionFamiliar":
                        if (row["DireccionFamiliar"] != DBNull.Value)
                            DireccionFamiliar = Convert.ToString(row["DireccionFamiliar"]);
                        break;
                    case "TelefonoFamiliar":
                        if (row["TelefonoFamiliar"] != DBNull.Value)
                            TelefonoFamiliar = Convert.ToString(row["TelefonoFamiliar"]);
                        break;
                    case "CelularFamiliar":
                        if (row["CelularFamiliar"] != DBNull.Value)
                            CelularFamiliar = Convert.ToString(row["CelularFamiliar"]);
                        break;
                    case "TipoVinculoFamiliar":
                        if (row["TipoVinculoFamiliar"] != DBNull.Value)
                            TipoVinculoFamiliar = Convert.ToInt32(row["TipoVinculoFamiliar"]);
                        break;
                    case "ApellidoNoFamiliar":
                        if (row["ApellidoNoFamiliar"] != DBNull.Value)
                            ApellidoNoFamiliar = Convert.ToString(row["ApellidoNoFamiliar"]);
                        break;
                    case "NombreNoFamiliar":
                        if (row["NombreNoFamiliar"] != DBNull.Value)
                            NombreNoFamiliar = Convert.ToString(row["NombreNoFamiliar"]);
                        break;
                    case "DireccionNoFamiliar":
                        if (row["DireccionNoFamiliar"] != DBNull.Value)
                            DireccionNoFamiliar = Convert.ToString(row["DireccionNoFamiliar"]);
                        break;
                    case "TelefonoNoFamiliar":
                        if (row["TelefonoNoFamiliar"] != DBNull.Value)
                            TelefonoNoFamiliar = Convert.ToString(row["TelefonoNoFamiliar"]);
                        break;
                    case "CelularNoFamiliar":
                        if (row["CelularNoFamiliar"] != DBNull.Value)
                            CelularNoFamiliar = Convert.ToString(row["CelularNoFamiliar"]);
                        break;
                    case "TipoVinculoNoFamiliar":
                        if (row["TipoVinculoNoFamiliar"] != DBNull.Value)
                            TipoVinculoNoFamiliar = Convert.ToInt32(row["TipoVinculoNoFamiliar"]);
                        break;
                    case "ApellidoPaternoAval":
                        if (row["ApellidoPaternoAval"] != DBNull.Value)
                            ApellidoPaternoAval = Convert.ToString(row["ApellidoPaternoAval"]);
                        break;
                    case "ApellidoMaternoAval":
                        if (row["ApellidoMaternoAval"] != DBNull.Value)
                            ApellidoMaternoAval = Convert.ToString(row["ApellidoMaternoAval"]);
                        break;
                    case "PrimerNombreAval":
                        if (row["PrimerNombreAval"] != DBNull.Value)
                            PrimerNombreAval = Convert.ToString(row["PrimerNombreAval"]);
                        break;
                    case "SegundoNombreAval":
                        if (row["SegundoNombreAval"] != DBNull.Value)
                            SegundoNombreAval = Convert.ToString(row["SegundoNombreAval"]);
                        break;
                    case "DireccionAval":
                        if (row["DireccionAval"] != DBNull.Value)
                            DireccionAval = Convert.ToString(row["DireccionAval"]);
                        break;
                    case "TelefonoAval":
                        if (row["TelefonoAval"] != DBNull.Value)
                            TelefonoAval = Convert.ToString(row["TelefonoAval"]);
                        break;
                    case "CelularAval":
                        if (row["CelularAval"] != DBNull.Value)
                            CelularAval = Convert.ToString(row["CelularAval"]);
                        break;
                    case "TipoDocumentoAval":
                        if (row["TipoDocumentoAval"] != DBNull.Value)
                            TipoDocumentoAval = Convert.ToString(row["TipoDocumentoAval"]);
                        break;
                    case "NumeroDocumentoAval":
                        if (row["NumeroDocumentoAval"] != DBNull.Value)
                            NumeroDocumentoAval = Convert.ToString(row["NumeroDocumentoAval"]);
                        break;
                    case "TipoVinculoAval":
                        if (row["TipoVinculoAval"] != DBNull.Value)
                            TipoVinculoAval = Convert.ToInt32(row["TipoVinculoAval"]);
                        break;
                    case "MontoMeta":
                        if (row["MontoMeta"] != DBNull.Value)
                            MontoMeta = Convert.ToDecimal(row["MontoMeta"]);
                        break;
                    case "TipoMeta":
                        if (row["TipoMeta"] != DBNull.Value)
                            TipoMeta = Convert.ToString(row["TipoMeta"]);
                        break;
                    case "DescripcionMeta":
                        if (row["DescripcionMeta"] != DBNull.Value)
                            DescripcionMeta = Convert.ToString(row["DescripcionMeta"]);
                        break;
                    case "IndicadorActivo":
                        if (row["IndicadorActivo"] != DBNull.Value)
                            IndicadorActivo = Convert.ToBoolean(row["IndicadorActivo"]);
                        break;
                    case "UsuarioCreacion":
                        if (row["UsuarioCreacion"] != DBNull.Value)
                            UsuarioCreacion = Convert.ToString(row["UsuarioCreacion"]);
                        break;
                    case "FechaCreacion":
                        if (row["FechaCreacion"] != DBNull.Value)
                            FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]);
                        break;
                    case "CodigoLote":
                        if (row["CodigoLote"] != DBNull.Value)
                            CodigoLote = Convert.ToInt32(row["CodigoLote"]);
                        break;
                    case "Estado":
                        if (row["Estado"] != DBNull.Value)
                            Estado = Convert.ToString(row["Estado"]);
                        break;

                    case "DescripcionRechazo":
                        if (row["DescripcionRechazo"] != DBNull.Value)
                            DescripcionRechazo = Convert.ToString(row["DescripcionRechazo"]);
                        break;
                    case "Municipio":
                        if (row["Municipio"] != DBNull.Value)
                            Municipio = Convert.ToString(row["Municipio"]);
                        break;
                    case "Localidad":
                        if (row["Localidad"] != DBNull.Value)
                            Localidad = Convert.ToString(row["Localidad"]);
                        break;
                    case "Colonia":
                        if (row["Colonia"] != DBNull.Value)
                            Colonia = Convert.ToString(row["Colonia"]);
                        break;

                    default:
                        break;
                }
            }
        }
    }
}
