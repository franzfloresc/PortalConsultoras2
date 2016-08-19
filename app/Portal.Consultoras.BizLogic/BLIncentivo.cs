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
    public class BLIncentivo
    {
        public IList<BEIncentivo> SelectIncentivo(int paisID, int campaniaID)
        {
            var lista = new List<BEIncentivo>();
            var DAIncentivo = new DAIncentivo(paisID);

            using (IDataReader reader = DAIncentivo.SelectIncentivo(paisID, campaniaID))
                while (reader.Read())
                {
                    var entidad = new BEIncentivo(reader);
                    //entidad.PaisID = paisID;
                    lista.Add(entidad);
                }

            return lista;
        }

        //public BEIncentivo GetIncentivoById(int paisID, int IncentivoID)
        //{
        //    var entidad = new BEIncentivo();
        //    var DAIncentivo = new DAIncentivo(paisID);

        //    using (IDataReader reader = DAIncentivo.GetIncentivoById(IncentivoID))
        //    if (reader.Read())
        //    {
        //        entidad = new BEIncentivo(reader);
        //        //entidad.PaisID = paisID;
        //    }

        //    return entidad;
        //}

        public void InsertIncentivo(BEIncentivo entidad)
        {
            var DAIncentivo = new DAIncentivo(entidad.PaisID);
            DAIncentivo.Insert(entidad);
        }

        public void UpdateIncentivo(BEIncentivo entidad)
        {
            var DAIncentivo = new DAIncentivo(entidad.PaisID);
            DAIncentivo.Update(entidad);
        }

        public void DeleteIncentivo(int paisID, int IncentivoID)
        {
            var DAIncentivo = new DAIncentivo(paisID);
            DAIncentivo.Delete(IncentivoID);
        }
    }
}
