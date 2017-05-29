using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseRevistaDigitalController : BaseEstrategiaController
    {
        public RevistaDigitalModel IndexModel()
        {
            var model = new RevistaDigitalModel();
            model = ListarTabs(model);

            if (model.EstadoAccion < 0)
                return model;

            model.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
            var listaProducto = ConsultarEstrategiasModel();
            using (SACServiceClient svc = new SACServiceClient())
            {
                model.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
            }

            var listaMarca = listaProducto.GroupBy(p => p.DescripcionMarca).ToList();
            model.FiltersByBrand = new List<BETablaLogicaDatos>();
            if (listaMarca.Any())
            {
                model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "-", Descripcion = "Todas" });
                foreach (var marca in listaMarca)
                {
                    model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = marca.Key, Descripcion = marca.Key });
                }
            }

            model.ListaProducto = listaProducto.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();
            var listadoNoLanzamiento = listaProducto.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();

            if (listadoNoLanzamiento.Any())
            {
                model.PrecioMin = listadoNoLanzamiento.Min(p => p.Precio2);
                model.PrecioMax = listadoNoLanzamiento.Max(p => p.Precio2);
            }

            model.IsMobile = IsMobile();

            return model;
        }

        public EstrategiaPedidoModel DetalleModel(int id)
        {
            var listaProducto = ConsultarEstrategiasModel();
            var model = listaProducto.FirstOrDefault(e => e.EstrategiaID == id) ?? new EstrategiaPedidoModel();
            
            return model;
        }

        public RevistaDigitalModel ListarTabs(RevistaDigitalModel model = null)
        {
            model = model ?? new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.ListaTabs = new List<ComunModel>();

            model.Titulo = userData.UsuarioNombre.ToUpper();
            model.TituloDescripcion = "";
            string cadenaActiva = "COMPRAR CAMPAÑA ";

            if (ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalSuscripcion))
            {
                if (ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalReducida))
                {
                    model.EstadoAccion = 1;
                    model.Titulo += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA<br />";
                    model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                    model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaActiva + userData.CampaniaID.Substring(4, 2) });
                    model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                    return model;
                }

                if (ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigital))
                {
                    //model.EstadoAccion = 2;
                    model = ListarTabsRD(model);
                    return model;
                }

                if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                {
                    model.Titulo += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                }
                else
                {
                    model.Titulo += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA<br />";
                    model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                }

                model.EstadoAccion = 0;
                return model;
            }
            else
            {
                if (ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalReducida))
                {
                    model.EstadoAccion = 1;
                    model.Titulo += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA<br />";
                    model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                    return model;
                }

                if (ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigital))
                {
                    //model.EstadoAccion = 2;
                    model = ListarTabsRD(model);
                    return model;
                }

                model.EstadoAccion = -1;
                return model;
            }            
        }

        public RevistaDigitalModel ListarTabsRD(RevistaDigitalModel model = null)
        {
            model = model ?? new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.ListaTabs = new List<ComunModel>();

            if (ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigital))
            {
                return model;
            }

            model.Titulo = userData.UsuarioNombre.ToUpper();
            model.TituloDescripcion = "";
            string cadenaActiva = "COMPRAR CAMPAÑA ", cadenaBloqueado = "VER CAMAPAÑA ";

            if (userData.RevistaDigital.SuscripcionAnteriorModel.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo)
            {
                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo)
                {
                    model.EstadoAccion = 0;
                    model.Titulo += ", INSCRÍBETE A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "INCREMENTA EN 20% TU GANANCIA REEMPLAZANDO TU REVISTA IMPRESA POR TU REVISTA ONLINE.";
                    return model;
                }

                if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                {
                    model.EstadoAccion = 0;
                    model.Titulo += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                    return model;
                }

                if (userData.RevistaDigital.SuscripcionModel.CampaniaID == AddCampaniaAndNumero(userData.CampaniaID, -1))
                {
                    model.Titulo += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS. RECUERDA QUE PODRÁS AGREGARLOS A PARTIRÁ DE LA PRÓXIMA CAMPAÑA";
                    model.EstadoAccion = AddCampaniaAndNumero(userData.CampaniaID, 1);
                    model.ListaTabs.Add(new ComunModel { Id = model.EstadoAccion, Descripcion = cadenaBloqueado + model.EstadoAccion.Substring(4, 2) });
                    model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                    model.EstadoAccion = 1;
                    return model;
                }
            }
            
            if (userData.RevistaDigital.SuscripcionAnteriorModel.CampaniaID == userData.CampaniaID)
            {
                model.EstadoAccion = 0;
                model.Titulo += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                model.TituloDescripcion = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                return model;
            }

            model.Titulo += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";

            if (userData.RevistaDigital.SuscripcionAnteriorModel.CampaniaID == AddCampaniaAndNumero(userData.CampaniaID, -1))
            {
                model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS. RECUERDA QUE PODRÁS AGREGARLOS A PARTIRÁ DE LA PRÓXIMA CAMPAÑA";
                model.EstadoAccion = AddCampaniaAndNumero(userData.CampaniaID, 1);
                model.ListaTabs.Add(new ComunModel { Id = model.EstadoAccion, Descripcion = cadenaBloqueado + model.EstadoAccion.Substring(4, 2) });
                model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                model.EstadoAccion = 1;
                return model;
            }

            if (userData.RevistaDigital.SuscripcionAnteriorModel.CampaniaID <= AddCampaniaAndNumero(userData.CampaniaID, -2))
            {
                model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                model.EstadoAccion = AddCampaniaAndNumero(userData.CampaniaID, 1);
                model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaActiva + userData.CampaniaID.Substring(4, 2) });
                model.ListaTabs.Add(new ComunModel { Id = model.EstadoAccion, Descripcion = cadenaBloqueado + model.EstadoAccion.Substring(4, 2) });
                model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                model.EstadoAccion = 2;
                return model;
            }

            return model;
        }

    }
}