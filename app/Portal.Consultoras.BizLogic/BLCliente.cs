using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Text.RegularExpressions;
using Portal.Consultoras.BizLogic.Cliente;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;

namespace Portal.Consultoras.BizLogic
{
    public class BLCliente
    {
        private readonly INotasBusinessLogic _notasBusinessLogic;
        private readonly IMovimientoBusinessLogic _movimientoBusinessLogic;
        private readonly IRecordatorioBusinessLogic _recordatorioBusinessLogic;

        public BLCliente() : this(new BLNotas(),
            new BLMovimiento(),
            new BLRecordatorio())
        { }

        public BLCliente(INotasBusinessLogic notasBusinessLogic,
            IMovimientoBusinessLogic movimientoBusinessLogic,
            IRecordatorioBusinessLogic recordatorioBusinessLogic)
        {
            _notasBusinessLogic = notasBusinessLogic;
            _movimientoBusinessLogic = movimientoBusinessLogic;
            _recordatorioBusinessLogic = recordatorioBusinessLogic;
        }

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

        public BECliente SelectByConsultoraByCodigo(int paisID, long consultoraID, int ClienteID, long codigoCliente)
        {
            var cliente = new BECliente();
            var DACliente = new DACliente(paisID);

            using (IDataReader reader = DACliente.GetClienteByCodigo(consultoraID, ClienteID, codigoCliente))
                if (reader.Read())
                {
                    cliente = new BECliente(reader);
                    cliente.PaisID = paisID;
                }
            return cliente;
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

        public int GetExisteClienteConsultora(int paisID, BECliente entidad)
        {
            var DACliente = new DACliente(paisID);
            return DACliente.GetExisteClienteConsultora(entidad);
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

        #region Contactos
        private void ContactoListar(IList<BECliente> lstConsultoraCliente, List<BEClienteDB> lstCliente)
        {
            List<BEClienteContactoDB> contactos = null;

            foreach (var consultoraCliente in lstConsultoraCliente)
            {
                contactos = new List<BEClienteContactoDB>();

                var clienteDB = lstCliente.Where(x => x.ClienteID == consultoraCliente.CodigoCliente).FirstOrDefault();

                if (clienteDB != null)
                {
                    if (!string.IsNullOrEmpty(consultoraCliente.Celular))
                    {
                        var oContacto = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular).FirstOrDefault();

                        contactos.Add(new BEClienteContactoDB()
                        {
                            ContactoClienteID = (oContacto == null ? 0 : oContacto.ContactoClienteID),
                            ClienteIDSB = consultoraCliente.ClienteID,
                            TipoContactoID = Constantes.ClienteTipoContacto.Celular,
                            Valor = consultoraCliente.Celular,
                            Estado = 1
                        });
                    }
                    if (!string.IsNullOrEmpty(consultoraCliente.Telefono))
                    {
                        var oContacto = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo).FirstOrDefault();

                        contactos.Add(new BEClienteContactoDB()
                        {
                            ContactoClienteID = (oContacto == null ? 0 : oContacto.ContactoClienteID),
                            ClienteIDSB = consultoraCliente.ClienteID,
                            TipoContactoID = Constantes.ClienteTipoContacto.TelefonoFijo,
                            Valor = consultoraCliente.Telefono,
                            Estado = 1
                        });
                    }
                    if (!string.IsNullOrEmpty(consultoraCliente.eMail))
                    {
                        var oContacto = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo).FirstOrDefault();

                        contactos.Add(new BEClienteContactoDB()
                        {
                            ContactoClienteID = (oContacto == null ? 0 : oContacto.ContactoClienteID),
                            ClienteIDSB = consultoraCliente.ClienteID,
                            TipoContactoID = Constantes.ClienteTipoContacto.Correo,
                            Valor = consultoraCliente.eMail,
                            Estado = 1
                        });
                    }

                    var contactoDB = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Direccion || x.TipoContactoID == Constantes.ClienteTipoContacto.Referencia)
                                            .Select(x => new BEClienteContactoDB()
                                            {
                                                ContactoClienteID = x.ContactoClienteID,
                                                ClienteIDSB = consultoraCliente.ClienteID,
                                                TipoContactoID = x.TipoContactoID,
                                                Valor = x.Valor,
                                                Estado = x.Estado
                                            });
                    if (contactoDB.Any()) contactos.AddRange(contactoDB);
                }

