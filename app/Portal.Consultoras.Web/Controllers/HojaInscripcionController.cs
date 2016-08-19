using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;
using Portal.Consultoras.Web.HojaInscripcionODS;
using Portal.Consultoras.Web.Models;
using System.Globalization;
using AutoMapper;
using Portal.Consultoras.Web.ServiceUnete;
using Newtonsoft.Json.Linq;
using System.Configuration;
using System.Text;
using System.IO;
using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using System.Web.Routing;
using CORP.BEL.Unete.Utils;
using Portal.Consultoras.Web.GestionPasos;

namespace Portal.Consultoras.Web.Controllers
{
    [AllowAnonymous]
    public class HojaInscripcionController : BaseControllerUnete
    {
        public ActionResult Index(string E)
        {
            //o	PAIS  —> String (2)
            //o	+  SISTEMA  —> String (100)
            //o	+ USUARIO —> String (100)
            //o	+ NRO_TICKET —> int   

            var e = !string.IsNullOrEmpty(E) ? new Crypto().DecryptString(E) : string.Empty;
            var parametros = e.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            var codigoISO = parametros.Length > 0 ? parametros[0] : base.ObtenerCodigoISO(); //CL

            if (!base.CodigoISOActivo(codigoISO))
            {
                return View("PaisInactivo");
            }

            var sv = new BelcorpPaisServiceClient();
            var paises = sv.ObtenerPaises(codigoISO);
            var pais = paises.FirstOrDefault(p => p.CodigoISO == codigoISO);

            sv.Close();

            ViewBag.UsuarioCreacion = parametros.Length > 0 ? parametros[2] : string.Empty;
            ViewBag.CodigoISO = codigoISO;
            ViewBag.NroTicket = parametros.Length > 0 ? parametros[3] : string.Empty;
            ViewBag.FuenteIngreso = parametros.Length > 0 && parametros[1] == "ACC" ? "ACC" : "SAC";
            ViewBag.Pais = pais.Nombre;
            ViewBag.PaisID = pais.PaisID;

            if (!string.IsNullOrWhiteSpace(E))
            {
                TempData["Token"] = E;
            }

            return View();
        }

