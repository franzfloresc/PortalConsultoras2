using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Text.RegularExpressions;
using Portal.Consultoras.BizLogic.Framework;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Cliente;

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

        #region Movimiento
        public ResponseType<int> MovimientoInsertar(int paisId, BEMovimiento movimiento)
        {
            if (!Constantes.MovimientoTipo.Todos.Contains(movimiento.TipoMovimiento))
                return ResponseType<int>.Build(success: false, message: Resources.ClienteValidationMessages.TipoMovimientoInvalido);
            
            movimiento.Monto = movimiento.TipoMovimiento == Constantes.MovimientoTipo.Abono
                ? (-1) * Math.Abs(movimiento.Monto)
                : Math.Abs(movimiento.Monto);

            var daCliente = new DACliente(paisId);
            var movimientoInsertado = daCliente.MovimientoInsertar(movimiento);

            return ResponseType<int>.Build(data: movimientoInsertado);
        }

        public IEnumerable<BEMovimiento> MovimientoListar(int paisId, short clienteId, long consultoraId)
        {
            int codigoCampania;
            var movimientos = new List<BEMovimiento>();
            var daCliente = new DACliente(paisId);
            var daPedidoDetalle = new DAPedidoWebDetalle(paisId);

            using (IDataReader reader = daCliente.MovimientosListar(clienteId, consultoraId))
                while (reader.Read())
                {
                    var movimiento = new BEMovimiento(reader);
                    movimientos.Add(movimiento);
                }

            foreach (var movimiento in movimientos)
            {
                if (movimiento.TipoMovimiento != "CB")
                    continue;

                if (!int.TryParse(movimiento.CodigoCampania, out codigoCampania))
                    continue;

                if (codigoCampania <= 0)
                    continue;

                var pedidos = new List<BEPedidoDDWebDetalle>();
                using (IDataReader reader = daPedidoDetalle.ClientePedidoFacturadoListar(codigoCampania, consultoraId, clienteId))
                    while (reader.Read())
                    {
                        var pedido = new BEPedidoDDWebDetalle(reader);
                        pedidos.Add(pedido);
                    }

                movimiento.Pedidos = pedidos;
            }

            return movimientos;
        }

        public ResponseType<BEMovimiento> MovimientoActualizar(int paisId, BEMovimiento movimiento)
        {
            if (!Constantes.MovimientoTipo.Todos.Contains(movimiento.TipoMovimiento))
            {
                return ResponseType<BEMovimiento>.Build(success: false, message: Resources.ClienteValidationMessages.TipoMovimientoInvalido);
            }

            movimiento.Monto = movimiento.TipoMovimiento == Constantes.MovimientoTipo.Abono
                ? (-1) * Math.Abs(movimiento.Monto)
                : Math.Abs(movimiento.Monto);

            var daCliente = new DACliente(paisId);
            var result = daCliente.MovimientoActualizar(movimiento);

            return ResponseType<BEMovimiento>.Build(result, string.Empty);
        }

        private ResponseType<List<BEMovimiento>> MovimientoProcesar(int paisId, IEnumerable<BEMovimiento> movimientos)
        {
            var movimientosResponse = ResponseType<List<BEMovimiento>>.Build(data: new List<BEMovimiento>());

            foreach (var movimiento in movimientos)
            {
                if (movimiento.ClienteMovimientoId == 0)
                {
                    var resultInsertar = MovimientoInsertar(paisId, movimiento);
                    if (!resultInsertar.Success)
                    {
                        movimientosResponse.Success = resultInsertar.Success;
                        movimientosResponse.Message += ", " + resultInsertar.Message;
                        continue;
                    }

                    movimiento.ClienteMovimientoId = resultInsertar.Data;
                }
                else
                {
                    var resultActualizar = MovimientoActualizar(paisId, movimiento);
                    if (!resultActualizar.Success)
                    {
                        movimientosResponse.Success = resultActualizar.Success;
                        movimientosResponse.Message += ", " + resultActualizar.Message;
                        continue;
                    }
                }

                movimientosResponse.Data.Add(movimiento);
            }

            return movimientosResponse;
        }
        #endregion

        #region Recordatorio
        public int RecordatorioInsertar(int paisId, BEClienteRecordatorio recordatorio)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.RecordatorioInsertar(recordatorio);
        }

        public List<BEClienteRecordatorio> RecordatorioListar(int paisId, long consultoraId)
        {
            var recordatorios = new List<BEClienteRecordatorio>();
            var daCliente = new DACliente(paisId);

            using (IDataReader reader = daCliente.RecordatorioObtener(consultoraId))
                while (reader.Read())
                {
                    var recordatorio = new BEClienteRecordatorio(reader);
                    recordatorios.Add(recordatorio);
                }

            return recordatorios;
        }

        public bool RecordatorioActualizar(int paisId, BEClienteRecordatorio recordatorio)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.RecordatorioActualizar(recordatorio);
        }

        public bool RecordatorioEliminar(int paisId, short clienteId, long consultoraId, int recordatorioId)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.RecordatorioEliminar(clienteId, consultoraId, recordatorioId);
        }

        #endregion

        #region Notas
        public long NotaInsertar(int paisId, BENota nota)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.NotaInsertar(nota);
        }

        public List<BENota> NotaListar(int paisId, long consultoraId)
        {
            var notas = new List<BENota>();
            var daCliente = new DACliente(paisId);

            using (IDataReader reader = daCliente.NotaObtener(consultoraId))
                while (reader.Read())
                {
                    var nota = new BENota(reader);
                    notas.Add(nota);
                }

            return notas;
        }

        public bool NotaActualizar(int paisId, BENota nota)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.NotaActualizar(nota);
        }

        public bool NotaEliminar(int paisId, short clienteId, long consultoraId, long clienteNotaId)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.NotaEliminar(clienteId, consultoraId, clienteNotaId);
        }

        public void NotaProcesar(int paisID, BEClienteDB clienteDB)
        {
            foreach (var nota in clienteDB.Notas)
            {
                nota.ClienteId = (short)clienteDB.ClienteIDSB;
                nota.ConsultoraId = clienteDB.ConsultoraID;

                if (nota.ClienteNotaId == 0)
                    nota.ClienteNotaId = NotaInsertar(paisID, nota);
                else
                    NotaActualizar(paisID, nota); ;
            }
        }
        #endregion

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
                            ClienteID = consultoraCliente.ClienteID,
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
                            ClienteID = consultoraCliente.ClienteID,
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
                            ClienteID = consultoraCliente.ClienteID,
                            TipoContactoID = Constantes.ClienteTipoContacto.Correo,
                            Valor = consultoraCliente.eMail,
                            Estado = 1
                        });
                    }

                    var contactoDB = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Direccion || x.TipoContactoID == Constantes.ClienteTipoContacto.Referencia)
                                            .Select(x => new BEClienteContactoDB()
                                            {
                                                ContactoClienteID = x.ContactoClienteID,
                                                ClienteID = consultoraCliente.ClienteID,
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
        public List<BEClienteResponse> SaveDB(int paisID, List<BEClienteDB> clientes)
        {
            List<BEClienteResponse> lstResponse = new List<BEClienteResponse>();
            var daCliente = new DACliente(paisID);
            var daClienteDB = new BLClienteDB();
            var clienteSB = new BECliente();
            bool Insertado = false;

            foreach (var clienteDB in clientes)
            {
                var movimientosResponse = ResponseType<List<BEMovimiento>>.Build();

                clienteDB.PaisID = paisID;

                if (clienteDB.Estado == Constantes.ClienteEstado.Activo)
                {
                    //VALIDAR CLIENTE - ATRIBUTOS
                    var validacion = this.ValidateAttribute(paisID, clienteDB);
                    if (validacion != Constantes.ClienteValidacion.Code.SUCCESS)
                    {
                        lstResponse.Add(new BEClienteResponse()
                        {
                            ClienteID = clienteDB.ClienteID,
                            ConsultoraID = clienteDB.ConsultoraID,
                            ClienteIDSB = clienteDB.ClienteIDSB,
                            CodigoRespuesta = validacion,
                            MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion]
                        });

                        continue;
                    }

                    //OBTENER CLIENTE DB
                    var lstContactoPrincipal = (from tbl in clienteDB.Contactos
                                                where (tbl.TipoContactoID == Constantes.ClienteTipoContacto.Celular
                                                || tbl.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo)
                                                && tbl.Estado == Constantes.ClienteEstado.Activo
                                                select tbl).OrderBy(x => x.TipoContactoID);

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

                    //OBTENER CLIENTE SB
                    var lstClienteConsultora = this.ObtenerClienteConsultora(paisID, clienteDB);

                    foreach (var contactoPrincipal in lstContactoPrincipal)
                    {
                        var clienteSBSearch = lstClienteConsultora.Where(x => (contactoPrincipal.TipoContactoID == Constantes.ClienteTipoContacto.Celular ? x.Celular : x.Telefono) == contactoPrincipal.Valor).FirstOrDefault();
                        if (clienteSBSearch != null)
                        {
                            clienteDB.ClienteIDSB = clienteSBSearch.ClienteID;
                            break;
                        }
                    }

                    //VALIDAR CLIENTE - CONSULTORA
                    validacion = this.ValidateConsultora(paisID, clienteDB, lstClienteConsultora);
                    if (validacion != Constantes.ClienteValidacion.Code.SUCCESS)
                    {
                        lstResponse.Add(new BEClienteResponse()
                        {
                            ClienteID = clienteDB.ClienteID,
                            ConsultoraID = clienteDB.ConsultoraID,
                            ClienteIDSB = clienteDB.ClienteIDSB,
                            CodigoRespuesta = validacion,
                            MensajeRespuesta = Constantes.ClienteValidacion.Message[validacion]
                        });

                        continue;
                    }

                    //GRABAR CLIENTE DB
                    if (clienteDB.ClienteID == 0)
                    {
                        clienteDB.ClienteID = daClienteDB.InsertCliente(clienteDB);

                        if (clienteDB.ClienteID == 0)
                        {
                            lstResponse.Add(new BEClienteResponse()
                            {
                                ClienteID = clienteDB.ClienteID,
                                ConsultoraID = clienteDB.ConsultoraID,
                                ClienteIDSB = clienteDB.ClienteIDSB,
                                CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO,
                                MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO]
                            });

                            continue;
                        }
                    }
                    else
                    {
                        var resUpdateCliente = daClienteDB.UpdateCliente(clienteDB);

                        if (!resUpdateCliente)
                        {
                            lstResponse.Add(new BEClienteResponse()
                            {
                                ClienteID = clienteDB.ClienteID,
                                ConsultoraID = clienteDB.ConsultoraID,
                                ClienteIDSB = clienteDB.ClienteIDSB,
                                CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO,
                                MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO]
                            });

                            continue;
                        }
                    }

                    //GRABAR CLIENTE SB
                    var oCorreo = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
                    var correo = (oCorreo == null ? string.Empty : oCorreo.Valor);
                    var oTelefonoFijo = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
                    var telefonoFijo = (oTelefonoFijo == null ? string.Empty : oTelefonoFijo.Valor);
                    var oCelular = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
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
                            lstResponse.Add(new BEClienteResponse()
                            {
                                ClienteID = clienteDB.ClienteID,
                                ConsultoraID = clienteDB.ConsultoraID,
                                ClienteIDSB = clienteDB.ClienteIDSB,
                                CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO,
                                MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO]
                            });

                            continue;
                        }

                        Insertado = true;
                    }
                    else
                    {
                        var resUpdateCliente = daCliente.UpdCliente(clienteSB);

                        if (resUpdateCliente == 0)
                        {
                            lstResponse.Add(new BEClienteResponse()
                            {
                                ClienteID = clienteDB.ClienteID,
                                ConsultoraID = clienteDB.ConsultoraID,
                                ClienteIDSB = clienteDB.ClienteIDSB,
                                CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO,
                                MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO]
                            });

                            continue;
                        }

                        Insertado = false;
                    }

                    //GRABAR NOTAS
                    if (clienteDB.Notas != null)
                    {
                        NotaProcesar(paisID, clienteDB);
                    }

                    //GRABAR MOVIMIENTOS COBRANZA
                    if (clienteDB.Movimientos != null)
                    {
                        movimientosResponse = MovimientoProcesar(paisID, clienteDB.Movimientos);
                    }
                }
                else
                {
                    var deleted = false;

                    if (clienteDB.ClienteIDSB > 0) daCliente.DelCliente(clienteDB.ConsultoraID, clienteDB.ClienteIDSB, out deleted);

                    if (!deleted)
                    {
                        lstResponse.Add(new BEClienteResponse()
                        {
                            ClienteID = clienteDB.ClienteID,
                            ConsultoraID = clienteDB.ConsultoraID,
                            ClienteIDSB = clienteDB.ClienteIDSB,
                            CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_CLIENTEASOCIADOPEDIDO,
                            MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_CLIENTEASOCIADOPEDIDO]
                        });

                        continue;
                    }
                }

                var clienteResponse = new BEClienteResponse()
                {
                    ClienteID = clienteDB.ClienteID,
                    ConsultoraID = clienteDB.ConsultoraID,
                    ClienteIDSB = clienteDB.ClienteIDSB,
                    Notas = clienteDB.Notas,
                    CodigoRespuesta = Constantes.ClienteValidacion.Code.SUCCESS,
                    MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.SUCCESS],
                    Insertado = Insertado
                };

                if (!movimientosResponse.Success)
                {
                    clienteResponse.CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTOINVALIDO;
                    clienteResponse.MensajeRespuesta = movimientosResponse.Message;
                }

                clienteResponse.Movimientos = movimientosResponse.Data;
                lstResponse.Add(clienteResponse);
            }

            return lstResponse;
        }

        /// <summary>
        /// Obtiene la lista de clientes por consultora
        /// </summary>
        /// <param name="paisID">Pais Id</param>
        /// <param name="consultoraID">Consultora Id</param>
        /// /// <param name="campaniaID">Campania Id</param>
        /// <returns></returns>
        public List<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID, int campaniaID)
        {
            List<BEClienteDB> clientes = new List<BEClienteDB>();
            List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();
            var daClienteDB = new BLClienteDB();

            //OBTENER CLIENTE CONSULTORA
            var lstConsultoraCliente = SelectByConsultora(paisID, consultoraID);

            var recordatorios = RecordatorioListar(paisID, consultoraID);
            var notas = NotaListar(paisID, consultoraID);

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
                            Contactos = tblConsultoraCliente.Contactos,
                            Recordatorios = recordatorios.Where(r => r.ClienteId == tblConsultoraCliente.ClienteID),
                            Notas = notas.Where(r => r.ClienteId == tblConsultoraCliente.ClienteID)
                        }).OrderBy(x => x.Nombres).ToList();

            return clientes;
        }

        public BEClienteResponse ValidateTelefonoByConsultoraDB(int paisID, long consultoraID, BEClienteContactoDB contactoCliente)
        {
            BEClienteResponse clienteResponse = null;
            var daClienteDB = new DAClienteDB();

            if (!this.ValidateTelefono(paisID, contactoCliente.TipoContactoID, contactoCliente.Valor))
            {
                clienteResponse = new BEClienteResponse()
                {
                    ClienteID = contactoCliente.ClienteID,
                    CodigoRespuesta = (contactoCliente.TipoContactoID == Constantes.ClienteTipoContacto.Celular ? Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR : Constantes.ClienteValidacion.Code.ERROR_FORMATOTELFIJO),
                    MensajeRespuesta = (contactoCliente.TipoContactoID == Constantes.ClienteTipoContacto.Celular ? Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_FORMATOTELCELULAR] : Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_FORMATOTELFIJO])
                };
            }

            if (clienteResponse == null)
            {
                List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();
                contactos.Add(contactoCliente);

                var clienteDB = new BEClienteDB()
                {
                    ConsultoraID = consultoraID,
                    ClienteID = contactoCliente.ClienteID,
                    Nombres = string.Empty,
                    Contactos = contactos
                };

                var lstClienteConsultora = this.ObtenerClienteConsultora(paisID, clienteDB);
                var valConsultora = this.ValidateConsultora(paisID, clienteDB, lstClienteConsultora);
                if (valConsultora != Constantes.ClienteValidacion.Code.SUCCESS)
                {
                    clienteResponse = new BEClienteResponse()
                    {
                        ClienteID = contactoCliente.ClienteID,
                        CodigoRespuesta = valConsultora,
                        MensajeRespuesta = Constantes.ClienteValidacion.Message[valConsultora]
                    };
                }
                else
                {
                    var lstCliente = daClienteDB.GetCliente(contactoCliente.TipoContactoID, contactoCliente.Valor, paisID);
                    lstCliente = lstCliente.Where(x => x.ClienteID != contactoCliente.ClienteID).ToList();

                    if (lstCliente.Count > 0)
                    {
                        clienteResponse = new BEClienteResponse()
                        {
                            ClienteID = contactoCliente.ClienteID,
                            CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_NUMEROTELEFONOEXISTE,
                            MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_NUMEROTELEFONOEXISTE]
                        };
                    }
                }
            }

            if (clienteResponse == null)
            {
                clienteResponse = new BEClienteResponse()
                {
                    ClienteID = contactoCliente.ClienteID,
                    CodigoRespuesta = Constantes.ClienteValidacion.Code.SUCCESS,
                    MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.SUCCESS]
                };
            }

            return clienteResponse;
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