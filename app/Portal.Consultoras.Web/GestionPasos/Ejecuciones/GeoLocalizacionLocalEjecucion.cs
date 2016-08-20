using System;
using System.Collections.Generic;
using System.Configuration;
using CORP.BEL.Unete.UI.UB.GestionPasos;
using CORP.BEL.Unete.UI.UB.Validaciones;
using CORP.BEL.Unete.Utils.ServicioLocal;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class GeoLocalizacionLocalEjecucion : IEjecucionAsync<Paso3CoreVm, SolicitudPostulante>
    {
        public IEnumerable<IEjecucion<Paso3CoreVm, SolicitudPostulante>> OperacionesSiguientes { get; set; }

        public ValidationResponse Ejecutar(Paso3CoreVm model, SolicitudPostulante entidad)
        {
            var zonaEncontrada = default(string);
            var listaPuntos = new List<Tuple<decimal, decimal, string>>();
            var esPreferencial = false;

            try
            {
                var urlServicioLocalColombia = ConfigurationManager.AppSettings[AppSettingsKeys.WSGEO_CO_Url];
                var parametro =
                    new { idRegistro = "2", pais = model.CodigoISO, ciudad = model.Ciudad, direccion = model.Direccion };

                var resultadoGeo = BaseUtilities.ConsumirServicio<ResponseGeoCoDto>("/ConsultarGeoCo",
                    parametro, urlServicioLocalColombia);

                if (!string.IsNullOrWhiteSpace(resultadoGeo.coordenadaX) && !string.IsNullOrWhiteSpace(resultadoGeo.coordenadaY))
                {
                    zonaEncontrada = resultadoGeo.zona;

                    var codigoRegion = resultadoGeo.zona.Substring(0, 2);
                    entidad.RespuestaGEO = zonaEncontrada;
                    entidad.CodigoZona = zonaEncontrada.Substring(2, 4);
                    entidad.CodigoSeccion = zonaEncontrada.Substring(6, 1);
                    entidad.CodigoTerritorio = zonaEncontrada.Substring(7, zonaEncontrada.Length - 7);
                    entidad.Latitud = decimal.Parse(resultadoGeo.coordenadaX);
                    entidad.Longitud = decimal.Parse(resultadoGeo.coordenadaY);
                    entidad.EstadoGEO = Enumeradores.EstadoGEO.OK.ToInt();
                    esPreferencial = codigoRegion == "24";
                }
                else
                {
                    entidad.EstadoGEO = Enumeradores.EstadoGEO.NoEncontroTerritorioSiLatLong.ToInt();
                }
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
                entidad.EstadoGEO = Enumeradores.EstadoGEO.ErrorConsumoIntegracion.ToInt();
            }

            return new ValidationResponse
            {
                Valid = true,
                Data = new KeyValuePair<ZonaParameter, List<Tuple<decimal, decimal, string>>>(new ZonaParameter(zonaEncontrada, esPreferencial), listaPuntos)
            };
        }
    }
}