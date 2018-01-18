﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarReporteValidacionController : BaseController
    {
        private const string NombreReporteValidacionOPT = "ReporteValidacionOPT";
        private const string NombreReporteValidacionODD = "ReporteValidacionODD";
        private const string NombreReporteValidacionSR = "ReporteValidacionSR";

        private const string NombreSRHoja1 = "Campaña";
        private const string NombreSRHoja2 = "Personalización de Visuales";
        private const string NombreSRHoja3 = "Ofertas (Set)";
        private const string NombreSRHoja4 = "Ofertas (Componentes del Set)";

        private const string MensajeNoHayRegistros = "No existen registros para la campaña.";

        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarReporteValidacion/Index"))
                return RedirectToAction("Index", "Bienvenida");

            string paisIso = Util.GetPaisISO(userData.PaisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisIso;
            var urlS3 = ConfigS3.GetUrlS3(carpetaPais);

            var reporteValidacionModel = new ReporteValidacionModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                ListaTipoEstrategia = DropDowListTipoEstrategia(),
                UrlS3 = urlS3
            };
            return View(reporteValidacionModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst = new List<BEPais>
            {
                new BEPais {PaisID = 0, Nombre = "Todos", NombreCorto = "Todos"}
            };

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }
        
        public JsonResult ObtenerCampanias()
        {
            int paisId = UserData().PaisID;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(paisId);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
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

        private IEnumerable<TipoEstrategiaModel> DropDowListTipoEstrategia()
        {
            List<BETipoEstrategia> lst = GetTipoEstrategias();
            List<TipoEstrategiaModel> lista = new List<TipoEstrategiaModel>();

            foreach (var item in lst)
            {
                if (item.CodigoGeneral == 4 || item.CodigoGeneral == 7)
                {
                    lista.Add(new TipoEstrategiaModel
                    {
                        TipoEstrategiaID = item.TipoEstrategiaID,
                        Descripcion = item.DescripcionEstrategia,
                        PaisID = UserData().PaisID,
                        FlagNueva = item.FlagNueva,
                        FlagRecoPerfil = item.FlagRecoPerfil,
                        FlagRecoProduc = item.FlagRecoProduc,
                        CodigoGeneral = item.CodigoGeneral,
                        CodigoPrograma = item.CodigoPrograma
                    });
                }
            }

            lista.Add(new TipoEstrategiaModel
            {
                TipoEstrategiaID = 9999,
                Descripcion = "ShowRoom",
                PaisID = UserData().PaisID,
                FlagNueva = 1,
                FlagRecoPerfil = 1,
                FlagRecoProduc = 1,
                CodigoGeneral = 99,
                CodigoPrograma = "099"
            });

            return lista;
        }

        public ActionResult ExportarExcel(string CampaniaID, string TipoEstrategiaID)
        {
            List<BEReporteValidacion> lst;
            string nombreReporte = String.Empty;

            if (int.Parse(TipoEstrategiaID) == 99)
                return ExportarExcelShowRoom(CampaniaID);
            if (int.Parse(TipoEstrategiaID) == 4)
                nombreReporte = NombreReporteValidacionOPT;
            if (int.Parse(TipoEstrategiaID) == 7)
                nombreReporte = NombreReporteValidacionODD;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetReporteValidacion(UserData().PaisID, Convert.ToInt32(CampaniaID), Convert.ToInt32(TipoEstrategiaID)).ToList();
            }

            if (lst.Count == 0)
                return Content("<script>alert('" + MensajeNoHayRegistros + "')</script>");

            foreach (var item in lst)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + item.CodPais;
                var urlS3 = ConfigS3.GetUrlS3(carpetaPais);
                item.ImagenUrl = urlS3 + item.ImagenUrl;
            }

            Util.ExportToExcel<BEReporteValidacion>(nombreReporte, lst, GetConfiguracionExcel(int.Parse(TipoEstrategiaID)));

            return null;
        }

        private ActionResult ExportarExcelShowRoom(string CampaniaID)
        {
            List<List<ReporteValidacionSRModel>> lst = new List<List<ReporteValidacionSRModel>>();
            List<Dictionary<string, string>> lstConfiguration = new List<Dictionary<string, string>>();
            List<string> nombresHojas = new List<string>();

            List<BEReporteValidacionSRCampania> lstSrCampania;
            List<BEReporteValidacionSRPersonalizacion> lstSrPersonalizacion;
            List<BEReporteValidacionSROferta> lstSrOferta;
            List<BEReporteValidacionSRComponentes> lstSrComponente;
            string nombreReporte = NombreReporteValidacionSR;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstSrCampania = sv.GetReporteShowRoomCampania(UserData().PaisID, Convert.ToInt32(CampaniaID)).ToList();
                lstSrPersonalizacion = sv.GetReporteShowRoomPersonalizacion(UserData().PaisID, Convert.ToInt32(CampaniaID)).ToList();
                lstSrOferta = sv.GetReporteShowRoomOferta(UserData().PaisID, Convert.ToInt32(CampaniaID)).ToList();
                lstSrComponente = sv.GetReporteShowRoomComponentes(UserData().PaisID, Convert.ToInt32(CampaniaID)).ToList();
            }

            if (lstSrCampania.Count == 0 && lstSrPersonalizacion.Count == 0 && lstSrOferta.Count == 0 && lstSrComponente.Count == 0)
                return Content("<script>alert('" + MensajeNoHayRegistros + "')</script>");

            List<ReporteValidacionSRModel> listSrCampaniaModel = new List<ReporteValidacionSRModel>();
            List<ReporteValidacionSRModel> lstSrPersonalizacionModel = new List<ReporteValidacionSRModel>();
            List<ReporteValidacionSRModel> lstSrOfertaModel = new List<ReporteValidacionSRModel>();
            List<ReporteValidacionSRModel> lstSrComponenteModel = new List<ReporteValidacionSRModel>();

            lstSrCampania.ForEach(x => listSrCampaniaModel.Add(new ReporteValidacionSRModel
            {
                CodPais = x.CodPais,
                Campania = x.Campania,
                CUV = x.CUV,
                NombreEvento = x.NombreEvento,
                DiasAntesFacturacion = x.DiasAntesFacturacion,
                DiasDespuesFacturacion = x.DiasDespuesFacturacion,
                FlagHabilitarEvento = x.FlagHabilitarEvento,
                FlagHabilitarCompraXCompra = x.FlagHabilitarCompraXCompra,
                FlagHabilitarSubCampania = x.FlagHabilitarSubCampania

            }));

            lstSrPersonalizacion.ForEach(x => lstSrPersonalizacionModel.Add(new ReporteValidacionSRModel
            {
                Personalizacion = x.Personalizacion,
                Medio = x.Medio,
                BO = x.BO,
                CL = x.CL,
                CO = x.CO,
                CR = x.CR,
                DO = x.DO,
                EC = x.EC,
                GT = x.GT,
                MX = x.MX,
                PA = x.PA,
                PE = x.PE,
                PR = x.PR,
                SV = x.SV,
                VE = x.VE
            }));

            lstSrOferta.ForEach(x => lstSrOfertaModel.Add(new ReporteValidacionSRModel
            {
                CodPais = x.CodPais,
                Campania = x.Campania,
                CUV = x.CUV,
                CodigoTO = x.CodigoTO,
                CodigoSAP = x.CodigoSAP,
                Descripcion = x.Descripcion,
                PrecioValorizado = x.PrecioValorizado,
                PrecioOferta = x.PrecioOferta,
                UnidadesPermitidas = x.UnidadesPermitidas,
                EsSubCampania = x.EsSubCampania,
                HabilitarOferta = x.HabilitarOferta,
                FlagImagenCargada = x.FlagImagenCargada,
                FlagImagenMINI = x.FlagImagenMINI

            }));

            lstSrComponente.ForEach(x => lstSrComponenteModel.Add(new ReporteValidacionSRModel
            {
                CodPais = x.CodPais,
                Campania = x.Campania,
                CUV = x.CUV,
                Nombre = x.Nombre,
                Descripcion1 = x.Descripcion1,
                Descripcion2 = x.Descripcion2,
                Descripcion3 = x.Descripcion3,
                FlagImagenCargada = Convert.ToInt32(x.FlagImagenCargada)
            }));

            lst.Add(listSrCampaniaModel);
            lst.Add(lstSrPersonalizacionModel);
            lst.Add(lstSrOfertaModel);
            lst.Add(lstSrComponenteModel);

            lstConfiguration.Add(GetConfiguracionExcelSRCampania());
            lstConfiguration.Add(GetConfiguracionExcelSRPersonalizacion());
            lstConfiguration.Add(GetConfiguracionExcelSROferta());
            lstConfiguration.Add(GetConfiguracionExcelSRComponentes());

            nombresHojas.Add(NombreSRHoja1);
            nombresHojas.Add(NombreSRHoja2);
            nombresHojas.Add(NombreSRHoja3);
            nombresHojas.Add(NombreSRHoja4);

            Util.ExportToExcelManySheets<ReporteValidacionSRModel>(nombreReporte, lst, lstConfiguration, nombresHojas, 30);

            return null;
        }

        private Dictionary<string, string> GetConfiguracionExcel(int tipoEstrategiaId)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"PALANCA", "TipoPersonalizacion"},
                {"CAMPAÑA", "AnioCampanaVenta"},
                {"CÓDIGO PAÍS", "CodPais"},
                {"CUV PADRE", "CUV2"}
            };
            if (tipoEstrategiaId == 4)
            {
                dic.Add("DESCRIPCIÓN DE LA OFERTA (OPT: NOMBRE OFERTA / OPT: P1 + P2 + P3)", "DescripcionCUV2");
                dic.Add("DESCRIPCIÓN VISUALIZACIÓN DE LA CONSULTORA (CORTA)", "DescripcionCorta");
            }
            if (tipoEstrategiaId == 7)
            {
                dic.Add("DESCRIPCIÓN DE LA OFERTA", "DescripcionCUV2");
                dic.Add("DESCRIPCIÓN DE LOS COMPONENTES DEL SET", "DescripcionCorta");
            }
            dic.Add("IMAGEN", "ImagenUrl");
            dic.Add("PRECIO NORMAL", "PrecioNormal");
            dic.Add("PRECIO OFERTA DIGITAL", "PrecioOfertaDigital");
            dic.Add("LÍMITE DE VENTA", "LimiteVenta");
            dic.Add("INDICADOR DE ACTIVA/INACTIVA", "Activo");
            dic.Add("CUV PRECIO TACHADO", "CUVPrecioTachado");
            dic.Add("PRECIO TACHADO", "PrecioTachado");
            return dic;

        }

        private Dictionary<string, string> GetConfiguracionExcelSRCampania()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"País", "CodPais"},
                {"Campaña", "Campania"},
                {"Nombre Evento", "NombreEvento"},
                {"Días Antes de Facturación", "DiasAntesFacturacion"},
                {"Días Después de Facturación", "DiasDespuesFacturacion"},
                {"Flag Habilitar Evento", "FlagHabilitarEvento"},
                {"Flag Habilitar Compra por Compra", "FlagHabilitarCompraXCompra"},
                {"Flag Habilitar SubCampaña", "FlagHabilitarSubCampania"}
            };
            return dic;
        }

        private Dictionary<string, string> GetConfiguracionExcelSRPersonalizacion()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Detalle Personalización", "Personalizacion"},
                {"Medio", "Medio"},
                {"Bolivia", "BO"},
                {"Chile", "CL"},
                {"Colombia", "CO"},
                {"Costa Rica", "CR"},
                {"Dominicana", "DO"},
                {"Ecuador", "EC"},
                {"Guatemala", "GT"},
                {"México", "MX"},
                {"Panamá", "PA"},
                {"Perú", "PE"},
                {"Puerto Rico", "PR"},
                {"Salvador", "SV"},
                {"Venezuela", "VE"}
            };
            return dic;
        }

        private Dictionary<string, string> GetConfiguracionExcelSROferta()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"País", "CodPais"},
                {"Campaña", "Campania"},
                {"Código TO", "CodigoTO"},
                {"SAP", "CodigoSAP"},
                {"CUV", "CUV"},
                {"Descripción", "Descripcion"},
                {"Precio Valorizado", "PrecioValorizado"},
                {"Precio Oferta", "PrecioOferta"},
                {"Unidades Permitidas", "UnidadesPermitidas"},
                {"Es Subcampaña", "EsSubCampania"},
                {"Habilitar Oferta", "HabilitarOferta"},
                {"Flag Imagen Cargada", "FlagImagenCargada"},
                {"Flag Imagen MINI", "FlagImagenMINI"}
            };
            return dic;
        }

        private Dictionary<string, string> GetConfiguracionExcelSRComponentes()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"País", "CodPais"},
                {"Campaña", "Campania"},
                {"CUV", "CUV"},
                {"Nombre", "Nombre"},
                {"Descripción1", "Descripcion1"},
                {"Descripción2", "Descripcion2"},
                {"Descripción3", "Descripcion3"},
                {"Flag Imagen Cargada", "FlagImagenCargada"}
            };
            return dic;
        }
    }
}