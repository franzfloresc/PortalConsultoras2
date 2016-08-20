using System.Collections.Generic;
using CORP.BEL.Unete.UI.UB.Validaciones;

namespace CORP.BEL.Unete.UI.UB.GestionPasos
{
    public class ValidationPaso<TModel>
    {
        public IEnumerable<IValidation<TModel>> Validaciones { get; set; }

        public ValidationPasoResponse Validar(TModel model)
        {
            var listaValidacionResponse = new List<ValidationResponse>();
            var indiceValidacionError = -1;
            var contador = 0;
            object data = null;

            foreach (var validacion in Validaciones)
            {
                var response = validacion.Validar(model);
                listaValidacionResponse.Add(response);

                if (!response.Valid)
                {
                    indiceValidacionError = contador;
                    data = response.Data;
                    break;
                }

                contador++;
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