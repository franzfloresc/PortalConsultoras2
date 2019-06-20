using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHInformacionOnlineConsultora
    {
        public BEUsuario GetDatosConsultoraHana(int paisId, string codigoConsultora, int campaniaId)
        {
            var beUsuario = new BEUsuario();
            try
            {
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");
                var codigoIsoHana = Common.Util.GetPaisIsoHanna(paisId);

                string urlConParametros = rutaServiceHana + "ObtenerInformacionOnlineConsultora/" + codigoIsoHana + "/" + codigoConsultora + "/" + campaniaId;
                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);
                List<InformacionOnlineConsultoraHana> listaInformacionOnlineConsultoraHana = JsonConvert.DeserializeObject<List<InformacionOnlineConsultoraHana>>(responseFromServer);

                if (listaInformacionOnlineConsultoraHana != null && listaInformacionOnlineConsultoraHana.Count > 0)
                {
                    var informacionOnlineConsultoraHana = listaInformacionOnlineConsultoraHana[0];

                    DateTime fechaVencimiento;
                    bool esFechaVencimiento = DateTime.TryParseExact(informacionOnlineConsultoraHana.FECHAVEN, "ddMMyyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaVencimiento);
                    beUsuario.FechaLimPago = esFechaVencimiento ? fechaVencimiento : DateTime.MinValue;

                    decimal montoMinimo;
                    bool esMontoMinimo = decimal.TryParse(informacionOnlineConsultoraHana.MontoMinimoPedido, out montoMinimo);
                    beUsuario.MontoMinimoPedido = esMontoMinimo ? montoMinimo : 0;

                    decimal montoMaximo;
                    bool esMontoMaximo = decimal.TryParse(informacionOnlineConsultoraHana.MontoMaximoPedido, out montoMaximo);
                    beUsuario.MontoMaximoPedido = esMontoMaximo ? montoMaximo : 0;

                    beUsuario.MontoDeuda = informacionOnlineConsultoraHana.SALDOTOTALCAM;

                    beUsuario.IndicadorFlexiPago = informacionOnlineConsultoraHana.Indicador_Activa;

                    decimal montoMinimoFlexipago;
                    bool esMontoMinimoFlexipago = decimal.TryParse(informacionOnlineConsultoraHana.IMP_MONT_MINI, out montoMinimoFlexipago);
                    beUsuario.MontoMinimoFlexipago = esMontoMinimoFlexipago ? montoMinimoFlexipago : 0;

                    /* por confirmar para que sirven estos campos o cuales son sus equivalentes.
                     * AutorizaPedido           no se usa
                     * FECHAVENCAM              no se usa
                     * FEC_CREA                 no se usa
                     * Invitada                 para flexipago
                     * IMP_SALD_CAMP            no se usa
                     * SALDOTOTALCAM            no se usa
                    */
                }
            }
            catch (Exception) { beUsuario = null; }

            return beUsuario;
        }
    }
}