﻿using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using Common = Portal.Consultoras.Common;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHConfiguracionProgramaNuevas
    {
        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisId, BEConfiguracionProgramaNuevas entidad)
        {
            var programaNueva = new BEConfiguracionProgramaNuevas();

            try
            {
                var codigoIsoHana = Common.Util.GetPaisIsoHanna(paisId);
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");
                
                string urlConParametros = rutaServiceHana + "ObtenerConfiguracionProgramaNuevas/" + codigoIsoHana + "/" + entidad.Campania;
                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);
                List<ConfiguracionProgramaNuevasHana> listaHana = JsonConvert.DeserializeObject<List<ConfiguracionProgramaNuevasHana>>(responseFromServer);

                if (listaHana != null && listaHana.Count > 0)
                {
                    var configuracionProgramaNuevasHana = listaHana[0];

                    programaNueva.CodigoPrograma = configuracionProgramaNuevasHana.cod_prog;
                    programaNueva.IndExigVent = configuracionProgramaNuevasHana.ind_exig_vent;
                    programaNueva.IndProgObli = configuracionProgramaNuevasHana.ind_prog_obli;
                    programaNueva.CUVKit = configuracionProgramaNuevasHana.cuv_kit;
                }
            }
            catch (Exception) { programaNueva = new BEConfiguracionProgramaNuevas(); }

            return programaNueva;
        }
    }
}