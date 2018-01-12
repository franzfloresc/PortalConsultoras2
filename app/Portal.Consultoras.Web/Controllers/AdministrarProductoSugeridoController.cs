using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.MagickNet;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
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
                ExpValidacionNemotecnico = GetConfiguracionManager(Constantes.ConfiguracionManager.ExpresionValidacionNemotecnico)
            };
            return View(model);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2 
                    ? sv.SelectPaises().ToList() 
                    : new List<BEPais> {sv.SelectPais(userData.PaisID)};
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
                                a.Estado.ToString()
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

                List<EntidadMagickResize> listaImagenesResize;

                string rutaImagen = entidad.ImagenProducto.Clone().ToString();
                var valorAppCatalogo = Constantes.ConfiguracionImagenResize.ValorTextoDefaultAppCatalogo;
                if (rutaImagen.ToLower().Contains(valorAppCatalogo))
                {
                    listaImagenesResize = ObtenerListaImagenesResizeAppCatalogo(entidad.ImagenProducto);
                }
                else
                {                    
                    listaImagenesResize = ObtenerListaImagenesResize(entidad.ImagenProducto);                    
                }

                if (listaImagenesResize != null && listaImagenesResize.Count > 0)
                    MagickNetLibrary.GuardarImagenesResize(listaImagenesResize);

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

        #region Imagenes Resize App Catalogo

        public List<EntidadMagickResize> ObtenerListaImagenesResizeAppCatalogo(string rutaImagen)
        {
            var listaImagenesResize = new List<EntidadMagickResize>();

            if (Util.ExisteUrlRemota(rutaImagen))
            {
                string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);
                string soloExtension = Path.GetExtension(rutaImagen);

                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                var extensionNombreImagenSmall = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall;
                var rutaImagenSmall = ConfigS3.GetUrlFileS3(carpetaPais, soloImagen + extensionNombreImagenSmall + soloExtension);

                var extensionNombreImagenMedium = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium;
                var rutaImagenMedium = ConfigS3.GetUrlFileS3(carpetaPais, soloImagen + extensionNombreImagenMedium + soloExtension);

                var listaValoresImagenesResize = ObtenerParametrosTablaLogica(Constantes.PaisID.Peru, Constantes.TablaLogica.ValoresImagenesResize, true);

                EntidadMagickResize entidadResize;
                if (!Util.ExisteUrlRemota(rutaImagenSmall))
                {
                    entidadResize = new EntidadMagickResize
                    {
                        RutaImagenOriginal = rutaImagen,
                        RutaImagenResize = rutaImagenSmall,
                        Width = ObtenerTablaLogicaDimensionImagen(listaValoresImagenesResize,
                            Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhSmall),
                        Height = ObtenerTablaLogicaDimensionImagen(listaValoresImagenesResize,
                            Constantes.TablaLogicaDato.ValoresImagenesResizeHeightSmall),
                        TipoImagen = Constantes.ConfiguracionImagenResize.TipoImagenSmall,
                        CodigoIso = userData.CodigoISO
                    };
                    listaImagenesResize.Add(entidadResize);
                }

                if (!Util.ExisteUrlRemota(rutaImagenMedium))
                {
                    entidadResize = new EntidadMagickResize
                    {
                        RutaImagenOriginal = rutaImagen,
                        RutaImagenResize = rutaImagenMedium,
                        Width = ObtenerTablaLogicaDimensionImagen(listaValoresImagenesResize,
                            Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhMedium),
                        Height = ObtenerTablaLogicaDimensionImagen(listaValoresImagenesResize,
                            Constantes.TablaLogicaDato.ValoresImagenesResizeHeightMedium),
                        TipoImagen = Constantes.ConfiguracionImagenResize.TipoImagenMedium,
                        CodigoIso = userData.CodigoISO
                    };
                    listaImagenesResize.Add(entidadResize);
                }
            }

            return listaImagenesResize;
        }

        #endregion

        

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

        #region CargaMasivaImagenes

        public JsonResult CargaMasivaImagenes(int campaniaId)
        {
            try
            {
                List<BECargaMasivaImagenes> lista;

                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    lista = ps.GetListaImagenesProductoSugeridoByCampania(userData.PaisID, campaniaId).ToList();
                }
                //listaEstrategias = listaEstrategias.Take(5).ToList();
                var cuvNoGenerados = "";
                var cuvNoExistentes = "";

                foreach (var item in lista)
                {                    
                    var mensajeError = "";

                    List<EntidadMagickResize> listaImagenesResize;

                    string rutaImagen = item.RutaImagen.Clone().ToString();
                    var valorAppCatalogo = Constantes.ConfiguracionImagenResize.ValorTextoDefaultAppCatalogo;
                    if (rutaImagen.ToLower().Contains(valorAppCatalogo))
                    {
                        listaImagenesResize = ObtenerListaImagenesResizeAppCatalogo(item.RutaImagen);
                    }
                    else
                    {
                        listaImagenesResize = ObtenerListaImagenesResize(item.RutaImagen);
                    }

                    if (listaImagenesResize != null && listaImagenesResize.Count > 0)
                        mensajeError = MagickNetLibrary.GuardarImagenesResize(listaImagenesResize);                    
                    else
                        cuvNoExistentes += item.Cuv + ",";

                    if (mensajeError != "")
                        cuvNoGenerados += item.Cuv + ",";
                }

                var mensaje = "Se generaron las imagenes SMALL y MEDIUM de todas las imagenes.";
                if (cuvNoGenerados != "")
                {
                    mensaje += " Excepto los siguientes Cuvs: " + cuvNoGenerados;
                }
                if (cuvNoExistentes != "")
                {
                    mensaje += " Excepto los siguientes Cuvs (imagen orignal no encontrada o ya existen): " + cuvNoExistentes;
                }

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion
    }
}
