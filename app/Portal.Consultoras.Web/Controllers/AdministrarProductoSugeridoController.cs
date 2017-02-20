using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarProductoSugeridoController : BaseController
    {
        // GET: /AdministrarProductoSugerido/

        public ActionResult Index()
        {
            var userData = UserData();
            var model = new AdministrarProductoSugeridoModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstPais = DropDowListPaises(),
                PaisIDUser = userData.PaisID
            };
            return View(model);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            var userData = UserData();
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (userData.RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(userData.PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int PaisID, int CampaniaID, string CUVAgotado, string CUVSugerido)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            List<BEProductoSugerido> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetPaginateProductoSugerido(PaisID, CampaniaID, CUVAgotado, CUVSugerido).ToList();
            }

            // Usamos el modelo para obtener los datos
            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
            //int buscar = int.Parse(txtBuscar);
            BEPager pag = new BEPager();
            IEnumerable<BEProductoSugerido> items = lst;

            #region Sort Section
            //if (sord == "asc")
            //{
            //    switch (sidx)
            //    {
            //        case "TipoOferta":
            //            items = lst.OrderBy(x => x.Descripcion);
            //            break;
            //        case "CodigoProducto":
            //            items = lst.OrderBy(x => x.CodigoProducto);
            //            break;
            //        case "CUV":
            //            items = lst.OrderBy(x => x.CUV);
            //            break;
            //        case "CodigoCampania":
            //            items = lst.OrderBy(x => x.CodigoCampania);
            //            break;
            //        case "Descripcion":
            //            items = lst.OrderBy(x => x.Descripcion);
            //            break;
            //        case "PrecioOferta":
            //            items = lst.OrderBy(x => x.PrecioOferta);
            //            break;
            //        case "Orden":
            //            items = lst.OrderBy(x => x.Orden);
            //            break;
            //        case "Stock":
            //            items = lst.OrderBy(x => x.Stock);
            //            break;
            //        case "UnidadesPermitidas":
            //            items = lst.OrderBy(x => x.UnidadesPermitidas);
            //            break;
            //        case "DescripcionProducto1":
            //            items = lst.OrderBy(x => x.DescripcionProducto1);
            //            break;
            //        case "DescripcionProducto2":
            //            items = lst.OrderBy(x => x.DescripcionProducto2);
            //            break;
            //        case "DescripcionProducto3":
            //            items = lst.OrderBy(x => x.DescripcionProducto3);
            //            break;
            //        case "ImagenProducto1":
            //            items = lst.OrderBy(x => x.ImagenProducto1);
            //            break;
            //        case "ImagenProducto2":
            //            items = lst.OrderBy(x => x.ImagenProducto2);
            //            break;
            //        case "ImagenProducto3":
            //            items = lst.OrderBy(x => x.ImagenProducto3);
            //            break;
            //    }
            //}
            //else
            //{
            //    switch (sidx)
            //    {
            //        case "TipoOferta":
            //            items = lst.OrderByDescending(x => x.Descripcion);
            //            break;
            //        case "CodigoProducto":
            //            items = lst.OrderByDescending(x => x.CodigoProducto);
            //            break;
            //        case "CUV":
            //            items = lst.OrderByDescending(x => x.CUV);
            //            break;
            //        case "CodigoCampania":
            //            items = lst.OrderByDescending(x => x.CodigoCampania);
            //            break;
            //        case "Descripcion":
            //            items = lst.OrderByDescending(x => x.Descripcion);
            //            break;
            //        case "PrecioOferta":
            //            items = lst.OrderByDescending(x => x.PrecioOferta);
            //            break;
            //        case "Orden":
            //            items = lst.OrderByDescending(x => x.Orden);
            //            break;
            //        case "Stock":
            //            items = lst.OrderByDescending(x => x.Stock);
            //            break;
            //        case "UnidadesPermitidas":
            //            items = lst.OrderByDescending(x => x.UnidadesPermitidas);
            //            break;
            //        case "DescripcionProducto1":
            //            items = lst.OrderBy(x => x.DescripcionProducto1);
            //            break;
            //        case "DescripcionProducto2":
            //            items = lst.OrderBy(x => x.DescripcionProducto2);
            //            break;
            //        case "DescripcionProducto3":
            //            items = lst.OrderBy(x => x.DescripcionProducto3);
            //            break;
            //        case "ImagenProducto1":
            //            items = lst.OrderBy(x => x.ImagenProducto1);
            //            break;
            //        case "ImagenProducto2":
            //            items = lst.OrderBy(x => x.ImagenProducto2);
            //            break;
            //        case "ImagenProducto3":
            //            items = lst.OrderBy(x => x.ImagenProducto3);
            //            break;
            //    }
            //}
            #endregion

            items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            pag = Util.PaginadorGenerico(grid, lst);
            string ISO = Util.GetPaisISO(PaisID);
            var carpetaPais = Globals.UrlMatriz + "/" + ISO;
            lst.Update(x => x.ImagenProducto = x.ImagenProducto ?? "");
            //lst.Update(x => x.ImagenProducto = (x.ImagenProducto.ToString().Equals(string.Empty) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + ISO)));

            // Creamos la estructura
            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           id = a.ProductoSugeridoID,
                           cell = new[]
                            {
                                a.ProductoSugeridoID.ToString(),
                                a.CampaniaID.ToString(),
                                a.CUV,
                                a.CUVSugerido,
                                a.Orden.ToString(),
                                a.ImagenProducto,
                                a.Estado.ToString()
                            }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);


        }

        public JsonResult ObtenerImagenesByCUV(int paisID, int campaniaID, string cuv)
        {
            var userData = UserData();
            BEPais pais = new BEPais();
            List<BEMatrizComercial> lst = new List<BEMatrizComercial>();

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                pais = sv.SelectPais(paisID);
            }
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCUV(paisID, campaniaID, cuv).ToList();
            }

            List<MatrizComercialResultadoModel> modelList = Mapper.Map<List<MatrizComercialResultadoModel>>(lst);
            if (modelList != null && modelList.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                if (modelList[0].FotoProducto01 != "") modelList[0].FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, modelList[0].FotoProducto01, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                if (modelList[0].FotoProducto02 != "") modelList[0].FotoProducto02 = ConfigS3.GetUrlFileS3(carpetaPais, modelList[0].FotoProducto02, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                if (modelList[0].FotoProducto03 != "") modelList[0].FotoProducto03 = ConfigS3.GetUrlFileS3(carpetaPais, modelList[0].FotoProducto03, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                modelList[0].FotoProductoAppCatalogo = ImagenAppCatalogo(campaniaID, lst[0].CodigoSAP, 3, pais.NroCampanias);
            }
            return Json(new { lista = modelList }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Registrar(AdministrarProductoSugeridoModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<AdministrarProductoSugeridoModel, BEProductoSugerido>()
                   .ForMember(t => t.ProductoSugeridoID, f => f.MapFrom(c => c.ProductoSugeridoID))
                   //.ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                   .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                   .ForMember(t => t.CUVSugerido, f => f.MapFrom(c => c.CUVSugerido))
                   .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                   .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                   .ForMember(t => t.Estado, f => f.MapFrom(c => c.Estado));

                var entidad = Mapper.Map<AdministrarProductoSugeridoModel, BEProductoSugerido>(model);

                entidad.Estado = 1;
                entidad.UsuarioRegistro = userData.CodigoConsultora;
                entidad.UsuarioModificacion = userData.CodigoConsultora;

                string r = "";
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    if (entidad.ProductoSugeridoID > 0)
                    {
                        r = sv.UpdProductoSugerido(userData.PaisID, entidad);
                    }
                    else
                    {
                        r = sv.InsProductoSugerido(userData.PaisID, entidad);
                    }
                }
                var js = Respuesta(r);
                return js;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult Deshabilitar(AdministrarProductoSugeridoModel model)
        {
            var userData = UserData();
            try
            {
                Mapper.CreateMap<AdministrarProductoSugeridoModel, BEProductoSugerido>()
                   .ForMember(t => t.ProductoSugeridoID, f => f.MapFrom(c => c.ProductoSugeridoID));

                var entidad = Mapper.Map<AdministrarProductoSugeridoModel, BEProductoSugerido>(model);

                string r = "";
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.Estado = 1;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    r = sv.DelProductoSugerido(userData.PaisID, entidad);
                }

                var js = Respuesta(r);
                return js;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        private JsonResult Respuesta(string r)
        {
            var txt = "";
            var nro = "";
            if (r != "")
            {
                var list = r.Split('|');
                nro = list.Count() > 0 ? list[0] : "";
                txt = list.Count() > 1 ? list[1] : "";

                int x;
                txt = !Int32.TryParse(nro, out x) ? nro : txt;
                txt = txt.Trim();
                var nroId = Int32.TryParse(nro, out x) ? Int32.Parse(nro) : 0;
                nro = nroId > 0 ? "" : "0";
            }
            return Json(new
            {
                success = nro == "",
                message = txt,
                extra = nro
            });

        }

        private string ImagenAppCatalogo(int campaniaID, string codigoSAP, int intentos, int nroCampanias)
        {
            int campanaAppCatalogo;
            using (ProductoServiceClient sv = new ProductoServiceClient())
            {
                for (int i = 0; i < intentos; i++)
                {
                    campanaAppCatalogo = AddCampaniaAndNumero(campaniaID, -i, nroCampanias);
                    var arrayProducto = sv.ObtenerProductosByCodigoSap(userData.CodigoISO, campanaAppCatalogo, codigoSAP);

                    if (arrayProducto == null || arrayProducto.Length == 0) continue;
                    if (!string.IsNullOrEmpty(arrayProducto[0].Imagen)) return arrayProducto[0].Imagen;
                }
            }
            return null;
        }
    }
}
