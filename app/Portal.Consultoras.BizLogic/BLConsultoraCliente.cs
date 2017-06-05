using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;
using System.Linq;
using System.Text.RegularExpressions;

using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraCliente
    {
        private DAConsultoraCliente daConsultoraCliente;
        private List<BEConsultoraClienteResponse> lstResponse;
        private int PaisID;

        public BLConsultoraCliente(int paisID)
        {
            daConsultoraCliente = new DAConsultoraCliente(paisID);

            lstResponse = new List<BEConsultoraClienteResponse>();

            PaisID = paisID;
        }

        #region MetodosPublicos
        public List<BEConsultoraClienteResponse> SincronizacionSubida(long consultoraID, List<BEConsultoraCliente> clientes)
        {
            bool validacionTelefono = true;

            foreach(var clienteItem in clientes)
            {
                validacionTelefono = true;

                //VALIDACION DE CLIENTE
                if (!this.Validacion(clienteItem)) continue;

                //OBTENER CELULAR O FIJO
                var lstContactoTelefono = (from tbl in clienteItem.Contactos
                                    where (tbl.TipoContactoID == Constantes.ConsultoraClienteTipoContacto.Celular
                                    || tbl.TipoContactoID == Constantes.ConsultoraClienteTipoContacto.Fijo)
                                    && tbl.Estado == Constantes.ConsultoraClienteEstado.Activo
                                    select tbl).OrderBy(x => x.TipoContactoID);

                foreach(var telefonoCliente in lstContactoTelefono)
                {
                    if(!this.ValidacionTelefono(telefonoCliente.TipoContactoID, telefonoCliente.Valor))
                    {
                        validacionTelefono = false;
                        lstResponse.Add(new BEConsultoraClienteResponse()
                        {
                            ClienteID = clienteItem.ClienteID,
                            CodigoRespuesta = (telefonoCliente.TipoContactoID == Constantes.ConsultoraClienteTipoContacto.Celular ? Constantes.ConsultoraClienteValidacion.Code.ERROR_FORMATOTELCELULAR : Constantes.ConsultoraClienteValidacion.Code.ERROR_FORMATOTELFIJO),
                            MensajeRespuesta = (telefonoCliente.TipoContactoID == Constantes.ConsultoraClienteTipoContacto.Celular ? Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_FORMATOTELCELULAR] : Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_FORMATOTELFIJO])
                        });
                        break;
                    }
                }

                if (!validacionTelefono) continue;

                var contactoItem = lstContactoTelefono.FirstOrDefault();

                if (contactoItem == null)
                {
                    lstResponse.Add(new BEConsultoraClienteResponse()
                        {
                            ClienteID = clienteItem.ClienteID,
                            CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_NUMEROTELEFONONOENVIADO,
                            MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_NUMEROTELEFONONOENVIADO]
                        });
                    continue;
                }

                //VERIFICACION CLIENTE CONSULTORA - TELEFONO
                if(!this.ValidacionTelefonoConsultora(consultoraID,clienteItem.ClienteID, contactoItem.TipoContactoID, contactoItem.Valor))
                {
                    lstResponse.Add(new BEConsultoraClienteResponse()
                    {
                        ClienteID = clienteItem.ClienteID,
                        CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE,
                        MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE]
                    });
                    continue;
                }

                //VERIFICACION CLIENTE - TELEFONO
                var resGetCliente = daConsultoraCliente.GetCliente(clienteItem.ClienteID, contactoItem.TipoContactoID, contactoItem.Valor);
                
                if (resGetCliente.Count > 0)
                {
                    if (clienteItem.ClienteID == 0)
                    {
                        clienteItem.ClienteID = resGetCliente.First().ClienteID;
                    }
                    else
                    {
                        lstResponse.Add(new BEConsultoraClienteResponse()
                        {
                            ClienteID = clienteItem.ClienteID,
                            CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_NUMEROTELEFONOEXISTE,
                            MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_NUMEROTELEFONOEXISTE]
                        });
                        continue;
                    }
                }

                //ACCION A REALIZAR
                if (clienteItem.Estado == Constantes.ConsultoraClienteEstado.Inactivo)
                {
                    if (clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.Todos || clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.DatosGenerales)
                    {
                        if (clienteItem.ClienteID > 0) daConsultoraCliente.DeleteConsultoraCliente(consultoraID, clienteItem.ClienteID);
                    }
                }
                else
                {
                    if (clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.DatosGenerales || clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.Anotaciones)
                    {
                        clienteItem.Contactos = new List<BEContactoCliente>();
                    }

                    if (clienteItem.ClienteID == 0)
                    {
                        //INSERTA CLIENTES Y CONTACTOS
                        clienteItem.ClienteID = daConsultoraCliente.InsertCliente(clienteItem);

                        if (clienteItem.ClienteID == 0)
                        {
                            lstResponse.Add(new BEConsultoraClienteResponse()
                            {
                                ClienteID = clienteItem.ClienteID,
                                CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO,
                                MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_CLIENTENOREGISTRADO]
                            });
                            continue;
                        }
                    }
                    else
                    {
                        if (clienteItem.TipoRegistro != Constantes.ConsultoraClienteTipoRegistro.Anotaciones)
                        {
                            //ACTUALIZA CLIENTES Y CONTACTOS (Insert,Update)
                            //var lstContactos = clienteItem.Contactos;
                            //clienteItem.Contactos = lstContactos.Where(x => x.Estado == Constantes.ConsultoraClienteEstado.Activo).ToList();
                            var resUpdateCliente = daConsultoraCliente.UpdateCliente(clienteItem);

                            if (!resUpdateCliente)
                            {
                                lstResponse.Add(new BEConsultoraClienteResponse()
                                {
                                    ClienteID = clienteItem.ClienteID,
                                    CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO,
                                    MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_CLIENTENOACTUALIZADO]
                                });
                                continue;
                            }

                            //if (clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.Todos || clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.TipoContacto)
                            //{
                            //    //ACTUALIZA CONTACTOS (Delete)
                            //    foreach (var contactoItemDelete in lstContactos.Where(x => x.Estado == Constantes.ConsultoraClienteEstado.Inactivo))
                            //    {
                            //        var resultDeleteContactoCliente = daConsultoraCliente.DeleteContactoCliente(contactoItemDelete);
                            //    }
                            //}
                        }
                    }

                    //ASOCIACION CLIENTE CONSULTORA - ANOTACIONES
                    if (clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.DatosGenerales || clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.TipoContacto)
                        clienteItem.Anotaciones = new List<BEAnotacion>();

                    clienteItem.ConsultoraID = consultoraID;

                    if (clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.Todos || clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.DatosGenerales ||
                            clienteItem.TipoRegistro == Constantes.ConsultoraClienteTipoRegistro.Anotaciones)
                        this.InsertConsultoraCliente(clienteItem);
                }

                lstResponse.Add(new BEConsultoraClienteResponse()
                    {
                        ClienteID = clienteItem.ClienteID,
                        CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.SUCCESS,
                        MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.SUCCESS]
                    });
            }

            return lstResponse;
        }

        public List<BEConsultoraCliente> SincronizacionBajada(long consultoraID)
        {
            List<BEConsultoraCliente> lstResult = new List<BEConsultoraCliente>();

            //1. OBTENER CONSULTORA CLIENTES Y ANOTACIONES
            var lstAnotacion = daConsultoraCliente.GetConsultoraCliente(consultoraID);

            var lstConsultoraCliente = (from tbl in lstAnotacion
                                        group tbl by tbl.ConsultoraClienteID into grp
                                        select new BEConsultoraCliente
                                        {
                                            ConsultoraClienteID = grp.Key,
                                            ConsultoraID = grp.Max(x => x.ConsultoraID),
                                            ClienteID = grp.Max(x => x.ClienteID),
                                            Favorito = grp.Max(x => x.Favorito),
                                            TipoContactoFavorito = grp.Max(x => x.TipoContactoFavorito),
                                            Anotaciones = grp.ToList(),
                                        }).ToList();

            //2. OBTENER CLIENTES Y TIPO CONTACTOS
            string clientes = string.Join("|", lstConsultoraCliente.Select(x => x.ClienteID));
            var lstCliente = daConsultoraCliente.GetClienteByClienteID(clientes);

            //4. CRUZAR 1 Y 2
            lstResult = (from tblConsultoraCliente in lstConsultoraCliente
                         join tblCliente in lstCliente
                          on tblConsultoraCliente.ClienteID equals tblCliente.ClienteID
                         select new BEConsultoraCliente
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
                              Contactos = tblCliente.Contactos,
                              Anotaciones = tblConsultoraCliente.Anotaciones.Where(x => x.AnotacionID != 0).Any() ? tblConsultoraCliente.Anotaciones : new List<BEAnotacion>()
                          }).OrderBy(x => x.Nombres).ToList();

            return lstResult;
        }

        public BEConsultoraClienteResponse ValidaTelefono(long consultoraID,BEContactoCliente contactoCliente)
        {
            BEConsultoraClienteResponse consultoraClienteResponse = null;

            if (!this.ValidacionTelefono(contactoCliente.TipoContactoID, contactoCliente.Valor))
            {
                consultoraClienteResponse = new BEConsultoraClienteResponse()
                {
                    ClienteID = contactoCliente.ClienteID,
                    CodigoRespuesta = (contactoCliente.TipoContactoID == Constantes.ConsultoraClienteTipoContacto.Celular ? Constantes.ConsultoraClienteValidacion.Code.ERROR_FORMATOTELCELULAR : Constantes.ConsultoraClienteValidacion.Code.ERROR_FORMATOTELFIJO),
                    MensajeRespuesta = (contactoCliente.TipoContactoID == Constantes.ConsultoraClienteTipoContacto.Celular ? Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_FORMATOTELCELULAR] : Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_FORMATOTELFIJO])
                };
            }

            if (consultoraClienteResponse == null)
            {
                if (!this.ValidacionTelefonoConsultora(consultoraID, contactoCliente.ClienteID, contactoCliente.TipoContactoID, contactoCliente.Valor))
                {
                    consultoraClienteResponse = new BEConsultoraClienteResponse()
                    {
                        ClienteID = contactoCliente.ClienteID,
                        CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE,
                        MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_CONSULTORATELEFONOEXISTE]
                    };
                }
                else if (contactoCliente.ClienteID > 0)
                {
                    var lstCliente = daConsultoraCliente.GetCliente(contactoCliente.ClienteID, contactoCliente.TipoContactoID, contactoCliente.Valor);

                    if (lstCliente.Count > 0)
                    {
                        consultoraClienteResponse = new BEConsultoraClienteResponse()
                        {
                            ClienteID = contactoCliente.ClienteID,
                            CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_NUMEROTELEFONOEXISTE,
                            MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_NUMEROTELEFONOEXISTE]
                        };
                    }
                }
            }

            if (consultoraClienteResponse == null)
            {  
                consultoraClienteResponse = new BEConsultoraClienteResponse()
                {
                    ClienteID = contactoCliente.ClienteID,
                    CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.SUCCESS,
                    MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.SUCCESS]
                };
            }

            return consultoraClienteResponse;
        }
        #endregion

        #region MetodosPrivados
        private bool Validacion(BEConsultoraCliente cliente)
        {
            if (string.IsNullOrEmpty(cliente.Nombres))
            {
                lstResponse.Add(new BEConsultoraClienteResponse()
                {
                    ClienteID = cliente.ClienteID,
                    CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_NOMBRENOENVIADO,
                    MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_NOMBRENOENVIADO]
                });

                return false;
            }
            else if (string.IsNullOrEmpty(cliente.Origen))
            {
                lstResponse.Add(new BEConsultoraClienteResponse()
                {
                    ClienteID = cliente.ClienteID,
                    CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_ORIGENNOENVIADO,
                    MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_ORIGENNOENVIADO]
                });

                return false;
            }
            else if (cliente.Contactos.Count == 0)
            {
                lstResponse.Add(new BEConsultoraClienteResponse()
                {
                    ClienteID = cliente.ClienteID,
                    CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_CONTACTOSNOENVIADO,
                    MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_CONTACTOSNOENVIADO]
                });

                return false;
            }

            var validacionTipoContacto = cliente.Contactos.Where(x => string.IsNullOrEmpty(x.Valor) && x.Estado == Constantes.ConsultoraClienteEstado.Activo).FirstOrDefault();

            if (validacionTipoContacto != null)
            {
                lstResponse.Add(new BEConsultoraClienteResponse()
                {
                    ClienteID = cliente.ClienteID,
                    CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_TIPOCONTACTONOENVIADO,
                    MensajeRespuesta = string.Format(Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_TIPOCONTACTONOENVIADO], validacionTipoContacto.TipoContactoID)
                });

                return false;
            }

            var validacionAnotacion = cliente.Anotaciones.Where(x => string.IsNullOrEmpty(x.Descripcion)).FirstOrDefault();

            if (validacionAnotacion != null)
            {
                lstResponse.Add(new BEConsultoraClienteResponse()
                {
                    ClienteID = cliente.ClienteID,
                    CodigoRespuesta = Constantes.ConsultoraClienteValidacion.Code.ERROR_ANOTACIONDESCRIPCIONNOENVIADO,
                    MensajeRespuesta = Constantes.ConsultoraClienteValidacion.Message[Constantes.ConsultoraClienteValidacion.Code.ERROR_ANOTACIONDESCRIPCIONNOENVIADO]
                });

                return false;
            }

            return true;
        }

        private bool ValidacionTelefono(short TipoContactoID, string telefono)
        {
            string paisISO = Util.GetPaisISO(PaisID);

            string expression = (TipoContactoID == Constantes.ConsultoraClienteTipoContacto.Celular ? Constantes.CelularValidacion.RegExp[paisISO] : Constantes.TelefonoValidacion.RegExp[paisISO]);

            Regex regex = new Regex(expression);
            Match match = regex.Match(telefono);

            return match.Success;
        }

        private bool ValidacionTelefonoConsultora(long consultoraID, long ClienteID, short TipoContactoID, string valor)
        {
            var lstAnotacion = daConsultoraCliente.GetConsultoraCliente(consultoraID);

            var lstConsultoraCliente = (from tbl in lstAnotacion
                                        group tbl by tbl.ConsultoraClienteID into grp
                                        select new BEConsultoraCliente
                                        {
                                            ConsultoraClienteID = grp.Key,
                                            ConsultoraID = grp.Max(x => x.ConsultoraID),
                                            ClienteID = grp.Max(x => x.ClienteID),
                                            Favorito = grp.Max(x => x.Favorito),
                                            TipoContactoFavorito = grp.Max(x => x.TipoContactoFavorito),
                                            Anotaciones = grp.ToList(),
                                        }).ToList();

            string clientes = string.Join("|", lstConsultoraCliente.Select(x => x.ClienteID));
            var lstCliente = daConsultoraCliente.GetClienteByClienteID(clientes);

            foreach(var itemCliente in lstCliente)
            {
                if (itemCliente.ClienteID == ClienteID) continue;

                var existe = itemCliente.Contactos.Where(x => x.TipoContactoID == TipoContactoID && x.Valor == valor).Count();
                if (existe > 0) return false; 
            }

            return true;
        }

        private bool InsertConsultoraCliente(BEConsultoraCliente consultoraCliente)
        {
            bool resultado = false;

            using (TransactionScope Ambito = new TransactionScope(TransactionScopeOption.Required, TimeSpan.FromMinutes(0)))
            {
                var ConsultoraClienteID = daConsultoraCliente.InsertConsultoraCliente(consultoraCliente);

                if (ConsultoraClienteID > 0)
                {
                    foreach (var item in consultoraCliente.Anotaciones)
                    {
                        item.ConsultoraClienteID = ConsultoraClienteID;

                        if (item.Estado == 1)
                        {
                            if (item.AnotacionID == 0)
                                daConsultoraCliente.InsertAnotacion(item);
                            else
                                daConsultoraCliente.UpdateAnotacion(item);
                        }
                        else
                        {
                            daConsultoraCliente.DeleteAnotacion(item.AnotacionID);
                        }
                    }

                    Ambito.Complete();
                }
            }

            return resultado;
        }
        #endregion
    }
}
