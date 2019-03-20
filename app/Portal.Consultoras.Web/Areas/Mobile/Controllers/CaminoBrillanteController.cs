using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CaminoBrillanteController : BaseMobileController
    {
        #region CaminoBrillante
        // GET: Mobile/CaminoBrillante
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetNiveles()
        {
            Random rdn = new Random();
            long Nivel = rdn.Next(1, 6);

            //Consumiendo servicio comercial
            //List<NivelesCaminoBrillanteModel> list = new List<NivelesCaminoBrillanteModel>();
            //list = await Niveles();

            var objniveles = new List<NivelesCaminoBrillanteModel>();
            var objBeneficio = new List<BeneficiosNivelCaminoBrillanteModel>();
            int montominimo = rdn.Next(50, 70);
            int montomaximo = rdn.Next(315, 400);

            for (int j = 1; j < 8; j++)
                objBeneficio.Add(new BeneficiosNivelCaminoBrillanteModel()
                {
                    CodigoBeneficio = j,
                    Titulo = "BENEFICIO " + j.ToString(),
                    Descripcion = "Descripción de Prueba " + j.ToString(),
                    UrlImagen = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGC9FIeHPnZEUkMW3Pf0PozOdqCH8ip5InmMAp60L4uwRYbtdF"
                });

            for (int i = 1; i < 7; i++)
            {
                objniveles.Add(new NivelesCaminoBrillanteModel()
                {
                    IsoPais = "CRI",
                    CodigoNivel = i.ToString(),
                    DescripcionNivel = i == 1 ? "Consultora" : i == 2 ? "Coral" : i == 3 ? "Ámbar" : i == 4 ? "Perla" : i == 5 ? "Topacio" : i == 6 ? "Brillante" : "",
                    MontoMinimo = montominimo.ToString("C"),
                    MontoMaximo = montomaximo.ToString("C"),
                    BeneficiosNivel = objBeneficio,
                    UrlImagenNivel = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGC9FIeHPnZEUkMW3Pf0PozOdqCH8ip5InmMAp60L4uwRYbtdF"
                });
                montominimo = montomaximo + 1;
                montomaximo = montomaximo + 100;
            }
            return Json(
                new {
                    list = objniveles,
                    NivelActual = rdn.Next(1, 6) }, 
                JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult MisLogros()
        {
            var oLogros = new List<MisLogrosCaminoBrillanteModel>();
            var oIndicadoresCre = new List<Indicador>();
            var oIndicadoresCom = new List<Indicador>();

            oIndicadoresCre.Add(new Indicador()
            {
                Titulo = "Ganancia",
                Valor = "25",
                UrlImagen = "/CAMINOBRILLANTE/DESKTOP/NIVELES/NIVEL_{0}.svg"
            });

            oIndicadoresCre.Add(new Indicador()
            {
                Titulo = "Ganancia",
                Valor = "8",
                UrlImagen = "/CAMINOBRILLANTE/DESKTOP/NIVELES/NIVEL_{0}.svg"
            });

            oIndicadoresCre.Add(new Indicador()
            {
                Titulo = "Ganancia",
                Valor = "5",
                UrlImagen = "/CAMINOBRILLANTE/DESKTOP/NIVELES/NIVEL_{0}.svg"
            });

            oLogros.Add(new MisLogrosCaminoBrillanteModel()
            {
                Titulo = "Crecimiento",
                Descripcion = "Tu progreso tiene recompensas",
                Indicador = oIndicadoresCre
            });

            for (int i = 1; i < 3; i++)
            {
                oIndicadoresCom.Add(new Indicador()
                {
                    Titulo = "",
                    Valor = "",
                    UrlImagen = ""
                });
            }

            oLogros.Add(new MisLogrosCaminoBrillanteModel()
            {
                Titulo = "Compromiso",
                Descripcion = "Tu compromiso tiene recompensas",
                Indicador = oIndicadoresCom
            });
            return Json(new { list = oLogros }, JsonRequestBehavior.AllowGet);
        }


        private Task<List<NivelesCaminoBrillanteModel>> Niveles()
        {
            List<string> Credenciales = new List<string>();
            Credenciales = GetDatosComercial();
            CaminoBrillanteProvider prv = new CaminoBrillanteProvider(Credenciales[0], Credenciales[1], Credenciales[2]);
            Task<List<NivelesCaminoBrillanteModel>> task = prv.GetNivel("CRI"); //Reemplazar por UserData.Pais
            return task;
        }

        public List<string> GetDatosComercial()
        {
            List<string> list = new List<string>();
            using (var svc = new SACServiceClient())
            {
                var response = svc.GetTablaLogicaDatos(userData.PaisID, Constantes.TablaLogicaDato.CaminoBrillanteTablaLogica).ToList();
                foreach (BETablaLogicaDatos obj in response)
                    list.Add(obj.Valor);
            }
            return list;
        }
        #endregion
    }
}