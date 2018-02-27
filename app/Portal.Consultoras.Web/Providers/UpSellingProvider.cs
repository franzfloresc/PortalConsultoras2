using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.Models;

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

        public async Task<bool> GuardarRegalo(int paisId, RegaloOfertaFinalModel model)
        {
            using (var sv = new SACServiceClient())
            {
                var upSellingRegalo = Mapper.Map<RegaloOfertaFinalModel, UpSellingRegalo>(model);
                var ok = await sv.InsertUpSellingRegaloAsync(paisId, upSellingRegalo);

                return ok;
            }
        }

    }
}
