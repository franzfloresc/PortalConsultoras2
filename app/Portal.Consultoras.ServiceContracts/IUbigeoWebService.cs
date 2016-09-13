using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

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
