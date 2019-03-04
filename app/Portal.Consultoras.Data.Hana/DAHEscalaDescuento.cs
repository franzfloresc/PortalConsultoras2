using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHEscalaDescuento
    {
        public List<BEEscalaDescuento> GetEscalaDescuento(int paisId)
        {
            var listBe = new List<BEEscalaDescuento>();

            try
            {
                var codigoIsoHana = Common.Util.GetPaisIsoHanna(paisId);
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");

                string urlConParametros = rutaServiceHana + "ObtenerEscalaDescuento/" + codigoIsoHana;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                var listaHana = JsonConvert.DeserializeObject<List<EscalaDescuentoHana>>(responseFromServer);

                foreach (var escalaDescuentoHana in listaHana)
                {
                    var beEscalaDescuento = new BEEscalaDescuento
                    {
                        MontoHasta = escalaDescuentoHana.Monto_Hasta,
                        PorDescuento = Convert.ToInt32(escalaDescuentoHana.Por_Descuento)
                    };

                    listBe.Add(beEscalaDescuento);
                }
            }
            catch (Exception)
            {
                listBe = new List<BEEscalaDescuento>();
            }

            return listBe;
        }
    }
}