using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;
using System.Linq;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraCliente
    {
        public bool InsertConsultoraCliente(int paisID, BEConsultoraCliente consultoraCliente)
        {
            bool resultado = false;

            using (TransactionScope Ambito = new TransactionScope(TransactionScopeOption.Required,TimeSpan.FromMinutes(0)))
            {
                var DAConsultoraCliente = new DAConsultoraCliente(paisID);

                var ConsultoraClienteID = DAConsultoraCliente.InsertConsultoraCliente(consultoraCliente);

                if (ConsultoraClienteID > 0)
                {
                    foreach(var item in consultoraCliente.Anotaciones)
                    {
                        item.ConsultoraClienteID = ConsultoraClienteID;

                        if (item.Estado == 1)
                        {
                            if (item.AnotacionID == 0)
                                resultado = DAConsultoraCliente.InsertAnotacion(item);
                            else
                                resultado = DAConsultoraCliente.UpdateAnotacion(item);

                            if (!resultado) break;
                        }
                        else
                        {
                            resultado = DAConsultoraCliente.DeleteAnotacion(item.AnotacionID);
                        }
                    }

                    Ambito.Complete();
                }
            }

            return resultado;
        }

        public bool DeleteConsultoraCliente(int paisID, long ConsultoraID, long ClienteID)
        {
            var DAConsultoraCliente = new DAConsultoraCliente(paisID);

            return DAConsultoraCliente.DeleteConsultoraCliente(ConsultoraID, ClienteID);
        }

        public List<BEConsultoraCliente> GetConsultoraCliente(int paisID, long ConsultoraID)
        {
            var DAConsultoraCliente = new DAConsultoraCliente(paisID);

            var lst = DAConsultoraCliente.GetConsultoraCliente(ConsultoraID);

            var result = (from tbl in lst
                          group tbl by tbl.ConsultoraClienteID into grp
                          select new BEConsultoraCliente
                          {
                              ConsultoraClienteID = grp.Key,
                              ConsultoraID = grp.Max(x => x.ConsultoraID),
                              ClienteID = grp.Max(x => x.ClienteID),
                              Favorito = grp.Max(x => x.Favorito),
                              Anotaciones = grp.ToList(),
                          }).ToList();

            return result;
        }
    }
}
