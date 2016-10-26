using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using System.ServiceModel;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServicePedido;
using AutoMapper;
using Portal.Consultoras.Common;
using System.IO;

namespace Portal.Consultoras.Web.Controllers
{
    public class MatrizComercialController : BaseController
    {
        public ActionResult AdministrarMatrizComercial()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MatrizComercial/AdministrarMatrizComercial"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var model = new MatrizComercialModel()
            {
                lstPais = DropDowListPaises()
            };
            return View(model);
        }

        public ActionResult ConsultarMatrizComercial(string sidx, string sord, int page, int rows, int paisID, string codigoSAP)
        {
            if (ModelState.IsValid)
            {
                List<BEMatrizComercial> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetMatrizComercialByCodigoSAP(paisID, codigoSAP).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEMatrizComercial> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoSAP":
                            items = lst.OrderBy(x => x.CodigoSAP);
                            break;
                        case "DescripcionOriginal":
                            items = lst.OrderBy(x => x.DescripcionOriginal);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoSAP":
                            items = lst.OrderBy(x => x.CodigoSAP);
                            break;
                        case "DescripcionOriginal":
                            items = lst.OrderBy(x => x.DescripcionOriginal);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);           
                // Creamos la estructura
                string ISO = Util.GetPaisISO(paisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO; // 1664

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    ISOPais = ISO.ToString().Trim(),
                    rows = from a in items
                           select new
                           {
                               id = a.CodigoSAP,
                               cell = new string[] 
                               {
                                   a.IdMatrizComercial.ToString(),
                                   a.CodigoSAP.ToString(),
                                   a.DescripcionOriginal.ToString(),
                                   a.Descripcion.ToString(),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto01.ToString(), Globals.RutaImagenesMatriz + "/" + ISO), // 1664
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto02.ToString(), Globals.RutaImagenesMatriz + "/" + ISO), // 1664
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto03.ToString(), Globals.RutaImagenesMatriz + "/" + ISO), // 1664
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto04.ToString(), Globals.RutaImagenesMatriz + "/" + ISO),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto05.ToString(), Globals.RutaImagenesMatriz + "/" + ISO),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto06.ToString(), Globals.RutaImagenesMatriz + "/" + ISO),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto07.ToString(), Globals.RutaImagenesMatriz + "/" + ISO),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto08.ToString(), Globals.RutaImagenesMatriz + "/" + ISO),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto09.ToString(), Globals.RutaImagenesMatriz + "/" + ISO),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto10.ToString(), Globals.RutaImagenesMatriz + "/" + ISO)
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private string UploadFoto(string foto, string number, string preFileName, string carpetaPais)
        {
            foto = foto ?? "";
            if (!foto.Trim().Equals("prod_grilla_vacio.png"))
            {
                string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                var newfilename = preFileName + time + "_" + number + "_" + FileManager.RandomString() + ".png";
                ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, foto), carpetaPais, newfilename);
                return newfilename;
            }
            return string.Empty;
        }

        private string ReplaceFoto(string foto, string fotoAnterior, string number, string preFileName, string carpetaPais)
        {
            foto = foto ?? "";
            fotoAnterior = fotoAnterior ?? "";

            if (foto != fotoAnterior)
            {
                string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                string newfilename = preFileName + time + "_" + number + "_" + FileManager.RandomString() + ".png";
                ConfigS3.DeleteFileS3(carpetaPais, fotoAnterior);
                ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, foto), carpetaPais, newfilename);
                return newfilename;
            }
            else if (!foto.Trim().Equals("prod_grilla_vacio.png")) return foto;
            return string.Empty;
        }

        [HttpPost]
        public JsonResult InsertMatrizComercial(MatrizComercialModel model)
        {
            try
            {
                BEMatrizComercial entidad = Mapper.Map<MatrizComercialModel, BEMatrizComercial>(model);
                entidad.UsuarioRegistro = userData.CodigoConsultora;

                string paisISO = Util.GetPaisISO(model.PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + paisISO;
                string preFileName = paisISO + "_" + model.CodigoSAP + "_";

                entidad.FotoProducto01 = this.UploadFoto(model.FotoProducto01, "01", preFileName, carpetaPais);
                entidad.FotoProducto02 = this.UploadFoto(model.FotoProducto02, "02", preFileName, carpetaPais);
                entidad.FotoProducto03 = this.UploadFoto(model.FotoProducto03, "03", preFileName, carpetaPais);
                entidad.FotoProducto04 = this.UploadFoto(model.FotoProducto04, "04", preFileName, carpetaPais);
                entidad.FotoProducto05 = this.UploadFoto(model.FotoProducto05, "05", preFileName, carpetaPais);
                entidad.FotoProducto06 = this.UploadFoto(model.FotoProducto06, "06", preFileName, carpetaPais);
                entidad.FotoProducto07 = this.UploadFoto(model.FotoProducto07, "07", preFileName, carpetaPais);
                entidad.FotoProducto08 = this.UploadFoto(model.FotoProducto08, "08", preFileName, carpetaPais);
                entidad.FotoProducto09 = this.UploadFoto(model.FotoProducto09, "09", preFileName, carpetaPais);
                entidad.FotoProducto10 = this.UploadFoto(model.FotoProducto10, "10", preFileName, carpetaPais);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsMatrizComercial(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Matriz de Productos satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult UpdateMatrizComercial(MatrizComercialModel model)
        {
            try
            {
                BEMatrizComercial entidad = Mapper.Map<MatrizComercialModel, BEMatrizComercial>(model);
                entidad.UsuarioModificacion = userData.CodigoConsultora;

                string paisISO = Util.GetPaisISO(model.PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + paisISO;
                string preFileName = paisISO + "_" + model.CodigoSAP + "_";

                entidad.FotoProducto01 = this.ReplaceFoto(model.FotoProducto01, model.FotoProductoAnterior01, "01", preFileName, carpetaPais);
                entidad.FotoProducto02 = this.ReplaceFoto(model.FotoProducto02, model.FotoProductoAnterior02, "02", preFileName, carpetaPais);
                entidad.FotoProducto03 = this.ReplaceFoto(model.FotoProducto03, model.FotoProductoAnterior03, "03", preFileName, carpetaPais);
                entidad.FotoProducto04 = this.ReplaceFoto(model.FotoProducto04, model.FotoProductoAnterior04, "04", preFileName, carpetaPais);
                entidad.FotoProducto05 = this.ReplaceFoto(model.FotoProducto05, model.FotoProductoAnterior05, "05", preFileName, carpetaPais);
                entidad.FotoProducto06 = this.ReplaceFoto(model.FotoProducto06, model.FotoProductoAnterior06, "06", preFileName, carpetaPais);
                entidad.FotoProducto07 = this.ReplaceFoto(model.FotoProducto07, model.FotoProductoAnterior07, "07", preFileName, carpetaPais);
                entidad.FotoProducto08 = this.ReplaceFoto(model.FotoProducto08, model.FotoProductoAnterior08, "08", preFileName, carpetaPais);
                entidad.FotoProducto09 = this.ReplaceFoto(model.FotoProducto09, model.FotoProductoAnterior09, "09", preFileName, carpetaPais);
                entidad.FotoProducto10 = this.ReplaceFoto(model.FotoProducto10, model.FotoProductoAnterior10, "10", preFileName, carpetaPais);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.UpdMatrizComercial(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Matriz de Productos satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public string UpdDescripcionProductoMasivo(HttpPostedFileBase flDescProd)
        {
            string message = string.Empty;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV
                string finalPath = string.Empty;
                List<BEMatrizComercial> lstmatriz = new List<BEMatrizComercial>();

                if (flDescProd != null)
                {
                    string fileName = Path.GetFileName(flDescProd.FileName);
                    string extension = Path.GetExtension(flDescProd.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    finalPath = Path.Combine(pathFile, newfileName);
                    flDescProd.SaveAs(finalPath);

                    string inputLine = "";

                    string[] values = null;

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                if (IsNumeric(values[0].ToString().Trim()))
                                {
                                    BEMatrizComercial ent = new BEMatrizComercial();
                                    ent.CodigoSAP = values[0].ToString().Trim();
                                    ent.Descripcion = values[1].ToString().Trim();
                                    if (!string.IsNullOrEmpty(ent.CodigoSAP))
                                        lstmatriz.Add(ent);
                                }
                            }
                        }
                    }
                    if (lstmatriz.Count > 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            int paisID = Util.GetPaisID(UserData().CodigoISO);
                            if (paisID > 0)
                            {
                                try
                                {
                                    registros += sv.UpdMatrizComercialDescripcionMasivo(paisID, lstmatriz.ToArray(), UserData().CodigoConsultora);
                                }
                                catch (FaultException ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                                }
                            }
                        }
                    }
                }
                #endregion

                if (registros > 0)
                {
                    message = "Se realizó la actualización de " + registros + " producto(s)";
                }
                else
                {
                    message = "No se actualizó ninguna descripción de los productos que estaban dentro del archivo (CSV), verifique que el código sea correcto.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Se actualizaron solo las descripciones de " + registros + " producto(s).";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Se actualizaron solo las descripciones de " + registros + " producto(s).";
            }
            return message;
        }

        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;

            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        public JsonResult ObtenerISOPais(int paisID)
        {
            string ISO = Util.GetPaisISO(paisID);

            return Json(new
            {
                ISO = ISO
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
