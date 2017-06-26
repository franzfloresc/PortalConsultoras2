using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaProductoComentarioController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult RegistrarComentario(EstrategiaProductoComentarioModel model)
        {
            try
            {
                model.ProdComentarioId = 0;
                model.CodigoSAP = "0123456789";
                model.CodigoGenerico = "9876543210";
                model.CampaniaID = 201710;
                model.CodigoConsultora = userData.CodigoConsultora;
                model.CodTipoOrigen = 666;

                var BEProdComentario = MapearProductoComentarioModelAProductoComentarioBE(model);
                RegistrarComentarioServicio(BEProdComentario);

                return Json(new { success = true });
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        [HttpGet]
        public JsonResult ListarComentarios(string codigoSAP)
        {
            try
            {
                var listaComentarios = ListarComentariosServicio(codigoSAP);
                return Json(new { success = true, data = listaComentarios }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }, JsonRequestBehavior.AllowGet); }
        }

        private void RegistrarComentarioServicio(BEProductoComentarioDetalle model)
        {
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                sv.InsertarProductoComentarioDetalle(userData.PaisID, model);
            }
        }

        private List<EstrategiaProductoComentarioModel> ListarComentariosServicio(string codigoSAP)
        {
            var listaComentarios = new List<EstrategiaProductoComentarioModel>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                //var listarComentariosBE = sv.GetListaProductoComentarioDetalleResumen(userData.PaisID, codigoSAP).ToList();
                //listaComentarios = listarComentariosBE.Select(x => MapearProductoComentarioBEAProductoComentarioModel(x)).ToList();
            }

            return listaComentarios;
        }

        #region Mapero

        private BEProductoComentarioDetalle MapearProductoComentarioModelAProductoComentarioBE(EstrategiaProductoComentarioModel model)
        {
            return new BEProductoComentarioDetalle()
            {
                ProdComentarioDetalleId = model.ProdComentarioDetalleId,
                ProdComentarioId = model.ProdComentarioId,
                Valorizado = model.Valorizado,
                Recomendado = model.Recomendado,
                Comentario = model.Comentario,
                CodigoConsultora = model.CodigoConsultora,
                CampaniaID = model.CampaniaID,
                FechaRegistro = model.FechaRegistro,
                FechaAprobacion = model.FechaAprobacion,
                CodTipoOrigen = model.CodTipoOrigen,
                Estado = model.Estado,
                CodigoSAP = model.CodigoSAP,
                CodigoGenerico = model.CodigoGenerico
            };
        }

        private EstrategiaProductoComentarioModel MapearProductoComentarioBEAProductoComentarioModel(BEProductoComentarioDetalle modelBE)
        {
            return new EstrategiaProductoComentarioModel()
            {
                ProdComentarioDetalleId = modelBE.ProdComentarioDetalleId,
                ProdComentarioId = modelBE.ProdComentarioId,
                Valorizado = modelBE.Valorizado,
                Recomendado = modelBE.Recomendado,
                Comentario = modelBE.Comentario,
                CodigoConsultora = modelBE.CodigoConsultora,
                CampaniaID = modelBE.CampaniaID,
                FechaRegistro = modelBE.FechaRegistro,
                FechaAprobacion = modelBE.FechaAprobacion,
                CodTipoOrigen = modelBE.CodTipoOrigen,
                Estado = modelBE.Estado,
                CodigoSAP = modelBE.CodigoSAP,
                CodigoGenerico = modelBE.CodigoGenerico
            };
        }
        
        #endregion
    }
}