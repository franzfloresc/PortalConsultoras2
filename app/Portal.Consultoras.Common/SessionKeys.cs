using System;
using System.Web;

namespace Portal.Consultoras.Common
{
    public static class SessionKeys
    {
        #region Cantidad Notificaciones

        private const string KeyFechaGetNotificacionesSinLeer = "fechaGetNotificacionesSinLeer";
        private const string KeyCantidadGetNotificacionesSinLeer = "cantidadGetNotificacionesSinLeer";
        private const int RefrescoGetNotificacionesSinLeer = 30; //Lapso de tiempo en Minutos

        public static void ClearSessionCantidadNotificaciones()
        {
            HttpContext.Current.Session[KeyFechaGetNotificacionesSinLeer] = null;
            HttpContext.Current.Session[KeyCantidadGetNotificacionesSinLeer] = null;
        }

        public static bool CheckDataSessionCantidadNotificaciones()
        {
            if (HttpContext.Current.Session[KeyFechaGetNotificacionesSinLeer] != null &&
                HttpContext.Current.Session[KeyCantidadGetNotificacionesSinLeer] != null)
            {
                var fecha = Convert.ToDateTime(HttpContext.Current.Session[KeyFechaGetNotificacionesSinLeer]);
                var diferencia = DateTime.Now - fecha;
                if (diferencia.TotalMinutes > RefrescoGetNotificacionesSinLeer)
                    return false;
                return true;
            }
            return false;
        }

        public static int GetDataSessionCantidadNotificaciones()
        {
            return Convert.ToInt32(HttpContext.Current.Session[KeyCantidadGetNotificacionesSinLeer]);
        }

        public static void SetDataSessionCantidadNotificaciones(int cantidadNotificaciones)
        {
            HttpContext.Current.Session[KeyFechaGetNotificacionesSinLeer] = DateTime.Now;
            HttpContext.Current.Session[KeyCantidadGetNotificacionesSinLeer] = cantidadNotificaciones;
        }

        #endregion
    }
}
