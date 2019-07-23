using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Cryptography;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers
{
    public class TuVozOnlineProvider
    {
        public string BasePath { get; set; }

        public string GetUrl(UsuarioModel user, string panelId, string panelKey)
        {
            var url = BasePath;

            var currentTimeSeconds = Util.ToUnixTimespan(DateTime.Now);
            var values = new List<string>
            {
                currentTimeSeconds.ToString(),
                user.PrimerNombre,
                user.PrimerApellido,
                user.EMail,
            };

            var extraParams = new Dictionary<string, string>
            {
                {"EMailActivo", user.EMailActivo ? "Validado" : "NoValidado"},
                {"CodigoConsultora", user.CodigoConsultora},
                {"FechaNacimiento", user.FechaNacimiento == default(DateTime) ? string.Empty : user.FechaNacimiento.ToString("dd/MM/yyyy")},
                {"CodigoPais", user.CodigoISO},
                {"CodigoZona", user.CodigoZona},
                {"CodigoRegion", user.CodigorRegion},
                {"CampaniaActual", user.CampaniaID.ToString()},
                {"Lider", user.esConsultoraLider ? "Si" : "No"},
                {"AñoCampaniaIngreso", user.AnoCampaniaIngreso},
                {"FechaIngreso", string.Empty},
                {"DocumentoIdentidad", user.DocumentoIdentidad},
                {"EsConsultoraNueva", user.EsConsultoraNueva ? "Si" : "No"},
                {"EsConsultoraOficina", user.EsConsultoraOficina ? "Si" : "No"},
                {"Segmento", user.Segmento},
            };
            values.AddRange(
                extraParams
                .Select(item => item.Key + "=" + (string.IsNullOrWhiteSpace(item.Value) ? "\"\"" : item.Value.Trim()))
            );
            var parameters = string.Join("|", values);

            var query = string.Format("?ID_STRING={0}&SIGNATURE={1}&id={2}",
                HttpUtility.UrlEncode(DesAlgorithm.Encrypt(parameters, panelKey)),
                HmacShaAlgorithm.GetHash(parameters, panelKey),
                panelId
            );

            return url + query;
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