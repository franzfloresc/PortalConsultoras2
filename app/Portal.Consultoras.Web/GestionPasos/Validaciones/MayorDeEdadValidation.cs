using System;
using CORP.BEL.Unete.UI.UB.GestionPasos;
using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.GestionPasos.Validaciones
{
    public class MayorDeEdadValidation : IValidation<Paso1CoreVm>
    {
        public ValidationResponse Validar(Paso1CoreVm model)
        {
            var fechaNacimiento = new DateTime(model.Anio.ToInt(), model.Mes.ToInt(), model.Dia.ToInt());
            var fechaActual = DateTime.Now;
            var anios = (new DateTime(1, 1, 1) + (fechaActual - fechaNacimiento)).Year - 1;

            if (anios < 18)
                return new ValidationResponse
                {
                    Valid = false,
                    Data = new Tuple<string,int>(string.Empty, Enumeradores.TipoMensajeEdad.MenorDeEdad.ToInt())
                };

            if (anios >= 80 && model.CodigoISO == "MX")
                return new ValidationResponse
                {
                    Valid = false,
                    Data = new Tuple<string,int>(string.Empty, Enumeradores.TipoMensajeEdad.MayorDeEdad.ToInt())
                };

            return new ValidationResponse { Valid = true, Data = new Tuple<string, int>(fechaNacimiento.ToFormattedDate(), 0) };
        }
    }
}