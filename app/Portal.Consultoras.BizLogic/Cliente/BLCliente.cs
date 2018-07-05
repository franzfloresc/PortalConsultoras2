using Portal.Consultoras.BizLogic.Cliente;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLCliente : IClienteBusinessLogic
    {
        private readonly INotasBusinessLogic _notasBusinessLogic;
        private readonly IMovimientoBusinessLogic _movimientoBusinessLogic;
        private readonly IRecordatorioBusinessLogic _recordatorioBusinessLogic;
        private readonly IClienteDBBusinessLogic _clienteDBBusinessLogic;

        public BLCliente() : this(new BLNotas(),
            new BLMovimiento(),
            new BLRecordatorio(),
            new BLClienteDB())
        { }

        public BLCliente(INotasBusinessLogic notasBusinessLogic,
            IMovimientoBusinessLogic movimientoBusinessLogic,
            IRecordatorioBusinessLogic recordatorioBusinessLogic,
            IClienteDBBusinessLogic clienteDBBusinessLogic)
        {
            _notasBusinessLogic = notasBusinessLogic;
            _movimientoBusinessLogic = movimientoBusinessLogic;
            _recordatorioBusinessLogic = recordatorioBusinessLogic;
            _clienteDBBusinessLogic = clienteDBBusinessLogic;
        }

        public int Insert(BECliente cliente)
        {
            var daCliente = new DACliente(cliente.PaisID);
            return daCliente.InsCliente(cliente);
        }

        public int InsertById(BECliente cliente)
        {
            var daCliente = new DACliente(cliente.PaisID);
            return daCliente.InsCliente(cliente);
        }

        public void Update(BECliente cliente)
        {
            var daCliente = new DACliente(cliente.PaisID);
            daCliente.UpdCliente(cliente);
        }

        public bool Delete(int paisID, long consultoraID, int clienteID)
        {
            bool deleted;
            var daCliente = new DACliente(paisID);

            daCliente.DelCliente(consultoraID, clienteID, out deleted);
            return deleted;
        }

        public IList<BECliente> SelectByConsultora(int paisID, long consultoraID, int ClienteID = 0)
        {
            var clientes = new List<BECliente>();

            try
            {
                using (var reader = new DACliente(paisID).GetClienteByConsultora(consultoraID, ClienteID))
                {
                    while (reader.Read())
                    {
                        var cliente = new BECliente(reader) { PaisID = paisID };
                        clientes.Add(cliente);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraID, paisID);
            }

            return clientes ?? new List<BECliente>();
        }

        public BECliente SelectByConsultoraByCodigo(int paisID, long consultoraID, int ClienteID, long codigoCliente)
        {
            var cliente = new BECliente();
            var daCliente = new DACliente(paisID);

            using (IDataReader reader = daCliente.GetClienteByCodigo(consultoraID, ClienteID, codigoCliente))
                if (reader.Read())
                {
                    cliente = new BECliente(reader) { PaisID = paisID };
                }
            return cliente;
        }

        public BECliente SelectById(int paisID, long consultoraID, int clienteID)
        {
            var cliente = new BECliente();
            var daCliente = new DACliente(paisID);

            using (IDataReader reader = daCliente.GetClienteByConsultora(consultoraID, clienteID))
                if (reader.Read())
                {
                    cliente = new BECliente(reader) { PaisID = paisID };
                }
            return cliente;
        }

        public IList<BECliente> SelectByNombre(int paisID, long consultoraID, string Nombre)
        {
            var clientes = new List<BECliente>();
            var daCliente = new DACliente(paisID);

            using (IDataReader reader = daCliente.GetClienteByNombre(consultoraID, Nombre))
                while (reader.Read())
                {
                    var cliente = new BECliente(reader) { PaisID = paisID };
                    clientes.Add(cliente);
                }
            return clientes;
        }

        public int CheckClienteByConsultora(int paisID, long ConsultoraID, string Nombre)
        {
            var daCliente = new DACliente(paisID);
            return daCliente.CheckClienteByConsultora(ConsultoraID, Nombre);
        }

        public int GetExisteClienteConsultora(int paisID, BECliente entidad)
        {
            var daCliente = new DACliente(paisID);
            return daCliente.GetExisteClienteConsultora(entidad);
        }

        public void UndoCliente(int paisID, long consultoraID, int clienteID)
        {
            var daCliente = new DACliente(paisID);
            daCliente.UndoCliente(consultoraID, clienteID);
        }

        public void InsCatalogoCampania(int paisID, string CodigoConsultora, int CampaniaID)
        {
            var daCliente = new DACliente(paisID);
            daCliente.InsCatalogoCampania(CodigoConsultora, CampaniaID);
        }

        #region Contactos
        private void ContactoListar(IList<BECliente> lstConsultoraCliente, List<BEClienteDB> lstCliente)
        {
            foreach (var consultoraCliente in lstConsultoraCliente)
            {
                var contactos = new List<BEClienteContactoDB>();

                var clienteDb = lstCliente.FirstOrDefault(x => x.CodigoCliente == consultoraCliente.CodigoCliente);

                if (clienteDb != null)
                {
                    if (!string.IsNullOrEmpty(consultoraCliente.Celular))
                    {
                        var oContacto = clienteDb.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular);

                        contactos.Add(new BEClienteContactoDB()
                        {
                            ContactoClienteID = (oContacto == null ? 0 : oContacto.ContactoClienteID),
                            ClienteID = consultoraCliente.ClienteID,
                            TipoContactoID = Constantes.ClienteTipoContacto.Celular,
                            Valor = consultoraCliente.Celular,
                            Estado = 1
                        });
                    }
                    if (!string.IsNullOrEmpty(consultoraCliente.Telefono))
                    {
                        var oContacto = clienteDb.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo);

                        contactos.Add(new BEClienteContactoDB()
                        {
                            ContactoClienteID = (oContacto == null ? 0 : oContacto.ContactoClienteID),
                            ClienteID = consultoraCliente.ClienteID,
                            TipoContactoID = Constantes.ClienteTipoContacto.TelefonoFijo,
                            Valor = consultoraCliente.Telefono,
                            Estado = 1
                        });
                    }
                    if (!string.IsNullOrEmpty(consultoraCliente.eMail))
                    {
                        var oContacto = clienteDb.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo);

                        contactos.Add(new BEClienteContactoDB()
                        {
                            ContactoClienteID = (oContacto == null ? 0 : oContacto.ContactoClienteID),
                            ClienteID = consultoraCliente.ClienteID,
                            TipoContactoID = Constantes.ClienteTipoContacto.Correo,
                            Valor = consultoraCliente.eMail,
                            Estado = 1
                        });
                    }

                    var contactoDb = clienteDb.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Direccion || x.TipoContactoID == Constantes.ClienteTipoContacto.Referencia)
                                            .Select(x => new BEClienteContactoDB()
                                            {
                                                ContactoClienteID = x.ContactoClienteID,
                                                ClienteID = consultoraCliente.ClienteID,
                                                TipoContactoID = x.TipoContactoID,
                                                Valor = x.Valor,
                                                Estado = x.Estado
                                            }).ToList();
                    if (contactoDb.Any()) contactos.AddRange(contactoDb);
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
            var blClienteDb = new BLClienteDB();
            var daCliente = new DACliente(paisID);

            foreach (var cliente in clientes)
            {
                cliente.PaisID = paisID;

                if (cliente.Estado == Constantes.ClienteEstado.Activo)
                {
                    cliente.CodigoRespuesta = this.ValidarAtributo(cliente);

                    if (cliente.CodigoRespuesta != Constantes.ClienteValidacion.Code.SUCCESS) continue;

                    var lstTelefonos = this.ObtenerTelefonos(cliente);

                    var lstClienteConsultora = this.SelectByConsultora(paisID, cliente.ConsultoraID).ToList();

                    var clienteTaskBd = Task.Run(() => this.ObtenerCodigoCliente(cliente, blClienteDb, lstTelefonos));
                    var clienteTaskSb = Task.Run(() => this.ObtenerClienteID(cliente, lstClienteConsultora, lstTelefonos));

                    Task.WaitAll(clienteTaskBd, clienteTaskSb);

                    cliente.CodigoCliente = clienteTaskBd.Result;
                    cliente.ClienteID = clienteTaskSb.Result;

                    cliente.CodigoRespuesta = this.ValidarConsultora(cliente, lstClienteConsultora);
                    if (cliente.CodigoRespuesta != Constantes.ClienteValidacion.Code.SUCCESS) continue;

                    cliente.CodigoRespuesta = this.GrabarDB(cliente, blClienteDb);
                    if (cliente.CodigoRespuesta != Constantes.ClienteValidacion.Code.SUCCESS) continue;

                    cliente.CodigoRespuesta = this.GrabarSB(cliente, daCliente);
                    if (cliente.CodigoRespuesta != Constantes.ClienteValidacion.Code.SUCCESS) continue;

                    var movimientosTask = Task.Run(() => _movimientoBusinessLogic.Procesar(paisID, cliente));
                    var recordatoriosTask = Task.Run(() => _recordatorioBusinessLogic.Procesar(paisID, cliente));
                    var notasTask = Task.Run(() => _notasBusinessLogic.Procesar(paisID, cliente));

                    Task.WaitAll(movimientosTask, recordatoriosTask, notasTask);
                }
                else
                {
                    var clienteTaskTel = Task.Run(() => this.ObtenerTelefonos(cliente));
                    var clienteTaskList = Task.Run(() => this.SelectByConsultora(cliente.PaisID, cliente.ConsultoraID));

                    Task.WaitAll(clienteTaskTel, clienteTaskList);

                    var lstTelefonos = clienteTaskTel.Result;
                    var lstClienteConsultora = clienteTaskList.Result.ToList();

                    cliente.ClienteID = this.ObtenerClienteID(cliente, lstClienteConsultora, lstTelefonos);

                    cliente.CodigoRespuesta = this.EliminarSB(cliente, daCliente);
                }
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
        public List<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID, int campaniaID, int clienteID)
        {
            var clientes = new List<BEClienteDB>();

            try
            {
                //OBTENER CLIENTE CONSULTORA
                var clienteTaskList = Task.Run(() => this.SelectByConsultora(paisID, consultoraID, clienteID));
                var recordatorioTaskList = Task.Run(() => _recordatorioBusinessLogic.Listar(paisID, consultoraID, (short)clienteID));
                var notaTaskList = Task.Run(() => _notasBusinessLogic.Listar(paisID, consultoraID, (short)clienteID));
                var clienteTaskCalc = Task.Run(() => this.GetClienteByConsultoraDetalle(paisID, consultoraID, campaniaID, clienteID));

                Task.WaitAll(clienteTaskList, recordatorioTaskList, notaTaskList, clienteTaskCalc);

                var lstConsultoraCliente = clienteTaskList.Result;
                var recordatorios = recordatorioTaskList.Result;
                var notas = notaTaskList.Result;
                var lstClienteDetalle = clienteTaskCalc.Result;

                //OBTENER CLIENTES Y TIPO CONTACTOS
                string strclientes = string.Join("|", lstConsultoraCliente.Select(x => x.CodigoCliente));
                var lstCliente = _clienteDBBusinessLogic.GetClienteByClienteID(strclientes, paisID);

                //ARMAR CONTACTOS POR CONSULTORA
                this.ContactoListar(lstConsultoraCliente, lstCliente);

                //CONSULTA FINAL
                clientes = (from tblConsultoraCliente in lstConsultoraCliente
                                join tblCliente in lstCliente
                                 on tblConsultoraCliente.CodigoCliente equals tblCliente.CodigoCliente
                                join tblClienteDetalle in lstClienteDetalle
                                on tblConsultoraCliente.ClienteID equals tblClienteDetalle.ClienteID
                                select new BEClienteDB
                                {
                                    ConsultoraID = tblConsultoraCliente.ConsultoraID,
                                    CodigoCliente = tblConsultoraCliente.CodigoCliente,
                                    ClienteID = tblConsultoraCliente.ClienteID,
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
                                    MontoPedido = tblClienteDetalle.MontoPedido,
                                    CantidadPedido = tblClienteDetalle.CantidadPedido,
                                    Contactos = tblConsultoraCliente.Contactos,
                                    Recordatorios = recordatorios.Where(r => r.ClienteId == tblConsultoraCliente.ClienteID).ToList(),
                                    Notas = notas.Data.Where(r => r.ClienteId == tblConsultoraCliente.ClienteID).ToList()
                                }).OrderBy(x => x.NombreCompleto).ToList();
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraID, paisID);
            }

            return clientes ?? new List<BEClienteDB>();
        }
        #endregion

        private List<BECliente> GetClienteByConsultoraDetalle(int paisID, long consultoraID, int campaniaID, int clienteID)
        {
            var clientes = new List<BECliente>();

            try
            {
                using (var reader = new DACliente(paisID).GetClienteByConsultoraDetalle(consultoraID, campaniaID, clienteID))
                {
                    clientes = reader.MapToCollection<BECliente>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraID, paisID);
            }

            return clientes ?? new List<BECliente>();
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

            string paisIso = Util.GetPaisISO(paisID);

            string expression = (tipoContactoID == Constantes.ClienteTipoContacto.Celular ? Constantes.ClienteCelularValidacion.RegExp[paisIso] : Constantes.ClienteTelefonoValidacion.RegExp[paisIso]);

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

        private string ValidarAtributo(BEClienteDB cliente)
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

            var contactos = cliente.Contactos.Where(x => (x.TipoContactoID == Constantes.ClienteTipoContacto.Celular || x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo) && x.Estado == Constantes.ClienteEstado.Activo).OrderBy(x => x.TipoContactoID).ToList();
            if (!contactos.Any())
                return Constantes.ClienteValidacion.Code.ERROR_NUMEROTELEFONONOENVIADO;

            var lstCelular = contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular).ToList();
            if (lstCelular.Any())
            {
                if (lstCelular.Count > 1)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOREPETIDO;
                }
                else
                {
                    var oCelular = lstCelular.First();
                    if (!this.ValidateTelefono(cliente.PaisID, Constantes.ClienteTipoContacto.Celular, oCelular.Valor))
                        return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR;
                }
            }

            var lstTelefono = contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo).ToList();
            if (lstTelefono.Any())
            {
                if (lstTelefono.Count > 1)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOREPETIDO;
                }
                else
                {
                    var oTelefonoFijo = lstTelefono.First();
                    if (!this.ValidateTelefono(cliente.PaisID, Constantes.ClienteTipoContacto.TelefonoFijo, oTelefonoFijo.Valor))
                        return Constantes.ClienteValidacion.Code.ERROR_FORMATOTELFIJO;
                }
            }

            var lstCorreo = cliente.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo && x.Estado == Constantes.ClienteEstado.Activo).ToList();
            if (lstCorreo.Any())
            {
                if (lstCorreo.Count > 1)
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

        private List<BEClienteContactoDB> ObtenerTelefonos(BEClienteDB cliente)
        {
            return (from tbl in cliente.Contactos
                    where (tbl.TipoContactoID == Constantes.ClienteTipoContacto.Celular
                    || tbl.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo)
                    && tbl.Estado == Constantes.ClienteEstado.Activo
                    select tbl).OrderBy(x => x.TipoContactoID).ToList();
        }

        private long ObtenerCodigoCliente(BEClienteDB cliente, BLClienteDB blClienteDB, List<BEClienteContactoDB> lstTelefonos)
        {
            long codigoCliente = 0;

            if (cliente.CodigoCliente > 0) return cliente.CodigoCliente;

            foreach (var telefono in lstTelefonos)
            {
                var result = blClienteDB.GetCliente(telefono.TipoContactoID, telefono.Valor, cliente.PaisID).FirstOrDefault();

                if (result != null)
                {
                    codigoCliente = result.CodigoCliente;
                    break;
                }
            }

            return codigoCliente;
        }

        private int ObtenerClienteID(BEClienteDB cliente, List<BECliente> lstClienteConsultora, List<BEClienteContactoDB> lstTelefonos)
        {
            int clienteId = 0;

            if (cliente.ClienteID > 0) return cliente.ClienteID;

            foreach (var telefono in lstTelefonos)
            {
                var result = lstClienteConsultora.FirstOrDefault(x => (telefono.TipoContactoID == Constantes.ClienteTipoContacto.Celular ? x.Celular : x.Telefono) == telefono.Valor);

                if (result != null)
                {
                    clienteId = result.ClienteID;
                    break;
                }
            }

            return clienteId;
        }

        private string ValidarConsultora(BEClienteDB cliente, List<BECliente> lstClienteConsultora)
        {
            var lstCliente = lstClienteConsultora.Where(x => x.ClienteID != cliente.ClienteID).ToList();

            if (!string.IsNullOrEmpty(cliente.NombreCompleto))
            {
                var nombreExiste = lstCliente.Where(x => x.Nombre.ToUpper() == cliente.NombreCompleto.ToUpper());
                if (nombreExiste.Any()) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORANOMBREEXISTE;
            }

            var contactos = cliente.Contactos.Where(x => (x.TipoContactoID == Constantes.ClienteTipoContacto.Celular || x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo) && x.Estado == Constantes.ClienteEstado.Activo).OrderBy(x => x.TipoContactoID).ToList();
            var celular = contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular);

            if (celular != null)
            {
                var telefonoExiste = lstCliente.Where(x => x.Celular == celular.Valor);
                if (telefonoExiste.Any()) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE;
            }

            var telefono = contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo);
            if (telefono != null)
            {
                var telefonoExiste = lstCliente.Where(x => x.Telefono == telefono.Valor);
                if (telefonoExiste.Any()) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE;
            }

            return Constantes.ClienteValidacion.Code.SUCCESS;
        }

        private string GrabarDB(BEClienteDB cliente, BLClienteDB blClienteDB)
        {
            if (cliente.CodigoCliente == 0)
            {
                cliente.CodigoCliente = blClienteDB.InsertCliente(cliente);

                if (cliente.CodigoCliente == 0)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO;
                }
            }
            else
            {
                var result = blClienteDB.UpdateCliente(cliente);

                if (!result)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO;
                }
            }

            return Constantes.ClienteValidacion.Code.SUCCESS;
        }

        private string GrabarSB(BEClienteDB cliente, DACliente daCliente)
        {
            var oCorreo = cliente.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo && x.Estado == Constantes.ClienteEstado.Activo);
            var correo = (oCorreo == null ? string.Empty : oCorreo.Valor);
            var oTelefonoFijo = cliente.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo && x.Estado == Constantes.ClienteEstado.Activo);
            var telefonoFijo = (oTelefonoFijo == null ? string.Empty : oTelefonoFijo.Valor);
            var oCelular = cliente.Contactos.FirstOrDefault(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular && x.Estado == Constantes.ClienteEstado.Activo);
            var celular = (oCelular == null ? string.Empty : oCelular.Valor);

            var clienteSb = new BECliente()
            {
                ConsultoraID = cliente.ConsultoraID,
                ClienteID = cliente.ClienteID,
                Nombre = cliente.NombreCompleto,
                NombreCliente = cliente.Nombres,
                ApellidoCliente = cliente.Apellidos,
                eMail = correo,
                Activo = true,
                Telefono = telefonoFijo,
                Celular = celular,
                CodigoCliente = cliente.CodigoCliente,
                Favorito = cliente.Favorito,
                TipoContactoFavorito = cliente.TipoContactoFavorito,
                Origen = cliente.Origen
            };

            if (cliente.ClienteID == 0)
            {
                cliente.ClienteID = daCliente.InsCliente(clienteSb);

                if (cliente.ClienteID == 0)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO;
                }

                cliente.Insertado = true;
            }
            else
            {
                var result = daCliente.UpdCliente(clienteSb);

                if (result == 0)
                {
                    return Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO;
                }

                cliente.Insertado = false;
            }
            cliente.Contactos.Update(x => x.ClienteID = cliente.ClienteID);

            return Constantes.ClienteValidacion.Code.SUCCESS;
        }

        private string EliminarSB(BEClienteDB cliente, DACliente daCliente)
        {
            var deleted = false;

            if (cliente.ClienteID > 0) daCliente.DelCliente(cliente.ConsultoraID, cliente.ClienteID, out deleted);

            if (!deleted)
            {
                return Constantes.ClienteValidacion.Code.ERROR_CLIENTEASOCIADOPEDIDO;
            }

            return Constantes.ClienteValidacion.Code.SUCCESS;

        }
        #endregion
    }
}