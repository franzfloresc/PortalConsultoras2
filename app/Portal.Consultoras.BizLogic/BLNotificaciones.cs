using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLNotificaciones
    {
        public IList<BENotificaciones> GetNotificacionesConsultora(int PaisID, long ConsultoraId)
        {

            var DANotificaciones = new DANotificaciones(PaisID);
            var notificaciones = new List<BENotificaciones>();
            using (IDataReader reader = DANotificaciones.GetNotificacionesConsultora(ConsultoraId))
                while (reader.Read())
                {
                    var entidad = new BENotificaciones(reader);
                    notificaciones.Add(entidad);
                }
            notificaciones.ForEach(Notificacion =>
            {
                Notificacion.Observaciones = Notificacion.Observaciones.Replace("Tu pedido ha sido reservado con éxito. Para lograrlo se realizó lo siguiente:", "Tu pedido ha sido reservado con éxito. Para que el pedido pase correctamente, se ha tenido que realizar lo siguiente:");
            });
            return notificaciones;
        }

        public IList<BENotificacionesDetalle> GetNotificacionesConsultoraDetalle(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen) // R2073
        {

            var DANotificaciones = new DANotificaciones(PaisID);
            var notificaciones = new List<BENotificacionesDetalle>();
            using (IDataReader reader = DANotificaciones.GetNotificacionesConsultoraDetalle(ValAutomaticaPROLLogId, TipoOrigen)) // R2073
                while (reader.Read())
                {
                    var entidad = new BENotificacionesDetalle(reader);
                    notificaciones.Add(entidad);
                }

            return notificaciones;
        }

        public IList<BENotificacionesDetallePedido> GetNotificacionesConsultoraDetallePedido(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen) // R2073
        {
            var DANotificaciones = new DANotificaciones(PaisID);
            var notificacionespedido = new List<BENotificacionesDetallePedido>();
            using (IDataReader reader = DANotificaciones.GetNotificacionesConsultoraDetallePedido(ValAutomaticaPROLLogId, TipoOrigen)) // R2073
                while (reader.Read())
                {
                    var entidad = new BENotificacionesDetallePedido(reader);
                    notificacionespedido.Add(entidad);
                }

            return notificacionespedido;
        }

        public void UpdNotificacionesConsultoraVisualizacion(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen) // R2073
        {
            var DANotificaciones = new DANotificaciones(PaisID);
            DANotificaciones.UpdNotificacionesConsultoraVisualizacion(ValAutomaticaPROLLogId, TipoOrigen); // R2073
        }

        //RQ_NS - R2133
        public IList<BENotificacionesDetallePedido> GetValidacionStockProductos(int PaisID, long ConsultoraId, long ValAutomaticaPROLLogId)
        {
            var DANotificaciones = new DANotificaciones(PaisID);
            var notificacionespedido = new List<BENotificacionesDetallePedido>();

            try
            {
                using (IDataReader reader = DANotificaciones.GetValidacionStockProductos(ConsultoraId, ValAutomaticaPROLLogId))
                    while (reader.Read())
                    {
                        var entidad = new BENotificacionesDetallePedido(reader);
                        notificacionespedido.Add(entidad);
                    }
            }
            catch { }

            return notificacionespedido;
        }

        //RQ_FP - R2161        
        public String GetFechaPromesaCronogramaByCampania(int PaisID, int CampaniaId, string CodigoConsultora, DateTime Fechafact)
        {
            var DANotificaciones = new DANotificaciones(PaisID);
            return DANotificaciones.GetFechaPromesaCronogramaByCampania(CampaniaId, CodigoConsultora, Fechafact);
        }
        
        //R2319- JLCS
        public void UpdNotificacionSolicitudClienteVisualizacion(int PaisID, long SolicitudClienteId)
        {
            var DANotificaciones = new DANotificaciones(PaisID);
            DANotificaciones.UpdNotificacionSolicitudClienteVisualizacion(SolicitudClienteId);
        }

    }
}
