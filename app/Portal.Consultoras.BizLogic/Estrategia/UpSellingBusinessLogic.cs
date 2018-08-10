using Microsoft.Practices.EnterpriseLibrary.Common.Utility;
using Portal.Consultoras.Data.Estrategia;
using Portal.Consultoras.Entities.Estrategia;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.Estrategia
{
    public class UpSellingBusinessLogic : IUpSellingBusinessLogic
    {
        private readonly UpSellingDataAccess _upSellingDataAccess;

        public UpSellingBusinessLogic(int paisId)
        {
            _upSellingDataAccess = new UpSellingDataAccess(paisId);
        }

        public IEnumerable<UpSelling> Obtener(string codigoCampana, bool incluirDetalle)
        {
            var upSellings = _upSellingDataAccess.Obtener(null, codigoCampana);
            if (upSellings != null && incluirDetalle)
            {
                upSellings.ForEach(upSelling =>
                {
                    var detalle = _upSellingDataAccess.ObtenerDetalles(upSelling.UpSellingId);
                    if (detalle != null)
                        upSelling.Regalos.AddRange(detalle);
                });
            }

            return upSellings ?? new List<UpSelling>();
        }

        /// <summary>
        /// Actualiza el upselling y sus detalles
        /// </summary>
        /// <param name="upSelling"></param>
        /// <param name="soloCabecera">true si solo sea desea actualizar el upSelling y no los detalles</param>
        /// <exception cref="NullReferenceException">Id no encontrado</exception>
        /// <exception cref="ArgumentException">UpSelling detalle no perteneciente</exception>
        /// <returns></returns>
        public UpSelling Actualizar(UpSelling upSelling, bool soloCabecera)
        {
            if (string.IsNullOrEmpty(upSelling.UsuarioModificacion))
                throw new ArgumentNullException("UsuarioModificacion");

            upSelling.FechaModificacion = upSelling.FechaModificacion ?? DateTime.Now;

            using (var transaction = new TransactionScope())
            {
                var upSellingOriginal = _upSellingDataAccess.Obtener(upSelling.UpSellingId);
                if (upSellingOriginal == null)
                    throw new NullReferenceException("UpSelling no encontrado");

                var upSellingsByCampana = _upSellingDataAccess.Obtener(null, upSelling.CodigoCampana);
                if (upSellingsByCampana.Count(us => us.CodigoCampana == upSelling.CodigoCampana && us.UpSellingId != upSelling.UpSellingId) > 0)
                    throw new ArgumentException("Esta campaña ya cuenta con Upselling asociado");

                upSellingOriginal.Regalos = _upSellingDataAccess.ObtenerDetalles(upSelling.UpSellingId);

                var entidad = _upSellingDataAccess.Actualizar(upSelling);
                if (upSelling.Regalos != null && !soloCabecera)
                {
                    upSelling.Regalos.ForEach(r =>
                    {
                        if (r.UpSellingId == 0)
                            r.UpSellingId = entidad.UpSellingId;
                    });

                    //algun regalo que no pertenzca a UpSelling 
                    // por UpSellingId y UpSellingDetalleId
                    if (upSelling.Regalos.Any(r => r.UpSellingId != upSelling.UpSellingId)
                    || upSelling.Regalos
                            .Where(r => r.UpSellingDetalleId != 0)
                            .Select(r => r.UpSellingDetalleId)
                            .Any(r => !upSellingOriginal.Regalos
                                .Select(ro => ro.UpSellingDetalleId)
                                .Contains(r)))
                        throw new System.ArgumentException("Regalo no perteneciente al UpSelling");

                    entidad.Regalos.AddRange(InsertarActualizarDetalle(upSelling.Regalos));

                    //eliminar los que no vayan a actualizarce
                    var detallesEliminar =
                        from o in upSellingOriginal.Regalos
                        where entidad.Regalos.All(upSellingDetalle => upSellingDetalle.UpSellingDetalleId != o.UpSellingDetalleId)
                        select o.UpSellingDetalleId;

                    try
                    {
                        EliminarDetalle(detallesEliminar);
                    }
                    catch (Exception ex)
                    {
                        throw new ArgumentException("No se puede eliminar el Upselling por que uno de sus regalos ya fue ganado por alguna consultora", ex);
                    }
                }

                transaction.Complete();

                return entidad;
            }
        }

        public UpSelling Insertar(UpSelling upSelling)
        {
            using (var transaction = new TransactionScope())
            {
                var upSellings = _upSellingDataAccess.Obtener(null, upSelling.CodigoCampana);
                if (upSellings != null && upSellings.Any())
                    throw new ArgumentException("Esta campaña ya cuenta con Upselling asociado");

                var entidad = _upSellingDataAccess.Insertar(upSelling);
                if (upSelling.Regalos != null)
                {
                    upSelling.Regalos.ForEach(r =>
                    {
                        r.UpSellingId = entidad.UpSellingId;
                    });

                    entidad.Regalos.AddRange(InsertarActualizarDetalle(upSelling.Regalos));
                }

                transaction.Complete();

                return entidad;
            }
        }

        public int Eliminar(int upSellingId)
        {
            using (var transaction = new TransactionScope())
            {
                var upSelling = _upSellingDataAccess.Obtener(upSellingId);

                if (upSelling == null)
                    throw new NullReferenceException("UpSelling no encontrado");

                upSelling.Regalos = _upSellingDataAccess.ObtenerDetalles(upSelling.UpSellingId);
                var rowsDetailAffected = EliminarDetalle(upSelling.Regalos.Select(upSellingDetalle => upSellingDetalle.UpSellingDetalleId));
                var rowHeaderAffected = _upSellingDataAccess.Eliminar(upSellingId);


                transaction.Complete();
                return rowsDetailAffected + rowHeaderAffected;
            }
        }

        private IEnumerable<UpSellingDetalle> InsertarActualizarDetalle(List<UpSellingDetalle> regalos)
        {
            var detalles = new List<UpSellingDetalle>();
            regalos.ForEach(regalo =>
            {
                UpSellingDetalle detalle;
                if (regalo.UpSellingDetalleId == default(int))
                    detalle = _upSellingDataAccess.InsertarDetalle(regalo);
                else
                    detalle = _upSellingDataAccess.ActualizarDetalle(regalo);

                detalles.Add(detalle);
            });

            return detalles;
        }

        private int EliminarDetalle(IEnumerable<int> upSellingDetalleIds)
        {
            var counter = 0;
            upSellingDetalleIds.ForEach(upSellingDetalleId =>
            {
                var result = _upSellingDataAccess.EliminarDetalle(upSellingDetalleId);
                if (result != 1)
                    throw new NullReferenceException("Id no encontrado " + upSellingDetalleId);

                counter += result;
            });

            return counter;
        }

        public UpSellingDetalle ObtenerDetalle(int upSellingDetalleId)
        {
            var model = _upSellingDataAccess.ObtenerDetalle(upSellingDetalleId);

            if (model == default(UpSellingDetalle))
                throw new NullReferenceException("Detalle no encontrado");

            return model;
        }

        public IEnumerable<UpSellingDetalle> ObtenerDetalles(int upSellingId)
        {
            return _upSellingDataAccess.ObtenerDetalles(upSellingId);
        }

        public UpSellingRegalo ObtenerMontoMeta(int campaniaId, long consultoraId)
        {
            var entidad = _upSellingDataAccess.ObtenerMontoMeta(campaniaId, consultoraId);
            return entidad;
        }

        public int InsertarRegalo(UpSellingRegalo entidad)
        {
            TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            using (var transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                var result = _upSellingDataAccess.InsertarRegalo(entidad);
                transaction.Complete();

                return result;
            }
        }

        public UpSellingRegalo ObtenerRegaloGanado(int campaniaId, long consultoraId)
        {
            var entidad = _upSellingDataAccess.ObtenerRegaloGanado(campaniaId, consultoraId);
            return entidad;
        }

        public IEnumerable<UpSellingMontoMeta> ListarReporteMontoMeta(int upSellingId)
        {
            var lista = _upSellingDataAccess.ListarReporteMontoMeta(upSellingId);
            return lista;
        }

    }
}
