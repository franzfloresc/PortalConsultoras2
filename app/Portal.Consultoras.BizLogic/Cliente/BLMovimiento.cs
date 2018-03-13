using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public class BLMovimiento : IMovimientoBusinessLogic
    {
        public ResponseType<int> Insertar(int paisId, BEMovimiento movimiento)
        {
            if (!Constantes.MovimientoTipo.Todos.Contains(movimiento.TipoMovimiento))
                return ResponseType<int>.Build(success: false, message: Resources.ClienteValidationMessages.TipoMovimientoInvalido);

            movimiento.Monto = movimiento.TipoMovimiento == Constantes.MovimientoTipo.Abono
                ? (-1) * Math.Abs(movimiento.Monto)
                : Math.Abs(movimiento.Monto);

            var daCliente = new DACliente(paisId);
            var movimientoInsertado = daCliente.MovimientoInsertar(movimiento);

            if (movimientoInsertado == 0)
                return ResponseType<int>.Build(false, code: Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTOINVALIDO);

            return ResponseType<int>.Build(data: movimientoInsertado);
        }

        public IEnumerable<BEMovimiento> Listar(int paisId, short clienteId, long consultoraId)
        {
            List<BEMovimiento> movimientos;
            var daCliente = new DACliente(paisId);
            var daPedidoDetalle = new DAPedidoWebDetalle(paisId);

            using (var reader = daCliente.MovimientosListar(clienteId, consultoraId))
                movimientos = reader.MapToCollection<BEMovimiento>();

            foreach (var movimiento in movimientos)
            {
                if (movimiento.TipoMovimiento != Constantes.MovimientoTipo.CargoBelcorp)
                    continue;

                int codigoCampania;
                if (!int.TryParse(movimiento.CodigoCampania, out codigoCampania))
                    continue;

                if (codigoCampania <= 0)
                    continue;

                var pedidos = new List<BEPedidoDDWebDetalle>();
                using (var reader = daPedidoDetalle.ClientePedidoFacturadoListar(codigoCampania, consultoraId, clienteId))
                    while (reader.Read())
                    {
                        var pedido = new BEPedidoDDWebDetalle(reader);
                        pedidos.Add(pedido);
                    }

                movimiento.Pedidos = pedidos;
            }

            return movimientos;
        }

        public ResponseType<BEMovimiento> Actualizar(int paisId, BEMovimiento movimiento)
        {
            if (!Constantes.MovimientoTipo.Todos.Contains(movimiento.TipoMovimiento))
            {
                return ResponseType<BEMovimiento>.Build(success: false, message: Resources.ClienteValidationMessages.TipoMovimientoInvalido);
            }

            movimiento.Monto = movimiento.TipoMovimiento == Constantes.MovimientoTipo.Abono
                ? (-1) * Math.Abs(movimiento.Monto)
                : Math.Abs(movimiento.Monto);

            var daCliente = new DACliente(paisId);
            var result = daCliente.MovimientoActualizar(movimiento);

            if (!result)
                return ResponseType<BEMovimiento>.Build(false, Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTOINVALIDO);

            return ResponseType<BEMovimiento>.Build(result, string.Empty);
        }

        public ResponseType<int> Eliminar(int paisId, long consultoraId, short clienteId, int movimientoId)
        {
            var movimientos = Listar(paisId, clienteId, consultoraId);
            var movimiento = movimientos.FirstOrDefault(m => m.ClienteMovimientoId == movimientoId);

            if (movimiento == null)
                return ResponseType<int>.Build(success: false, code: Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTOINVALIDO, message: Resources.ClienteValidationMessages.TipoMovimientoInvalido);

            if (new[] { Constantes.MovimientoTipo.Historico, Constantes.MovimientoTipo.CargoBelcorp }.Contains(movimiento.TipoMovimiento))
                return ResponseType<int>.Build(success: false, code: Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTOINVALIDO, message: Resources.ClienteValidationMessages.TipoMovimientoInvalido);

            var daCliente = new DACliente(paisId);
            var result = daCliente.MovimientoEliminar(consultoraId, clienteId, movimientoId);

            if (!result)
                return ResponseType<int>.Build(false, Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTOINVALIDO, Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTOINVALIDO]);

            return ResponseType<int>.Build(result, string.Empty);
        }

        public ResponseType<List<BEMovimiento>> Procesar(int paisId, BEClienteDB clienteDb)
        {
            var movimientosResponse = ResponseType<List<BEMovimiento>>.Build(data: new List<BEMovimiento>());

            if (clienteDb.Movimientos != null)
            {
                foreach (var movimiento in clienteDb.Movimientos)
                {
                    movimiento.ClienteId = (short)clienteDb.ClienteID;
                    movimiento.CodigoCliente = clienteDb.CodigoCliente;

                    if (movimiento.StatusEnum == StatusEnum.Delete)
                    {
                        var resultEliminar = Eliminar(paisId, clienteDb.ConsultoraID, movimiento.ClienteId, movimiento.ClienteMovimientoId);
                        if (!resultEliminar.Success)
                        {
                            movimientosResponse.Success = resultEliminar.Success;
                            movimientosResponse.Message = resultEliminar.Message;
                            movimiento.Code = resultEliminar.Code;
                            movimiento.Message = resultEliminar.Message;

                            movimientosResponse.Data.Add(movimiento);
                        }

                        continue;
                    }

                    if (movimiento.ClienteMovimientoId == 0)
                    {
                        var resultInsertar = Insertar(paisId, movimiento);
                        if (!resultInsertar.Success)
                        {
                            movimientosResponse.Success = resultInsertar.Success;
                            movimientosResponse.Message = resultInsertar.Message;

                            movimiento.Code = resultInsertar.Code;
                            movimiento.Message = resultInsertar.Message;
                        }

                        movimiento.ClienteMovimientoId = resultInsertar.Data;
                    }
                    else
                    {
                        var resultActualizar = Actualizar(paisId, movimiento);
                        if (!resultActualizar.Success)
                        {
                            movimientosResponse.Success = resultActualizar.Success;
                            movimientosResponse.Message = resultActualizar.Message;

                            movimiento.Code = resultActualizar.Code;
                            movimiento.Message = resultActualizar.Message;
                        }
                    }

                    movimientosResponse.Data.Add(movimiento);
                }
            }

            clienteDb.Movimientos = movimientosResponse.Data;

            return movimientosResponse;
        }

        public ResponseType<List<BEMovimientoDetalle>> ActualizarDetalle(int paisId, List<BEMovimientoDetalle> movimientos)
        {
            var daPedidoWebDetalle = new DAPedidoWebDetalle(paisId);

            foreach (var movimientoDetalle in movimientos)
            {
                this.ValidarMovimientoDetalle(movimientoDetalle);
                if (movimientoDetalle.Code != Constantes.ClienteValidacion.Code.SUCCESS) continue;

                movimientoDetalle.ImporteTotal = movimientoDetalle.Cantidad * movimientoDetalle.PrecioUnidad;
                var result = daPedidoWebDetalle.UpdPedidoWebFacturado(movimientoDetalle.PedidoWebFacturadoID, movimientoDetalle.PrecioUnidad, movimientoDetalle.ImporteTotal);

                if (result == 0)
                {
                    movimientoDetalle.Code = Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_NOACTUALIZADO;
                    movimientoDetalle.Message = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_NOACTUALIZADO];
                    continue;
                }

                movimientoDetalle.Code = Constantes.ClienteValidacion.Code.SUCCESS;
                movimientoDetalle.Message = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.SUCCESS];
            }

            if (movimientos.Any(m => m.Code != Constantes.ClienteValidacion.Code.SUCCESS))
                return ResponseType<List<BEMovimientoDetalle>>.Build(false, Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_NOACTUALIZADO, Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_NOACTUALIZADO], movimientos);

            return ResponseType<List<BEMovimientoDetalle>>.Build(true, Constantes.ClienteValidacion.Code.SUCCESS, Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.SUCCESS], movimientos);
        }

        private void ValidarMovimientoDetalle(BEMovimientoDetalle detalle)
        {
            if (detalle.PedidoWebFacturadoID == 0)
            {
                detalle.Code = Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_PEDIDOWEBFACTURADOID_NOENVIADO;
                detalle.Message = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_PEDIDOWEBFACTURADOID_NOENVIADO];
                return;
            }
            else if (detalle.Cantidad == 0)
            {
                detalle.Code = Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_CANTIDAD_NOENVIADO;
                detalle.Message = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_CANTIDAD_NOENVIADO];
                return;
            }
            else if (detalle.PrecioUnidad == 0)
            {
                detalle.Code = Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_PRECIOUNIDAD_NOENVIADO;
                detalle.Message = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_MOVIMIENTODETALLE_PRECIOUNIDAD_NOENVIADO];
                return;
            }

            detalle.Code = Constantes.ClienteValidacion.Code.SUCCESS;
            detalle.Message = Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.SUCCESS];
        }
    }
}