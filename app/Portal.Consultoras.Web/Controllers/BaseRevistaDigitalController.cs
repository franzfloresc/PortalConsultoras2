using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicePROLConsultas;
using Portal.Consultoras.Web.ServiceSAC;
using System;
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
            model.NombreUsuario = userData.UsuarioNombre.ToUpper();
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
            //model.ListaProducto.Update(p => {
            //    p.EstrategiaDetalle.ImgFondoDesktop = model.IsMobile ? "" : p.EstrategiaDetalle.ImgFondoDesktop;
            //    p.EstrategiaDetalle.ImgPrevDesktop = model.IsMobile ? "" : p.EstrategiaDetalle.ImgPrevDesktop;
            //    p.EstrategiaDetalle.ImgFichaDesktop = model.IsMobile ? p.EstrategiaDetalle.ImgFichaMobile : p.EstrategiaDetalle.ImgFichaDesktop;
            //    p.EstrategiaDetalle.ImgFichaFondoDesktop = model.IsMobile ? p.EstrategiaDetalle.ImgFichaFondoMobile : p.EstrategiaDetalle.ImgFichaFondoDesktop;
            //});

            return model;
        }

        public EstrategiaPedidoModel DetalleModel(int id)
        {
            var listaProducto = ConsultarEstrategiasModel();
            var model = listaProducto.FirstOrDefault(e => e.EstrategiaID == id) ?? new EstrategiaPedidoModel();
            
            return model;
        }
    }
}