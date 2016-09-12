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
    public class BLOferta
    {
        public int InsertOferta(BEOferta entidad)
        {
            try
            {
                var DAOferta = new DAOferta(entidad.PaisID);
                int result = DAOferta.Insert(entidad);
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public int DeleteOferta(BEOferta entidad)
        {
            try
            {
                var DAOferta = new DAOferta(entidad.PaisID);
                int result = DAOferta.Delete(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEOferta> GetOfertas(BEOferta entidad)
        {
            try
            {
                List<BEOferta> listaOfertas = new List<BEOferta>();

                var DAOferta = new DAOferta(entidad.PaisID);
                using (IDataReader reader = DAOferta.GetOferta(entidad))
                {
                    while (reader.Read())
                    {
                        listaOfertas.Add(new BEOferta(reader));
                    }
                }
                return listaOfertas;
            }
            catch (Exception) { throw; }
        }
    }
}
