using System;
using System.Linq;
using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class ObtenerDatosAdicionalesEjecucion : IEjecucion<Paso3CoreVm, Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante entidad)
        {
            entidad.UsuarioCreacion = model.UsuarioCreacion;
            entidad.FuenteIngreso = model.FuenteIngreso;
            entidad.FechaCreacion = DateTime.Now.ToNullableDatetime();
            entidad.NumeroDocumento = BaseUtilities.AplicarFormatoNumeroDocumentoPorPais(model.CodigoISO, model.NumeroDocumento);
            entidad.IndicadorActivo = model.IndicadorActivo;
            entidad.IndicadorOptin = model.IndicadorOptin;

            using (var sv = new BelcorpPaisServiceClient())
            {
                var campaniaId = sv.ObtenerIdCampaniaActiva(model.CodigoISO);
                entidad.CampaniaID = campaniaId == null ? null : campaniaId.ToInt().ToNullableInt();

                var paises = sv.ObtenerPaises(model.CodigoISO);
                var paisActual = paises.FirstOrDefault(p => p.CodigoISO == model.CodigoISO);
                entidad.PaisID = paisActual != null ? paisActual.PaisID : default(int);
                entidad.Direccion = model.DireccionCadena;
                entidad.Telefono = model.Telefono;
                entidad.Celular = model.Celular;
            }

            return new ValidationResponse { Valid = true, Data = entidad };
        }
    }
}