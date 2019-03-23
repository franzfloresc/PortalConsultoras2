using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteController : BaseController
    {
        #region CaminoBrillante
        // GET: CaminoBrillante
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetNiveles()
        {
            //List<NivelesCaminoBrillanteModel> list = new List<NivelesCaminoBrillanteModel>();
            //list = await Niveles();
            Random rdn = new Random();
            List<NivelConsultoraCaminoBrillanteModel> DatosConsultora = SessionManager.GetConsultora();

            var objniveles = new List<NivelesCaminoBrillanteModel>();
            var objBeneficio1 = new List<BeneficiosNivelCaminoBrillanteModel>();
            var objBeneficio2 = new List<BeneficiosNivelCaminoBrillanteModel>();
            var objBeneficio3 = new List<BeneficiosNivelCaminoBrillanteModel>();
            var objBeneficio4 = new List<BeneficiosNivelCaminoBrillanteModel>();
            var objBeneficio5 = new List<BeneficiosNivelCaminoBrillanteModel>();
            var objBeneficio6 = new List<BeneficiosNivelCaminoBrillanteModel>();

            int montominimo = rdn.Next(50, 70);
            int montomaximo = rdn.Next(315, 400);


            objBeneficio1.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Revista Mi Negocio L'Bel"
            });
            objBeneficio1.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "1 catálogo gratis de Ésika, L'Bel y Cyzone"
            });
            objBeneficio1.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Regalo por pedido y constancia"
            });
            objBeneficio1.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Servicio Callcenter"
            });
            objBeneficio1.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Asesor guía por whatsapp y en persona"
            });





            objBeneficio2.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Revista Mi Negocio L'Bel"
            });
            objBeneficio2.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "1 catálogo gratis de Ésika, L'Bel y Cyzone"
            });
            objBeneficio2.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "20% de descuento en la compra de catálogos y demostradores"
            });
            objBeneficio2.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Regalo por pedido y constancia"
            });
            objBeneficio2.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "Kit de productos a bajo precio",
                Descripcion = "5 productos + muestras"
            });
            objBeneficio2.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Servicio Callcenter"
            });
            objBeneficio2.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Asesor guía por whatsapp y en persona"
            });
            objBeneficio2.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "Descuentos especiales",
                Descripcion = "Las mejores ofertas según tu nivel"
            });



            objBeneficio3.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Revista Mi Negocio L'Bel"
            });
            objBeneficio3.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "1 catálogo gratis de Ésika, L'Bel y Cyzone"
            });
            objBeneficio3.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "25% de descuento en la compra de catálogos y demostradores"
            });
            objBeneficio3.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Regalo por pedido y constancia"
            });
            objBeneficio3.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "Kit de productos a bajo precio",
                Descripcion = "5 productos + demostradores + neceser pequeño"
            });
            objBeneficio3.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Servicio Callcenter"
            });
            objBeneficio3.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Asesor guía por whatsapp y en persona"
            });
            objBeneficio3.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "Descuentos especiales",
                Descripcion = "Las mejores ofertas según tu nivel"
            });




            objBeneficio4.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Revista Mi Negocio L'Bel"
            });
            objBeneficio4.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "1 catálogo gratis de Ésika, L'Bel y Cyzone"
            });
            objBeneficio4.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "30% de descuento en la compra de catálogos y demostradores"
            });
            objBeneficio4.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Regalo por pedido y constancia"
            });
            objBeneficio4.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "Kit de productos a bajo precio",
                Descripcion = "7 productos + demostradores + neceser mediano"
            });
            objBeneficio4.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Servicio Callcenter"
            });
            objBeneficio4.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Asesor guía por whatsapp y en persona"
            });
            objBeneficio4.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "Descuentos especiales",
                Descripcion = "Las mejores ofertas según tu nivel"

            });



            objBeneficio5.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Revista Mi Negocio L'Bel"
            });
            objBeneficio5.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "1 catálogo gratis de Ésika, L'Bel y Cyzone"
            });
            objBeneficio5.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "30% de descuento en la compra de catálogos y demostradores"
            });
            objBeneficio5.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Regalo por pedido y constancia"
            });
            objBeneficio5.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "Kit de productos a bajo precio",
                Descripcion = "14 productos + demostradores + neceser grande"
            });
            objBeneficio5.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Servicio Callcenter"
            });
            objBeneficio5.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Asesor guía por whatsapp y en persona"
            });
            objBeneficio5.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "Descuentos especiales",
                Descripcion = "Las mejores ofertas según tu nivel"
            });



            objBeneficio6.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Beneficios de topacio"
            });
            objBeneficio6.Add(new BeneficiosNivelCaminoBrillanteModel()
            {
                CodigoBeneficio = 1,
                Titulo = "",
                Descripcion = "Programa brillante según tu nivel"
            });



            for (int i = 1; i < 7; i++)
            {
                if (i == 1)
                {
                    objniveles.Add(new NivelesCaminoBrillanteModel()
                    {
                        IsoPais = "CRI",
                        CodigoNivel = i.ToString(),
                        DescripcionNivel = i == 1 ? "Consultora" : i == 2 ? "Coral" : i == 3 ? "Ámbar" : i == 4 ? "Perla" : i == 5 ? "Topacio" : i == 6 ? "Brillante" : "",
                        MontoMinimo = montominimo.ToString(),
                        MontoMaximo = montomaximo.ToString(),
                        BeneficiosNivel = objBeneficio1,
                        UrlImagenNivel = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGC9FIeHPnZEUkMW3Pf0PozOdqCH8ip5InmMAp60L4uwRYbtdF"
                    });
                    montominimo = montomaximo + 1;
                    montomaximo = montomaximo + 100;
                }



                if (i == 2)
                {
                    objniveles.Add(new NivelesCaminoBrillanteModel()
                    {
                        IsoPais = "CRI",
                        CodigoNivel = i.ToString(),
                        DescripcionNivel = i == 1 ? "Consultora" : i == 2 ? "Coral" : i == 3 ? "Ámbar" : i == 4 ? "Perla" : i == 5 ? "Topacio" : i == 6 ? "Brillante" : "",
                        MontoMinimo = montominimo.ToString(),
                        MontoMaximo = montomaximo.ToString(),
                        BeneficiosNivel = objBeneficio2,
                        UrlImagenNivel = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGC9FIeHPnZEUkMW3Pf0PozOdqCH8ip5InmMAp60L4uwRYbtdF"
                    });
                    montominimo = montomaximo + 1;
                    montomaximo = montomaximo + 100;
                }





                if (i == 3)
                {
                    objniveles.Add(new NivelesCaminoBrillanteModel()
                    {
                        IsoPais = "CRI",
                        CodigoNivel = i.ToString(),
                        DescripcionNivel = i == 1 ? "Consultora" : i == 2 ? "Coral" : i == 3 ? "Ámbar" : i == 4 ? "Perla" : i == 5 ? "Topacio" : i == 6 ? "Brillante" : "",
                        MontoMinimo = montominimo.ToString(),
                        MontoMaximo = montomaximo.ToString(),
                        BeneficiosNivel = objBeneficio3,
                        UrlImagenNivel = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGC9FIeHPnZEUkMW3Pf0PozOdqCH8ip5InmMAp60L4uwRYbtdF"
                    });
                    montominimo = montomaximo + 1;
                    montomaximo = montomaximo + 100;
                }




                if (i == 4)
                {
                    objniveles.Add(new NivelesCaminoBrillanteModel()
                    {
                        IsoPais = "CRI",
                        CodigoNivel = i.ToString(),
                        DescripcionNivel = i == 1 ? "Consultora" : i == 2 ? "Coral" : i == 3 ? "Ámbar" : i == 4 ? "Perla" : i == 5 ? "Topacio" : i == 6 ? "Brillante" : "",
                        MontoMinimo = montominimo.ToString(),
                        MontoMaximo = montomaximo.ToString(),
                        BeneficiosNivel = objBeneficio4,
                        UrlImagenNivel = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGC9FIeHPnZEUkMW3Pf0PozOdqCH8ip5InmMAp60L4uwRYbtdF"
                    });
                    montominimo = montomaximo + 1;
                    montomaximo = montomaximo + 100;
                }




                if (i == 5)
                {
                    objniveles.Add(new NivelesCaminoBrillanteModel()
                    {
                        IsoPais = "CRI",
                        CodigoNivel = i.ToString(),
                        DescripcionNivel = i == 1 ? "Consultora" : i == 2 ? "Coral" : i == 3 ? "Ámbar" : i == 4 ? "Perla" : i == 5 ? "Topacio" : i == 6 ? "Brillante" : "",
                        MontoMinimo = montominimo.ToString(),
                        MontoMaximo = montomaximo.ToString(),
                        BeneficiosNivel = objBeneficio5,
                        UrlImagenNivel = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGC9FIeHPnZEUkMW3Pf0PozOdqCH8ip5InmMAp60L4uwRYbtdF"
                    });
                    montominimo = montomaximo + 1;
                    montomaximo = montomaximo + 100;
                }



                if (i == 6)
                {
                    objniveles.Add(new NivelesCaminoBrillanteModel()
                    {
                        IsoPais = "CRI",
                        CodigoNivel = i.ToString(),
                        DescripcionNivel = i == 1 ? "Consultora" : i == 2 ? "Coral" : i == 3 ? "Ámbar" : i == 4 ? "Perla" : i == 5 ? "Topacio" : i == 6 ? "Brillante" : "",
                        MontoMinimo = montominimo.ToString(),
                        MontoMaximo = montomaximo.ToString(),
                        BeneficiosNivel = objBeneficio6,
                        UrlImagenNivel = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGC9FIeHPnZEUkMW3Pf0PozOdqCH8ip5InmMAp60L4uwRYbtdF"
                    });
                    montominimo = montomaximo + 1;
                    montomaximo = montomaximo + 100;
                }
            }

            long nivel = DatosConsultora[0].NivelActual;
            return Json(new { list = objniveles, NivelActual = nivel }, JsonRequestBehavior.AllowGet);
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

        private List<NivelesCaminoBrillanteModel> Niveles()
        {
            List<string> Credenciales = new List<string>();
            Credenciales = GetDatosComercial();
            CaminoBrillanteProvider prv = new CaminoBrillanteProvider(Credenciales[0], Credenciales[1], Credenciales[2]);
            //List<NivelesCaminoBrillanteModel> task = prv.GetNivel("CRI");
            List<NivelesCaminoBrillanteModel> task = prv.GetNivel(userData.CodigoISO);
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