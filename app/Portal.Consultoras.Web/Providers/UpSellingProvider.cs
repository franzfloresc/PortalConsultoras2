using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.Models;

using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Common;

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

        public async Task<IEnumerable<OfertaFinalMontoMetaModel>> ObtenerOfertaFinalMontoMeta(int paisId,int upSellingId)
        {

            using (var sv = new SACServiceClient())
            {
                var upSellings = await sv.ObtenerOfertaFinalMontoMetaAsync(paisId, upSellingId);
                return Mapper.Map<IList<OfertaFinalMontoMeta>, IEnumerable<OfertaFinalMontoMetaModel>>(upSellings);
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

        public async Task<RegaloOfertaFinalModel> ObtenerMontoMeta(string codigoISO, int campaniaId, long consultoraId)
        {
            using (var sv = new ProductoServiceClient())
            {
                var entidad = await sv.ObtenerRegaloMontoMetaAsync(codigoISO, campaniaId, consultoraId);
                if (entidad != null)
                {
                    var model = Mapper.Map<RegaloOfertaFinal, RegaloOfertaFinalModel>(entidad);
                    model.FormatoMontoMeta = Util.DecimalToStringFormat(model.MontoMeta, codigoISO);
                    return model;
                }
                return null;
            }
        }

        public async Task<RegaloOfertaFinalModel> ObtenerRegaloGanado(string codigoISO, int campaniaId, long consultoraId)
        {
            using (var sv = new ProductoServiceClient())
            {
                var entidad = await sv.ObtenerRegaloOfertaFinalAsync(codigoISO, campaniaId, consultoraId);
                if (entidad != null)
                {
                    var model = Mapper.Map<RegaloOfertaFinal, RegaloOfertaFinalModel>(entidad);
                    var carpetaPais = Globals.UrlMatriz + "/" + codigoISO;
                    model.RegaloImagenUrl = ConfigS3.GetUrlFileS3(carpetaPais, entidad.RegaloImagenUrl, carpetaPais);
                    model.FormatoMontoMeta = Util.DecimalToStringFormat(model.MontoMeta, codigoISO);

                    return model;
                }
                return null;
            }
        }

        public async Task<int> GuardarRegalo(int paisId, RegaloOfertaFinalModel model)
        {
            using (var sv = new SACServiceClient())
            {
                var entidad = Mapper.Map<RegaloOfertaFinalModel, UpSellingRegalo>(model);
                var result = await sv.InsertUpSellingRegaloAsync(paisId, entidad);

                return result;
            }
        }

    }
}
