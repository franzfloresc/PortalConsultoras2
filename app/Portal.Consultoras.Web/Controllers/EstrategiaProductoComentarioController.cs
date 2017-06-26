using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
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
        public JsonResult ListarComentarios()
        {
            try
            {
                return Json(new { success = true });
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        private void RegistrarComentarioServicio(BEProductoComentarioDetalle model)
        {
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                sv.InsertarProductoComentarioDetalle(userData.PaisID, model);
            }
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

        #endregion
    }
}