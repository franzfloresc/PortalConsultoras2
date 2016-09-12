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
    public class BLEtiqueta
    {
        public int InsertEtiqueta(BEEtiqueta entidad)
        {
            try
            {
                var DAEtiqueta = new DAEtiqueta(entidad.PaisID);
                int result = DAEtiqueta.Insert(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEtiqueta> GetEtiquetas(BEEtiqueta entidad)
        {
            try
            {
                List<BEEtiqueta> listaEtiquetas = new List<BEEtiqueta>();

                var DAEtiqueta = new DAEtiqueta(entidad.PaisID);
                using (IDataReader reader = DAEtiqueta.GetEtiquetas(entidad))
                {
                    while (reader.Read())
                    {
                        listaEtiquetas.Add(new BEEtiqueta(reader));
                    }
                }
                return listaEtiquetas;
            }
            catch (Exception) { throw; }
        }
    }
}
