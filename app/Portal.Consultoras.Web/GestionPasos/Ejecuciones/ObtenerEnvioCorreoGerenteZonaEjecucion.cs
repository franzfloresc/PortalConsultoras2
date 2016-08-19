using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;
using Portal.Consultoras.Web.HojaInscripcionODS;
using RazorEngine;


namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class ObtenerEnvioCorreoGerenteZonaEjecucion : IEjecucion<Paso3CoreVm, Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante entidad)
        {
            ZonaBE zonaActual = null;

            //if (!model.RealizarEnvioCorreoGerenteZona)
            //    return new ValidationResponse { Valid = true };

            if (entidad.EstadoPostulante == Enumeradores.EstadoPostulante.EnAprobacionFFVV.ToInt())
            {
                #region Envío de correos

                CorreoHelper.EnviarCorreoGz(model.CodigoISO, entidad, out zonaActual);

                #endregion
            }

            return new ValidationResponse { Valid = true, Data = zonaActual };
        }

    }
}