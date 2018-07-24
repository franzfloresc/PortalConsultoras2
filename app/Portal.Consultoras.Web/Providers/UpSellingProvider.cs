using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class UpSellingProvider
    {
        public async Task<IEnumerable<UpSellingModel>> ObtenerAsync(int paisId, string codigoCampana, bool incluirRegalos = false)
        {
            using (var sv = new SACServiceClient())
            {
                var upSellings = await sv.UpSellingObtenerAsync(paisId, codigoCampana, incluirRegalos);
                return Mapper.Map<IList<UpSelling>, IEnumerable<UpSellingModel>>(upSellings);
            }
        }

        public async Task<IEnumerable<UpSellingRegaloModel>> ObtenerRegalos(int paisId, int upSellingId)
        {
            using (var sv = new SACServiceClient())
            {
                var upSellings = await sv.UpSellingDetallesObtenerAsync(paisId, upSellingId);
                return Mapper.Map<IList<UpSellingDetalle>, IEnumerable<UpSellingRegaloModel>>(upSellings);
            }
        }

        public async Task<UpSellingModel> Guardar(int paisId, UpSellingModel model)
        {
            using (var sv = new SACServiceClient())
            {
                var upSelling = Mapper.Map<UpSellingModel, UpSelling>(model);
                var upSellingInsertado = await sv.UpSellingInsertarAsync(paisId, upSelling);

                return Mapper.Map<UpSelling, UpSellingModel>(upSellingInsertado);
            }
        }

        public async Task<UpSellingModel> Actualizar(int paisId, UpSellingModel model, bool soloCabecera = false)
        {
            using (var sv = new SACServiceClient())
            {
                var upSelling = Mapper.Map<UpSellingModel, UpSelling>(model);
                var upSellingInsertado = await sv.UpSellingActualizarAsync(paisId, upSelling, soloCabecera);

                return Mapper.Map<UpSelling, UpSellingModel>(upSellingInsertado);
            }
        }

        public async Task Eliminar(int paisId, int upSellingId)
        {
            using (var sv = new SACServiceClient())
            {
                await sv.UpSellingEliminarAsync(paisId, upSellingId);
            }
        }

        public async Task<OfertaFinalRegaloModel> ObtenerMontoMeta(int paisId, int campaniaId, long consultoraId)
        {
            using (var sv = new SACServiceClient())
            {
                var entidad = await sv.UpSellingObtenerMontoMetaAsync(paisId, campaniaId, consultoraId);
                return Mapper.Map<UpSellingRegalo, OfertaFinalRegaloModel>(entidad);
            }
        }

        public async Task<int> GuardarRegalo(int paisId, OfertaFinalRegaloModel modelo)
        {
            using (var sv = new SACServiceClient())
            {
                var entidad = Mapper.Map<OfertaFinalRegaloModel, UpSellingRegalo>(modelo);
                return await sv.UpSellingInsertarRegaloAsync(paisId, entidad);
            }
        }

        public async Task<OfertaFinalRegaloModel> ObtenerRegaloGanado(int paisId, int campaniaId, long consultoraId)
        {
            using (var sv = new SACServiceClient())
            {
                var entidad = await sv.UpSellingObtenerRegaloGanadoAsync(paisId, campaniaId, consultoraId);
                if (entidad != null && entidad.CampaniaId > 0)
                {
                    return Mapper.Map<UpSellingRegalo, OfertaFinalRegaloModel>(entidad);
                }
                return null;
            }
        }

        public async Task<IEnumerable<OfertaFinalMontoMetaModel>> ListarReporteMontoMeta(int paisId, int upSellingId)
        {
            using (var sv = new SACServiceClient())
            {
                var upSellings = await sv.UpSellingReporteMontoMetaAsync(paisId, upSellingId);
                return Mapper.Map<IList<UpSellingMontoMeta>, IEnumerable<OfertaFinalMontoMetaModel>>(upSellings);
            }
        }

    }
}
