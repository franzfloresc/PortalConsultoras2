using Portal.Consultoras.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLCuponesProgramaNuevas
    {
        public List<string> ObtenerListadoCuvCupon(int paisId, int campaniaId)
        {
            //var lista = new List<string>();
            var lista = (List<string>)CacheManager<string>.GetData(paisId, ECacheItem.CuponesProgramaNuevas, campaniaId.ToString());

            if (lista == null || lista.Count == 0)
            {
                lista = new List<string>();
                var daCuponesProgramaNuevas = new DACuponesProgramaNuevas(paisId);

                using (var reader = daCuponesProgramaNuevas.ObtenerListadoCuvCupon(campaniaId))
                {
                    while (reader.Read())
                    {
                        lista.Add(reader.ToString());
                    }
                }
            }                

            return lista;
        }
    }
}
