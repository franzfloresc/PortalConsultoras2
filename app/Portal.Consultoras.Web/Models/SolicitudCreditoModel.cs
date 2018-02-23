using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class SolicitudCreditoModel
    {
        public string vpage { set; get; }
        public string vsortname { set; get; }
        public string vsortorder { set; get; }
        public string vrowNum { set; get; }

        #region Propiedades Internas

        public int SolicitudCreditoID { get; set; }
        public int PaisID { get; set; }
        public string TipoSolicitud { get; set; }
        public string CodigoUbigeo { get; set; }
        public bool IndicadorActivo { get; set; }
        public string UsuarioCreacion { get; set; }
        public DateTime? FechaCreacion { get; set; }
        public int CodigoLote { get; set; }
        public string FuenteIngreso { get; set; }
        public string NumeroPreimpreso { get; set; }
        public string CodigoIso { get; set; }
        public string EstadoDescripcion
        {
            get
            {
                return CodigoLote > 0 ? "ENVIADO" : "PENDIENTE";
            }
        }

        #endregion

        #region Propiedades: Datos de la Inscripcion

        public string CodigoZona { get; set; }
        public string CodigoTerritorio { get; set; }
        public int TipoContacto { get; set; }
        public int CampaniaID { get; set; }
        public string CodigoConsultoraRecomienda { get; set; }
        public string NombreConsultoraRecomienda { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoPremio { get; set; }

        #endregion

        #region Propiedades: Datos Personales de la Solicitante

        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string PrimerNombre { get; set; }
        public string SegundoNombre { get; set; }
        public string TipoDocumento { get; set; }
        public string NumeroDocumento { get; set; }
        public string Sexo { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public string EstadoCivil { get; set; }
        public string NivelEducativo { get; set; }
        public int CodigoOtrasMarcas { get; set; }
        public string TipoNacionalidad { get; set; }

        #endregion

        #region Propiedades: Datos del Contacto

        public string Telefono { get; set; }
        public string Celular { get; set; }
        public string CorreoElectronico { get; set; }

        #endregion

        #region Propiedades: Direccion de la Solicitante

        public string Direccion { get; set; }
        public string Referencia { get; set; }
        public string Ciudad { get; set; }
        public string TipoVia { get; set; }
        public string PoblacionVilla { get; set; }
        public string CodigoPostal { get; set; }

        #endregion

        #region Propiedades: Direccion Entrega de la Zona

        public string DireccionEntrega { get; set; }
        public string ReferenciaEntrega { get; set; }
        public string TelefonoEntrega { get; set; }
        public string CelularEntrega { get; set; }
        public string ObservacionEntrega { get; set; }

        #endregion

        #region Propiedades: Referencia Familiar

        public string ApellidoFamiliar { get; set; }
        public string NombreFamiliar { get; set; }
        public string DireccionFamiliar { get; set; }
        public string TelefonoFamiliar { get; set; }
        public string CelularFamiliar { get; set; }
        public int TipoVinculoFamiliar { get; set; }

        #endregion

        #region Propiedades: Referencia No Familiar

        public string ApellidoNoFamiliar { get; set; }
        public string NombreNoFamiliar { get; set; }
        public string DireccionNoFamiliar { get; set; }
        public string TelefonoNoFamiliar { get; set; }
        public string CelularNoFamiliar { get; set; }
        public int TipoVinculoNoFamiliar { get; set; }

        #endregion

        #region Propiedades: Referencia del Aval

        public string ApellidoPaternoAval { get; set; }
        public string ApellidoMaternoAval { get; set; }
        public string PrimerNombreAval { get; set; }
        public string SegundoNombreAval { get; set; }
        public string DireccionAval { get; set; }
        public string TelefonoAval { get; set; }
        public string CelularAval { get; set; }
        public string TipoDocumentoAval { get; set; }
        public string NumeroDocumentoAval { get; set; }
        public int TipoVinculoAval { get; set; }

        #endregion

        #region Propiedades: Meta de Consultoras

        public decimal MontoMeta { get; set; }
        public string TipoMeta { get; set; }
        public string DescripcionMeta { get; set; }

        #endregion

        public IEnumerable<BETablaLogicaDatos> ListaTipoContacto { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaTipoDocumento { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaEstadoCivil { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaNivelEducativo { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaOtrasMarcas { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaTipoVinculoFamiliar { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaTipoVinculoNoFamiliar { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaTipoVinculoAval { get; set; }

        public string UnidadGeografica1 { get; set; }
        public string UnidadGeografica2 { get; set; }
        public string UnidadGeografica3 { get; set; }

        public IEnumerable<InfoGenerica> ListaAvenidaCalle { get; set; }
        public IEnumerable<InfoGenerica> ListaCasaEdificio { get; set; }
        public IEnumerable<InfoGenerica> ListaUrbanizacionSector { get; set; }
        public IEnumerable<InfoGenerica> ListaApartamentoCasa { get; set; }

        public string AvenidaCalleCodigo { get; set; }
        public string CasaEdificioCodigo { get; set; }
        public string UrbanizacionSectorCodigo { get; set; }
        public string ApartamentoCasaCodigo { get; set; }
        public string AvenidaCalle { get; set; }
        public string CasaEdificio { get; set; }
        public string UrbanizacionSector { get; set; }
        public string ApartamentoCasa { get; set; }
        public string CiudadSolicitante { get; set; }

        public string AvenidaCalleEntregaCodigo { get; set; }
        public string CasaEdificioEntregaCodigo { get; set; }
        public string UrbanizacionSectorEntregaCodigo { get; set; }
        public string ApartamentoCasaEntregaCodigo { get; set; }
        public string AvenidaCalleEntrega { get; set; }
        public string CasaEdificioEntrega { get; set; }
        public string UrbanizacionSectorEntrega { get; set; }
        public string ApartamentoCasaEntrega { get; set; }
        public string CiudadEntrega { get; set; }

        public IEnumerable<BETipoMeta> ListaTipoMeta { get; set; }

        public string DiaNacimiento { get; set; }
        public string MesNacimiento { get; set; }
        public string AnioNacimiento { get; set; }
        public IEnumerable<InfoGenerica> ListaDiaNacimiento { get; set; }
        public IEnumerable<InfoGenerica> ListaMesNacimiento { get; set; }
        public IEnumerable<InfoGenerica> ListaAnioNacimiento { get; set; }

        public IEnumerable<InfoGenerica> ListaSexos { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaTipoVia { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaTipoNacionalidad { get; set; }
        public IEnumerable<PaisModel> ListaPaises { get; set; }
        public IEnumerable<ZonaModel> ListaZonas { get; set; }

        public bool EsInsercion { get; set; }
    }

    public class InfoGenerica
    {
        public string Valor { get; set; }
        public string Texto { get; set; }
    }
}
