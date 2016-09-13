using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLSolicitudClienteCatalogo
    {
        public int InsSolicitudClienteCatalogo(int paisID, string CodigoConsultora, string AsuntoNotificacion, string DetalleNotificacion, string Campania, string CorreoCliente, string NombreCliente, string Telefono, string DireccionCliente, bool parametroEsDocumento)
        {
            DASolicitudClienteCatalogo solicitudClienteCatalogo = new DASolicitudClienteCatalogo(paisID);
            return solicitudClienteCatalogo.InsSolicitudClienteCatalogo(CodigoConsultora, AsuntoNotificacion, DetalleNotificacion, Campania, CorreoCliente, NombreCliente, DateTime.Now, Telefono, DireccionCliente, parametroEsDocumento);
        }

        public void UpdNotificacionSolicitudClienteCatalogoVisualizacion(int PaisID, long SolicitudClienteCatalogoId)
        {
            DASolicitudClienteCatalogo DASolicitudClienteCatalogo = new DASolicitudClienteCatalogo(PaisID);
            DASolicitudClienteCatalogo.UpdNotificacionSolicitudClienteCatalogoVisualizacion(SolicitudClienteCatalogoId);
        }

        public BENotificacionesDetalleCatalogo ObtenerDetalleNotificacionCatalogo(int PaisID, long SolicitudClienteCatalagoId)
        {
            DASolicitudClienteCatalogo DASolicitudClienteCatalogo = new DASolicitudClienteCatalogo(PaisID);

            IDataReader reader = DASolicitudClienteCatalogo.ObtenerDetalleNotificacionCatalogo(SolicitudClienteCatalagoId);
            reader.Read();

            BENotificacionesDetalleCatalogo entidad = new BENotificacionesDetalleCatalogo(reader);

            return entidad;
        }
    }
}