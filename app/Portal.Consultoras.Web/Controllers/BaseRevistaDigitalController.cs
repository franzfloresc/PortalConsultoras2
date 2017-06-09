﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseRevistaDigitalController : BaseEstrategiaController
    {
        public RevistaDigitalModel IndexModel()
        {
            var model = new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.IsMobile = ViewBag.EsMobile == 2;
            if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
            {
                if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigitalSuscripcion))
                {
                    return model;
                }

                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo)
                {
                    return model;
                }
            }
            
            model = ListarTabs(model);

            if (model.EstadoAccion < 0) 
                return model;

            model.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;

            //model.FiltersBySorting = new List<BETablaLogicaDatos>();
            //model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido, Descripcion = IsMobile() ? "LO MÁS VENDIDO" : "ORDENAR POR PRECIO" });
            //model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor, Descripcion = IsMobile() ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO" });
            //model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor, Descripcion = IsMobile() ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO" });
            //var listaProducto = ConsultarEstrategiasModel();
            //model.ListaProducto = listaProducto.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();
            //var listadoNoLanzamiento = listaProducto.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();
            //var listaMarca = listadoNoLanzamiento.GroupBy(p => p.DescripcionMarca).ToList();
            //model.FiltersByBrand = new List<BETablaLogicaDatos>();
            //if (listaMarca.Any())
            //{
            //    model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "-", Descripcion = IsMobile() ? "MARCAS" : "FILTRAR POR MARCA" });
            //    foreach (var marca in listaMarca)
            //    {
            //        model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = marca.Key, Descripcion = marca.Key.ToUpper() });
            //    }
            //}
            //if (listadoNoLanzamiento.Any())
            //{
            //    model.PrecioMin = listadoNoLanzamiento.Min(p => p.Precio2);
            //    model.PrecioMax = listadoNoLanzamiento.Max(p => p.Precio2);
            //}
            
            model.CampaniaMasUno = AddCampaniaAndNumero(userData.CampaniaID, 1) % 100;
            model.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;

            model.NumeroContacto = Util.Trim(ConfigurationManager.AppSettings["BelcorpRespondeTEL_" + userData.CodigoISO]);

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
                    model.Titulo += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                }

                model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
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
                    model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaActiva + userData.CampaniaID.Substring(4, 2) });
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
                    model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                    return model;
                }

                if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                {
                    model.EstadoAccion = 0;
                    model.Titulo += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                    model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
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
                model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
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