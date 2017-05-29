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

            DACliente.DelCliente(consultoraID, clienteID, 0, out deleted);
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

        #region ClienteDB
        public List<BEClienteResponse> SaveDB(int paisID, List<BEClienteDB> clientes)
        {
            List<BEClienteResponse> lstResponse = new List<BEClienteResponse>();
            var daCliente = new DACliente(paisID);
            var daClienteDB = new DAClienteDB();
            var cliente = new BECliente();

            foreach(var clienteDB in clientes)
            {
                //VALIDAR CLIENTE
                var validacion = this.ValidateAttribute(paisID, clienteDB);
                if (validacion != Constantes.ClienteValidacion.Code.SUCCESS)
                {
                    lstResponse.Add(new BEClienteResponse()
                    {
                        ClienteID = clienteDB.ClienteID,
                        CodigoRespuesta = validacion,
                        MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion]
                    });
                    continue;
                }

                //OBTENER TELEFONO PRINCIPAL
                var contactoPrincipal = (from tbl in clienteDB.Contactos
                                           where (tbl.TipoContactoID == Constantes.ClienteTipoContacto.Celular
                                           || tbl.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo)
                                           && tbl.Estado == Constantes.ClienteEstado.Activo
                                           select tbl).OrderBy(x => x.TipoContactoID).FirstOrDefault();

                //VALIDAR CLIENTE CONSULTORA
                validacion = this.ValidateConsultora(paisID, clienteDB, contactoPrincipal);
                if (validacion != Constantes.ClienteValidacion.Code.SUCCESS)
                {
                    lstResponse.Add(new BEClienteResponse()
                    {
                        ClienteID = clienteDB.ClienteID,
                        CodigoRespuesta = validacion,
                        MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion]
                    });
                    continue;
                }

                //OBTENER CLIENTE TELEFONO
                var resGetCliente = daClienteDB.GetCliente(clienteDB.ClienteID, contactoPrincipal.TipoContactoID, contactoPrincipal.Valor);

                if (resGetCliente.Count > 0)
                {
                    if (clienteDB.ClienteID == 0)
                    {
                        clienteDB.ClienteID = resGetCliente.First().ClienteID;
                    }
                    else
                    {
                        lstResponse.Add(new BEClienteResponse()
                        {
                            ClienteID = clienteDB.ClienteID,
                            CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_NUMEROTELEFONOEXISTE,
                            MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_NUMEROTELEFONOEXISTE]
                        });
                        continue;
                    }
                }

                //GRABAR CLIENTE
                if(clienteDB.Estado == Constantes.ClienteEstado.Activo)
                {
                    var oCorreo = clienteDB.Contactos.Where(x=>x.TipoContactoID == Constantes.ClienteTipoContacto.Correo && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
                    var correo = (oCorreo == null ? string.Empty : oCorreo.Valor);
                    var oTelefonoFijo = clienteDB.Contactos.Where(x=>x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
                    var telefonoFijo = (oTelefonoFijo == null ? string.Empty : oTelefonoFijo.Valor);
                    var oCelular = clienteDB.Contactos.Where(x=>x.TipoContactoID == Constantes.ClienteTipoContacto.Celular && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
                    var celular = (oCelular == null ? string.Empty : oCelular.Valor);

                    if (clienteDB.TipoRegistro == Constantes.ClienteTipoRegistro.DatosGenerales)
                        clienteDB.Contactos = new List<BEClienteContactoDB>();

                    if (clienteDB.ClienteID == 0)
                    {
                        //INSERTAR CLIENTE
                        clienteDB.ClienteID = daClienteDB.InsertCliente(clienteDB);
                        if (clienteDB.ClienteID == 0)
                        {
                            lstResponse.Add(new BEClienteResponse()
                            {
                                ClienteID = clienteDB.ClienteID,
                                CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO,
                                MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO]
                            });
                            continue;
                        }

                        daCliente.InsCliente(new BECliente()
                        {
                            ConsultoraID = clienteDB.ConsultoraID,
                            Nombre = clienteDB.Nombres,
                            eMail = correo,
                            Activo = true,
                            Telefono = telefonoFijo,
                            Celular = celular,
                            CodigoCliente = clienteDB.ClienteID
                        });
                    }
                    else
                    {
                        //ACTUALIZAR CLIENTE
                        var lstContactos = clienteDB.Contactos;
                        clienteDB.Contactos = lstContactos.Where(x => x.Estado == Constantes.ClienteEstado.Activo).ToList();
                        var resUpdateCliente = daClienteDB.UpdateCliente(clienteDB);

                        if (!resUpdateCliente)
                        {
                            lstResponse.Add(new BEClienteResponse()
                            {
                                ClienteID = clienteDB.ClienteID,
                                CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO,
                                MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO]
                            });
                            continue;
                        }

                        daCliente.UpdCliente(new BECliente()
                            {
                                ConsultoraID = clienteDB.ConsultoraID,
                                ClienteID = 0,
                                Nombre = clienteDB.Nombres,
                                eMail = correo,
                                Activo = true,
                                Telefono = telefonoFijo,
                                Celular = celular,
                                CodigoCliente = clienteDB.ClienteID
                            });

                        if (clienteDB.TipoRegistro == Constantes.ClienteTipoRegistro.Todos || clienteDB.TipoRegistro == Constantes.ClienteTipoRegistro.TipoContacto)
                        {
                            //ACTUALIZA CONTACTOS (Delete)
                            foreach (var contactoItemDelete in lstContactos.Where(x => x.Estado == Constantes.ClienteEstado.Inactivo))
                            {
                                var resultDeleteContactoCliente = daClienteDB.DeleteContactoCliente(contactoItemDelete);
                            }
                        }
                    }
                }
                else
                {
                    if (clienteDB.TipoRegistro == Constantes.ClienteTipoRegistro.Todos || clienteDB.TipoRegistro == Constantes.ClienteTipoRegistro.DatosGenerales)
                    {
                        var deleted = false;
                        daCliente.DelCliente(clienteDB.ConsultoraID, 0, clienteDB.ClienteID, out deleted);
                    }
                }

                lstResponse.Add(new BEClienteResponse()
                {
                    ClienteID = cliente.CodigoCliente,
                    CodigoRespuesta = Constantes.ClienteValidacion.Code.SUCCESS,
                    MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.SUCCESS]
                });
            }

            return lstResponse;
        }

        public List<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID)
        {
            List<BEClienteDB> clientes = new List<BEClienteDB>();
            var daClienteDB = new DAClienteDB();

            //1. OBTENER CLIENTE CONSULTORA
            var lstConsultoraCliente = this.SelectByConsultora(paisID, consultoraID);

            //2. OBTENER CLIENTES Y TIPO CONTACTOS
            string strclientes = string.Join("|", lstConsultoraCliente.Select(x => x.CodigoCliente));
            var lstCliente = daClienteDB.GetClienteByClienteID(strclientes);

            //3. CRUZAR 1 Y 2
            clientes = (from tblConsultoraCliente in lstConsultoraCliente
                         join tblCliente in lstCliente
                          on tblConsultoraCliente.ClienteID equals tblCliente.ClienteID
                        select new BEClienteDB
                         {
                             ClienteID = tblConsultoraCliente.ClienteID,
                             Apellidos = tblCliente.Apellidos,
                             Nombres = tblCliente.Nombres,
                             Alias = tblCliente.Alias,
                             Foto = tblCliente.Foto,
                             FechaNacimiento = tblCliente.FechaNacimiento,
                             Sexo = tblCliente.Sexo,
                             Documento = tblCliente.Documento,
                             Origen = tblCliente.Origen,
                             Favorito = tblConsultoraCliente.Favorito,
                             TipoContactoFavorito = tblConsultoraCliente.TipoContactoFavorito,
                             Estado = 1,
                             Contactos = tblCliente.Contactos
                         }).OrderBy(x => x.Nombres).ToList();

            return clientes;
        }
        #endregion

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

        private string ValidateAttribute(int paisID, BEClienteDB cliente)
        {
            if (string.IsNullOrEmpty(cliente.Nombres))
                return Constantes.ClienteValidacion.Code.ERROR_NOMBRENOENVIADO;
            if (string.IsNullOrEmpty(cliente.Origen))
                return Constantes.ClienteValidacion.Code.ERROR_NOMBRENOENVIADO;
            if (cliente.Contactos == null)
                return Constantes.ClienteValidacion.Code.ERROR_CONTACTOSNOENVIADO;
            if(cliente.Contactos.Count == 0)
                return Constantes.ClienteValidacion.Code.ERROR_CONTACTOSNOENVIADO;

            var validacionTipoContacto = cliente.Contactos.Where(x => string.IsNullOrEmpty(x.Valor) && x.Estado == Constantes.ClienteEstado.Activo).Count();
            if (validacionTipoContacto > 0)
                return Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOVALORNOENVIADO;

            var contactos = cliente.Contactos.Where(x => (x.TipoContactoID == Constantes.ClienteTipoContacto.Celular || x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo) && x.Estado == Constantes.ClienteEstado.Activo).OrderBy(x=>x.TipoContactoID).ToList();
            if (contactos.Count == 0)
                return Constantes.ClienteValidacion.Code.ERROR_NUMEROTELEFONONOENVIADO;

            var oCelular = contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular).FirstOrDefault();
            if (oCelular != null)
            {
                if (!this.ValidateTelefono(paisID, Constantes.ClienteTipoContacto.Celular, oCelular.Valor))
                    return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR;
            }

            var oTelefonoFijo = contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo).FirstOrDefault();
            if (oTelefonoFijo != null)
            {
                if (!this.ValidateTelefono(paisID, Constantes.ClienteTipoContacto.TelefonoFijo, oTelefonoFijo.Valor))
                    return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELFIJO;
            }

            var oCorreo = cliente.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
            if (oCorreo != null)
            {
                if (!this.ValidateMail(oCorreo.Valor))
                    return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR;
            }

            return Constantes.ClienteValidacion.Code.SUCCESS;
        }

        private string ValidateConsultora(int paisID, BEClienteDB cliente, BEClienteContactoDB contactoPrincipal)
        {
            var lstCliente = this.SelectByConsultora(paisID, cliente.ConsultoraID);
            lstCliente = lstCliente.Where(x => x.CodigoCliente != cliente.ClienteID).ToList();

            var nombreExiste = lstCliente.Where(x => x.Nombre.ToUpper() == cliente.Nombres.ToUpper()).Count();
            if (nombreExiste > 0) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORANOMBREEXISTE;

            if(contactoPrincipal.TipoContactoID == Constantes.ClienteTipoContacto.Celular)
            {
                var telefonoExiste = lstCliente.Where(x => x.Telefono == contactoPrincipal.Valor).Count();
                if (telefonoExiste > 0) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE;
            }

            if (contactoPrincipal.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo)
            {
                var telefonoExiste = lstCliente.Where(x => x.Celular == contactoPrincipal.Valor).Count();
                if (telefonoExiste > 0) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE;
            }

            return Constantes.ClienteValidacion.Code.SUCCESS;
        }
        #endregion
    }
}