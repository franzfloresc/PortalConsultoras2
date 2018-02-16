using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
        /// <returns></returns>
        public UpSelling Actualizar(UpSelling upSelling)
        {
            var upSellingOriginal = _upSellingDataAccess.Obtener(upSelling.UpSellingId);

            var entidad = _upSellingDataAccess.Actualizar(upSelling);
            entidad.Regalos.AddRange(InsertarActualizarDetalle(upSelling.Regalos));

            var detallesEliminar = from o in upSellingOriginal.Regalos
                                   where entidad.Regalos.Select(upSellingDetalle => upSellingDetalle.UpSellingDetalleId).Contains(o.UpSellingDetalleId)
                                   select o.UpSellingDetalleId;

            EliminarDetalle(detallesEliminar);
            return entidad;
        }

        public UpSelling Insertar(UpSelling upSelling)
        {
            var entidad = _upSellingDataAccess.Insertar(upSelling);
            entidad.Regalos.AddRange(InsertarActualizarDetalle(upSelling.Regalos));
            return entidad;
        }

        public void Eliminar(int upSellingId)
        {
            var upSelling = _upSellingDataAccess.Obtener(upSellingId);

            if (upSelling != null)
            {
                EliminarDetalle(upSelling.Regalos.Select(upSellingDetalle => upSellingDetalle.UpSellingDetalleId));
                _upSellingDataAccess.Eliminar(upSellingId);
            }
        }

        private List<UpSellingDetalle> InsertarActualizarDetalle(List<UpSellingDetalle> regalos)
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

        private void EliminarDetalle(IEnumerable<int> upSellingDetalleIds)
        {
            upSellingDetalleIds.ForEach(upSellingDetalleId =>
            {
                _upSellingDataAccess.EliminarDetalle(upSellingDetalleId);
            });
        }
    }
}
