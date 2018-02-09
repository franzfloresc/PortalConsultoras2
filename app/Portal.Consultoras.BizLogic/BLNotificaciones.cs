using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLNotificaciones
    {
        public IList<BENotificaciones> GetNotificacionesConsultora(int PaisID, long ConsultoraId, int indicadorBloqueoCDR, bool tienePagoEnLinea)
        {
            var daNotificaciones = new DANotificaciones(PaisID);
            var notificaciones = new List<BENotificaciones>();
            using (IDataReader reader = daNotificaciones.GetNotificacionesConsultora(ConsultoraId, indicadorBloqueoCDR, tienePagoEnLinea))
                while (reader.Read())
                {
                    var entidad = new BENotificaciones(reader);
                    notificaciones.Add(entidad);
                }
            notificaciones.ForEach(notificacion =>
            {
                notificacion.Observaciones = notificacion.Observaciones.Replace("Tu pedido ha sido reservado con éxito. Para lograrlo se realizó lo siguiente:", "Tu pedido ha sido reservado con éxito. Para que el pedido pase correctamente, se ha tenido que realizar lo siguiente:");
            });
            return notificaciones;
        }

        public int GetNotificacionesSinLeer(int PaisID, long ConsultoraId, int indicadorBloqueoCDR)
        {
            var daNotificaciones = new DANotificaciones(PaisID);
            return daNotificaciones.GetNotificacionesSinLeer(ConsultoraId, indicadorBloqueoCDR);
        }    

        public IList<BENotificacionesDetalle> GetNotificacionesConsultoraDetalle(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen) 
        {

            var daNotificaciones = new DANotificaciones(PaisID);
            var notificaciones = new List<BENotificacionesDetalle>();
            using (IDataReader reader = daNotificaciones.GetNotificacionesConsultoraDetalle(ValAutomaticaPROLLogId, TipoOrigen)) 
                while (reader.Read())
                {
                    var entidad = new BENotificacionesDetalle(reader);
                    notificaciones.Add(entidad);
                }

            return notificaciones;
        }

        public IList<BENotificacionesDetallePedido> GetNotificacionesConsultoraDetallePedido(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen) 
        {
            var daNotificaciones = new DANotificaciones(PaisID);
            var notificacionespedido = new List<BENotificacionesDetallePedido>();
            using (IDataReader reader = daNotificaciones.GetNotificacionesConsultoraDetallePedido(ValAutomaticaPROLLogId, TipoOrigen)) 
                while (reader.Read())
                {
                    var entidad = new BENotificacionesDetallePedido(reader);
                    notificacionespedido.Add(entidad);
                }

            return notificacionespedido;
        }

        public void UpdNotificacionesConsultoraVisualizacion(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen) 
        {
            var daNotificaciones = new DANotificaciones(PaisID);
            daNotificaciones.UpdNotificacionesConsultoraVisualizacion(ValAutomaticaPROLLogId, TipoOrigen); 
        }

        public IList<BENotificacionesDetallePedido> GetValidacionStockProductos(int PaisID, long ConsultoraId, long ValAutomaticaPROLLogId)
        {
            var daNotificaciones = new DANotificaciones(PaisID);
            var notificacionespedido = new List<BENotificacionesDetallePedido>();

            try
            {
                using (IDataReader reader = daNotificaciones.GetValidacionStockProductos(ConsultoraId, ValAutomaticaPROLLogId))
                    while (reader.Read())
                    {
                        var entidad = new BENotificacionesDetallePedido(reader);
                        notificacionespedido.Add(entidad);
                    }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, ConsultoraId.ToString(), PaisID.ToString());
            }

            return notificacionespedido;
        }

        public String GetFechaPromesaCronogramaByCampania(int PaisID, int CampaniaId, string CodigoConsultora, DateTime Fechafact)
        {
            var daNotificaciones = new DANotificaciones(PaisID);
            return daNotificaciones.GetFechaPromesaCronogramaByCampania(CampaniaId, CodigoConsultora, Fechafact);
        }
        
        public void UpdNotificacionSolicitudClienteVisualizacion(int PaisID, long SolicitudClienteId)
        {
            var daNotificaciones = new DANotificaciones(PaisID);
            daNotificaciones.UpdNotificacionSolicitudClienteVisualizacion(SolicitudClienteId);
        }

    }
}
