using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;

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

                string urlConParametros = rutaServiceHana + "ObtenerInformacionOnlineConsultora/" + codigoIsoHana + "/" +
                                          codigoConsultora + "/" + campaniaId;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                listaInformacionOnlineConsultoraHana = JsonConvert.DeserializeObject<List<InformacionOnlineConsultoraHana>>(responseFromServer);

                foreach (var informacionOnlineConsultoraHana in listaInformacionOnlineConsultoraHana)
                {
                    //int campania;
                    //bool esCampaniaId = int.TryParse(informacionOnlineConsultoraHana.COD_CAMP, out campania);
                    //beUsuario.CampaniaID = esCampaniaId ? campania : 0;

                    //beUsuario.CodigoConsultora = informacionOnlineConsultoraHana.COD_CLIE;

                    //int consultoraId;
                    //bool esConsultoraId = int.TryParse(informacionOnlineConsultoraHana.ConsultoraID, out consultoraId);
                    //beUsuario.ConsultoraID = esConsultoraId ? consultoraId : 0;

                    DateTime fechaVencimiento;
                    bool esFechaVencimiento = DateTime.TryParse(informacionOnlineConsultoraHana.FECHAVEN, out fechaVencimiento);
                    beUsuario.FechaLimPago = esFechaVencimiento ? fechaVencimiento : DateTime.MinValue;

                    decimal montoMinimo;
                    bool esMontoMinimo = decimal.TryParse(informacionOnlineConsultoraHana.MontoMinimoPedido, out montoMinimo);
                    beUsuario.MontoMinimoPedido = esMontoMinimo ? montoMinimo : 0;

                    decimal montoMaximo;
                    bool esMontoMaximo = decimal.TryParse(informacionOnlineConsultoraHana.MontoMaximoPedido, out montoMaximo);
                    beUsuario.MontoMaximoPedido = esMontoMaximo ? montoMaximo : 0;                    

                    //por confirmar para que sirven estos campos o cuales son sus equivalentes.
                    /*
                     * AutorizaPedido           no se usa
                     * FECHAVENCAM              no se usa
                     * FEC_CREA                 no se usa
                     * IMP_MONT_MINI            para flexipago
                     * Indicador_Activa         para flexipago
                     * Invitada                 para flexipago
                     * IMP_SALD_CAMP            no se usa
                     * SALDOTOTAL               deuda actual consultora (bienvenida y mis pagos)
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
