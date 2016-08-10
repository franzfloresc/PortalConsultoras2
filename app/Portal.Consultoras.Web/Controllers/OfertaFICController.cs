using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System.Threading.Tasks;
using Portal.Consultoras.Web.ServiceODS;
using System.ServiceModel;
using System.IO;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertaFICController : BaseController
    {
        /// <resumen>
        /// CREADO POR      : Shumaha Smith Asencios Pezo
        /// Solicitud   : 1402
        /// FECHA CREACION  : 13/02/2013
        /// DESCRIPCIÓN     :Oferta FIC
        /// </resumen>

        public async Task<ActionResult> Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaFIC/Index"))
                return RedirectToAction("Index", "Bienvenida");


            await Task.Run(() => LoadConsultorasCache(11));
            var listaCampanias = DropDowListCampanias(11);

            var oCuvBeneficioModel = new OfertaFICModel()
            {
                listaCampanias = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                listaRegiones = new List<RegionModel>(),
                listaZonas = new List<ZonaModel>()
            };
            return View(oCuvBeneficioModel);
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
        public void LoadConsultorasCache(int PaisID)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                sv.LoadConsultoraCodigo(PaisID);
            }
        }
        public JsonResult ObtenterCampanias(int PaisID)
        {
            IEnumerable<CampaniaModel> lst;

            if (PaisID == 0)
            {
                lst = null;

                return Json(new
                {
                    lista = lst
                }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                lst = DropDowListCampanias(PaisID);

                return Json(new
                {
                    lista = lst
                }, JsonRequestBehavior.AllowGet);
            }

        }
        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            //PaisID = 11;
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult FindByCUVs(int campaniaID, int paisID, string codigo, int rowCount)
        {
            Mapper.CreateMap<ServiceODS.BEProductoDescripcion, GestionFaltantesModel>()
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            List<ServiceODS.BEProductoDescripcion> lista;



            Int32 nroCampanias = UserData().NroCampanias;
            if (Convert.ToInt32(Convert.ToString(campaniaID).Substring(4, 2)) == 1)
            {
                campaniaID = Convert.ToInt32(Convert.ToString(Convert.ToInt32(Convert.ToString(campaniaID).Substring(0, 4))-1)+ Convert.ToString(nroCampanias));
            }
            else
            {
                campaniaID = campaniaID - 1;
            }
            


            using (ODSServiceClient srv = new ODSServiceClient())
            {
                lista = srv.GetProductoComercialByPaisAndCampania(campaniaID, codigo, paisID, rowCount).ToList();
            }

            var lstModel = Mapper.Map<IList<ServiceODS.BEProductoDescripcion>, IEnumerable<GestionFaltantesModel>>(lista);

            return Json(lstModel, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public string Insertar(HttpPostedFileBase uplArchivo, OfertaFICModel model)
        {

            int paisID;
            int campaniaID;
            List<string> codigos;

            paisID = model.PaisID;
            campaniaID = model.CampaniaID;
            codigos = model.CUV.Split(',').ToList();
            string message = string.Empty;

            try
            {
                string paisISO = UserData().CodigoISO;
                string CodigoUsuario = UserData().CodigoUsuario;
                List<BEOfertaFIC> ofertaFIC = new List<BEOfertaFIC>();

                string[] productosAValidar = codigos[0].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                productosAValidar = productosAValidar.Select(p => p.Trim()).ToArray<string>();

                List<ServiceODS.BEProductoDescripcion> productosValidos = new List<ServiceODS.BEProductoDescripcion>();

                //Productos a validar
                if (productosAValidar.Length != 0)
                {
                    List<string> productosNoValidos = new List<string>();
                    List<ServiceODS.BEProductoDescripcion> productoFaltante;

                    using (ODSServiceClient srv = new ODSServiceClient())
                    {
                        Int32 nroCampanias = UserData().NroCampanias;
                        Int32 codiCampania;
                        if (Convert.ToInt32(Convert.ToString(campaniaID).Substring(4, 2)) == 1)
                        {
                            codiCampania = Convert.ToInt32(Convert.ToString(Convert.ToInt32(Convert.ToString(campaniaID).Substring(0, 4)) - 1) + Convert.ToString(nroCampanias));
                        }
                        else
                        {
                            codiCampania = campaniaID - 1;
                        }

                        foreach (string cuv in productosAValidar)
                        {                            
                            productoFaltante = srv.GetProductoComercialByPaisAndCampania(codiCampania, cuv, paisID, 1).ToList();

                            if (productoFaltante.Count == 0 || productoFaltante[0].CUV != cuv)
                            {
                                productosNoValidos.Add(cuv);
                            }
                            else
                            {
                                productosValidos.Add(productoFaltante[0]);
                            }
                        }
                    }

                    if (productosNoValidos.Count != 0)
                    {

                        message = (message != string.Empty ? message + "\r\n" : "") +
                                                  "El códigos de venta no es válido: " +
                                                  string.Join(",", productosNoValidos.Select(z => z));
                    }
                }

                if (message != string.Empty)
                {
                    return message;
                }
                else
                {
                    if (uplArchivo == null)
                    {
                        return message = "El archivo especificado no existe.";
                    }
                    string finalPath = string.Empty, httpPath = string.Empty;
                    string fileextension = Path.GetExtension(uplArchivo.FileName);

                    if (!fileextension.ToLower().Equals(".jpg"))
                    {
                        return message = "Sólo se permiten imágenes en formato JPG.";
                    }

                    string fileName = Guid.NewGuid().ToString() + fileextension;
                   
                    if (!Directory.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    
                    HttpPostedFileBase postedFile = Request.Files[0];

                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    postedFile.SaveAs(path);

                    // Req. 1664 - Gestion de contenido S3
                    var carpetaPais = Globals.UrlOfertasFic + "/" + UserData().CodigoISO;
                    ConfigS3.SetFileS3(path, carpetaPais, fileName);

                    foreach (ServiceODS.BEProductoDescripcion producto in productosValidos)
                    {
                        // ofertaFIC.Add(new BEOfertaFIC() { CampaniaID = campaniaID, CUV = producto.CUV, ImagenUrl = httpPath, PaisISO = paisISO, UsuarioRegistro = CodigoUsuario, NombreImagen = uplArchivo.FileName });
                        ofertaFIC.Add(new BEOfertaFIC() { CampaniaID = campaniaID, CUV = producto.CUV, ImagenUrl = fileName, PaisISO = paisISO, UsuarioRegistro = CodigoUsuario, NombreImagen = uplArchivo.FileName });
                    }

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        sv.InsOfertaFIC(paisID, ofertaFIC.ToArray());
                    }


                    return message = "El registro ha sido ingresado satisfactoriamente.";
                }


                return message;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return message = "Hubo un problema con el servicio, intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return message = "Hubo un problema con el servicio, intente nuevamente.";
            }

        }


        public ActionResult Consultar(string sidx, string sord, int page, int rows, int paisID, int campaniaID)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    List<BEOfertaFIC> lst;
                    using (SACServiceClient srv = new SACServiceClient())
                    {
                        BEOfertaFIC producto = new BEOfertaFIC()
                        {
                            CampaniaID = campaniaID
                        };

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
                return RedirectToAction("Index", "Bienvenida");
            }
            catch (System.ServiceModel.FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al cargar los datos de la grilla",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al cargar los datos de la grilla",
                    extra = ""
                });
            }
        }

        public JsonResult Eliminar(int CampaniaID, string CUV)
        {
            try
            {
                bool rslt = false;
                using (SACServiceClient SACsrv = new SACServiceClient())
                {
                    BEOfertaFIC producto = new BEOfertaFIC()
                    {
                        CampaniaID = CampaniaID,
                        CUV = CUV
                    };

                    rslt = SACsrv.DelOfertaFIC(UserData().PaisID, producto);
                }
                return Json(new
                {
                    success = true,
                    message = "Se elimino satisfactoriamente el registro",
                    extra = ""
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }    
    

    }
}
