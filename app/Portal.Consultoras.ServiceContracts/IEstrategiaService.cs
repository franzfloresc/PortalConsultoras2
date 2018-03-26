using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Web;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.Framework;
namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IEstrategiaService
    {
        [OperationContract]
        [WebGet(UriTemplate = "/ObtenerProductoEstrategia/{PaisId}/{Campania}/{CodigoConsultora}/{TipoConsulta}/{Texto}/{CantidadResultado}",
           RequestFormat = WebMessageFormat.Json,
           ResponseFormat = WebMessageFormat.Json)]
        ResponseType<List<EstrategiaProductoSet>> ObtenerProductoEstrategia(string PaisId, string Campania, string CodigoConsultora, string TipoConsulta, string Texto, string CantidadResultado);
    }
}
