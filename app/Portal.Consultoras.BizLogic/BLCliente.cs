using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Text.RegularExpressions;

using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLCliente
    {
        public int Insert(BECliente cliente)
        {
            var DACliente = new DACliente(cliente.PaisID);
            return DACliente.InsCliente(cliente);
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

        public List<BEClienteResponse> Save(int paisID, List<BECliente> clientes)
        {
            List<BEClienteResponse> lstResponse = new List<BEClienteResponse>();
            var DACliente = new DACliente(paisID);

            foreach(var cliente in clientes)
            {
                var validacion = this.ValidateAttribute(paisID, cliente);
                if (validacion != string.Empty)
                {
                    lstResponse.Add(new BEClienteResponse()
                    {
                        CodigoCliente = cliente.CodigoCliente,
                        CodigoRespuesta = validacion,
                        MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion]
                    });
                    continue;
                }

                if (cliente.ClienteID == 0)
                {
                    DACliente.InsCliente(cliente);
                }
                else
                {
                    DACliente.UpdCliente(cliente);
                }

                lstResponse.Add(new BEClienteResponse()
                {
                    CodigoCliente = cliente.CodigoCliente,
                    CodigoRespuesta = Constantes.ClienteValidacion.Code.SUCCESS,
                    MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.SUCCESS]
                });
            }

            return lstResponse;
        }

        #region Metodos Privados
        private bool ValidateTelefono(int paisID, short tipoContactoID, string telefono)
        {
            if (string.IsNullOrEmpty(telefono)) return true;

            string paisISO = Util.GetPaisISO(paisID);

            string expression = (tipoContactoID == Constantes.ClienteTipoContacto.Celular ? Constantes.ClienteCelularValidacion.RegExp[paisISO] : Constantes.ClienteTelefonoValidacion.RegExp[paisISO]);

            Regex regex = new Regex(expression);
            Match match = regex.Match(telefono);

            return match.Success;
        }

        private bool ValidateMail(string correo)
        {
            if (string.IsNullOrEmpty(correo)) return true;

            string expression = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";

            Regex regex = new Regex(expression);
            Match match = regex.Match(correo);

            return match.Success;
        }

        private string ValidateAttribute(int paisID, BECliente cliente)
        {
            if (string.IsNullOrEmpty(cliente.Nombre))
                return Constantes.ClienteValidacion.Code.ERROR_NOMBRENOENVIADO;
            if (string.IsNullOrEmpty(cliente.Telefono) && string.IsNullOrEmpty(cliente.Celular))
                return Constantes.ClienteValidacion.Code.ERROR_NUMEROTELEFONONOENVIADO;
            if (!this.ValidateTelefono(paisID, Constantes.ClienteTipoContacto.TelefonoFijo, cliente.Telefono))
                return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELFIJO;
            if (!this.ValidateTelefono(paisID, Constantes.ClienteTipoContacto.Celular, cliente.Celular))
                return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR;
            if (!this.ValidateMail(cliente.eMail))
                return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR;

            return string.Empty;
        }
        #endregion
    }
}