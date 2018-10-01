using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class BaseProvider
    {
        static readonly HttpClient Client = new HttpClient();
        protected ConfiguracionManagerProvider _configuracionManager;

        public BaseProvider() : this(new ConfiguracionManagerProvider())
        {
        }

        public BaseProvider(ConfiguracionManagerProvider configuracionManagerProvider)
        {
            _configuracionManager = configuracionManagerProvider;
        }

        public string GetFormatDecimalPais(string isoPais)
        {
            var listaPaises = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.KeyPaisFormatDecimal);
            if (listaPaises == "" || isoPais == "") return ",|.|2";
            if (listaPaises.Contains(isoPais)) return ".||0";
            return ",|.|2";
        }

        public string ObtenerRutaImagenResize(string rutaImagen, string rutaNombreExtension, string codigoIso)
        {
            string ruta = "";

            if (string.IsNullOrEmpty(rutaImagen))
                return ruta;

            var valorAppCatalogo = Constantes.ConfiguracionImagenResize.ValorTextoDefaultAppCatalogo;

            if (rutaImagen.ToLower().Contains(valorAppCatalogo))
            {
                string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);
                string soloExtension = Path.GetExtension(rutaImagen);

                var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;

                ruta = ConfigCdn.GetUrlFileCdn(carpetaPais, soloImagen + rutaNombreExtension + soloExtension);
            }
            else
            {
                ruta = Util.GenerarRutaImagenResize(rutaImagen, rutaNombreExtension);
            }

            return ruta;
        }

        #region Zonificacion
        public IEnumerable<RegionModel> DropDownListRegiones(int paisId)
        {
            IList<BERegion> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllRegiones(paisId);
            }
            return Mapper.Map<IList<BERegion>, IEnumerable<RegionModel>>(lst.OrderBy(zona => zona.Codigo).ToList());
        }

        public IEnumerable<ZonaModel> DropDownListZonas(int paisId)
        {
            IList<BEZona> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllZonas(paisId);
            }
            return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lst);
        }
        #endregion

        public string GetFechaPromesa(TimeSpan horaCierre, int diasFaltantes, DateTime fechaInicioCampania, bool esMobile)
        {
            var time = DateTime.Today.Add(horaCierre);
            string fecha = null;

            if (esMobile)
            {
                string hrCierrePortal = time.ToString("hh:mm tt").Replace(". ", "").ToUpper();

                fecha = diasFaltantes > 0
                    ? " CIERRA EL " + fechaInicioCampania.Day + " " + Util.NombreMes(fechaInicioCampania.Month).ToUpper()
                    : " CIERRA HOY";
                
                return fecha + " - " + hrCierrePortal.Replace(".", "");
            }
            else
            {
                var culture = CultureInfo.GetCultureInfo("es-PE");
                fecha = diasFaltantes > 0
                    ? fechaInicioCampania.ToString("dd MMM", culture).ToUpper()
                    : "HOY";

                return fecha + " - " + time.ToString("hh:mm tt", CultureInfo.InvariantCulture).ToLower();
            }

        }

        //Llamadas Post genérica
        public async Task<T> PostAsync<T>(string url, object data) where T : class, new()
        {
            try
            {
                string content = JsonConvert.SerializeObject(data);
                var buffer = Encoding.UTF8.GetBytes(content);
                var byteContent = new ByteArrayContent(buffer);
                byteContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                var response = await Client.PostAsync(url, byteContent).ConfigureAwait(false);
                string result = await response.Content.ReadAsStringAsync();
                if (response.StatusCode != HttpStatusCode.OK)
                {
                    return new T();
                }
                return JsonConvert.DeserializeObject<T>(result);
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    return new T();
                }
                throw;
            }
        }

    }

}