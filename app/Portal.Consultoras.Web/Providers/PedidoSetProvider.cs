﻿using Portal.Consultoras.Web.Models.Common;
using System.ServiceModel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.Pedido;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class PedidoSetProvider
    {
        public ResultModel<bool> EliminarSet(int paisId, int setId)
        {
            using (var client = new PedidoServiceClient())
            {
                try
                {
                    var result = client.EliminarPedidoWebSet(paisId, setId);
                    if (!result)
                        return ResultModel<bool>.BuildBad("Sucedio un error", false);

                    return ResultModel<bool>.BuildOk(true);
                }
                catch (FaultException e)
                {
                    LogManager.LogManager.LogErrorWebServicesPortal(e, "", Util.GetPaisISO(paisId));
                    return ResultModel<bool>.BuildBad(e.Message, false);
                }
            }
        }
        public ResultModel<bool> ActualizarCantidadSet(int paisId, int setId, int cantidad)
        {
            using (var client = new PedidoServiceClient())
            {
                try
                {
                    var result = client.UpdCantidadPedidoWebSet(paisId, setId, cantidad);
                    if (!result)
                        return ResultModel<bool>.BuildBad("Sucedio un error", false);

                    return ResultModel<bool>.BuildOk(true);
                }
                catch (FaultException e)
                {
                    LogManager.LogManager.LogErrorWebServicesPortal(e, "", Util.GetPaisISO(paisId));
                    return ResultModel<bool>.BuildBad(e.Message, false);
                }
            }
        }
        public PedidoWebSetModel ObtenerPorId(int paisId, int setId)
        {
            using (var client = new PedidoServiceClient())
            {
                var result = client.ObtenerPedidoWebSet(paisId, setId);
                if (result != null)
                    return AutoMapper.Mapper.Map<BEPedidoWebSet, PedidoWebSetModel>(result);
            }

            return null;
        }

        public List<PedidoWebSetDetalleModel> ObtenerDetalle(int paisID, int campania, long consultoraId)
        {
            using (var client = new PedidoServiceClient())
            {
                var result = client.GetPedidoWebSetDetalle(paisID, campania, consultoraId).ToList<BEPedidoWebSetDetalle>();
                if (result != null)
                    return AutoMapper.Mapper.Map<List<BEPedidoWebSetDetalle>, List<PedidoWebSetDetalleModel>>(result);
            }
            return null;
        }
    }
}
