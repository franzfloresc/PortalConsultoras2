using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CuponController : BaseController
    {
        [HttpPost]
        public JsonResult ActualizarCupon(CuponModel cupon)
        {
            try
            {
                var success = true;
                return Json(new { success = success });
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        [HttpGet]
        public JsonResult ObtenerCupon()
        {
            try
            {
                CuponModel cuponModel = ObtenerDatosCupon();
                return Json(new { success = true, data = cuponModel }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        private CuponModel ObtenerDatosCupon()
        {
            CuponModel cuponModel;
            BECuponConsultora cuponResult = ObtenerCuponDesdeServicio();
            
            if (cuponResult != null)
                cuponModel = MapearBECuponACuponModel(cuponResult);
            else
                throw new Exception();

            return cuponModel;
        }

        private BECuponConsultora ObtenerCuponDesdeServicio()
        {
            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                int paisId = userData.PaisID;
                BECuponConsultora cuponBE = new BECuponConsultora();
                cuponBE.CodigoConsultora = userData.CodigoConsultora;
                cuponBE.CampaniaId = userData.CampaniaID;

                var cuponResult = svClient.GetCuponConsultoraByCodigoConsultoraCampaniaId(paisId, cuponBE);
                return cuponResult;
            }
        }

        private CuponModel MapearBECuponACuponModel(BECuponConsultora cuponBE)
        {
            var codigoISO = userData.CodigoISO;

            return new CuponModel(codigoISO) {
                CuponConsultoraId = cuponBE.CuponConsultoraId,
                CodigoConsultora = cuponBE.CodigoConsultora,
                CampaniaId = cuponBE.CampaniaId,
                CuponId = cuponBE.CuponId,
                ValorAsociado = cuponBE.ValorAsociado,
                EstadoCupon = cuponBE.EstadoCupon,
                EnvioCorreo = cuponBE.EnvioCorreo,
                FechaCreacion = cuponBE.FechaCreacion,
                FechaModificacion = cuponBE.FechaModificacion,
                UsuarioCreacion = cuponBE.UsuarioCreacion,
                UsuarioModificacion = cuponBE.UsuarioModificacion,
                TipoCupon = cuponBE.TipoCupon
            };
        }
    }
}