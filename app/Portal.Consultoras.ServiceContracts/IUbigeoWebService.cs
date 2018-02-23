using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{

    [ServiceContract]
    public interface IUbigeoWebService
    {
        [OperationContract]
        List<BEUnidadGeografica> GetUnidadesGeograficas(string paisID, int nivel, string codigoPadre);

        [OperationContract]
        List<BEUnidadGeografica> ObtenerUbigeosPais(string paisCodigoISO);
    }
}