        private void CargarCombosPaso1(string codigoISO, string month, string year)
        {
            var monthsNames = new CultureInfo("es-PE").DateTimeFormat.MonthNames;
            var _month = !string.IsNullOrEmpty(month) ? month.ToInt() : 0;
            var _year = !string.IsNullOrEmpty(year) ? year.ToInt() : 0;
            int minYear = DateTime.Now.Year - 110;

            var years = Enumerable.Range(minYear, DateTime.Now.Year - minYear + 1).OrderByDescending(x => x).Select(x => new { Value = x, Text = x }).ToList();
            var months = Enumerable.Range(1, 12).Select(x => new { Value = x, Text = monthsNames[x - 1] }).ToList();
            var days = Enumerable.Range(1, _month == 0 || _year == 0 ? 31 : DateTime.DaysInMonth(_year, _month)).Select(x => new { Value = x, Text = x }).ToList();

            ViewBag.Years = new SelectList(years, "Value", "Text");
            ViewBag.Months = new SelectList(months, "Value", "Text");
            ViewBag.Days = new SelectList(days, "Value", "Text");
        }
        public ActionResult Paso1(string codigoISO, int? paisID, string fuenteIngreso, string usuarioCreacion)
        {
            CargarCombosPaso1(codigoISO, string.Empty, string.Empty);
            return PartialView("_Paso1", new HojaInscripcionPaso1Model
            {
                CodigoISO = codigoISO,
                FuenteIngreso = fuenteIngreso,
                UsuarioCreacion = usuarioCreacion,
                PaisID = paisID.HasValue ? paisID.Value : 0,
                Token = TempData["Token"] != null ? TempData["Token"].ToString() : string.Empty
            });

            //return PartialView("_MensajePostulanteRechazada", new HojaInscripcionMensajeFinalModel
            //{
            //    NombrePostulante = "nombre completo",
            //    PrimerNombrePostulante = "aaaa",
            //    CodigoISO = "CL",
            //    NombreGZ = "GZ",
            //    CorreoGZ = "GZ@demo.com"
            //});
        }
        [HttpPost]
        public ActionResult Paso1(HojaInscripcionPaso1Model model)
        {
            if (ModelState.IsValid)
            {
                var paso1CoreVm = Mapper.Map<Paso1CoreVm>(model);

                var respuesta = ValidationFactory.ValidacionPaises[model.CodigoISO].Paso1.Validar(paso1CoreVm);
                model.TipoSolicitud = "INS";

                if (respuesta.Valid)
                {
                    if (respuesta.DetalleRespuestas[2].Data != null)
                        model.TipoSolicitud = respuesta.DetalleRespuestas[2].Data.ToString();

                    if (respuesta.DetalleRespuestas[0].Data != null)
                        model.FechaNacimiento = ((Tuple<string, int>)respuesta.DetalleRespuestas[0].Data).Item1.ToString();

                    CargarCombosPaso2(model.CodigoISO);

                    Mapper.CreateMap<HojaInscripcionPaso1Model, HojaInscripcionPaso2Model>();
                    var paso2 = Mapper.Map<HojaInscripcionPaso2Model>(model);

                    return PartialView("_Paso2", paso2);
                }

                if (!respuesta.Valid && respuesta.IndicePrimerError == 0)
                {
                    string mensajeError = ((Tuple<string, int>)respuesta.DetalleRespuestas[0].Data).Item2 ==
                                          Enumeradores.TipoMensajeEdad.MenorDeEdad.ToInt()
                        ? "Necesitas tener más de 18 años de edad para postular."
                        : "Necesitas tener menos de 80 años para postular.";

                    ModelState.AddModelError("FechaNacimiento", mensajeError);
                }

                model.SolicitudRegistrada = !respuesta.Valid && respuesta.IndicePrimerError == 1;
                model.PostulanteRegistrada = !respuesta.Valid && respuesta.IndicePrimerError == 2;
                model.ValidacionBloqueo = !respuesta.Valid && respuesta.IndicePrimerError == 3;

            }

            CargarCombosPaso1(model.CodigoISO, model.Mes, model.Anio);
            return PartialView("_Paso1", model);
        }
        [HttpPost]
        public ActionResult RegresarAPaso1(HojaInscripcionPaso1Model model)
        {
            CargarCombosPaso1(model.CodigoISO, model.Mes, model.Anio);
            return PartialView("_Paso1", model);
        }

        private void CargarCombosPaso2(string codigoISO)
        {
            using (var sv = new BelcorpPaisServiceClient())
            {
                if (codigoISO == "CL")
                {
                    var lugaresNivel1 = sv.ObtenerParametrosUnete(codigoISO, Enumeradores.TipoParametro.LugarNivel1.ToInt(), 0);
                    ViewBag.LugaresNivel1 = new SelectList(lugaresNivel1, "IdParametroUnete", "Nombre");
                }

                else if (codigoISO == "CO")
                {
                    var lugaresNivel1 = sv.ObtenerParametrosUnete(codigoISO, Enumeradores.TipoParametro.LugarNivel1CO.ToInt(), 0);
                    ViewBag.LugaresNivel1 = new SelectList(lugaresNivel1, "IdParametroUnete", "Nombre");

                    var direccionesCo = sv.ObtenerParametrosUnete(codigoISO, Enumeradores.TipoParametro.DireccionesCo.ToInt(), 0);
                    ViewBag.DireccionesCo = new SelectList(direccionesCo, "IdParametroUnete", "Nombre");
                }

                else if (codigoISO == "MX")
                {
                    var lugaresNivel1 = sv.ObtenerParametrosUnete(codigoISO, Enumeradores.TipoParametro.LugarNivel1Mx.ToInt(), 0);
                    ViewBag.LugaresNivel1 = new SelectList(lugaresNivel1, "IdParametroUnete", "Nombre");

                    var prefijosCelular = sv.ObtenerParametrosUnete(codigoISO, Enumeradores.TipoParametro.PrefijosCelular.ToInt(), 0);
                    ViewBag.PrefijosCelular = new SelectList(prefijosCelular, "IdParametroUnete", "Nombre");
                }
            }
        }

