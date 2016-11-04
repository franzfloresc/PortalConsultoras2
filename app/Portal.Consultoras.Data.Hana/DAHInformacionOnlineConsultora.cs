using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System.Globalization;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHInformacionOnlineConsultora
    {
        public BEUsuario GetDatosConsultoraHana(int paisId, string codigoConsultora, int campaniaId)
        {
            var beUsuario = new BEUsuario();
            var listaInformacionOnlineConsultoraHana = new List<InformacionOnlineConsultoraHana>();

            try
            {
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");
                var codigoIsoHana = Util.GetCodigoIsoHana(paisId);

                string urlConParametros = rutaServiceHana + "ObtenerInformacionOnlineConsultora/" + codigoIsoHana + "/" + codigoConsultora + "/" + campaniaId;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                listaInformacionOnlineConsultoraHana = JsonConvert.DeserializeObject<List<InformacionOnlineConsultoraHana>>(responseFromServer);

                foreach (var informacionOnlineConsultoraHana in listaInformacionOnlineConsultoraHana)
                {
                    DateTime fechaVencimiento;
                    bool esFechaVencimiento = DateTime.TryParseExact(informacionOnlineConsultoraHana.FECHAVEN, "ddMMyyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaVencimiento);
                    beUsuario.FechaLimPago = esFechaVencimiento ? fechaVencimiento : DateTime.MinValue;

                    decimal montoMinimo;
                    bool esMontoMinimo = decimal.TryParse(informacionOnlineConsultoraHana.MontoMinimoPedido, out montoMinimo);
                    beUsuario.MontoMinimoPedido = esMontoMinimo ? montoMinimo : 0;

                    decimal montoMaximo;
                    bool esMontoMaximo = decimal.TryParse(informacionOnlineConsultoraHana.MontoMaximoPedido, out montoMaximo);
                    beUsuario.MontoMaximoPedido = esMontoMaximo ? montoMaximo : 0;

                    decimal montoDeuda;
                    bool esMontoDeuda = decimal.TryParse(informacionOnlineConsultoraHana.SALDOTOTAL, out montoDeuda);
                    beUsuario.MontoDeuda = esMontoDeuda ? montoDeuda : 0;

                    beUsuario.IndicadorFlexiPago = informacionOnlineConsultoraHana.Indicador_Activa;

                    decimal montoMinimoFlexipago;
                    bool esMontoMinimoFlexipago = decimal.TryParse(informacionOnlineConsultoraHana.IMP_MONT_MINI, out montoMinimoFlexipago);
                    beUsuario.MontoMinimoFlexipago = esMontoMinimoFlexipago ? montoMinimoFlexipago : 0;

                    //por confirmar para que sirven estos campos o cuales son sus equivalentes.
                    /*
                     * AutorizaPedido           no se usa
                     * FECHAVENCAM              no se usa
                     * FEC_CREA                 no se usa
                     * Invitada                 para flexipago
                     * IMP_SALD_CAMP            no se usa
                     * SALDOTOTALCAM            no se usa
                    */

                    break;                    
                }                
            }
            catch (Exception ex)
            {
                beUsuario = null;
            }

            return beUsuario;
        }
    }
}
