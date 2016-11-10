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
    public class DAHConfiguracionProgramaNuevas
    {
        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisId, BEConfiguracionProgramaNuevas entidad)
        {
            //var listBE = new List<BEConfiguracionProgramaNuevas>();
            var listaHana = new List<ConfiguracionProgramaNuevasHana>();
            var programaNueva = new BEConfiguracionProgramaNuevas();

            try
            {
                var codigoIsoHana = Util.GetCodigoIsoHana(paisId);
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");

                string urlConParametros = rutaServiceHana + "ObtenerConfiguracionProgramaNuevas/" + codigoIsoHana + "/" +
                                          entidad.CampaniaInicio;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                listaHana = JsonConvert.DeserializeObject<List<ConfiguracionProgramaNuevasHana>>(responseFromServer);

                foreach (var configuracionProgramaNuevasHana in listaHana)
                {
                    programaNueva.CodigoPrograma = configuracionProgramaNuevasHana.cod_prog;
                    programaNueva.CampaniaInicio = configuracionProgramaNuevasHana.cam_inic;
                    programaNueva.CampaniaFin = configuracionProgramaNuevasHana.cam_fin;
                    programaNueva.IndExigVent = configuracionProgramaNuevasHana.ind_exig_vent;
                    programaNueva.IndProgObli = configuracionProgramaNuevasHana.ind_prog_obli;
                    programaNueva.CuponKit = configuracionProgramaNuevasHana.cupon_kit ?? "";
                    programaNueva.CUVKit = configuracionProgramaNuevasHana.cuv_kit;
                    programaNueva.CodigoRegion = entidad.CodigoRegion;
                    programaNueva.CodigoZona = entidad.CodigoZona;

                    break;
                }
            }
            catch (Exception ex)
            {
                programaNueva = new BEConfiguracionProgramaNuevas();                
            }

            return programaNueva;
        }
    }
}
