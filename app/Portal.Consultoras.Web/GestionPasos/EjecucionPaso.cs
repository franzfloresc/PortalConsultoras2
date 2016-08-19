using System.Collections.Generic;
using System.Threading;
using CORP.BEL.Unete.UI.UB.GestionPasos;
using CORP.BEL.Unete.UI.UB.Validaciones;

namespace Portal.Consultoras.Web.GestionPasos
{
    public class EjecucionPaso<TModel, TResponse>
    {
        public IEnumerable<IEjecucion<TModel, TResponse>> Ejecuciones { get; set; }

        public ValidationPasoResponse Ejecutar(TModel model, TResponse entidad)
        {
            var listaValidacionResponse = new List<ValidationResponse>();
            var indiceValidacionError = -1;
            var contador = 0;
            object data = null;

            foreach (var ejecucion in Ejecuciones)
            {
                if (ejecucion is IEjecucionAsync<TModel, TResponse>)
                {
                    var ejecucionActual = (IEjecucionAsync<TModel, TResponse>)ejecucion;
                    new Thread(() =>
                    {
                        //Do an advanced looging here which takes a while
                        ejecucionActual.Ejecutar(model, entidad);

                        foreach (var operacion in ejecucionActual.OperacionesSiguientes)
                        {
                            operacion.Ejecutar(model, entidad);
                        }

                    }).Start();
                }
                else
                {
                    var response = ejecucion.Ejecutar(model, entidad);
                    listaValidacionResponse.Add(response);

                    if (!response.Valid)
                    {
                        indiceValidacionError = contador;
                        data = response.Data;
                        break;
                    }

                    contador++;
                }
            }

            return new ValidationPasoResponse
            {
                Valid = indiceValidacionError == -1,
                DetalleRespuestas = listaValidacionResponse,
                IndicePrimerError = indiceValidacionError,
                Data = data
            };
        }
    }
}