                consultoraCliente.Contactos = contactos;
            }
        }
        #endregion

        #region ClienteDB
        /// <summary>
        /// Inserta o actualiza uno o varios clientes
        /// </summary>
        /// <param name="paisID">Pais Id</param>
        /// <param name="clientes">Lista clientes</param>
        /// <returns></returns>
        public List<BEClienteDB> SaveDB(int paisID, List<BEClienteDB> clientes)
        {
            var daCliente = new DACliente(paisID);
            var daClienteDB = new BLClienteDB();
            var clienteSB = new BECliente();

            string validacion = string.Empty;

            foreach (var clienteDB in clientes)
            {
                validacion = string.Empty;

                clienteDB.PaisID = paisID;

                if (clienteDB.Estado == Constantes.ClienteEstado.Activo)
                {
                    //VALIDAR CLIENTE - ATRIBUTOS
                    validacion = this.ValidateAttribute(paisID, clienteDB);
                    if (validacion != Constantes.ClienteValidacion.Code.SUCCESS)
                    {
                        clienteDB.CodigoRespuesta = validacion;
                        clienteDB.MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion];
                        continue;
                    }

                    //OBTENER CLIENTE DB
                    var lstContactoPrincipal = (from tbl in clienteDB.Contactos
                                                where (tbl.TipoContactoID == Constantes.ClienteTipoContacto.Celular
                                                || tbl.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo)
                                                && tbl.Estado == Constantes.ClienteEstado.Activo
                                                select tbl).OrderBy(x => x.TipoContactoID);

                    if (clienteDB.ClienteID == 0)
                    {
                        foreach (var contactoPrincipal in lstContactoPrincipal)
                        {
                            var resGetCliente = daClienteDB.GetCliente(contactoPrincipal.TipoContactoID, contactoPrincipal.Valor, paisID)
                                                                .FirstOrDefault();

                            if (resGetCliente != null)
                            {
                                clienteDB.ClienteID = resGetCliente.ClienteID;
                                break;
                            }
                        }
                    }

                    //OBTENER CLIENTE SB
                    var lstClienteConsultora = this.ObtenerClienteConsultora(paisID, clienteDB);
                    if (clienteDB.ClienteIDSB == 0)
                    {
                        foreach (var contactoPrincipal in lstContactoPrincipal)
                        {
                            var clienteSBSearch = lstClienteConsultora.Where(x => (contactoPrincipal.TipoContactoID == Constantes.ClienteTipoContacto.Celular ? x.Celular : x.Telefono) == contactoPrincipal.Valor).FirstOrDefault();
                            if (clienteSBSearch != null)
                            {
                                clienteDB.ClienteIDSB = clienteSBSearch.ClienteID;
                                break;
                            }
                        }
                    }

                    //VALIDAR CLIENTE - CONSULTORA
                    validacion = this.ValidateConsultora(paisID, clienteDB, lstClienteConsultora);
                    if (validacion != Constantes.ClienteValidacion.Code.SUCCESS)
                    {
                        clienteDB.CodigoRespuesta = validacion;
                        clienteDB.MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion];
                        continue;
                    }

                    //GRABAR CLIENTE DB
                    if (clienteDB.ClienteID == 0)
                    {
                        clienteDB.ClienteID = daClienteDB.InsertCliente(clienteDB);

                        if (clienteDB.ClienteID == 0)
                        {
                            validacion = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO;
                            clienteDB.CodigoRespuesta = validacion;
                            clienteDB.MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion];
                            continue;
                        }
                    }
                    else
                    {
                        var resUpdateCliente = daClienteDB.UpdateCliente(clienteDB);

                        if (!resUpdateCliente)
                        {
                            validacion = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO;
                            clienteDB.CodigoRespuesta = validacion;
                            clienteDB.MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion];
                            continue;
                        }
                    }

                    //GRABAR CLIENTE SB
                    var oCorreo = clienteDB.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo && x.Estado == Constantes.ClienteEstado.Activo);
                    var correo = (oCorreo == null ? string.Empty : oCorreo.Valor);
                    var oTelefonoFijo = clienteDB.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo && x.Estado == Constantes.ClienteEstado.Activo);
                    var telefonoFijo = (oTelefonoFijo == null ? string.Empty : oTelefonoFijo.Valor);
                    var oCelular = clienteDB.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular && x.Estado == Constantes.ClienteEstado.Activo);
                    var celular = (oCelular == null ? string.Empty : oCelular.Valor);

                    clienteSB = new BECliente()
                    {
                        ConsultoraID = clienteDB.ConsultoraID,
                        ClienteID = clienteDB.ClienteIDSB,
                        Nombre = clienteDB.NombreCompleto,
                        NombreCliente = clienteDB.Nombres,
                        ApellidoCliente = clienteDB.Apellidos,
                        eMail = correo,
                        Activo = true,
                        Telefono = telefonoFijo,
                        Celular = celular,
                        CodigoCliente = clienteDB.ClienteID,
                        Favorito = clienteDB.Favorito,
                        TipoContactoFavorito = clienteDB.TipoContactoFavorito
                    };

                    if (clienteDB.ClienteIDSB == 0)
                    {
                        clienteDB.ClienteIDSB = daCliente.InsCliente(clienteSB);

                        if (clienteDB.ClienteIDSB == 0)
                        {
                            validacion = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO;
                            clienteDB.CodigoRespuesta = validacion;
                            clienteDB.MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion];
                            continue;
                        }

                        clienteDB.Insertado = true;
                    }
                    else
                    {
                        var resUpdateCliente = daCliente.UpdCliente(clienteSB);

                        if (resUpdateCliente == 0)
                        {
                            validacion = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO;
                            clienteDB.CodigoRespuesta = validacion;
                            clienteDB.MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion];
                            continue;
                        }

                        clienteDB.Insertado = false;
                    }

                    clienteDB.Contactos.Update(x => x.ClienteIDSB = clienteDB.ClienteIDSB);

                    var movimientosTask = Task.Run(() => _movimientoBusinessLogic.Procesar(paisID, clienteDB));
                    var recordatoriosTask = Task.Run(() => _recordatorioBusinessLogic.Procesar(paisID, clienteDB));
                    var notasTask = Task.Run(() => _notasBusinessLogic.Procesar(paisID, clienteDB));

                    Task.WaitAll(movimientosTask, recordatoriosTask, notasTask);
                }
                else
                {
                    var deleted = false;

                    //OBTENER CLIENTE SB
                    var lstContactoPrincipal = (from tbl in clienteDB.Contactos
                                                where (tbl.TipoContactoID == Constantes.ClienteTipoContacto.Celular
                                                || tbl.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo)
                                                && tbl.Estado == Constantes.ClienteEstado.Activo
                                                select tbl).OrderBy(x => x.TipoContactoID);

                    var lstClienteConsultora = this.ObtenerClienteConsultora(paisID, clienteDB);

                    foreach (var contactoPrincipal in lstContactoPrincipal)
                    {
                        var clienteSBSearch = lstClienteConsultora.FirstOrDefault(x => (contactoPrincipal.TipoContactoID == Constantes.ClienteTipoContacto.Celular ? x.Celular : x.Telefono) == contactoPrincipal.Valor);
                        if (clienteSBSearch != null)
                        {
                            clienteDB.ClienteIDSB = clienteSBSearch.ClienteID;
                            break;
                        }
                    }

                    if (clienteDB.ClienteIDSB > 0) daCliente.DelCliente(clienteDB.ConsultoraID, clienteDB.ClienteIDSB, out deleted);

                    if (!deleted)
                    {
                        validacion = Constantes.ClienteValidacion.Code.ERROR_CLIENTEASOCIADOPEDIDO;
                        clienteDB.CodigoRespuesta = validacion;
                        clienteDB.MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion];
                        continue;
                    }
                }

                validacion = Constantes.ClienteValidacion.Code.SUCCESS;
                clienteDB.CodigoRespuesta = validacion;
                clienteDB.MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion];
            }

            return clientes;
        }

        /// <summary>
        /// Obtiene la lista de clientes por consultora
        /// </summary>
        /// <param name="paisID">Pais Id</param>
        /// <param name="consultoraID">Consultora Id</param>
        /// <param name="campaniaID">Campania Id</param>
        /// <returns></returns>
        public List<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID, int campaniaID)
        {
            List<BEClienteDB> clientes = new List<BEClienteDB>();
            List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();
            var daClienteDB = new BLClienteDB();

            //OBTENER CLIENTE CONSULTORA
            var lstConsultoraCliente = SelectByConsultora(paisID, consultoraID);

            var recordatorios = _recordatorioBusinessLogic.Listar(paisID, consultoraID);
            var notas = _notasBusinessLogic.Listar(paisID, consultoraID);

            //OBTENER CLIENTES Y TIPO CONTACTOS
            string strclientes = string.Join("|", lstConsultoraCliente.Select(x => x.CodigoCliente));
            var lstCliente = daClienteDB.GetClienteByClienteID(strclientes, paisID);

            //ARMAR CONTACTOS POR CONSULTORA
            ContactoListar(lstConsultoraCliente, lstCliente);

            //OBTENER CALCULO DETALLES POR CLIENTE
            var lstClienteDetalle = GetClienteByConsultoraDetalle(paisID, consultoraID, campaniaID);

            //CONSULTA FINAL
            clientes = (from tblConsultoraCliente in lstConsultoraCliente
                        join tblCliente in lstCliente
                         on tblConsultoraCliente.CodigoCliente equals tblCliente.ClienteID
                        join tblClienteDetalle in lstClienteDetalle
                        on tblConsultoraCliente.ClienteID equals tblClienteDetalle.ClienteID
                        select new BEClienteDB
                        {
                            ClienteID = tblConsultoraCliente.CodigoCliente,
                            ClienteIDSB = tblConsultoraCliente.ClienteID,
                            Apellidos = tblConsultoraCliente.ApellidoCliente,
                            Nombres = tblConsultoraCliente.NombreCliente,
                            Alias = tblCliente.Alias,
                            Foto = tblCliente.Foto,
                            FechaNacimiento = tblCliente.FechaNacimiento,
                            Sexo = tblCliente.Sexo,
                            Documento = tblCliente.Documento,
                            Origen = tblCliente.Origen,
                            Favorito = tblConsultoraCliente.Favorito,
                            TipoContactoFavorito = tblConsultoraCliente.TipoContactoFavorito,
                            Saldo = tblClienteDetalle.Saldo,
                            CantidadProductos = tblClienteDetalle.CantidadProductos,
                            Contactos = tblConsultoraCliente.Contactos,
                            Recordatorios = recordatorios.Where(r => r.ClienteId == tblConsultoraCliente.ClienteID),
                            Notas = notas.Data.Where(r => r.ClienteId == tblConsultoraCliente.ClienteID)
                        }).OrderBy(x => x.Nombres).ToList();

            return clientes;
        }
        #endregion

        private List<BECliente> GetClienteByConsultoraDetalle(int paisID, long consultoraID, int campaniaID)
        {
            var clientes = new List<BECliente>();
            var DACliente = new DACliente(paisID);

            using (IDataReader reader = DACliente.GetClienteByConsultoraDetalle(consultoraID, campaniaID))
            {
                while (reader.Read())
                {
                    var cliente = new BECliente(reader);
                    clientes.Add(cliente);
                }
            }

            return clientes;
        }

        /// <summary>
        /// Obtiene todos los clientes deudores
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <param name="consultoraId">Consultora Id</param>
        /// <returns>Lista de deudores</returns>
        public IEnumerable<BEClienteDeudaRecordatorio> ObtenerDeudores(int paisId, long consultoraId)
        {
            var deudores = new List<BEClienteDeudaRecordatorio>();
            var daCliente = new DACliente(paisId);

            using (IDataReader reader = daCliente.DeudoresObtener(consultoraId))
                while (reader.Read())
                {
                    var deuda = new BEClienteDeudaRecordatorio(reader);
                    deudores.Add(deuda);
                }

            return deudores;
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

        private string ValidateAttribute(int paisID, BEClienteDB cliente)
        {
            if (string.IsNullOrEmpty(cliente.Nombres))
                return Constantes.ClienteValidacion.Code.ERROR_NOMBRENOENVIADO;
            if (string.IsNullOrEmpty(cliente.Origen))
                return Constantes.ClienteValidacion.Code.ERROR_NOMBRENOENVIADO;
            if (cliente.Contactos == null)
                return Constantes.ClienteValidacion.Code.ERROR_CONTACTOSNOENVIADO;
            if (cliente.Contactos.Count == 0)
                return Constantes.ClienteValidacion.Code.ERROR_CONTACTOSNOENVIADO;

            var validacionTipoContacto = cliente.Contactos.Where(x => string.IsNullOrEmpty(x.Valor) && x.Estado == Constantes.ClienteEstado.Activo);
            if (validacionTipoContacto.Any())
                return Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOVALORNOENVIADO;

            var contactos = cliente.Contactos.Where(x => (x.TipoContactoID == Constantes.ClienteTipoContacto.Celular || x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo) && x.Estado == Constantes.ClienteEstado.Activo).OrderBy(x => x.TipoContactoID);
            if (!contactos.Any())
                return Constantes.ClienteValidacion.Code.ERROR_NUMEROTELEFONONOENVIADO;

            var lstCelular = contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular);
            if (lstCelular.Any())
            {
                if (lstCelular.Count() > 1)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOREPETIDO;
                }
                else
                {
                    var oCelular = lstCelular.First();
                    if (!this.ValidateTelefono(paisID, Constantes.ClienteTipoContacto.Celular, oCelular.Valor))
                        return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR;
                }
            }

            var lstTelefono = contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo);
            if (lstTelefono.Any())
            {
                if (lstTelefono.Count() > 1)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOREPETIDO;
                }
                else
                {
                    var oTelefonoFijo = lstTelefono.First();
                    if (!this.ValidateTelefono(paisID, Constantes.ClienteTipoContacto.TelefonoFijo, oTelefonoFijo.Valor))
                        return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELFIJO;
                }
            }

            var lstCorreo = cliente.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo && x.Estado == Constantes.ClienteEstado.Activo);
            if (lstCorreo.Any())
            {
                if (lstCorreo.Count() > 1)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOREPETIDO;
                }
                else
                {
                    var oCorreo = lstCorreo.First();
                    if (!this.ValidateMail(oCorreo.Valor))
                        return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR;
                }
            }

            return Constantes.ClienteValidacion.Code.SUCCESS;
        }

        private string ValidateConsultora(int paisID, BEClienteDB cliente, List<BECliente> plstCliente)
        {
            var lstCliente = plstCliente.Where(x => x.ClienteID != cliente.ClienteIDSB);

            if (!string.IsNullOrEmpty(cliente.NombreCompleto))
            {
                var nombreExiste = lstCliente.Where(x => x.Nombre.ToUpper() == cliente.NombreCompleto.ToUpper());
                if (nombreExiste.Any()) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORANOMBREEXISTE;
            }

            var contactos = cliente.Contactos.Where(x => (x.TipoContactoID == Constantes.ClienteTipoContacto.Celular || x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo) && x.Estado == Constantes.ClienteEstado.Activo).OrderBy(x => x.TipoContactoID);

            var celular = contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular).FirstOrDefault();
            if (celular != null)
            {
                var telefonoExiste = lstCliente.Where(x => x.Celular == celular.Valor);
                if (telefonoExiste.Any()) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE;
            }

            var telefono = contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo).FirstOrDefault();
            if (telefono != null)
            {
                var telefonoExiste = lstCliente.Where(x => x.Telefono == telefono.Valor);
                if (telefonoExiste.Any()) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE;
            }

            return Constantes.ClienteValidacion.Code.SUCCESS;
        }

        private List<BECliente> ObtenerClienteConsultora(int paisID, BEClienteDB cliente)
        {
            return this.SelectByConsultora(paisID, cliente.ConsultoraID).ToList();
        }
        #endregion
    }
}