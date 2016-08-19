using System;
using CORP.BEL.Unete.UI.UB.Validaciones;
using CORP.BEL.Unete.Utils;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class ObtenerTerritorioEjecucion : IEjecucion<Paso3CoreVm, SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, SolicitudPostulante entidad)
        {
            var response = new ValidationResponse {Valid = true};

            if (!string.IsNullOrEmpty(model.ResultadoZona))
            {
                entidad.RespuestaGEO = model.ResultadoZona;
                entidad.CodigoZona = model.ResultadoZona.Substring(2, 4);
                entidad.CodigoSeccion = model.ResultadoZona.Substring(6, 1);
                entidad.CodigoTerritorio = model.ResultadoZona.Substring(7, model.ResultadoZona.Length - 7);
                entidad.EstadoGEO = Enumeradores.EstadoGEO.OK.ToInt();

                response.Data = entidad;
                return response;
            }

            try
            {
                if (string.IsNullOrEmpty(model.Latitud) || string.IsNullOrEmpty(model.Longitud))
                {
                    entidad.EstadoGEO = Enumeradores.EstadoGEO.NoEncontroTerritorioSiLatLong.ToInt();
                    response.Data = entidad;
                    return response;
                }

                var resultadoGeo = BaseUtilities.ConsumirServicio("/ObtenerTerritorioPorPunto", new
                {
                    punto = new {model.Latitud, model.Longitud},
                    pais = model.CodigoISO,
                    aplicacion = 1
                }).SelectToken("ObtenerTerritorioPorPuntoResult");

                if (resultadoGeo.HasValues && resultadoGeo.SelectToken("MensajeRespuesta").ToObject<string>() == Enumeradores.EstadoGEO.OK.ToString())
                {
                    var resultado = resultadoGeo.SelectToken("Resultado").ToObject<string>();
                    if (!string.IsNullOrWhiteSpace(resultado))
                    {
                        entidad.RespuestaGEO = resultado;
                        entidad.CodigoZona = resultado.Substring(2, 4);
                        entidad.CodigoSeccion = resultado.Substring(6, 1);
                        entidad.CodigoTerritorio = resultado.Substring(7, resultado.Length - 7);
                        entidad.EstadoGEO = Enumeradores.EstadoGEO.OK.ToInt();
                    }
                    else
                    {
                        entidad.EstadoGEO = Enumeradores.EstadoGEO.NoEncontroTerritorioSiLatLong.ToInt();
                    }
                }
                else
                {
                    entidad.EstadoGEO = Enumeradores.EstadoGEO.ErrorConsumoIntegracion.ToInt();
                }
            }
            catch (Exception ex)
            {
                entidad.EstadoGEO = Enumeradores.EstadoGEO.ErrorConsumoIntegracion.ToInt();
                ErrorUtilities.AddLog(ex);
            }

            response.Data = entidad;
            return response;
        }
    }
}