using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.MagickNet;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarProductoSugeridoController : BaseController
    {
        public ActionResult Index()
        {
            var model = new AdministrarProductoSugeridoModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstPais = DropDowListPaises(),
                PaisIDUser = userData.PaisID,
                ExpValidacionNemotecnico = GetConfiguracionManager(Constantes.ConfiguracionManager.ExpresionValidacionNemotecnico),
                MostrarAgotado = MostrarCheckAgotado()
            };
            return View(model);
        }

        private int MostrarCheckAgotado()
        {
            var result = 0;
            var TablaLogicaDatos = new List<BETablaLogicaDatos>();
            short codigoTablaLogica = 141;

            using (var tablaLogica = new SACServiceClient())
            {
                TablaLogicaDatos = tablaLogica.GetTablaLogicaDatos(userData.PaisID, codigoTablaLogica).ToList();
            }

            foreach (var item in TablaLogicaDatos)
            {
                if (Convert.ToInt32(item.Valor) == 1)
                {
                    result = 1;
                    break;
                }
            }

            return result;
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

            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };
            IEnumerable<BEProductoSugerido> items = lst;

            items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            BEPager pag = Util.PaginadorGenerico(grid, lst);

            lst.Update(x => x.ImagenProducto = x.ImagenProducto ?? "");

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
                                a.Estado.ToString(),
                                a.MostrarAgotado.ToString()
                            }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerMatriz(int paisID, int campaniaID, string cuv)
        {
            BEPais pais;
            int nroCampanias;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                pais = sv.SelectPais(paisID);
                nroCampanias = sv.GetPaisNumeroCampaniasByPaisID(paisID);
            }

            if (nroCampanias == -1)
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al intentar cargar las imágenes del CUV"
                }, JsonRequestBehavior.AllowGet);

            BEMatrizComercial matriz;
            List<BEMatrizComercialImagen> imagenes = null;
            using (var sv = new PedidoServiceClient())
            {
                matriz = sv.GetMatrizComercialByCampaniaAndCUV(paisID, campaniaID, cuv);
                if (matriz != null && matriz.IdMatrizComercial != 0)
                {
                    imagenes = sv.GetMatrizComercialImagenByIdMatrizImagen(paisID, matriz.IdMatrizComercial, 1, 10).ToList();
                }
            }

            MatrizComercialResultadoModel model = null;

            int totalImagenes = 0;
            if (matriz != null)
            {
                model = Mapper.Map<MatrizComercialResultadoModel>(matriz);

                if (imagenes != null)
                {
                    var data = MapImages(imagenes, paisID);

                    model.Imagenes = data;
                    totalImagenes = imagenes.Any() ? imagenes[0].TotalRegistros : 0;
                }
                else
                {
                    model.Imagenes = new List<MatrizComercialImagen>();
                }

                int nroCampaniasAtras;
                Int32.TryParse(GetConfiguracionManager(Constantes.ConfiguracionManager.ProductoSugeridoAppCatalogosNroCampaniasAtras), out nroCampaniasAtras);
                if (nroCampaniasAtras <= 0) nroCampaniasAtras = 3;

                string paisesCcc = GetPaisesConConsultoraOnlineFromConfig();
                if (paisesCcc.Contains(pais.CodigoISO)) model.FotoProductoAppCatalogo = ImagenAppCatalogo(campaniaID, model.CodigoSAP, nroCampaniasAtras);
            }
            return Json(new { success = true, matriz = model, totalImagenes = totalImagenes }, JsonRequestBehavior.AllowGet);
        }

        private List<MatrizComercialImagen> MapImages(List<BEMatrizComercialImagen> lst, int paisId)
        {
            string paisIso = Util.GetPaisISO(paisId);
            var carpetaPais = Globals.UrlMatriz + "/" + paisIso;
            var urlS3 = ConfigS3.GetUrlS3(carpetaPais);

            var data = lst.Select(p => new MatrizComercialImagen
            {
                IdMatrizComercialImagen = p.IdMatrizComercialImagen,
                FechaRegistro = p.FechaRegistro ?? default(DateTime),
                Foto = urlS3 + p.Foto,
                NemoTecnico = p.NemoTecnico,
                DescripcionComercial = p.DescripcionComercial
            }).ToList();

            return data;
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenerCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            string habilitarNemotecnico = ObtenerValorTablaLogica(PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.BusquedaNemotecnicoProductoSugerido);

            return Json(new
            {
                lista = lst,
                habilitarNemotecnico = habilitarNemotecnico == "1"
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Registrar(AdministrarProductoSugeridoModel model)
        {
            try
            {
                var entidad = Mapper.Map<AdministrarProductoSugeridoModel, BEProductoSugerido>(model);

                entidad.Estado = 1;
                entidad.UsuarioRegistro = userData.CodigoConsultora;
                entidad.UsuarioModificacion = userData.CodigoConsultora;

                #region Imagen Resize 

                if (string.IsNullOrEmpty(entidad.ImagenProducto)) return Json(new { success = false, message = "La información ingresada se encuentra incompleta. Por favor, revisar.\n- Debe de seleccionar una imagen.", extra = ""});
                
                string rutaImagen = entidad.ImagenProducto.Clone().ToString();

                var valorAppCatalogo = Constantes.ConfiguracionImagenResize.ValorTextoDefaultAppCatalogo;

                ImagenesResizeProceso(entidad.ImagenProducto, rutaImagen.ToLower().Contains(valorAppCatalogo));
                
                #endregion

                string r;
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
            try
            {
                var entidad = Mapper.Map<AdministrarProductoSugeridoModel, BEProductoSugerido>(model);

                entidad.Estado = 1;
                entidad.UsuarioModificacion = userData.CodigoConsultora;

                string r;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
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
                nro = list.Any() ? list[0] : "";
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

        private string ImagenAppCatalogo(int campaniaId, string codigoSap, int nroCampaniasAtras)
        {
            Producto[] arrayProducto;
            using (ProductoServiceClient sv = new ProductoServiceClient())
            {
                arrayProducto = sv.ObtenerProductosPorCampaniasBySap(userData.CodigoISO, campaniaId, codigoSap, nroCampaniasAtras);
            }
            if (arrayProducto == null || arrayProducto.Length == 0) return null;
            return arrayProducto[0].Imagen;
        }
        
    }
}