        [HttpPost]
        public ActionResult Paso2(HojaInscripcionPaso2Model model)
        {
            if (ModelState.IsValid)
            {
                // Si ha seleccionado una dirección y tiene latitud y longitud continuar
                if (model.DireccionCorrecta.HasValue || model.CodigoISO == "CO")
                {
                    CargarCombosPaso3(model.CodigoISO);

                    Mapper.CreateMap<HojaInscripcionPaso2Model, HojaInscripcionPaso3Model>();
                    var paso3 = Mapper.Map<HojaInscripcionPaso3Model>(model);

                    return PartialView("_Paso3", paso3);
                }
                else
                {
                    ViewData["Direccion"] = string.Empty;

                    var viewModel = Mapper.Map<Paso2CoreVm>(model);

                    if (viewModel.CodigoISO == "CL")
                        viewModel.Direccion = string.Format("{0} {1}", model.CalleOAvenida, model.Numero);
                    else if (viewModel.CodigoISO == "MX")
                        viewModel.Direccion = string.Format("{0} {1} {2}", model.NombreColonia,
                            model.CalleOAvenida, model.Numero);

                    viewModel.Ciudad = model.NombreRegion;
                    viewModel.Area = model.NombreComuna;

                    var respuesta = ValidationFactory.ValidacionPaises[viewModel.CodigoISO].Paso2.Validar(viewModel);
                    model.ConsultoServicioGEO = true;

                    var responseData =
                        (KeyValuePair<ZonaParameter, List<Tuple<decimal, decimal, string>>>)
                            respuesta.DetalleRespuestas[0].Data;
                    var puntos = responseData.Value;

                    if (!puntos.Any())
                        ViewData["Direccion"] = viewModel.Direccion + ", " + viewModel.Area + ", " +
                                                viewModel.Ciudad;
                    else
                        model.Puntos = puntos;

                    Session["ResultadoZona"] = responseData.Key.Zona;
                    model.ResultadoZona = responseData.Key.Zona;
                    model.ZonaPreferencial = responseData.Key.EsPreferencial;
                }
            }

            CargarCombosPaso2(model.CodigoISO);
            model.ConsultoServicioGEO = true;

            return PartialView("_Paso2", model);
        }

        [HttpPost]
        public ActionResult RegresarAPaso2(HojaInscripcionPaso2Model model)
        {
            model.DireccionCorrecta = null;
            model.Latitud = string.Empty;
            model.Longitud = string.Empty;

            CargarCombosPaso2(model.CodigoISO);
            return PartialView("_Paso2", model);
        }

