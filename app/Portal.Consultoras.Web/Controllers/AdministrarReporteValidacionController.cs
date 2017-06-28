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
            lst.Add(new BEPais { PaisID = 0, Nombre = "Todos", NombreCorto = "Todos"});

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
            var entidad = new BETipoEstrategia();
            entidad.PaisID = UserData().PaisID;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetTipoEstrategias(entidad).ToList();
            }

            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                lst.Update(x => x.ImagenEstrategia = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenEstrategia, Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO));
            }

            var lista = from a in lst
                        where a.FlagActivo == 1 && (a.CodigoGeneral == 4 || a.CodigoGeneral == 7)
                        select a;

            Mapper.CreateMap<BETipoEstrategia, TipoEstrategiaModel>()
                    .ForMember(t => t.TipoEstrategiaID, f => f.MapFrom(c => c.TipoEstrategiaID))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.DescripcionEstrategia))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.FlagNueva, f => f.MapFrom(c => c.FlagNueva))
                    .ForMember(t => t.FlagRecoPerfil, f => f.MapFrom(c => c.FlagRecoPerfil))
                    .ForMember(t => t.FlagRecoProduc, f => f.MapFrom(c => c.FlagRecoProduc))
                    .ForMember(t => t.Imagen, f => f.MapFrom(c => c.ImagenEstrategia))
                    .ForMember(t => t.CodigoPrograma, f => f.MapFrom(c => c.CodigoPrograma));

            return Mapper.Map<IList<BETipoEstrategia>, IEnumerable<TipoEstrategiaModel>>(lista.ToList());
        }

        public ActionResult ExportarExcel(string CampaniaID, string TipoEstrategiaID)
        {
            List<BEReporteValidacion> lst;
            string nombreReporte = String.Empty;

            if (int.Parse(TipoEstrategiaID) == 4)
                nombreReporte = "ReporteValidacionOPT";
            if (int.Parse(TipoEstrategiaID)==7)
                nombreReporte = "ReporteValidacionODD";

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetReporteValidacion(UserData().PaisID, Convert.ToInt32(CampaniaID), Convert.ToInt32(TipoEstrategiaID)).ToList();
            }

            
            foreach (var item in lst)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + item.CodPais;
                var urlS3 = ConfigS3.GetUrlS3(carpetaPais);
                item.ImagenUrl = urlS3 + item.ImagenUrl;
            }

            Util.ExportToExcel<BEReporteValidacion>(nombreReporte, lst, GetConfiguracionExcel(int.Parse(TipoEstrategiaID)));

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
                dic.Add("DESCRIPCIÓN DE LA OFERTA (ODD: NOMBRE OFERTA / OPT: P1 + P2 + P3)", "DescripcionCUV2");
                dic.Add("DESCRIPCIÓN VISUALIZACIÓN DE LA CONSULORA (CORTA)", "DescripcionCorta");
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

    }
    
}