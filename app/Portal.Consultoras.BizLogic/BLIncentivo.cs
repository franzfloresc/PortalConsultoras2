using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLIncentivo
    {
        public IList<BEIncentivo> SelectIncentivo(int paisID, int campaniaID)
        {
            var lista = new List<BEIncentivo>();
            var daIncentivo = new DAIncentivo(paisID);

            using (IDataReader reader = daIncentivo.SelectIncentivo(paisID, campaniaID))
                while (reader.Read())
                {
                    var entidad = new BEIncentivo(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsertIncentivo(BEIncentivo entidad)
        {
            var daIncentivo = new DAIncentivo(entidad.PaisID);
            daIncentivo.Insert(entidad);
        }

        public void UpdateIncentivo(BEIncentivo entidad)
        {
            var daIncentivo = new DAIncentivo(entidad.PaisID);
            daIncentivo.Update(entidad);
        }

        public void DeleteIncentivo(int paisID, int IncentivoID)
        {
            var daIncentivo = new DAIncentivo(paisID);
            daIncentivo.Delete(IncentivoID);
        }
    }
}
