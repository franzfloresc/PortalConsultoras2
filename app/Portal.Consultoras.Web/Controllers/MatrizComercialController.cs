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
                //lst.Update(x => x.ImagenProducto = (x.ImagenProducto.ToString().Equals(string.Empty) ? string.Empty : (UserData().CodigoISO + "/" + x.CodigoCampania + "/" + x.ImagenProducto)));
                //try
                //{
                //    lst.Update(x => x.ISOPais = UserData().CodigoISO.ToString());
                //}
                //catch (Exception ex) 
                //{
                //    throw;
                //}               
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
                                   // a.FotoProducto01.ToString(),
                                   // a.FotoProducto02.ToString(),
                                   // a.FotoProducto03.ToString(),
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto01.ToString(), Globals.RutaImagenesMatriz + "/" + ISO), // 1664
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto02.ToString(), Globals.RutaImagenesMatriz + "/" + ISO), // 1664
                                   ConfigS3.GetUrlFileS3(carpetaPais, a.FotoProducto03.ToString(), Globals.RutaImagenesMatriz + "/" + ISO)  // 1664                                   
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



        [HttpPost]
        public JsonResult InsertMatrizComercial(MatrizComercialModel model)
        {
            try
            {
                Mapper.CreateMap<MatrizComercialModel, BEMatrizComercial>()
                    .ForMember(t => t.CodigoSAP, f => f.MapFrom(c => c.CodigoSAP))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.DescripcionOriginal, f => f.MapFrom(c => c.DescripcionOriginal))
                    .ForMember(t => t.FotoProducto01, f => f.MapFrom(c => c.FotoProducto01))
                    .ForMember(t => t.FotoProducto02, f => f.MapFrom(c => c.FotoProducto02))
                    .ForMember(t => t.FotoProducto03, f => f.MapFrom(c => c.FotoProducto03));

                BEMatrizComercial entidad = Mapper.Map<MatrizComercialModel, BEMatrizComercial>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    string tempImage01 = model.FotoProducto01;
                    string tempImage02 = model.FotoProducto02;
                    string tempImage03 = model.FotoProducto03;

                    model.FotoProducto01 = (model.FotoProducto01 != null) ? model.FotoProducto01 : "";
                    model.FotoProducto02 = (model.FotoProducto02 != null) ? model.FotoProducto02 : "";
                    model.FotoProducto03 = (model.FotoProducto03 != null) ? model.FotoProducto03 : "";
                    string ISO = Util.GetPaisISO(model.PaisID);
                    var carpetaPais = Globals.UrlMatriz + "/" + ISO;

                    if (!model.FotoProducto01.ToString().Trim().Equals("prod_grilla_vacio.png"))
                    {
                        // 1664 - Gestion de contenido S3
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CodigoSAP + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";

                        entidad.FotoProducto01 = newfilename;
                        ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage01), carpetaPais, newfilename);
                        // entidad.FotoProducto01 = FileManager.CopyImagesMatriz(Globals.RutaImagenesMatriz + "\\" + ISO, tempImage01, Globals.RutaImagenesTempMatriz, ISO, model.CodigoSAP, "01");
                    }
                    else
                        entidad.FotoProducto01 = string.Empty;
                    if (!model.FotoProducto02.ToString().Trim().Equals("prod_grilla_vacio.png"))
                    {
                        // 1664 - Gestion de contenido S3
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CodigoSAP + "_" + time + "_" + "02" + "_" + FileManager.RandomString() + ".png";

                        entidad.FotoProducto02 = newfilename;
                        ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage02), carpetaPais, newfilename);
                        // entidad.FotoProducto02 = FileManager.CopyImagesMatriz(Globals.RutaImagenesMatriz + "\\" + ISO, tempImage02, Globals.RutaImagenesTempMatriz, ISO, model.CodigoSAP, "02");
                    }
                    else
                        entidad.FotoProducto02 = string.Empty;
                    if (!model.FotoProducto03.ToString().Trim().Equals("prod_grilla_vacio.png"))
                    {
                        // 1664 - Gestion de contenido S3
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CodigoSAP + "_" + time + "_" + "03" + "_" + FileManager.RandomString() + ".png";

                        entidad.FotoProducto03 = newfilename;
                        ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage03), carpetaPais, newfilename);
                        // entidad.FotoProducto03 = FileManager.CopyImagesMatriz(Globals.RutaImagenesMatriz + "\\" + ISO, tempImage03, Globals.RutaImagenesTempMatriz, ISO, model.CodigoSAP, "03");
                    }
                    else
                        entidad.FotoProducto03 = string.Empty;

                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioRegistro = UserData().CodigoConsultora;
                    sv.InsMatrizComercial(entidad);
                    // FileManager.DeleteImagesInFolder(Globals.RutaImagenesTempMatriz);
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

        public JsonResult ObtenerISOPais(int paisID)
        {
            string ISO = Util.GetPaisISO(paisID);

            return Json(new
            {
                ISO = ISO
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult UpdateMatrizComercial(MatrizComercialModel model)
        {
            try
            {
                Mapper.CreateMap<MatrizComercialModel, BEMatrizComercial>()
                    .ForMember(t => t.CodigoSAP, f => f.MapFrom(c => c.CodigoSAP))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.DescripcionOriginal, f => f.MapFrom(c => c.DescripcionOriginal))
                    .ForMember(t => t.FotoProducto01, f => f.MapFrom(c => c.FotoProducto01))
                    .ForMember(t => t.FotoProducto02, f => f.MapFrom(c => c.FotoProducto02))
                    .ForMember(t => t.FotoProducto03, f => f.MapFrom(c => c.FotoProducto03));

                BEMatrizComercial entidad = Mapper.Map<MatrizComercialModel, BEMatrizComercial>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    string tempImage01 = (model.FotoProducto01 != null) ? model.FotoProducto01 : "";
                    string tempImage02 = (model.FotoProducto02 != null) ? model.FotoProducto02 : "";
                    string tempImage03 = (model.FotoProducto03 != null) ? model.FotoProducto03 : "";

                    model.FotoProducto01 = (model.FotoProducto01 != null) ? model.FotoProducto01 : "";
                    model.FotoProducto02 = (model.FotoProducto02 != null) ? model.FotoProducto02 : "";
                    model.FotoProducto03 = (model.FotoProducto03 != null) ? model.FotoProducto03 : "";

                    model.FotoProductoAnterior01 = (model.FotoProductoAnterior01 != null) ? model.FotoProductoAnterior01 : "";
                    model.FotoProductoAnterior02 = (model.FotoProductoAnterior02 != null) ? model.FotoProductoAnterior02 : "";
                    model.FotoProductoAnterior03 = (model.FotoProductoAnterior03 != null) ? model.FotoProductoAnterior03 : "";

                    string ISO = Util.GetPaisISO(model.PaisID);
                    var carpetaPais = Globals.UrlMatriz + "/" + ISO;

                    if (model.FotoProducto01 != model.FotoProductoAnterior01)
                    {
                        // 1664 - Gestion de contenido S3
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CodigoSAP + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";

                        entidad.FotoProducto01 = newfilename;
                        ConfigS3.DeleteFileS3(carpetaPais, model.FotoProductoAnterior01);
                        ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage01), carpetaPais, newfilename);                        
                        /*
                        entidad.FotoProducto01 = FileManager.CopyImagesMatriz(Globals.RutaImagenesMatriz + "\\" + ISO, tempImage01, Globals.RutaImagenesTempMatriz, ISO, model.CodigoSAP, "01");
                        FileManager.DeleteImage(Globals.RutaImagenesMatriz + "\\" + ISO, model.FotoProductoAnterior01);
                        */
                    }
                    else if (model.FotoProducto01.ToString().Trim().Equals("prod_grilla_vacio.png"))
                        entidad.FotoProducto01 = string.Empty;
                    if (model.FotoProducto02 != model.FotoProductoAnterior02)
                    {
                        // 1664 - Gestion de contenido S3
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CodigoSAP + "_" + time + "_" + "02" + "_" + FileManager.RandomString() + ".png";

                        entidad.FotoProducto02 = newfilename;
                        ConfigS3.DeleteFileS3(carpetaPais, model.FotoProductoAnterior02);
                        ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage02), carpetaPais, newfilename);
                        /*
                        entidad.FotoProducto02 = FileManager.CopyImagesMatriz(Globals.RutaImagenesMatriz + "\\" + ISO, tempImage02, Globals.RutaImagenesTempMatriz, ISO, model.CodigoSAP, "02");
                        FileManager.DeleteImage(Globals.RutaImagenesMatriz + "\\" + ISO, model.FotoProductoAnterior02);
                         */
                    }
                    else if (model.FotoProducto02.ToString().Trim().Equals("prod_grilla_vacio.png"))
                        entidad.FotoProducto02 = string.Empty;
                    if (model.FotoProducto03 != model.FotoProductoAnterior03)
                    {
                        // 1664 - Gestion de contenido S3
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CodigoSAP + "_" + time + "_" + "03" + "_" + FileManager.RandomString() + ".png";

                        entidad.FotoProducto03 = newfilename;
                        ConfigS3.DeleteFileS3(carpetaPais, model.FotoProductoAnterior03);
                        ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage03), carpetaPais, newfilename);
                        /*
                        entidad.FotoProducto03 = FileManager.CopyImagesMatriz(Globals.RutaImagenesMatriz + "\\" + ISO, tempImage03, Globals.RutaImagenesTempMatriz, ISO, model.CodigoSAP, "03");
                        FileManager.DeleteImage(Globals.RutaImagenesMatriz + "\\" + ISO, model.FotoProductoAnterior03);
                         */
                    }
                    else if (model.FotoProducto03.ToString().Trim().Equals("prod_grilla_vacio.png"))
                        entidad.FotoProducto03 = string.Empty;

                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = UserData().CodigoConsultora;
                    sv.UpdMatrizComercial(entidad);
                    // FileManager.DeleteImagesInFolder(Globals.RutaImagenesTempMatriz);
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
    }
}
