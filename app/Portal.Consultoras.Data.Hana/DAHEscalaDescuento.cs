using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHEscalaDescuento
    {
        public List<BEEscalaDescuento> GetEscalaDescuento(int paisId)
        {
            var listBE = new List<BEEscalaDescuento>();
            var listaHana = new List<EscalaDescuentoHana>();

            try
            {
                var codigoIsoHana = Util.GetCodigoIsoHana(paisId);

                string urlConParametros = Util.RutaHana + "ObtenerEscalaDescuento/" + codigoIsoHana;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                listaHana = JsonConvert.DeserializeObject<List<EscalaDescuentoHana>>(responseFromServer);

                foreach (var escalaDescuentoHana in listaHana)
                {
                    var beEscalaDescuento = new BEEscalaDescuento();
                    beEscalaDescuento.MontoHasta = escalaDescuentoHana.Monto_Hasta;
                    beEscalaDescuento.PorDescuento = Convert.ToInt32(escalaDescuentoHana.Por_Descuento);

                    listBE.Add(beEscalaDescuento);
                }
            }
            catch (Exception ex)
            {
                listBE = new List<BEEscalaDescuento>();
            }            

            return listBE;
        } 
    }
}
