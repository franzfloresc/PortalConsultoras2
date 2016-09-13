using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCliente
    {
        public void Insert(BECliente cliente)
        {
            var DACliente = new DACliente(cliente.PaisID);
            DACliente.InsCliente(cliente);
        }

        public int InsertById(BECliente cliente)
        {
            var DACliente = new DACliente(cliente.PaisID);
            return DACliente.InsCliente(cliente);
        }

        public void Update(BECliente cliente)
        {
            var DACliente = new DACliente(cliente.PaisID);
            DACliente.UpdCliente(cliente);
        }

        public bool Delete(int paisID, long consultoraID, int clienteID)
        {
            bool deleted;
            var DACliente = new DACliente(paisID);

            DACliente.DelCliente(consultoraID, clienteID, out deleted);
            return deleted;
        }

        public IList<BECliente> SelectByConsultora(int paisID, long consultoraID)
        {
            var clientes = new List<BECliente>();
            var DACliente = new DACliente(paisID);

            using (IDataReader reader = DACliente.GetClienteByConsultora(consultoraID))
                while (reader.Read())
                {
                    var cliente = new BECliente(reader);
                    cliente.PaisID = paisID;
                    clientes.Add(cliente);
                }

            return clientes;
        }

        public BECliente SelectById(int paisID, long consultoraID, int clienteID)
        {
            var cliente = new BECliente();
            var DACliente = new DACliente(paisID);

            using (IDataReader reader = DACliente.GetClienteByConsultora(consultoraID))
                if (reader.Read())
                {
                    cliente = new BECliente(reader);
                    cliente.PaisID = paisID;
                }
            return cliente;
        }

        public IList<BECliente> SelectByNombre(int paisID, long consultoraID, string Nombre)
        {
            var clientes = new List<BECliente>();
            var DACliente = new DACliente(paisID);

            using (IDataReader reader = DACliente.GetClienteByNombre(consultoraID, Nombre))
                while (reader.Read())
                {
                    var cliente = new BECliente(reader);
                    cliente.PaisID = paisID;
                    clientes.Add(cliente);
                }
            return clientes;
        }

        public int CheckClienteByConsultora(int paisID, long ConsultoraID, string Nombre)
        {
            var DACliente = new DACliente(paisID);
            return DACliente.CheckClienteByConsultora(ConsultoraID, Nombre);
        }

        public void UndoCliente(int paisID, long consultoraID, int clienteID)
        {
            var DACliente = new DACliente(paisID);

            DACliente.UndoCliente(consultoraID, clienteID);
        }

        public void InsCatalogoCampania(int paisID, string CodigoConsultora, int CampaniaID)
        {
            var DACliente = new DACliente(paisID);

            DACliente.InsCatalogoCampania(CodigoConsultora, CampaniaID);
        }
    }
    }
