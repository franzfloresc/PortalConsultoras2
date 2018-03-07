using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface ICatalogoService
    {
        [OperationContract]
        BEConsultoraCatalogo GetConsultoraCatalogo(string PaisISO, string CodigoConsultora);

        [OperationContract]
        int InsSolicitudClienteCatalogo(string PaisISO, string CodigoConsultora, string AsuntoNotificacion, string DetalleNotificacion, string Campania, string CorreoCliente, string NombreCliente, string Telefono, string DireccionCliente);

        [OperationContract]
        BEListaConsultoraCatalogo GetConsultorasCatalogosPorUbigeo(string codigoPais, string codigoUbigeo, int marcaId);

        [OperationContract]
        List<BEConsultoraCatalogo> GetConsultorasPorCodigoTerritorioGeo(string codigoPais, string codigoTerritorioGeo);

        [OperationContract]
        BEListaConsultoraCatalogo GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(string codigoPais, string codigoUbigeo, int marcaId, string nombres, string apellidos);

        [OperationContract]
        int InsLogClienteRegistraConsultoraCatalogo(string PaisISO, int consultoraId, string codigoConsultora, int campaniaId, string tipoBusqueda, int conoceConsultora, string codigoDispositivo, string soDispotivivo, string unidadGeo1, string unidadGeo2, string unidadGeo3, string nombreCliente, string emailCliente, string telefonoCliente, int nuevaConsultora);

    }
}