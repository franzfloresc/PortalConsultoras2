using Portal.Consultoras.Common;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;
using Portal.Consultoras.Web.HojaInscripcionODS;
using Portal.Consultoras.Web.ValidacionesUnete;
using RazorEngine;
using System;
using System.Configuration;
using System.IO;
using System.Linq;

namespace Portal.Consultoras.Web.GestionPasos
{
    public static class CorreoHelper
    {
        public static string RenderViewAsString(string viewName, object model, string rutaBaseVista)
        {
            string textoVistaHtml;
            var filename = Path.Combine(rutaBaseVista, string.Format("{0}.cshtml", viewName));

            TextReader reader = new StreamReader(Path.GetFullPath(filename));
            try
            {
                textoVistaHtml = reader.ReadToEnd();
            }
            finally
            {
                reader.Close();
            }

            return Razor.Parse(textoVistaHtml, model, null);
        }


        public static void EnviarCorreoGz(string codigoIso, ServiceUnete.SolicitudPostulante entidad, out ZonaBE zona)
        {
            var consultora = default(HojaInscripcionODS.ConsultoraBE);
            using (var ods = new ODSServiceClient())
            {
                zona = ods.ObtenerZona(codigoIso, entidad.CodigoZona);

                if (zona == null)
                    return;

                var seccion = ods.ObtenerSeccion(codigoIso, zona.ZonaID, entidad.CodigoSeccion);
                var consultoraLider = ods.ObtenerConsultoraLiderPorZonaySeccion(codigoIso, zona.Codigo,
                    seccion.Codigo);

                if (consultoraLider != null)
                {
                    consultora = ods.ObtenerConsultoraPorZonaYSeccionUnete(codigoIso,
                        consultoraLider.ConsultoraID.ToInt());
                }

                var tieneExperiencia = entidad.TieneExperiencia.HasValue ? entidad.TieneExperiencia.Value : 0;

                EnviarCorreoNotificacion(codigoIso, entidad, consultora, zona, seccion,
                    tieneExperiencia == 1 ? "SI" : "NO", entidad.FuenteIngreso);
            }
        }

        public static void EnviarCorreoNotificacion(
           string codigoIso,
           ServiceUnete.SolicitudPostulante solicitudPostulante,
           HojaInscripcionODS.ConsultoraBE consultora,
           ZonaBE zona,
           SeccionBE seccion,
           string tieneExperiencia,
           string viaFuenteIngreso)
        {
            ParametroUneteCollection mensajeBuroCrediticio;

            using (var svBelcorpPais = new BelcorpPaisServiceClient())
            {
                mensajeBuroCrediticio = svBelcorpPais.ObtenerParametrosUnete(codigoIso,
                    Enumeradores.TipoParametro.MensajeBuroCrediticio.ToInt(), 0);
            }

            using (var sv = new ValidacionesUneteClient())
            {
                var parametro = new EmailParameter
                {
                    CodigoIso = codigoIso,
                    TipoEmail = EnumsTipoEmail.NotificacionSe,
                    Marca = codigoIso == Constantes.CodigosISOPais.Mexico ? EnumsMarca.Lbel : EnumsMarca.Esika,
                    Nombre = solicitudPostulante.PrimerNombre,
                    Apellido = solicitudPostulante.ApellidoPaterno,
                    FechaNacimiento = solicitudPostulante.FechaNacimiento.Value.ToFormattedStringDate(),
                    Direccion = solicitudPostulante.Direccion.Replace("|", " "),
                    Telefono =
                   !string.IsNullOrEmpty(solicitudPostulante.Telefono)
                       ? solicitudPostulante.Telefono
                       : solicitudPostulante.Celular,
                    Edad =
                   ((new DateTime(1, 1, 1) + (DateTime.Now - solicitudPostulante.FechaNacimiento.Value)).Year - 1)
                       .ToString(),
                    TieneExperiencia = tieneExperiencia,
                    EvaluacionCrediticia =
                   solicitudPostulante.EstadoBurocrediticio == Enumeradores.EstadoBurocrediticio.PuedeSerConsultora.ToInt()
                       ? mensajeBuroCrediticio.FirstOrDefault(x => x.Valor == 1).Nombre
                       : mensajeBuroCrediticio.FirstOrDefault(x => x.Valor == 2).Nombre,
                    ContactoUnete = viaFuenteIngreso,
                    CodigoSeccion = solicitudPostulante.CodigoSeccion,
                    CorreoElectronicoPostulante = solicitudPostulante.CorreoElectronico,
                    UrlSite =
                   ConfigurationManager.AppSettings.AllKeys.Contains(AppSettingsKeys.UrlSiteSE) &&
                   ConfigurationManager.AppSettings[AppSettingsKeys.UrlSiteSE] != null
                       ? ConfigurationManager.AppSettings[AppSettingsKeys.UrlSiteSE]
                       : "#"
                };

                if (consultora != null)
                {
                    parametro.CorreoElectronico = consultora.Email;
                    parametro.NombreDestinatario = string.Format("{0} {1}", consultora.PrimerNombre,
                        consultora.PrimerApellido);

                    sv.EnviarEmail(parametro);
                }

                if (!string.IsNullOrEmpty(zona.GZEmail))
                {
                    parametro.TipoEmail = EnumsTipoEmail.NotificacionGz;
                    parametro.CorreoElectronico = zona.GZEmail;
                    parametro.NombreDestinatario = zona.GerenteZona;
                    parametro.UrlSite = ConfigurationManager.AppSettings.AllKeys.Contains(AppSettingsKeys.UrlSiteFFVV) &&
                                        ConfigurationManager.AppSettings[AppSettingsKeys.UrlSiteFFVV] != null
                        ? ConfigurationManager.AppSettings[AppSettingsKeys.UrlSiteFFVV]
                        : "#";

                    sv.EnviarEmail(parametro);
                }
            }
        }
    }
}