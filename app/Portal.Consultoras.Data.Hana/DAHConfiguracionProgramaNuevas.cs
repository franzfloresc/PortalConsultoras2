using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHConfiguracionProgramaNuevas
    {
        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisId, BEConfiguracionProgramaNuevas entidad)
        {
            var programaNueva = new BEConfiguracionProgramaNuevas();
            try
            {
                var codigoIsoHana = Util.GetCodigoIsoHana(paisId);
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");

                string urlConParametros = rutaServiceHana + "ObtenerConfiguracionProgramaNuevas/" + codigoIsoHana + "/" +
                                          entidad.CampaniaInicio + "/" + entidad.CodigoRegion + "/" + entidad.CodigoZona;
                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);
                List<ConfiguracionProgramaNuevasHana> listaHana = JsonConvert.DeserializeObject<List<ConfiguracionProgramaNuevasHana>>(responseFromServer);

                if (listaHana != null && listaHana.Count > 0)
                {
                    var configuracionProgramaNuevasHana = listaHana[0];

                    programaNueva.CodigoPrograma = configuracionProgramaNuevasHana.cod_prog;
                    programaNueva.CampaniaInicio = configuracionProgramaNuevasHana.cam_inic;
                    programaNueva.CampaniaFin = configuracionProgramaNuevasHana.cam_fin;
                    programaNueva.IndExigVent = configuracionProgramaNuevasHana.ind_exig_vent;
                    programaNueva.IndProgObli = configuracionProgramaNuevasHana.ind_prog_obli;
                    programaNueva.CuponKit = configuracionProgramaNuevasHana.cupon_kit ?? "";
                    programaNueva.CUVKit = configuracionProgramaNuevasHana.cuv_kit;
                    programaNueva.CodigoRegion = entidad.CodigoRegion;
                    programaNueva.CodigoZona = entidad.CodigoZona;
                }
            }
            catch (Exception) { programaNueva = new BEConfiguracionProgramaNuevas(); }

            return programaNueva;
        }
    }
}