using AutoMapper;
using Portal.Consultoras.Web.Models.Encuesta;
using Portal.Consultoras.Web.ServiceEncuesta;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class EncuestaProvider
    {
        protected readonly ISessionManager sessionManager;

        public EncuestaProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }

        private async Task<List<DataConfigEncuestaModel>> ObtenerDataEncuesta(int paisId,string consultoraCodigo,int verificarEncuestado) {
            var result = new List<DataConfigEncuestaModel>();
            try
            {
                if (sessionManager.GetDataConfigEncuesta() != null && verificarEncuestado == 0)
                    return sessionManager.GetDataConfigEncuesta();

                using (var sv = new EncuestaServiceClient())
                {
                    var response = await sv.ObtenerDataEncuestaAsync(paisId, consultoraCodigo, verificarEncuestado);
                    result = Mapper.Map<List<DataConfigEncuestaModel>>(response);
                    if (result.Count > 0 && result[0].EncuestaId != 0)
                        sessionManager.SetDataConfigEncuesta(result);
                    else
                        sessionManager.SetDataConfigEncuesta(null);
                }
            }
            catch (System.Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "ObtenerDataEncuesta", paisId.ToString());
                return result;
            }

            return result;
        }

        public async Task<EncuestaModel> ObtenerEncuesta(int paisId, string consultoraCodigo,string codigoCampania, int verificarEncuestado) {
            var result = new EncuestaModel();
            try
            {
                var data = await ObtenerDataEncuesta(paisId, consultoraCodigo, verificarEncuestado);
                if (!data.Any())
                    return result;

                result.EncuestaId = data.Select(a => a.EncuestaId).Distinct().Single();
                result.CodigoCampania = verificarEncuestado == 1 ? data.Select(a => a.CodigoCampania).Distinct().Single(): codigoCampania;
                result.EncuestaCalificacion = data
                    .GroupBy(a => new { a.CalificacionId, a.Calificacion, a.EstiloCalificacion,a.PreguntaDescripcion, a.ImagenCalificacion,a.TipoCalificacion })
                    .Select(a => new EncuestaCalificacionModel()
                    {
                        EncuestaCalificacionId = a.Key.CalificacionId,
                        Descripcion = a.Key.Calificacion,
                        PreguntaDescripcion = a.Key.PreguntaDescripcion,
                        EstiloCalificacion = a.Key.EstiloCalificacion,
                        ImagenCalificacion = a.Key.ImagenCalificacion,
                        TipoCalificacion = a.Key.TipoCalificacion,
                        EncuestaMotivo = a.Select(c => new EncuestaMotivoModel()
                        {
                            EncuestaMotivoId = c.MotivoId,
                            TipoEncuestaMotivoId = c.TipoMotivo,
                            Descripcion = c.Motivo
                        }).ToList()
                    }).ToList();

            }
            catch (System.Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "ObtenerDataEncuesta", paisId.ToString());
                return result;
                
            }
            return result;
        }

        public async Task<bool> GrabarEncuesta(EncuestaCalificacionModel model, int paisId)
        {
            try
            {
                if (model.EncuestaMotivo.Any())
                    model.XMLMotivo = EncuestaCalificacionModel.ListToXML(model.EncuestaMotivo.ToList());
                else
                    model.XMLMotivo = null;
                var request = new BEEncuestaCalificacion();
                request.EncuestaCalificacionId = model.EncuestaCalificacionId;
                request.EncuestaId = model.EncuestaId;
                request.XMLMotivo = model.XMLMotivo;
                request.CreatedBy = model.CreatedBy;
                request.CreateHost = model.CreateHost;
                request.CodigoCampania = model.CodigoCampania;
                request.CodigoConsultora = model.CodigoConsultora;
                request.CanalId = model.CanalId;

                using (var sv = new EncuestaServiceClient())
                {
                    var response = await sv.InsEncuestaAsync(request, paisId);
                    return response > 0;
                }
            }
            catch (System.Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "GrabarEncuesta", paisId.ToString());
                return false;
            }
        }
    }
}
