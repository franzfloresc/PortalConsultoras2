using AutoMapper;
using Portal.Consultoras.Common;
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
        protected readonly TablaLogicaProvider _tablaLogicaProvider;

        public ClienteProvider()
        {
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        public virtual bool ValidarFlagFuncional(int paisId)
        {
           return _tablaLogicaProvider.GetTablaLogicaDatoValorBool(
                            paisId,
                            ConsTablaLogica.FlagFuncional.TablaLogicaID,
                            ConsTablaLogica.FlagFuncional.MisClientes,
                            true
                            );
        }

        public virtual List<ClienteModel> SelectByConsultora(int paisId, long consultoraId)
        {
            var clientesResult = (List<ClienteModel>)null;
            var clientes = (List<BECliente>)null;

            using (var serviceClient = new ClienteServiceClient())
            {
                clientes = serviceClient.SelectByConsultora(paisId, consultoraId).ToList();
            }
            clientesResult = Mapper.Map<List<ClienteModel>>(clientes);

            return clientesResult;
        }

        public virtual BEClienteDB SaveDB(int paisId, long consultoraId, ClienteModel client)
        {

            List<BEClienteDB> clientes = new List<BEClienteDB>();
            List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();

            if (!string.IsNullOrEmpty(client.Celular))
            {
                contactos.Add(new BEClienteContactoDB()
                {
                    ClienteID = client.ClienteID,
                    Estado = Constantes.ClienteEstado.Activo,
                    TipoContactoID = Constantes.ClienteTipoContacto.Celular,
                    Valor = client.Celular
                });
            }

            if (!string.IsNullOrEmpty(client.Telefono))
            {
                contactos.Add(new BEClienteContactoDB()
                {
                    ClienteID = client.ClienteID,
                    Estado = Constantes.ClienteEstado.Activo,
                    TipoContactoID = Constantes.ClienteTipoContacto.TelefonoFijo,
                    Valor = client.Telefono
                });
            }

            if (!string.IsNullOrEmpty(client.eMail))
            {
                contactos.Add(new BEClienteContactoDB()
                {
                    ClienteID = client.ClienteID,
                    Estado = Constantes.ClienteEstado.Activo,
                    TipoContactoID = Constantes.ClienteTipoContacto.Correo,
                    Valor = client.eMail
                });
            }

            clientes.Add(new BEClienteDB()
            {
                CodigoCliente = client.CodigoCliente,
                ClienteID = client.ClienteID,
                Nombres = client.NombreCliente,
                Apellidos = client.ApellidoCliente,
                ConsultoraID = consultoraId,
                Origen = Constantes.ClienteOrigen.Desktop,
                Estado = Constantes.ClienteEstado.Activo,
                Contactos = contactos.ToArray()
            });

            List<BEClienteDB> response;
            using (var serviceClient = new ClienteServiceClient())
            {
                response = serviceClient.SaveDB(paisId, clientes.ToArray()).ToList();
            }

            return response.First();
        }

        public virtual bool Eliminar(int paisId, long consultoraId, int clientId)
        {
            var result  = false;

            if (clientId == 0) return result;

            using (var serviceClient = new ClienteServiceClient())
            {
                result = serviceClient.Delete(paisId, consultoraId, clientId);
            }

            return result;
        }
    }
}