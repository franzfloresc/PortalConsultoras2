using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLEtiqueta
    {
        public int InsertEtiqueta(BEEtiqueta entidad)
        {
            var daEtiqueta = new DAEtiqueta(entidad.PaisID);
            int result = daEtiqueta.Insert(entidad);
            return result;
        }

        public List<BEEtiqueta> GetEtiquetas(BEEtiqueta entidad)
        {
            List<BEEtiqueta> listaEtiquetas = new List<BEEtiqueta>();

            var daEtiqueta = new DAEtiqueta(entidad.PaisID);
            using (IDataReader reader = daEtiqueta.GetEtiquetas(entidad))
            {
                while (reader.Read())
                {
                    listaEtiquetas.Add(new BEEtiqueta(reader));
                }
            }
            return listaEtiquetas;
        }
    }
}
