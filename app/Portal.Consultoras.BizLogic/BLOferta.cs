using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLOferta
    {
        public int InsertOferta(BEOferta entidad)
        {
                var daOferta = new DAOferta(entidad.PaisID);
                int result = daOferta.Insert(entidad);
                return result;
        }

        public int DeleteOferta(BEOferta entidad)
        {
                var daOferta = new DAOferta(entidad.PaisID);
                int result = daOferta.Delete(entidad);
                return result;
        }

        public List<BEOferta> GetOfertas(BEOferta entidad)
        {
                List<BEOferta> listaOfertas = new List<BEOferta>();

                var daOferta = new DAOferta(entidad.PaisID);
                using (IDataReader reader = daOferta.GetOferta(entidad))
                {
                    while (reader.Read())
                    {
                        listaOfertas.Add(new BEOferta(reader));
                    }
                }
                return listaOfertas;
        }
    }
}