        private void CargarCombosPaso3(string codigoISO)
        {
            using (var sv = new ODSServiceClient())
            {
                var tiposMetas = sv.ObtenerTiposMetas(codigoISO);
                tiposMetas.ForEach(tm => tm.CodigoMeta = tm.CodigoMeta.Trim());
                ViewBag.TiposMetas = new SelectList(tiposMetas, "CodigoMeta", "Descripcion");       
            }

            using (var sv = new BelcorpPaisServiceClient())
            {
                var estadosCiviles = sv.ObtenerTablaLogicaDatos(codigoISO, EnumsTablaLogicaID.EstadoCivil.ToInt());
                ViewBag.EstadosCiviles = new SelectList(estadosCiviles, "Codigo", "Descripcion");

                var nivelesEducativos = sv.ObtenerTablaLogicaDatos(codigoISO, EnumsTablaLogicaID.NivelEducativo.ToInt());
                ViewBag.NivelesEducativos = new SelectList(nivelesEducativos, "Codigo", "Descripcion");

                var tiposNacionalidad = sv.ObtenerTablaLogicaDatos(codigoISO, EnumsTablaLogicaID.TipoNacionalidad.ToInt());
                ViewBag.TiposNacionalidad = new SelectList(tiposNacionalidad, "Codigo", "Descripcion");

                var tiposContacto = sv.ObtenerTablaLogicaDatos(codigoISO, EnumsTablaLogicaID.TipoContacto.ToInt());
                ViewBag.TiposContacto = new SelectList(tiposContacto, "Codigo", "Descripcion");
            }
        }
        [HttpPost]
        public ActionResult Paso3(HojaInscripcionPaso3Model model)
        {
            if (ModelState.IsValid)
            {
                var solicitudPostulante = Mapper.Map<Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante>(model);
                solicitudPostulante.TipoSolicitud = model.EstadoPostulante == EnumsEstadoPostulante.YaConCodigo.ToInt() ? "AD" : "INS";

                var paso3Model = new Paso3CoreVm
                {
                    CodigoISO = model.CodigoISO,
                    CodigoConsultoraRecomienda = model.CodigoConsultoraRecomienda,
                    ConsultoraRecomienda = model.RecomendoConsultora == 'S' ? "SI" : "NO",
                    Latitud = model.Latitud,
                    Longitud = model.Longitud,
                    NumeroDocumento = model.NumeroDocumento,
                    RealizarEnvioCorreoActivacion = false,
                    IndicadorActivo = true,
                    IndicadorOptin = false,
                    TieneExperiencia = model.TieneExperiencia,
                    ResultadoZona = model.ResultadoZona,
                    UsuarioCreacion = "ADMSAC",
                    FuenteIngreso = "SAC",
                    RealizarEnvioCorreoGerenteZona = true,
                    Direccion = string.Format("{0} {1} {2}", model.NombreDireccionColombia,
                            model.DptoCasa, model.CalleOAvenida),
                    Ciudad = model.NombreComuna,
                    RutaBaseVistaHome = Server.MapPath("~/Views/Shared/")
                };

                if (model.CodigoISO == "CL")
                {
                    paso3Model.DireccionCadena = model.CalleOAvenida + "|" + model.Numero;
                }

                else if (model.CodigoISO == "CO")
                {
                    paso3Model.DireccionCadena = model.CalleOAvenida + "|" + model.NombreDireccionColombia + "|" + model.DptoCasa;
                }

                else if (model.CodigoISO == "MX")
                {
                    paso3Model.DireccionCadena = model.NombreColonia + "|" + model.CalleOAvenida + "|" + model.Numero;
                }

                var prefijoTelefono = Dictionaries.PrefijoTelefonoFijo.ContainsKey(paso3Model.CodigoISO) ? Dictionaries.PrefijoTelefonoFijo[paso3Model.CodigoISO] : string.Empty;
                paso3Model.Telefono = !string.IsNullOrEmpty(prefijoTelefono) && paso3Model.CodigoISO == "MX" ? prefijoTelefono.Replace("+", "").Trim() + model.Telefono : model.Telefono;
                paso3Model.Celular = !string.IsNullOrEmpty(model.NombrePrefijoCelular) && paso3Model.CodigoISO == "MX" ? model.NombrePrefijoCelular + model.Celular : model.Celular;

                var respuesta = ValidationFactory.ValidacionPaises[model.CodigoISO].Paso3.Ejecutar(paso3Model,
                    solicitudPostulante);

                var nombreCompleto = string.Format("{0} {1}", solicitudPostulante.PrimerNombre, solicitudPostulante.ApellidoPaterno);

                if (solicitudPostulante.EstadoPostulante == Enumeradores.EstadoPostulante.EnAprobacionFFVV.ToInt())
                {
                    var zonaActual = (HojaInscripcionODS.ZonaBE)respuesta.DetalleRespuestas[7].Data; //Zona retornada por la clase ObtenerEnvioCorreoGerenteZonaEjecucion
                    return PartialView("_MensajePostulanteApta", new HojaInscripcionMensajeFinalModel
                    {
                        NombrePostulante = nombreCompleto,
                        PrimerNombrePostulante = model.PrimerNombre,
                        CodigoISO = model.CodigoISO,
                        NombreGZ = zonaActual.GerenteZona,
                        CorreoGZ = zonaActual.GZEmail,
                        Token = model.Token
                    });
                }

                if (solicitudPostulante.EstadoPostulante == Enumeradores.EstadoPostulante.EnGestionServicioAlCliente.ToInt())
                {
                    return PartialView("_MensajePostulantePendiente", new HojaInscripcionMensajeFinalModel
                    {
                        NombrePostulante = nombreCompleto,
                        PrimerNombrePostulante = model.PrimerNombre,
                        Token = model.Token
                    });
                }

                if (solicitudPostulante.EstadoBurocrediticio == Enumeradores.EstadoBurocrediticio.NoPuedeSerConsultora.ToInt())
                {
                    return PartialView("_MensajePostulanteRechazada", new HojaInscripcionMensajeFinalModel
                    {
                        NombrePostulante = nombreCompleto,
                        PrimerNombrePostulante = model.PrimerNombre,
                        Token = model.Token
                    });
                }

                return PartialView("_MensajePostulantePendiente", new HojaInscripcionMensajeFinalModel
                {
                    NombrePostulante = nombreCompleto,
                    PrimerNombrePostulante = model.PrimerNombre,
                    Token = model.Token
                });
            }

            CargarCombosPaso3(model.CodigoISO);
            return PartialView("_Paso3", model);
        }
        public JsonResult ObtenerLugaresSegundoNivel(int id, string codigoISO)
        {
            var sv = new BelcorpPaisServiceClient();

            var lugaresSegundoNivel = sv.ObtenerParametrosUnete(codigoISO, EnumsTipoParametro.LugarNivel2.ToInt(), id);
            var lugares = lugaresSegundoNivel.Select(l => new { Value = l.IdParametroUnete, Text = l.Nombre }).ToList();

            sv.Close();

            return Json(lugares, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ObtenerNombreConsultora(string codigoISO, string codigoConsultora)
        {
            var codigo = codigoConsultora;
            var consultora = default(HojaInscripcionBelcorpPais.ConsultoraBE);

            if (codigoISO == "CO")
            {
                codigo = codigo.PadLeft(10, '0');
                using (var sv = new BelcorpPaisServiceClient())
                {
                    consultora = sv.ObtenerConsultoraPorDocumento(codigoISO, codigoConsultora);
                }
            }
            else
            {
                codigo = codigo.PadLeft(7, '0');

                using (var sv = new BelcorpPaisServiceClient())
                {
                    consultora = sv.ObtenerConsultoraPorCodigo(codigoISO, codigo);
                }
            }

            return Json(consultora != null ? consultora.NombreCompleto : string.Empty, JsonRequestBehavior.AllowGet);
        }
        public string RenderViewAsString(string viewName, object model)
        {
            // Create a string writer to receive the HTML code
            StringWriter stringWriter = new StringWriter();

            // Get the view to render
            ViewEngineResult viewResult = ViewEngines.Engines.FindView(ControllerContext, viewName, null);

            // Create a context to render a view based on a model
            ViewContext viewContext = new ViewContext(
                        ControllerContext,
                        viewResult.View,
                        new ViewDataDictionary(model),
                        new TempDataDictionary(),
                        stringWriter
                    );

            // Render the view to a HTML code
            viewResult.View.Render(viewContext, stringWriter);

            // return the HTML code
            return stringWriter.ToString();
        }

        public JsonResult ObtenerLugaresTercerNivel(int id, string codigoISO)
        {
            var sv = new BelcorpPaisServiceClient();

            var tipoparametro = Enumeradores.TipoParametro.ColoniaMx.ToInt();

            var lugaresTercerNivel = sv.ObtenerParametrosUnete(codigoISO, tipoparametro, id);
            var lugares = lugaresTercerNivel.Select(l => new { Value = l.IdParametroUnete, Text = l.Nombre }).ToList();
            lugares.OrderBy(x => x.Text).ToList();
            sv.Close();

            return Json(lugares, JsonRequestBehavior.AllowGet);
        }
    }
}

