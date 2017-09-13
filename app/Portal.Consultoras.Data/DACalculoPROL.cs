using Portal.Consultoras.Data.ServiceCalculoPROL;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Data
{
    public class DACalculoPROL
    {
        public string URL { get; private set; }
        public DACalculoPROL(string urlService)
        {
            URL = urlService;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="pais">Pais ISO</param>
        /// <param name="periodo">Campania</param>
        /// <param name="codigoconsultora"></param>
        /// <param name="zona">Codigo Zona</param>
        /// <param name="lstProductos"></param>
        /// <returns></returns>
        public List<ObjMontosProl> CalculoMontosProl(string pais, string periodo, string codigoconsultora, string zona, System.Data.DataTable lstProductos)
        {
           
            var rtpa = new List<ObjMontosProl>();
            using (var sv = new ServicesCalculoPrecioNiveles())
            {
                sv.Url = URL;
                rtpa = sv.CalculoMontosProl(pais, periodo, codigoconsultora, zona, lstProductos).ToList();
            }

            return rtpa ?? new List<ObjMontosProl>();
        }
    }
}
