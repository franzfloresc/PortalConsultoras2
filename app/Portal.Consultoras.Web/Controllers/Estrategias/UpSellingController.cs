using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers.Estrategias
{
    [BaseAuthenticationFilter]
    public class UpSellingController : BaseController
    {
        private readonly ZonificacionProvider _zonificacionProvider;
        private readonly UpSellingProvider _upSellingProvider;

        public UpSellingController()
        {
            _upSellingProvider = new UpSellingProvider();
            _zonificacionProvider = new ZonificacionProvider();
        }

        public async Task<ActionResult> Index()
        {
            var campanas = await _zonificacionProvider.ObtenerCampanias(userData.PaisID);
            var model = new UpSellingAdminModel()
            {
                PaisIso = userData.CodigoISO,
                Campanas = campanas,
                PaisNombre = userData.NombrePais,
                EsPaisEsika = Settings.Instance.PaisesEsika.Contains(userData.CodigoISO)
            };

            return View(model);
        }

        private async Task<IEnumerable<UpSellingModel>> GetUpSellingsService(string codigoCampania, bool incluirRegalos)
        {
            var upsellings = await _upSellingProvider.ObtenerAsync(userData.PaisID, codigoCampania, incluirRegalos);

            upsellings.Update(upSelling =>
            {
                upSelling.ImagenFondoPrincipalDesktop = MakeFullUrlS3(upSelling.ImagenFondoPrincipalDesktop);
                upSelling.ImagenFondoPrincipalMobile = MakeFullUrlS3(upSelling.ImagenFondoPrincipalMobile);
                upSelling.ImagenFondoGanasteMobile = MakeFullUrlS3(upSelling.ImagenFondoGanasteMobile);
                SetFullUrlImage(upSelling.Regalos);
            });

            return upsellings;
        }

        [HttpGet]
        public async Task<JsonResult> Obtener(string codigoCampana, bool incluirRegalos = false)
        {
            if (string.IsNullOrEmpty(codigoCampana))
                codigoCampana = null;

            var upsellings = await GetUpSellingsService(codigoCampana, incluirRegalos);

            return Json(ResultModel<IEnumerable<UpSellingModel>>.BuildOk(upsellings), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public async Task<JsonResult> ObtenerRegalos(int upSellingId)
        {
            var regalos = await _upSellingProvider.ObtenerRegalos(userData.PaisID, upSellingId);
            SetFullUrlImage(regalos);

            return Json(ResultModel<UpSellingModel>.BuildOk(regalos), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public async Task<ActionResult> Guardar(UpSellingModel model)
        {
            try
            {
                model = SetAuditInfo(model);
                if (!UpLoadUploadImages(model))
                    return Json(ResultModel<bool>.BuildBad("Sucedio un error al guardar las imagenes", false));

                UpSellingModel result;
                if (model.UpSellingId > 0)
                    result = await _upSellingProvider.Actualizar(userData.PaisID, model);
                else
                    result = await _upSellingProvider.Guardar(userData.PaisID, model);

                return Json(ResultModel<UpSellingModel>.BuildOk(result), JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoUsuario, userData.CodigoISO);
                return Json(ResultModel<bool>.BuildBad(ex.Message, false));
            }
        }

        [HttpPost]
        public async Task<ActionResult> Eliminar(int upSellingId)
        {
            try
            {
                await _upSellingProvider.Eliminar(userData.PaisID, upSellingId);

                return Json(ResultModel<bool>.BuildOk(true));
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoUsuario, userData.CodigoISO);
                return Json(ResultModel<bool>.BuildBad(ex.Message, false));
            }
        }

        [HttpPost]
        public async Task<ActionResult> Actualizar(UpSellingModel model)
        {
            model = SetAuditInfo(model);
            var result = await _upSellingProvider.Actualizar(userData.PaisID, model, true);

            return Json(ResultModel<UpSellingModel>.BuildOk(result), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public async Task<ActionResult> ObtenerListadoGanadoras(int upSellingId)
        {
            var upSelling = await _upSellingProvider.ListarReporteMontoMeta(userData.PaisID, upSellingId);
            return Json(ResultModel<IEnumerable<OfertaFinalMontoMetaModel>>.BuildOk(upSelling), JsonRequestBehavior.AllowGet);
        }

        public async Task<ActionResult> ExportarExcel(int upSellingIdListaGanadoras, string campaniaListaGanadoras)
        {
            var upSellings = await _upSellingProvider.ListarReporteMontoMeta(userData.PaisID, upSellingIdListaGanadoras);

            Dictionary<string, string> dic =
                new Dictionary<string, string> {
                            { "Campaña", "Campania" },
                            {  "Cod Consultora","Codigo" },
                            { "Nombre de Consultora","Nombre" },
                            {  "CUV Regalo","CuvRegalo" },
                            { "Nombre Regalo", "NombreRegalo" },
                            { "Monto Pedido","MontoInicial" },
                            { "Rango Inicial", "RangoInicial" },
                             { "Rango Final", "RangoFinal" },
                            { "Monto a Agregar" ,"MontoAgregar"},
                            { "Monto Meta","MontoMeta" },
                             { "Monto Ganador", "MontoGanador" },
                            { "Fecha Registro" ,"FechaRegistro" },
                };

            var filename = string.Format("{0}_{1}_Upselling", userData.CodigoISO, campaniaListaGanadoras);
            Util.ExportToExcelFormat(filename, upSellings.ToList(), dic, "dd/MM/yyyy hh:mm:ss AM/PM");
            return View();
        }

        private void SetFullUrlImage(IEnumerable<UpSellingRegaloModel> model)
        {
            model.Update(regalo =>
            {
                regalo.Imagen = MakeFullUrlS3(regalo.Imagen);
            });
        }

        private string MakeFullUrlS3(string fileName)
        {
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            return ConfigS3.GetUrlFileS3(carpetaPais, fileName, carpetaPais);
        }

        private bool FileExistsOrIsNotValid(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
                return true;

            if (fileName.StartsWith("http"))
                return true;

            return false;
        }

        private bool UpLoadUploadImages(UpSellingModel model)
        {
            try
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                if (!FileExistsOrIsNotValid(model.ImagenFondoPrincipalDesktop))
                {
                    var upLoadedImagenPrincipal = ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, model.ImagenFondoPrincipalDesktop),
                        carpetaPais,
                        model.ImagenFondoPrincipalDesktop,
                        true, true, true);
                    if (!upLoadedImagenPrincipal)
                        return false;
                }

                if (!FileExistsOrIsNotValid(model.ImagenFondoPrincipalMobile))
                {
                    var upLoadedImagenPrincipalMobile = ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, model.ImagenFondoPrincipalMobile), carpetaPais, model.ImagenFondoPrincipalMobile, true, true, true);
                    if (!upLoadedImagenPrincipalMobile)
                        return false;
                }

                if (!FileExistsOrIsNotValid(model.ImagenFondoGanasteMobile))
                {
                    var upLoadedImagenGanasteMobile = ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, model.ImagenFondoGanasteMobile), carpetaPais, model.ImagenFondoGanasteMobile, true, true, true);
                    if (!upLoadedImagenGanasteMobile)
                        return false;
                }

                foreach (var regalo in model.Regalos)
                {
                    if (FileExistsOrIsNotValid(regalo.Imagen))
                        continue;

                    var upLoaded = ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, regalo.Imagen), carpetaPais, regalo.Imagen, true, true, true);
                    if (!upLoaded)
                        return false;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
                return false;
            }

            return true;
        }

        private UpSellingModel SetAuditInfo(UpSellingModel model)
        {
            if (model.UpSellingId == 0)
            {
                model.UsuarioCreacion = userData.UsuarioNombre;
                model.FechaCreacion = DateTime.Now;
            }
            else
            {
                model.UsuarioModificacion = userData.UsuarioNombre;
                model.FechaModificacion = DateTime.Now;
            }

            if (model.Regalos == null)
                return model;

            model.Regalos.ForEach(regalo =>
            {
                if (regalo.UpSellingRegaloId == 0)
                {
                    regalo.UsuarioCreacion = userData.UsuarioNombre;
                    regalo.FechaCreacion = DateTime.Now;
                }
                else
                {
                    regalo.UsuarioModificacion = userData.UsuarioNombre;
                    regalo.FechaModificacion = DateTime.Now;
                }
            });

            return model;
        }

        [HttpGet]
        public async Task<JsonResult> ObtenerUpSellingFull()
        {
            try
            {
                var upsellings = await GetUpSellingsService(userData.CampaniaID.ToString(), true);

                if (upsellings == null || !upsellings.Any())
                    return Json(ResultModel<string>.BuildBad("no hay upsellings", string.Empty), JsonRequestBehavior.AllowGet);

                var upsellingActivo = upsellings.FirstOrDefault(x => x.Activo);

                if (upsellingActivo == null)
                    return Json(ResultModel<string>.BuildBad("no hay upselling activo", string.Empty), JsonRequestBehavior.AllowGet);

                upsellingActivo.Regalos = upsellingActivo.Regalos.Where(r => r.Activo).ToList();

                var regalos = upsellingActivo.Regalos.Any(r => r.Activo);

                if (!regalos)
                    return Json(ResultModel<string>.BuildBad("no hay regalos o no estan activos", string.Empty), JsonRequestBehavior.AllowGet);
                
                return Json(ResultModel<UpSellingModel>.BuildOk(upsellingActivo), JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { Success = false, message = "No se pudo procesar la operacion" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public async Task<ActionResult> ObtenerMontoMeta()
        {
            try
            {
                var tipoMeta = await _upSellingProvider.ObtenerMontoMeta(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
                if (tipoMeta != null)
                {
                    tipoMeta.FormatoMontoMeta = Util.DecimalToStringFormat(tipoMeta.MontoMeta, userData.CodigoISO);
                }
                return Json(new { success = true, data = tipoMeta }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false, message = "No se pudo procesar la operacion" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public async Task<ActionResult> GuardarRegalo(OfertaFinalRegaloModel model)
        {
            try
            {
                var montoPedidoFinal = Convert.ToDecimal(ObtenerPedidoWebDetalle().Sum(p => p.ImporteTotal));
                model.CampaniaId = userData.CampaniaID;
                model.ConsultoraId = userData.ConsultoraID;
                model.MontoPedidoFinal = montoPedidoFinal;

                var result = await _upSellingProvider.GuardarRegalo(userData.PaisID, model);
                return Json(new { success = true, code = result });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false, message = "No se pudo procesar la operacion" });
            }
        }

        [HttpGet]
        public async Task<JsonResult> ObtenerRegaloGanado()
        {
            try
            {
                var model = await _upSellingProvider.ObtenerRegaloGanado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
                if (model != null)
                {
                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                    model.RegaloImagenUrl = ConfigS3.GetUrlFileS3(carpetaPais, model.RegaloImagenUrl, carpetaPais);
                    model.FormatoMontoMeta = Util.DecimalToStringFormat(model.MontoMeta, userData.CodigoISO);
                }
                return Json(new { success = true, data = model }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false, message = "No se pudo procesar la operacion" }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
