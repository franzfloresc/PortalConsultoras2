﻿using AutoMapper;
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
                if (userData.RolID == 2) lst = sv.SelectPaises().ToList();
                else lst = new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }
            return Mapper.Map<IEnumerable<PaisModel>>(lst);
        }
        public JsonResult ObtenterCampanias(int PaisID)
        {
            var listCampania = PaisID == 0 ? null : DropDowListCampanias(PaisID);            
            return Json(new { lista = listCampania }, JsonRequestBehavior.AllowGet);
        }
        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            return Mapper.Map<IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult FindByCUVs(int campaniaID, int paisID, string codigo, int rowCount)
        {
            List<ServiceODS.BEProductoDescripcion> lista;            
            int campaniaAnterior = AddCampaniaAndNumero(campaniaID, -1);
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
                    List<ServiceODS.BEProductoDescripcion> productoFaltante;

                    using (ODSServiceClient srv = new ODSServiceClient())
                    {
                        int campaniaAnterior = AddCampaniaAndNumero(model.CampaniaID, -1);
                        foreach (string cuv in productosAValidar)
                        {                            
                            productoFaltante = srv.GetProductoComercialByPaisAndCampania(campaniaAnterior, cuv, model.PaisID, 1).ToList();
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
                
                string fileextension = Path.GetExtension(uplArchivo.FileName);
                if (!fileextension.ToLower().Equals(".jpg")) return "Sólo se permiten imágenes en formato JPG.";

                string fileName = Guid.NewGuid().ToString() + fileextension;                   
                if (!Directory.Exists(Globals.RutaTemporales)) Directory.CreateDirectory(Globals.RutaTemporales);                    
                var path = Path.Combine(Globals.RutaTemporales, fileName);
                HttpPostedFileBase postedFile = Request.Files[0];
                postedFile.SaveAs(path);

                // Req. 1664 - Gestion de contenido S3
                var carpetaPais = Globals.UrlOfertasFic + "/" + userData.CodigoISO;
                ConfigS3.SetFileS3(path, carpetaPais, fileName);

                var ofertaFIC = productosValidos.Select(p => new BEOfertaFIC() { CampaniaID = model.CampaniaID, CUV = p.CUV, ImagenUrl = fileName, PaisISO = userData.CodigoISO, UsuarioRegistro = userData.CodigoUsuario, NombreImagen = uplArchivo.FileName }).ToArray();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.InsOfertaFIC(model.PaisID, ofertaFIC.ToArray());
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

                int Records = 0, TotalPages = 0;
                if (lst.Count > 0)
                {
                    TotalPages = lst[0].TotalPages;
                    Records = lst[0].RowsCount;
                }

                var data = new
                {
                    total = TotalPages,
                    page = page,
                    records = Records,
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
                return ErrorJson("Ocurrió un error al cargar los datos de la grilla");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson("Ocurrió un error al cargar los datos de la grilla");
            }
        }

        public JsonResult Eliminar(int CampaniaID, string CUV)
        {
            try
            {
                using (SACServiceClient SACsrv = new SACServiceClient())
                {
                    BEOfertaFIC producto = new BEOfertaFIC {
                        CampaniaID = CampaniaID,
                        CUV = CUV
                    };
                    SACsrv.DelOfertaFIC(userData.PaisID, producto);
                }
                return SuccessJson("Se elimino satisfactoriamente el registro");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson("Hubo un problema con el servicio, intente nuevamente");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson("Hubo un problema con el servicio, intente nuevamente");
            }
        }
    }
}