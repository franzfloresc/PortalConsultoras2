using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class RVDigitalController : BaseController
    {
        public ActionResult Index()
        {
            bool errorServicio;
            string errorCode;
            string errorMessage;

            if (UserData().PaisID == 4)
            {
                ContenidoServiceClient sv = new ContenidoServiceClient();
                ViewBag.PaisID = UserData().PaisID;
                ViewBag.InvitacionPaquete = Convert.ToInt32(sv.ValidarInvitacionPaqueteDocumentario(UserData().PaisID, UserData().CodigoConsultora));
            }

            var oRVDigitalModel = new RVDigitalModel()
            {
                listaCampania = GetCampaniasRVDigital(out errorServicio, out errorCode, out errorMessage)
            };
            if (errorServicio)
            {
                ViewBag.ErrorDescripcion = "Ocurrió un error al intentar obtener la información. Por favor, vuelva a intentar dentro de unos minutos.";
            }
            else
            {
                if (errorCode == string.Empty || errorCode == "00000")
                    ViewBag.ErrorDescripcion = string.Empty;
                else
                    ViewBag.ErrorDescripcion = errorMessage;
            }
            return View(oRVDigitalModel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string Campania)
        {
            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };
            bool errorServicio;
            string errorCode;
            string errorMessage;
            List<RVPRFModel> lst = new List<RVPRFModel>();
            if (!string.IsNullOrEmpty(Campania))
                lst = GetPDFRVDigital(Campania, out errorServicio, out errorCode, out errorMessage);
            IEnumerable<RVPRFModel> items = lst;

            #region Sort Section
            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "Nombre":
                        items = lst.OrderBy(x => x.Nombre);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "Nombre":
                        items = lst.OrderByDescending(x => x.Nombre);
                        break;
                }
            }
            #endregion

            items = string.IsNullOrEmpty(Campania)
                ? items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize) 
                : items.Where(p => p.Nombre.ToUpper().Contains(Campania.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            BEPager pag = Paginador(grid, Campania, lst);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           id = a.Nombre,
                           cell = new string[]
                               {
                                   "Paquete Documentario",
                                   Campania,
                                   DevolverFecha(a.Nombre),
                                   a.Ruta
                                }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public List<CampaniaModel> GetCampaniasRVDigital(out bool errorServicio, out string errorCode, out string errorMessage)
        {
            UsuarioModel usuario = UserData();
            string marca;
            string nombrePais = DevolverNombrePais(usuario.CodigoISO, out marca);
            var complain = new RVDCampaniasParam { pais = nombrePais, tipo = "Paq Doc Consultora", docIdentidad = "", consultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : usuario.CodigoConsultora), marca = marca };
            List<CampaniaModel> lstCampaniaModel = new List<CampaniaModel>();
            errorServicio = false;
            errorCode = string.Empty;
            errorMessage = string.Empty;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string output = serializer.Serialize(complain);

                string strUri = GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_Campanias);
                Uri uri = new Uri(strUri);
                WebRequest request = WebRequest.Create(uri);
                request.Method = "POST";
                request.ContentType = "application/json; charset=utf-8";

                using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
                {
                    writer.Write(output);
                }

                WebResponse responce = request.GetResponse();
                Stream reader = responce.GetResponseStream();
                if (reader != null)
                {
                    StreamReader sReader = new StreamReader(reader);
                    string outResult = sReader.ReadToEnd();
                    sReader.Close();

                    JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();

                    WrapperCampanias st = jsonSerializer.Deserialize<WrapperCampanias>(outResult);
                    if (st != null && st.LIS_CampanaResult != null)
                    {
                        if (st.LIS_CampanaResult.lista != null)
                        {
                            if (st.LIS_CampanaResult.lista.Count != 0)
                            {
                                foreach (var item in st.LIS_CampanaResult.lista)
                                {
                                    lstCampaniaModel.Add(new CampaniaModel() { CampaniaID = Convert.ToInt32(item), Codigo = item });
                                }
                            }
                            else
                            {
                                errorCode = st.LIS_CampanaResult.errorCode;
                                errorMessage = st.LIS_CampanaResult.errorMessage;
                            }
                        }
                        else
                        {
                            errorCode = st.LIS_CampanaResult.errorCode;
                            errorMessage = st.LIS_CampanaResult.errorMessage;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                errorServicio = true;
            }

            return lstCampaniaModel;
        }

        public string DevolverNombrePais(string iso, out string marca)
        {
            string result = string.Empty;
            marca = string.Empty;

            switch (iso)
            {
                case "AR":
                    result = "ARGENTINA";
                    marca = "L'Bel";
                    break;
                case "BO":
                    result = "BOLIVIA";
                    marca = "Esika";
                    break;
                case "CL":
                    result = "CHILE";
                    marca = "Esika";
                    break;
                case "CO":
                    result = "COLOMBIA";
                    marca = "L'Bel";
                    break;
                case "CR":
                    result = "COSTA RICA";
                    marca = "L'Bel";
                    break;
                case "DO":
                    result = "DOMINICANA";
                    marca = "L'Bel";
                    break;
                case "EC":
                    result = "ECUADOR";
                    marca = "L'Bel";
                    break;
                case "SV":
                    result = "EL SALVADOR";
                    marca = "Esika";
                    break;
                case "GT":
                    result = "GUATEMALA";
                    marca = "Esika";
                    break;
                case "MX":
                    result = "MEXICO";
                    marca = "L'Bel";
                    break;
                case "PA":
                    result = "PANAMA";
                    marca = "L'Bel";
                    break;
                case "PE":
                    result = "PERU";
                    marca = "Esika";
                    break;
                case "PR":
                    result = "PUERTO RICO";
                    marca = "L'Bel";
                    break;
                case "VE":
                    result = "VENEZUELA";
                    marca = "L'Bel";
                    break;
            }
            return result;
        }


        public List<RVPRFModel> GetPDFRVDigital(string campania, out bool errorServicio, out string errorCode, out string errorMessage)
        {
            UsuarioModel usuario = UserData();
            string marca;
            string nombrePais = DevolverNombrePais(usuario.CodigoISO, out marca);
            var complain = new RVDPDFParam { pais = nombrePais, tipo = "Paq Doc Consultora", docIdentidad = "", consultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : usuario.CodigoConsultora), marca = marca, Campana = campania };
            List<RVPRFModel> lstRVPRFModel = new List<RVPRFModel>();
            errorServicio = false;
            errorCode = string.Empty;
            errorMessage = string.Empty;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string output = serializer.Serialize(complain);

                string strUri = GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_PDF);
                Uri uri = new Uri(strUri);
                WebRequest request = WebRequest.Create(uri);
                request.Method = "POST";
                request.ContentType = "application/json; charset=utf-8";

                using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
                {
                    writer.Write(output);
                }

                WebResponse responce = request.GetResponse();
                Stream reader = responce.GetResponseStream();
                if (reader != null)
                {
                    StreamReader sReader = new StreamReader(reader);
                    string outResult = sReader.ReadToEnd();
                    sReader.Close();

                    JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();

                    WrapperPDF st = jsonSerializer.Deserialize<WrapperPDF>(outResult);
                    if (st != null && st.SEL_PDFxCampanaResult != null)
                    {
                        if (st.SEL_PDFxCampanaResult.lista != null)
                        {
                            if (st.SEL_PDFxCampanaResult.lista.Count != 0)
                            {
                                foreach (var item in st.SEL_PDFxCampanaResult.lista)
                                {
                                    lstRVPRFModel.Add(new RVPRFModel() { Nombre = item, Ruta = item });
                                }
                            }
                            else
                            {
                                errorCode = st.SEL_PDFxCampanaResult.errorCode;
                                errorMessage = st.SEL_PDFxCampanaResult.errorMessage;
                            }
                        }
                        else
                        {
                            errorCode = st.SEL_PDFxCampanaResult.errorCode;
                            errorMessage = st.SEL_PDFxCampanaResult.errorMessage;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                errorServicio = true;
            }

            return lstRVPRFModel;
        }

        public BEPager Paginador(BEGrid item, string vBusqueda, List<RVPRFModel> lst)
        {
            BEPager pag = new BEPager();

            var recordCount = string.IsNullOrEmpty(vBusqueda)
                ? lst.Count 
                : lst.Count(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        public string DevolverNombre(string url)
        {
            string[] cadenas = url.Split('/');
            string nombre = string.Empty;

            if (cadenas.Length > 0)
            {
                nombre = cadenas[cadenas.Length - 2] + "_" + cadenas[cadenas.Length - 1];
            }

            return nombre.Replace(".pdf", "");
        }

        public string DevolverFecha(string url)
        {
            string[] cadenas = url.Split('/');
            string fecha = string.Empty;

            if (cadenas.Length > 0)
            {
                string[] rutas = cadenas[cadenas.Length - 2].Split('_');
                if (rutas.Length > 0)
                {
                    string temp = rutas[1].Substring(6, 8);
                    fecha = string.Format("{0}/{1}/{2}", temp.Substring(6, 2), temp.Substring(4, 2), temp.Substring(0, 4));
                }
            }

            return fecha;
        }

        [HttpPost]
        public JsonResult AceptarPaqueteDocumentarioWeb()
        {
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    var result = sv.ActualizarEstadoPaqueteDocumentario(UserData().PaisID, UserData().CodigoConsultora, UserData().CampaniaID);
                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar el estado. Inténtelo mas tarde.",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = true,
                            message = ""
                        });
                    }
                }
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
        public JsonResult EnviarTxt(int paisID)
        {
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    var file = sv.GetPaqueteDocumentario(paisID);
                    if (file == null)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar el estado. Inténtelo mas tarde.",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = true,
                            message = ""
                        });
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult PaqueteDocumentario()
        {
            RVDigitalPaqueteDocumentarioModel model = new RVDigitalPaqueteDocumentarioModel
            {
                PaisID = UserData().PaisID,
                listaPaises = DropDowListPaises()
            };

            return View(model);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            IList<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList().FindAll(x => x.PaisID == UserData().PaisID);
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

    }
}
