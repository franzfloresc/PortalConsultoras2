using Portal.Consultoras.Entities;
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
    }
}
