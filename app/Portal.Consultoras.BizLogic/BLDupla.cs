using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLDupla
    {
        public BEDupla Select(int paisID, string codigoUsuario)
        {
            BEDupla dupla = null;
            var DADupla = new DADupla(paisID);
            using (IDataReader reader = DADupla.GetDupla(codigoUsuario))
                if (reader.Read())
                {
                    dupla = new BEDupla(reader);
                    dupla.PaisID = paisID;
                }
            return dupla;
        }

        public void Insert(BEDupla dupla)
        {
            var DADupla = new DADupla(dupla.PaisID);
            DADupla.InsDupla(dupla);
        }

        public void Update(BEDupla dupla)
        {
            var DADupla = new DADupla(dupla.PaisID);
            DADupla.UpdDupla(dupla);
        }
    }
}