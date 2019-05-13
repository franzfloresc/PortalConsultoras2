﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Cryptography;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Providers
{
    public class TuVozOnlineProvider
    {
        public string BasePath { get; set; }

        public string GetUrl(UsuarioModel user, string panelId, string panelKey)
        {
            var url = BasePath;

            var currentTimeSeconds = (DateTime.Now.ToUniversalTime() - new DateTime(1970, 1, 1)).TotalSeconds;
            var parameters = string.Format("{0}|{1}|{2}|{3}|Year={4}|Active={5}|Birthdate={6:dd-MM-yyyy}|Country={7}",
                currentTimeSeconds,
                user.PrimerNombre,
                user.PrimerApellido,
                user.EMail,
                DateTime.Now.Year,
                "Yes",
                user.FechaNacimiento,
                user.CodigoISO
            );

            var query = string.Format("?ID_STRING={0}&SIGNATURE={1}&id={2}",
                HttpUtility.UrlEncode(DesAlgorithm.Encrypt(parameters, panelKey)),
                HmacShaAlgorithm.GetHash(parameters, panelKey),
                panelId
            );

            return url + query;
        }

        public async Task<bool> RequiereValidarCorreo(UsuarioModel user)
        {
            using (var client = new UsuarioServiceClient())
            {
                var estado = await client.ObtenerEstadoValidacionDatosAsync(
                                user.PaisID,
                                user.CodigoUsuario,
                                Constantes.TipoEnvioEmailSms.EnviarPorEmail
                            );

                return string.IsNullOrEmpty(estado) || estado != Constantes.ValidacionDatosEstado.Activo;
            }
        }

        public KeyValuePair<string, string> GetPanelConfig(TablaLogicaProvider provider, int paisId)
        {
            var datos = provider.GetTablaLogicaDatos(paisId, ConsTablaLogica.TuVozOnline.Id);
            var dato = datos.FirstOrDefault(r => r.Codigo == ConsTablaLogica.TuVozOnline.PanelId);
            var panelId = dato != null ? dato.Valor : string.Empty;

            dato = datos.FirstOrDefault(r => r.Codigo == ConsTablaLogica.TuVozOnline.PanelKey);
            var panelKey = dato != null ? dato.Valor : string.Empty;

            return new KeyValuePair<string, string>(panelKey, panelId);
        }
    }
}