using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers.Estrategias
{
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
                EsPaisEsika = Settings.Instance.PaisesEsika.Contains(userData.CodigoISO),
                UrlS3 = ConfigS3.GetUrlS3(Globals.UrlMatriz + "/" + userData.CodigoISO)
            };

            return View(model);
        }

        [HttpGet]
        public async Task<JsonResult> Obtener(string codigoCampana)
        {
            if (string.IsNullOrEmpty(codigoCampana))
                codigoCampana = null;

            var upsellings = await _upSellingProvider.ObtenerAsync(userData.PaisID, codigoCampana);

            upsellings.Update(upSelling => SetFullUrlImage(upSelling.Regalos));

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
            model = SetAuditInfo(model);
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            foreach (var regalo in model.Regalos)
            {
                if (regalo.Imagen.StartsWith("http"))
                    continue;

                if (FileExistsInS3(carpetaPais, regalo.Imagen))
                    continue;

                var upLoaded = ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, regalo.Imagen), carpetaPais, regalo.Imagen);
                if (!upLoaded)
                    return Json(ResultModel<bool>.BuildBad("Sucedio un error al guardar las imagenes", false));
            };


            UpSellingModel result;
            if (model.UpSellingId > 0)
                result = await _upSellingProvider.Actualizar(userData.PaisID, model);
            else
                result = await _upSellingProvider.Guardar(userData.PaisID, model);

            return Json(ResultModel<UpSellingModel>.BuildOk(result), JsonRequestBehavior.AllowGet);
        }

        private UpSellingModel SetAuditInfo(UpSellingModel model)
        {
            model.UsuarioCreacion = userData.UsuarioNombre;
            model.FechaCreacion = DateTime.Now;
            if (model.UpSellingId > 0)
            {
                model.UsuarioModicacion = userData.UsuarioNombre;
                model.FechaModificacion = DateTime.Now;
            }

            if (model.Regalos == null)
                return model;

            model.Regalos.ForEach(regalo =>
            {
                regalo.UsuarioCreacion = userData.UsuarioNombre;
                regalo.FechaCreacion = DateTime.Now;
                if (regalo.UpSellingRegaloId > 0)
                {
                    regalo.UsuarioModicacion = userData.UsuarioNombre;
                    regalo.FechaModificacion = DateTime.Now;
                }
            });

            return model;
        }

        [HttpPost]
        public async Task<ActionResult> Eliminar(int upSellingId)
        {
            await _upSellingProvider.Eliminar(userData.PaisID, upSellingId);

            return Json(ResultModel<bool>.BuildOk(true));
        }

        [HttpPost]
        public async Task<ActionResult> Actualizar(UpSellingModel model)
        {
            model = SetAuditInfo(model);
            var result = await _upSellingProvider.Actualizar(userData.PaisID, model, true);

            return Json(ResultModel<UpSellingModel>.BuildOk(result), JsonRequestBehavior.AllowGet);
        }

        public bool FileExistsInS3(string carpetaPais, string fileName)
        {
            var url = ConfigS3.GetUrlFileS3(carpetaPais, fileName);

            HttpWebResponse response = null;
            var request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "HEAD";

            try
            {
                response = (HttpWebResponse)request.GetResponse();
            }
            catch (WebException ex)
            {
                /* A WebException will be thrown if the status of the response is not `200 OK` */
                return false;
            }
            finally
            {
                if (response != null)
                {
                    response.Close();
                }
            }

            return response.StatusCode == HttpStatusCode.OK;
        }

        private void SetFullUrlImage(IEnumerable<UpSellingRegaloModel> model)
        {
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            model.Update(regalo =>
            {
                regalo.Imagen = ConfigS3.GetUrlFileS3(carpetaPais, regalo.Imagen, carpetaPais);
            });
        }
    }
}
