using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
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
            bool ErrorServicio;
            string ErrorCode;
            string ErrorMessage;

            if (UserData().PaisID == 4)
            {
                ContenidoServiceClient sv = new ContenidoServiceClient();
                ViewBag.PaisID = UserData().PaisID;
                ViewBag.InvitacionPaquete = Convert.ToInt32(sv.ValidarInvitacionPaqueteDocumentario(UserData().PaisID, UserData().CodigoConsultora));
            }

            var oRVDigitalModel = new RVDigitalModel()
            {
                listaCampania = GetCampaniasRVDigital(out ErrorServicio, out ErrorCode, out ErrorMessage)
            };
            if (ErrorServicio)
            {
                ViewBag.ErrorDescripcion = "Ocurrió un error al intentar obtener la información. Por favor, vuelva a intentar dentro de unos minutos.";
            }
            else
            {
                if (ErrorCode == string.Empty || ErrorCode == "00000")
                    ViewBag.ErrorDescripcion = string.Empty;
                else
                    ViewBag.ErrorDescripcion = ErrorMessage;
            }
            return View(oRVDigitalModel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string Campania)
        {
            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
            bool ErrorServicio;
            string ErrorCode;
            string ErrorMessage;
            List<RVPRFModel> lst = new List<RVPRFModel>();
            if (!string.IsNullOrEmpty(Campania))
                lst = GetPDFRVDigital(Campania, out ErrorServicio, out ErrorCode, out ErrorMessage);
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

            if (string.IsNullOrEmpty(Campania))
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
            else
                items = items.Where(p => p.Nombre.ToUpper().Contains(Campania.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

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

        public List<CampaniaModel> GetCampaniasRVDigital(out bool ErrorServicio, out string ErrorCode, out string ErrorMessage)
        {
            UsuarioModel usuario = UserData();
            string Marca;
            string NombrePais = DevolverNombrePais(usuario.CodigoISO, out Marca);
            var complain = new RVDCampaniasParam { pais = NombrePais, tipo = "Paq Doc Consultora", docIdentidad = "", consultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : usuario.CodigoConsultora), marca = Marca };
            List<CampaniaModel> lstCampaniaModel = new List<CampaniaModel>();
            ErrorServicio = false;
            ErrorCode = string.Empty;
            ErrorMessage = string.Empty;
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
                StreamReader sReader = new StreamReader(reader);
                string outResult = sReader.ReadToEnd();
                sReader.Close();

                JavaScriptSerializer json_serializer = new JavaScriptSerializer();

                WrapperCampanias st = json_serializer.Deserialize<WrapperCampanias>(outResult);
                if (st != null)
                {
                    if (st.LIS_CampanaResult != null)
                    {
                        if (st.LIS_CampanaResult.lista != null)
                        {
                            if (st.LIS_CampanaResult.lista.Count != 0)
                            {
                                foreach (var item in st.LIS_CampanaResult.lista)
                                {
                                    lstCampaniaModel.Add(new CampaniaModel() { CampaniaID = Convert.ToInt32(item.campana), Codigo = item.campana });
                                }
                            }
                            else
                            {
                                ErrorCode = st.LIS_CampanaResult.errorCode;
                                ErrorMessage = st.LIS_CampanaResult.errorMessage;
                            }
                        }
                        else
                        {
                            ErrorCode = st.LIS_CampanaResult.errorCode;
                            ErrorMessage = st.LIS_CampanaResult.errorMessage;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ErrorServicio = true;
            }

            return lstCampaniaModel;
        }

        public string DevolverNombrePais(string ISO, out string Marca)
        {
            string result = string.Empty;
            Marca = string.Empty;

            switch (ISO)
            {
                case "AR":
                    result = "ARGENTINA";
                    Marca = "L'Bel";
                    break;
                case "BO":
                    result = "BOLIVIA";
                    Marca = "Esika";
                    break;
                case "CL":
                    result = "CHILE";
                    Marca = "Esika";
                    break;
                case "CO":
                    result = "COLOMBIA";
                    Marca = "L'Bel";
                    break;
                case "CR":
                    result = "COSTA RICA";
                    Marca = "L'Bel";
                    break;
                case "DO":
                    result = "DOMINICANA";
                    Marca = "L'Bel";
                    break;
                case "EC":
                    result = "ECUADOR";
                    Marca = "L'Bel";
                    break;
                case "SV":
                    result = "EL SALVADOR";
                    Marca = "Esika";
                    break;
                case "GT":
                    result = "GUATEMALA";
                    Marca = "Esika";
                    break;
                case "MX":
                    result = "MEXICO";
                    Marca = "L'Bel";
                    break;
                case "PA":
                    result = "PANAMA";
                    Marca = "L'Bel";
                    break;
                case "PE":
                    result = "PERU";
                    Marca = "Esika";
                    break;
                case "PR":
                    result = "PUERTO RICO";
                    Marca = "L'Bel";
                    break;
                case "VE":
                    result = "VENEZUELA";
                    Marca = "L'Bel";
                    break;
            }
            return result;
        }


        public List<RVPRFModel> GetPDFRVDigital(string Campania, out bool ErrorServicio, out string ErrorCode, out string ErrorMessage)
        {
            UsuarioModel usuario = UserData();
            string Marca;
            string NombrePais = DevolverNombrePais(usuario.CodigoISO, out Marca);
            var complain = new RVDPDFParam { pais = NombrePais, tipo = "Paq Doc Consultora", docIdentidad = "", consultora = ((usuario.UsuarioPrueba == 1) ? usuario.ConsultoraAsociada : usuario.CodigoConsultora), marca = Marca, Campana = Campania };
            List<RVPRFModel> lstRVPRFModel = new List<RVPRFModel>();
            ErrorServicio = false;
            ErrorCode = string.Empty;
            ErrorMessage = string.Empty;
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
                StreamReader sReader = new StreamReader(reader);
                string outResult = sReader.ReadToEnd();
                sReader.Close();

                JavaScriptSerializer json_serializer = new JavaScriptSerializer();

                WrapperPDF st = json_serializer.Deserialize<WrapperPDF>(outResult);
                if (st != null)
                {
                    if (st.SEL_PDFxCampanaResult != null)
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
                                ErrorCode = st.SEL_PDFxCampanaResult.errorCode;
                                ErrorMessage = st.SEL_PDFxCampanaResult.errorMessage;
                            }
                        }
                        else
                        {
                            ErrorCode = st.SEL_PDFxCampanaResult.errorCode;
                            ErrorMessage = st.SEL_PDFxCampanaResult.errorMessage;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ErrorServicio = true;
            }

            return lstRVPRFModel;
        }

        public BEPager Paginador(BEGrid item, string vBusqueda, List<RVPRFModel> lst)
        {
            BEPager pag = new BEPager();

            int RecordCount;

            if (string.IsNullOrEmpty(vBusqueda))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Count(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

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
                int result;
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    result = sv.ActualizarEstadoPaqueteDocumentario(UserData().PaisID, UserData().CodigoConsultora, UserData().CampaniaID);
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
                string[] file;
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    file = sv.GetPaqueteDocumentario(paisID);
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
            RVDigitalPaqueteDocumentarioModel model = new RVDigitalPaqueteDocumentarioModel();
            model.PaisID = UserData().PaisID;
            model.listaPaises = DropDowListPaises();

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
