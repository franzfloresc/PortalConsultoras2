using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.AdministracionPoput;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using Portal.Consultoras.Service;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministracionPopupsController : BaseAdmController
    {
        public ActionResult Index()
        {
            //if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarGuiaNegocioDigitalizada/Index"))
            //    return RedirectToAction("Index", "Bienvenida");
            return View(CargaInicial());
        }



        #region Consultas
        private ComunicadoModel CargaInicial()
        {
            var ComunicadoModel = new ComunicadoModel()
            {
                listaCampania = ObtenerCampaniasPorPaisPoput(Convert.ToInt32(userData.PaisID))
            };
            return ComunicadoModel;
        }

        public JsonResult GetCargaListadoPoput(int Estado, string Campania)
        {
            List<ComunicadoModel> listaComunicadoModel;

            try
            {
                using (ContenidoServiceClient sv= new ContenidoServiceClient())
            {
                var listContenidoService = sv.GetListaPoput(Estado, Campania).ToList();
                    listaComunicadoModel = GetAutoMapperManual(listContenidoService);
                    //Mapper.Map<List<ServiceContenido.BEComunicado>, List<ComunicadoModel>>(listContenidoService);
                }

        }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaComunicadoModel = new List<ComunicadoModel>();
            }
             
              return Json(listaComunicadoModel, JsonRequestBehavior.AllowGet);
    }

        private List<ComunicadoModel> GetAutoMapperManual(List<ServiceContenido.BEComunicado> listContenidoService)
        {
            List<ComunicadoModel> listComunicadoModel = new List<ComunicadoModel>();

            foreach (var item in listContenidoService)
            {
                listComunicadoModel.Add(
                    new ComunicadoModel() {
                        Numero=item.Numero,
                        UrlImagen=GetImagen(item.UrlImagen),
                        FechaInicio_=item.FechaInicio,
                        FechaFin_=item.FechaFin,
                        Titulo=item.Titulo,
                        DescripcionAccion=item.DescripcionAccion,
                        Activo=item.Activo
                    }
                    );

            }
            return listComunicadoModel;
        }

        private string GetImagen(string urlImagen)
        {
            if (urlImagen != string.Empty) {
                string[] array = urlImagen.Split('/');
                urlImagen = array[array.Length - 1].ToString();
                    }
            return urlImagen;
        }




        #endregion



        #region Operaciones


        #endregion


        [HttpPost]
        public JsonResult GetCargaEdicionPoput()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado))
            {
                return Json(new
                {
                    success = false,
                    message = "",
                    data = ""
                });
            }

            int cantProFav = Convert.ToInt32(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.LimiteJetloreCatalogoPersonalizadoHome));
            return Json(new
            {
                success = false,
                message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.",
                extra = ""
            });
        }

    }   
}
