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

        #endregion

        #region ClienteDB
        public List<BEClienteResponse> SaveDB(int paisID, List<BEClienteDB> clientes)
        {
            List<BEClienteResponse> lstResponse = new List<BEClienteResponse>();
            var daCliente = new DACliente(paisID);
            var daClienteDB = new BLClienteDB();
            var clienteSB = new BECliente();
            bool validacionConsultora = true;

            foreach (var clienteDB in clientes)
            {
                validacionConsultora = true;

                var movimientosResponse = ResponseType<List<BEMovimiento>>.Build();
                clienteDB.PaisID = paisID;

                //VALIDAR CLIENTE
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

                //VALIDAR TIPO CONTACTO REPETIDO
                var contactoRepetido = (from tbl in clienteDB.Contactos
                                        group tbl by tbl.TipoContactoID into grp
                                        select new
                                        {
                                            TipoContactoID = grp.Key,
                                            Cantidad = grp.Count()
                                        }).Where(x => x.Cantidad > 1).OrderBy(x => x.TipoContactoID).FirstOrDefault();

                if (contactoRepetido != null)
                {
                    lstResponse.Add(new BEClienteResponse()
                    {
                        ClienteID = clienteDB.ClienteID,
                        ConsultoraID = clienteDB.ConsultoraID,
                        ClienteIDSB = clienteDB.ClienteIDSB,
                        CodigoRespuesta = Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOREPETIDO,
                        MensajeRespuesta = string.Format(Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOREPETIDO], contactoRepetido.TipoContactoID)
                    });
                    continue;
                }

                //OBTENER TELEFONO PRINCIPAL
                var lstClienteConsultora = this.ObtenerClienteConsultora(paisID, clienteDB);

                var lstContactoPrincipal = (from tbl in clienteDB.Contactos
                                         where (tbl.TipoContactoID == Constantes.ClienteTipoContacto.Celular
                                         || tbl.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo)
                                         && tbl.Estado == Constantes.ClienteEstado.Activo
                                         select tbl).OrderBy(x => x.TipoContactoID);

                foreach(var contactoPrincipal in lstContactoPrincipal)
                {
                    //VALIDAR CLIENTE CONSULTORA
                    validacion = this.ValidateConsultora(paisID, clienteDB, contactoPrincipal, lstClienteConsultora);

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

                        validacionConsultora = false;
                        break;
                    }

                    //OBTENER CLIENTE POR TELEFONO Y PAIS
                    var resGetCliente = daClienteDB.GetCliente(contactoPrincipal.TipoContactoID, contactoPrincipal.Valor, paisID)
                                                        .Where(x => x.ClienteID != clienteDB.ClienteID)
                                                        .FirstOrDefault();

                    if (resGetCliente != null)
                    {
                        clienteDB.ClienteID = resGetCliente.ClienteID;
                        break;
                    }
                }

                if (!validacionConsultora) continue;

                //GRABAR CLIENTE
                if (clienteDB.Estado == Constantes.ClienteEstado.Activo)
                {
                    var oCorreo = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Correo && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
                    var correo = (oCorreo == null ? string.Empty : oCorreo.Valor);
                    var oTelefonoFijo = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
                    var telefonoFijo = (oTelefonoFijo == null ? string.Empty : oTelefonoFijo.Valor);
                    var oCelular = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Celular && x.Estado == Constantes.ClienteEstado.Activo).FirstOrDefault();
                    var celular = (oCelular == null ? string.Empty : oCelular.Valor);

                    if(clienteDB.ClienteID == 0)
                    {
                        //INSERTAR CLIENTE BD
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
                        //ACTUALIZAR CLIENTE BD
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
                        clienteDB.ClienteIDSB = daCliente.InsCliente(clienteSB);
                    else
                        daCliente.UpdCliente(clienteSB);

                    if (clienteDB.Notas != null)
                    {
                        foreach (var nota in clienteDB.Notas)
                        {
                            nota.ClienteId = (short)clienteDB.ClienteIDSB;
                            nota.ConsultoraId = clienteDB.ConsultoraID;

                            if (nota.ClienteNotaId == 0)
                                nota.ClienteNotaId = NotaInsertar(paisID, nota);
                            else
                                NotaActualizar(paisID, nota);;
                        }
                    }

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
                    MensajeRespuesta = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.SUCCESS]
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

        public List<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID)
        {
            List<BEClienteDB> clientes = new List<BEClienteDB>();
            List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();
            var daClienteDB = new BLClienteDB();

            //1. OBTENER CLIENTE CONSULTORA
            var lstConsultoraCliente = this.SelectByConsultora(paisID, consultoraID);

            var recordatorios = RecordatorioListar(paisID, consultoraID);
            var notas = NotaListar(paisID, consultoraID);

            //2. OBTENER CLIENTES Y TIPO CONTACTOS
            string strclientes = string.Join("|", lstConsultoraCliente.Select(x => x.CodigoCliente));
            var lstCliente = daClienteDB.GetClienteByClienteID(strclientes, paisID);

            //3. ARMAR CONTACTOS POR CONSULTORA
            foreach(var consultoraCliente in lstConsultoraCliente)
            {
                contactos.Clear();

                if (!string.IsNullOrEmpty(consultoraCliente.Celular))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ContactoClienteID = Constantes.ClienteTipoContacto.Celular,
                        ClienteID = consultoraCliente.ClienteID,
                        TipoContactoID = Constantes.ClienteTipoContacto.Celular,
                        Valor = consultoraCliente.Celular,
                        Estado = 1
                    });
                }
                if (!string.IsNullOrEmpty(consultoraCliente.Telefono))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ContactoClienteID = Constantes.ClienteTipoContacto.TelefonoFijo,
                        ClienteID = consultoraCliente.ClienteID,
                        TipoContactoID = Constantes.ClienteTipoContacto.TelefonoFijo,
                        Valor = consultoraCliente.Telefono,
                        Estado = 1
                    });
                }
                if (!string.IsNullOrEmpty(consultoraCliente.eMail))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ContactoClienteID = Constantes.ClienteTipoContacto.Correo,
                        ClienteID = consultoraCliente.ClienteID,
                        TipoContactoID = Constantes.ClienteTipoContacto.Correo,
                        Valor = consultoraCliente.eMail,
                        Estado = 1
                    });
                }

                var clienteDB = lstCliente.Where(x => x.ClienteID == consultoraCliente.CodigoCliente).FirstOrDefault();
                if (clienteDB != null)
                {
                    var contactoDB = clienteDB.Contactos.Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Direccion).Where(x => x.TipoContactoID == Constantes.ClienteTipoContacto.Referencia);
                    if(contactoDB.Any()) contactos.AddRange(contactoDB);
                }

                consultoraCliente.Contactos = contactos;
            }

            //4. CRUZAR 1 Y 2
            clientes = (from tblConsultoraCliente in lstConsultoraCliente
                        join tblCliente in lstCliente
                         on tblConsultoraCliente.CodigoCliente equals tblCliente.ClienteID
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
                            Saldo = tblConsultoraCliente.Saldo,
                            Contactos = tblConsultoraCliente.Contactos,
                            //Contactos = tblCliente.Contactos.Select(itemContacto => new BEClienteContactoDB
                            //{
                            //    ContactoClienteID = itemContacto.ContactoClienteID,
                            //    ClienteID = tblConsultoraCliente.ClienteID,
                            //    TipoContactoID = itemContacto.TipoContactoID,
                            //    Valor = itemContacto.Valor,
                            //    Estado = itemContacto.Estado
                            //}).ToList(),
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
                var clienteDB = new BEClienteDB()
                {
                    ConsultoraID = consultoraID,
                    ClienteID = contactoCliente.ClienteID,
                    Nombres = string.Empty
                };

                var lstClienteConsultora = this.ObtenerClienteConsultora(paisID, clienteDB);
                var valConsultora = this.ValidateConsultora(paisID, clienteDB, contactoCliente, lstClienteConsultora);
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

            var validacionTipoContacto = cliente.Contactos.Where(x => string.IsNullOrEmpty(x.Valor) && x.Estado == Constantes.ClienteEstado.Activo).Count();
            if (validacionTipoContacto > 0)
                return Constantes.ClienteValidacion.Code.ERROR_TIPOCONTACTOVALORNOENVIADO;

            var contactos = cliente.Contactos.Where(x => (x.TipoContactoID == Constantes.ClienteTipoContacto.Celular || x.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo) && x.Estado == Constantes.ClienteEstado.Activo).OrderBy(x => x.TipoContactoID).ToList();
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

        private string ValidateConsultora(int paisID, BEClienteDB cliente, BEClienteContactoDB contactoPrincipal, List<BECliente> lstCliente)
        {
            var nombreExiste = lstCliente.Where(x => x.Nombre.ToUpper() == cliente.NombreCompleto.ToUpper()).Count();
            if (nombreExiste > 0) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORANOMBREEXISTE;

            if (contactoPrincipal.TipoContactoID == Constantes.ClienteTipoContacto.Celular)
            {
                var telefonoExiste = lstCliente.Where(x => x.Celular == contactoPrincipal.Valor).Count();
                if (telefonoExiste > 0) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE;
            }

            if (contactoPrincipal.TipoContactoID == Constantes.ClienteTipoContacto.TelefonoFijo)
            {
                var telefonoExiste = lstCliente.Where(x => x.Telefono == contactoPrincipal.Valor).Count();
                if (telefonoExiste > 0) return Constantes.ClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE;
            }

            return Constantes.ClienteValidacion.Code.SUCCESS;
        }

        private List<BECliente> ObtenerClienteConsultora(int paisID, BEClienteDB cliente)
        {
            var lstCliente = this.SelectByConsultora(paisID, cliente.ConsultoraID)
                .Where(x => x.ClienteID != cliente.ClienteIDSB).ToList();

            return lstCliente;
        }
        #endregion
    }
}