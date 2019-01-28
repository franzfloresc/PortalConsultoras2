using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class ClienteProvider
    {
        public virtual List<ClienteModel> SelectByConsultora(int paisId,long consultoraId)
        {
            var clientesResult = (List<ClienteModel>)null;
            var clientes = (List<BECliente>)null;

            using (var serviceClient= new ClienteServiceClient())
            {
                clientes = serviceClient.SelectByConsultora(paisId, consultoraId).ToList();
            }
            clientesResult = Mapper.Map<List<ClienteModel>>(clientes);

            return clientesResult;
        }
    }
}