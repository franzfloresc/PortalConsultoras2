﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
        private const string MensajeExitoso = "Se ha descargado satisfactoriamente.";

        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarReporteValidacion/Index"))
                return RedirectToAction("Index", "Bienvenida");

            string paisISO = Util.GetPaisISO(userData.PaisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisISO;
            var urlS3 = ConfigS3.GetUrlS3(carpetaPais);

            var ReporteValidacionModel = new ReporteValidacionModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                ListaTipoEstrategia = DropDowListTipoEstrategia(),
                UrlS3 = urlS3
            };
            return View(ReporteValidacionModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst = new List<BEPais>();
            lst.Add(new BEPais { PaisID = 0, Nombre = "Todos", NombreCorto = "Todos" });

            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<EtiquetaModel> DropDowListEtiqueta()
        {
            IList<BEEtiqueta> lst;
            var entidad = new BEEtiqueta();
            entidad.PaisID = UserData().PaisID;
            entidad.Estado = -1;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetEtiquetas(entidad);
            }
            Mapper.CreateMap<BEEtiqueta, EtiquetaModel>()
                    .ForMember(t => t.EtiquetaID, f => f.MapFrom(c => c.EtiquetaID))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            return Mapper.Map<IList<BEEtiqueta>, IEnumerable<EtiquetaModel>>(lst);
        }

        public JsonResult ObtenerCampanias()
        {
            int PaisID = UserData().PaisID;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                    .ForMember(t => t.Anio, f => f.MapFrom(c => c.Anio))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Activo, f => f.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<TipoEstrategiaModel> DropDowListTipoEstrategia()
        {
            List<BETipoEstrategia> lst;
            List<TipoEstrategiaModel> lista = new List<TipoEstrategiaModel>();
            var entidad = new BETipoEstrategia();
            entidad.PaisID = UserData().PaisID;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetTipoEstrategias(entidad).ToList();

            }

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

            List<BEReporteValidacionSRCampania> lstSRCampania = new List<BEReporteValidacionSRCampania>();
            List<BEReporteValidacionSRPersonalizacion> lstSRPersonalizacion = new List<BEReporteValidacionSRPersonalizacion>();
            List<BEReporteValidacionSROferta> lstSROferta = new List<BEReporteValidacionSROferta>();
            List<BEReporteValidacionSRComponentes> lstSRComponente = new List<BEReporteValidacionSRComponentes>();
            string nombreReporte = NombreReporteValidacionSR;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstSRCampania = sv.GetReporteShowRoomCampania(UserData().PaisID, Convert.ToInt32(CampaniaID)).ToList();
                lstSRPersonalizacion = sv.GetReporteShowRoomPersonalizacion(UserData().PaisID, Convert.ToInt32(CampaniaID)).ToList();
                lstSROferta = sv.GetReporteShowRoomOferta(UserData().PaisID, Convert.ToInt32(CampaniaID)).ToList();
                lstSRComponente = sv.GetReporteShowRoomComponentes(UserData().PaisID, Convert.ToInt32(CampaniaID)).ToList();
            }

            if (lstSRCampania.Count == 0 && lstSRPersonalizacion.Count == 0 && lstSROferta.Count == 0 && lstSRComponente.Count == 0)
                return Content("<script>alert('" + MensajeNoHayRegistros + "')</script>");

            List<ReporteValidacionSRModel> listSRCampaniaModel = new List<ReporteValidacionSRModel>();
            List<ReporteValidacionSRModel> lstSRPersonalizacionModel = new List<ReporteValidacionSRModel>();
            List<ReporteValidacionSRModel> lstSROfertaModel = new List<ReporteValidacionSRModel>();
            List<ReporteValidacionSRModel> lstSRComponenteModel = new List<ReporteValidacionSRModel>();

            lstSRCampania.ForEach(x => listSRCampaniaModel.Add(new ReporteValidacionSRModel
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

            lstSRPersonalizacion.ForEach(x => lstSRPersonalizacionModel.Add(new ReporteValidacionSRModel
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

            lstSROferta.ForEach(x => lstSROfertaModel.Add(new ReporteValidacionSRModel
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

            lstSRComponente.ForEach(x => lstSRComponenteModel.Add(new ReporteValidacionSRModel
            {
                CodPais = x.CodPais,
                Campania = x.Campania,
                CUV = x.CUV,
                Nombre = x.Nombre,
                Descripcion1 = x.Descripcion1,
                Descripcion2 = x.Descripcion2,
                Descripcion3 = x.Descripcion3

            }));

            lst.Add(listSRCampaniaModel);
            lst.Add(lstSRPersonalizacionModel);
            lst.Add(lstSROfertaModel);
            lst.Add(lstSRComponenteModel);

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

        private Dictionary<string, string> GetConfiguracionExcel(int tipoEstrategiaID)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("PALANCA", "TipoPersonalizacion");
            dic.Add("CAMPAÑA", "AnioCampanaVenta");
            dic.Add("CÓDIGO PAÍS", "CodPais");
            dic.Add("CUV PADRE", "CUV2");
            if (tipoEstrategiaID == 4)
            {
                dic.Add("DESCRIPCIÓN DE LA OFERTA (OPT: NOMBRE OFERTA / OPT: P1 + P2 + P3)", "DescripcionCUV2");
                dic.Add("DESCRIPCIÓN VISUALIZACIÓN DE LA CONSULTORA (CORTA)", "DescripcionCorta");
            }
            if (tipoEstrategiaID == 7)
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
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("País", "CodPais");
            dic.Add("Campaña", "Campania");
            dic.Add("Nombre Evento", "NombreEvento");
            dic.Add("Días Antes de Facturación", "DiasAntesFacturacion");
            dic.Add("Días Después de Facturación", "DiasDespuesFacturacion");
            dic.Add("Flag Habilitar Evento", "FlagHabilitarEvento");
            dic.Add("Flag Habilitar Compra por Compra", "FlagHabilitarCompraXCompra");
            dic.Add("Flag Habilitar SubCampaña", "FlagHabilitarSubCampania");
            return dic;
        }

        private Dictionary<string, string> GetConfiguracionExcelSRPersonalizacion()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Detalle Personalización", "Personalizacion");
            dic.Add("Medio", "Medio");
            dic.Add("Bolivia", "BO");
            dic.Add("Chile", "CL");
            dic.Add("Colombia", "CO");
            dic.Add("Costa Rica", "CR");
            dic.Add("Dominicana", "DO");
            dic.Add("Ecuador", "EC");
            dic.Add("Guatemala", "GT");
            dic.Add("México", "MX");
            dic.Add("Panamá", "PA");
            dic.Add("Perú", "PE");
            dic.Add("Puerto Rico", "PR");
            dic.Add("Salvador", "SV");
            dic.Add("Venezuela", "VE");
            return dic;
        }

        private Dictionary<string, string> GetConfiguracionExcelSROferta()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("País", "CodPais");
            dic.Add("Campaña", "Campania");
            dic.Add("Código TO", "CodigoTO");
            dic.Add("SAP", "CodigoSAP");
            dic.Add("CUV", "CUV");
            dic.Add("Descripción", "Descripcion");
            dic.Add("Precio Valorizado", "PrecioValorizado");
            dic.Add("Precio Oferta", "PrecioOferta");
            dic.Add("Unidades Permitidas", "UnidadesPermitidas");
            dic.Add("Es Subcampaña", "EsSubCampania");
            dic.Add("Habilitar Oferta", "HabilitarOferta");
            dic.Add("Flag Imagen Cargada", "FlagImagenCargada");
            dic.Add("Flag Imagen MINI", "FlagImagenMINI");
            return dic;
        }

        private Dictionary<string, string> GetConfiguracionExcelSRComponentes()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("País", "CodPais");
            dic.Add("Campaña", "Campania");
            dic.Add("CUV", "CUV");
            dic.Add("Nombre", "Nombre");
            dic.Add("Descripción1", "Descripcion1");
            dic.Add("Descripción2", "Descripcion2");
            dic.Add("Descripción3", "Descripcion3");
            dic.Add("Flag Imagen Cargada", "FlagImagenCargada");
            return dic;
        }
    }
}