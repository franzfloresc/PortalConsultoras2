using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Cryptography;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic.Contenido
{
    public class BLTuVozOnline : ITuVozOnlineBusinessLogic
    {
        private readonly ITablaLogicaDatosBusinessLogic _tablaLogicaDatosBusinessLogic;

        public BLTuVozOnline() : this(new BLTablaLogicaDatos())
        {
        }

        public BLTuVozOnline(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
        }

        public BETvoPanelConfig GetPanelConfig(int paisId)
        {
            var config = new BETvoPanelConfig();
            var datos = _tablaLogicaDatosBusinessLogic.GetListCache(paisId, ConsTablaLogica.TuVozOnline.Id);
            var dato = datos.FirstOrDefault(r => r.Codigo == ConsTablaLogica.TuVozOnline.PanelId);
            config.Id = dato != null ? dato.Valor : string.Empty;

            dato = datos.FirstOrDefault(r => r.Codigo == ConsTablaLogica.TuVozOnline.PanelKey);
            config.Key = dato != null ? dato.Valor : string.Empty;

            dato = datos.FirstOrDefault(r => r.Codigo == ConsTablaLogica.TuVozOnline.PanelUrl);
            config.Url = dato != null ? dato.Valor : string.Empty;

            return config;
        }

        public string GetUrl(BETvoPanelConfig panelConfig, BEUsuario user)
        {
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

            return string.Format(panelConfig.Url,
                WebUtility.UrlEncode(DesAlgorithm.Encrypt(parameters, panelConfig.Key)),
                HmacShaAlgorithm.GetHash(parameters, panelConfig.Key),
                panelConfig.Id
            );
        }
    }
}
