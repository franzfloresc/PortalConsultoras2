using System;
using System.Collections.Generic;
using System.Linq;
using CORP.BEL.Unete.UI.UB.GestionPasos;
using CORP.BEL.Unete.UI.UB.Validaciones;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.GestionPasos.Validaciones
{
    public class GeoLocalizacionValidation : IValidation<Paso2CoreVm>
    {
        public ValidationResponse Validar(Paso2CoreVm model)
        {
            var listaPuntos = new List<Tuple<decimal, decimal, string>>();

            try
            {
                var resultadoGeo = BaseUtilities.ConsumirServicio("/ObtenerPuntosPorDireccion", new
                {
                    direccion = model.Direccion,
                    pais = model.CodigoISO,
                    ciudad = model.Ciudad,
                    area = model.Area,
                    aplicacion = 1
                }).SelectToken("ObtenerPuntosPorDireccionResult");

                if (resultadoGeo.HasValues && resultadoGeo.SelectToken("MensajeRespuesta").ToObject<string>() == Enumeradores.RespuestaGEO.OK.ToString())
                {
                    var jsonPuntos = resultadoGeo.SelectToken("Resultado").ToObject<JValue>().Value.ToString();
                    var puntos = JArray.Parse(jsonPuntos);

                    if (puntos.HasValues)
                    {
                        listaPuntos.AddRange(from item in puntos
                            where !item.SelectToken("formatted_address").ToObject<string>().Contains("no pudo ser")
                            select
                                new Tuple<decimal, decimal, string>(item.SelectToken("Latitud").ToObject<decimal>(),
                                    item.SelectToken("Longitud").ToObject<decimal>(),
                                    item.SelectToken("formatted_address").ToObject<string>()));
                    }
                }
            }
            catch (Exception)
            {
            }

            return new ValidationResponse
            {
                Valid = true,
                Data = new KeyValuePair<ZonaParameter, List<Tuple<decimal, decimal, string>>>(new ZonaParameter(string.Empty, false), listaPuntos)
            };
        }
    }
}