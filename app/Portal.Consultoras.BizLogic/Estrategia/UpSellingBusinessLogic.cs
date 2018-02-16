using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Microsoft.Practices.EnterpriseLibrary.Common.Utility;
using Portal.Consultoras.Data.Estrategia;
using Portal.Consultoras.Entities.Estrategia;

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
                    var detalle = _upSellingDataAccess.ObtenerDetalle(upSelling.UpSellingId);
                    if (detalle != null)
                        upSelling.Regalos.AddRange(detalle);
                });
            }

            return upSellings ?? new List<UpSelling>();
        }

        /// <summary>
        /// todo: transactional
        /// </summary>
        /// <param name="paisId"></param>
        /// <param name="upSelling"></param>
        /// <exception cref="NullReferenceException">Id no encontrado</exception>
        /// <exception cref="ArgumentException">UpSelling detalle no perteneciente</exception>
        /// <returns></returns>
        public UpSelling Actualizar(UpSelling upSelling)
        {
            using (var transaction = new TransactionScope())
            {
                var upSellingOriginal = _upSellingDataAccess.Obtener(upSelling.UpSellingId);
                if (upSellingOriginal == null)
                    throw new NullReferenceException("UpSelling no encontrado");

                upSellingOriginal.Regalos = _upSellingDataAccess.ObtenerDetalle(upSelling.UpSellingId);

                var entidad = _upSellingDataAccess.Actualizar(upSelling);
                if (upSelling.Regalos != null)
                {
                    upSelling.Regalos.ForEach(r =>
                    {
                        r.UpSellingId = entidad.UpSellingId;
                    });
                    entidad.Regalos.AddRange(InsertarActualizarDetalle(upSelling.Regalos));
                }

                var detallesEliminar = from o in upSellingOriginal.Regalos
                                       where entidad.Regalos.Select(upSellingDetalle => upSellingDetalle.UpSellingDetalleId).Contains(o.UpSellingDetalleId)
                                       select o.UpSellingDetalleId;

                var regalosEliminados = EliminarDetalle(detallesEliminar);

                if (upSelling.Regalos != null && upSelling.Regalos.Count != upSellingOriginal.Regalos.Count - regalosEliminados)
                    throw new ArgumentException("UpSelling detalle no coincide con los detalles originales");

                transaction.Complete();

                return entidad;
            }
        }

        public UpSelling Insertar(UpSelling upSelling)
        {
            using (var transaction = new TransactionScope())
            {
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

        public void Eliminar(int upSellingId)
        {
            using (var transaction = new TransactionScope())
            {
                var upSelling = _upSellingDataAccess.Obtener(upSellingId);

                if (upSelling != null)
                {
                    EliminarDetalle(upSelling.Regalos.Select(upSellingDetalle => upSellingDetalle.UpSellingDetalleId));
                    _upSellingDataAccess.Eliminar(upSellingId);
                }

                transaction.Complete();
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
                counter += result;
            });

            return counter;
        }
    }
}
