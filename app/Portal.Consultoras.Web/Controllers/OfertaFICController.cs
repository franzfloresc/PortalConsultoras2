using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertaFICController : BaseController
    {
        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaFIC/Index"))
                return RedirectToAction("Index", "Bienvenida");

            var oCuvBeneficioModel = new OfertaFICModel()
            {
                listaPaises = DropDowListPaises(),
                listaCampanias = new List<CampaniaModel>()
            };
            return View(oCuvBeneficioModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }
            return Mapper.Map<IEnumerable<PaisModel>>(lst);
        }

        public JsonResult ObtenterCampanias(int PaisID)
        {
            var listCampania = PaisID == 0 ? null : DropDowListCampanias(PaisID);
            return Json(new { lista = listCampania }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }
            return Mapper.Map<IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult FindByCUVs(int campaniaID, int paisID, string codigo, int rowCount)
        {
            List<ServiceODS.BEProductoDescripcion> lista;

            using (ODSServiceClient srv = new ODSServiceClient())
            {
                lista = srv.GetProductoComercialByPaisAndCampania(campaniaID, codigo, paisID, rowCount).ToList();
            }
            var lstModel = Mapper.Map<IEnumerable<GestionFaltantesModel>>(lista);

            return Json(lstModel, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public string Insertar(HttpPostedFileBase uplArchivo, OfertaFICModel model)
        {
            List<string> codigos = model.CUV.Split(',').ToList();

            try
            {
                string[] productosAValidar = codigos[0].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                productosAValidar = productosAValidar.Select(p => p.Trim()).ToArray<string>();

                List<ServiceODS.BEProductoDescripcion> productosValidos = new List<ServiceODS.BEProductoDescripcion>();

                string message = string.Empty;
                if (productosAValidar.Length != 0)
                {
                    List<string> productosNoValidos = new List<string>();

                    using (ODSServiceClient srv = new ODSServiceClient())
                    {
                        int campaniaAnterior = Util.AddCampaniaAndNumero(model.CampaniaID, -1, userData.NroCampanias);
                        foreach (string cuv in productosAValidar)
                        {
                            List<ServiceODS.BEProductoDescripcion> productoFaltante = srv.GetProductoComercialByPaisAndCampania(campaniaAnterior, cuv, model.PaisID, 1).ToList();
                            if (productoFaltante.Count == 0 || productoFaltante[0].CUV != cuv)
                            {
                                productosNoValidos.Add(cuv);
                            }
                            else productosValidos.Add(productoFaltante[0]);
                        }
                    }

                    if (productosNoValidos.Count != 0)
                    {
                        message = "El código de venta no es válido: " + string.Join(",", productosNoValidos.Select(z => z));
                    }
                }
                if (message != string.Empty) return message;

                if (uplArchivo == null) return "El archivo especificado no existe.";

                string fileextension = Path.GetExtension(uplArchivo.FileName) ?? "";
                if (!fileextension.ToLower().Equals(".jpg")) return "Sólo se permiten imágenes en formato JPG.";

                string fileName = Guid.NewGuid().ToString() + fileextension;
                if (!Directory.Exists(Globals.RutaTemporales)) Directory.CreateDirectory(Globals.RutaTemporales);
                var path = Path.Combine(Globals.RutaTemporales, fileName);
                HttpPostedFileBase postedFile = Request.Files[0];
                if (postedFile != null) postedFile.SaveAs(path);

                var carpetaPais = Globals.UrlOfertasFic + "/" + userData.CodigoISO;
                ConfigS3.SetFileS3(path, carpetaPais, fileName);

                var ofertaFic = productosValidos.Select(p => new BEOfertaFIC() { CampaniaID = model.CampaniaID, CUV = p.CUV, ImagenUrl = fileName, PaisISO = userData.CodigoISO, UsuarioRegistro = userData.CodigoUsuario, NombreImagen = uplArchivo.FileName }).ToArray();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.InsOfertaFIC(model.PaisID, ofertaFic.ToArray());
                }
                return "El registro ha sido ingresado satisfactoriamente.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "Hubo un problema con el servicio, intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "Hubo un problema con el servicio, intente nuevamente.";
            }
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int paisID, int campaniaID)
        {
            try
            {
                if (!ModelState.IsValid) return RedirectToAction("Index", "Bienvenida");

                List<BEOfertaFIC> lst;
                using (SACServiceClient srv = new SACServiceClient())
                {
                    BEOfertaFIC producto = new BEOfertaFIC { CampaniaID = campaniaID };
                    lst = srv.GetProductoOfertaFIC(paisID, producto, sidx, sord, page, 1, rows).ToList();
                }

                int records = 0, totalPages = 0;
                if (lst.Count > 0)
                {
                    totalPages = lst[0].TotalPages;
                    records = lst[0].RowsCount;
                }

                var data = new
                {
                    total = totalPages,
                    page = page,
                    records = records,
                    rows = from a in lst
                           select new
                           {
                               cell = new string[]
                               {
                                    a.CampaniaID.ToString(),
                                    a.CUV,
                                    a.Descripcion,
                                    a.NombreImagen
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson("Ocurrió un error al cargar los datos de la grilla", true);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson("Ocurrió un error al cargar los datos de la grilla", true);
            }
        }

        public JsonResult Eliminar(int CampaniaID, string CUV)
        {
            try
            {
                BEOfertaFIC producto = new BEOfertaFIC
                {
                    CampaniaID = CampaniaID,
                    CUV = CUV
                };

                using (SACServiceClient sacSrv = new SACServiceClient())
                {
                    sacSrv.DelOfertaFIC(userData.PaisID, producto);
                }
                return SuccessJson("Se elimino satisfactoriamente el registro");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson("Hubo un problema con el servicio, intente nuevamente", true);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson("Hubo un problema con el servicio, intente nuevamente", true);
            }
        }
    }
}