using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraCliente
    {
        public bool InsertConsultoraCliente(int paisID, BEConsultoraCliente consultoraCliente)
        {
            var cronogramas = new List<BEConsultoraCliente>();
            var DAConsultoraCliente = new DAConsultoraCliente(paisID);

            return DAConsultoraCliente.InsertConsultoraCliente(consultoraCliente);
        }

        public bool DeleteConsultoraCliente(int paisID, long ConsultoraID, long ClienteID)
        {
            var cronogramas = new List<BEConsultoraCliente>();
            var DAConsultoraCliente = new DAConsultoraCliente(paisID);

            return DAConsultoraCliente.DeleteConsultoraCliente(ConsultoraID, ClienteID);
        }

        public List<BEConsultoraCliente> GetConsultoraCliente(int paisID, long ConsultoraID)
        {
            var lst = new List<BEConsultoraCliente>();
            var DAConsultoraCliente = new DAConsultoraCliente(paisID);

            using (IDataReader reader = DAConsultoraCliente.GetConsultoraCliente(ConsultoraID))
            {
                while (reader.Read())
                {
                    var consultoraCliente = new BEConsultoraCliente(reader);
                    lst.Add(consultoraCliente);
                }
            }

            return lst;
        }
    }
}
