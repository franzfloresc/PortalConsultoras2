using AutoMapper;
using Portal.Consultoras.Web.Models.Encuesta;
using Portal.Consultoras.Web.ServiceEncuesta;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class EncuestaProvider
    {
        protected readonly ISessionManager sessionManager;

        public EncuestaProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }

        private List<DataConfigEncuestaModel> ObtenerDataEncuesta(int paisId) {
            var result = new List<DataConfigEncuestaModel>();
            try
            {
                if (sessionManager.GetDataConfigEncuesta() != null)
                {
                    return sessionManager.GetDataConfigEncuesta();
                }

                using (var sv = new EncuestaServiceClient())
                {
                    var response = sv.ObtenerDataEncuesta(paisId,"").ToList();
                    result = Mapper.Map<List<DataConfigEncuestaModel>>(response);
                }
            }
            catch (System.Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "ObtenerDataEncuesta", paisId.ToString());
                result = null;
            }

            return result;
        }

        public EncuestaModel ObtenerEncuesta(int paisId) {
            var result = new EncuestaModel();
            try
            {
                var data = ObtenerDataEncuesta(paisId);
                if (data == null)
                    return result;

                result.EncuestaId = data.Select(a => a.EncuestaId).Distinct().Single();
                result.EncuestaCalificacion = data
                    .GroupBy(a => new { a.CalificacionId,a.Calificacion })
                    .Select(a => new EncuestaCalificacionModel()
                {
                    EncuestaCalificacionId = a.Key.CalificacionId,
                    Descripcion = a.Key.Calificacion,
                    EncuestaMotivo = a.Select(c=> new EncuestaMotivoModel() {
                        EncuestaMotivoId = c.MotivoId,
                        TipoEncuestaMotivoId = c.TipoMotivo,
                        Descripcion = c.Motivo
                    }).ToList()
                }).ToList();

            }
            catch (System.Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "ObtenerDataEncuesta", paisId.ToString());
                
            }
            return result;
        }

    }
}