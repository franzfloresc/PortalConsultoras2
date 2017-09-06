﻿using System;
//using System.Transactions;
using System.Collections.Generic;
using System.Linq;

using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLClienteDB
    {
        DAClienteDB clienteData;

        public BLClienteDB()
        {
            clienteData = new DAClienteDB();
        }

        public long InsertCliente(BEClienteDB cliente)
        {
            long ClienteID = 0;

            //using (TransactionScope Ambito = new TransactionScope(TransactionScopeOption.Required, TimeSpan.FromMinutes(0)))
            //{
                ClienteID = clienteData.InsertCliente(cliente);

                if (ClienteID > 0 && cliente.Contactos != null)
                {
                    foreach (var item in cliente.Contactos)
                    {
                        if (item.Estado == Constantes.ClienteEstado.Inactivo) continue;

                        item.ClienteID = ClienteID;
                        item.ContactoClienteID = clienteData.InsertContactoCliente(item);
                        if (item.ContactoClienteID == 0)
                        {
                            ClienteID = 0;
                            item.ClienteID = 0;
                            break;
                        }
                    }
                }

            //    if (ClienteID > 0) Ambito.Complete();
            //}

            return ClienteID;
        }

        public bool UpdateCliente(BEClienteDB cliente)
        {
            bool result = false;

            //using (TransactionScope Ambito = new TransactionScope(TransactionScopeOption.Required, TimeSpan.FromMinutes(0)))
            //{
                result = clienteData.UpdateCliente(cliente);

                if (result && cliente.Contactos != null)
                {
                    foreach (var item in cliente.Contactos)
                    {
                        if (item.Estado == Constantes.ClienteEstado.Inactivo) continue;

                        item.ClienteID = cliente.ClienteID;

                        var existe = clienteData.GetContactoCliente(item).FirstOrDefault();
                        if (existe == null)
                        {
                            item.ContactoClienteID = clienteData.InsertContactoCliente(item);
                            if (item.ContactoClienteID == 0)
                            {
                                result = false;
                                break;
                            }
                        }
                        else
                        {
                            item.ContactoClienteID = existe.ContactoClienteID;
                            result = clienteData.UpdateContactoCliente(item);
                            if (!result) break;
                        }
                    }
                }

            //    if (result) Ambito.Complete();
            //}

            return result;
        }

        public List<BEClienteDB> GetCliente(short TipoContactoID, string Valor, int PaisID)
        {
            return clienteData.GetCliente(TipoContactoID, Valor, PaisID);
        }

        public List<BEClienteDB> GetClienteByClienteID(string Clientes, int PaisID)
        {
            var lst = clienteData.GetClienteByClienteID(Clientes, PaisID);
            List<BEClienteDB> result = (from tbl in lst
                                    group tbl by tbl.ClienteID into grp
                                        select new BEClienteDB
                                    {
                                        ClienteID = grp.Key,
                                        Apellidos = grp.Max(x => x.Apellidos),
                                        Nombres = grp.Max(x => x.Nombres),
                                        Alias = grp.Max(x => x.Alias),
                                        Foto = grp.Max(x => x.Foto),
                                        FechaNacimiento = grp.Max(x => x.FechaNacimiento),
                                        Sexo = grp.Max(x => x.Sexo),
                                        Documento = grp.Max(x => x.Documento),
                                        Origen = grp.Max(x => x.Origen),

                                        Contactos = grp.ToList()
                                    }).ToList();

            return result;
        }
    }
}
