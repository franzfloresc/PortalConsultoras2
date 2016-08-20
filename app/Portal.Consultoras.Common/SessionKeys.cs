using System;
using System.Web;

namespace Portal.Consultoras.Common
{
    public static class SessionKeys
    {
        #region Cantidad Productos

        private const string KeyFechaGetCantidadProductos = "fechaGetCantidadProductos";
        private const string KeyCantidadGetCantidadProductos = "cantidadGetCantidadProductos";
        private const int RefrescoGetCantidadProductos = 30; //Lapso de tiempo en Minutos

        public static void ClearSessionCantidadProductos()
        {
            HttpContext.Current.Session["PedidoWeb"] = null;
            HttpContext.Current.Session[KeyFechaGetCantidadProductos] = null;
            HttpContext.Current.Session[KeyCantidadGetCantidadProductos] = null;
        }

        public static bool CheckDataSessionCantidadProductos()
        {
            if (HttpContext.Current.Session[KeyFechaGetCantidadProductos] != null &&
                HttpContext.Current.Session[KeyCantidadGetCantidadProductos] != null)
            {
                var fecha = Convert.ToDateTime(HttpContext.Current.Session[KeyFechaGetCantidadProductos]);
                var diferencia = DateTime.Now - fecha;
                if (diferencia.TotalMinutes > RefrescoGetCantidadProductos)
                    return false;
                return true;
            }
            return false;
        }

        public static int GetDataSessionCantidadProductos()
        {
            return Convert.ToInt32(HttpContext.Current.Session[KeyCantidadGetCantidadProductos]);
        }

        public static void SetDataSessionCantidadProductos(int cantidadProductos)
        {
            HttpContext.Current.Session[KeyFechaGetCantidadProductos] = DateTime.Now;
            HttpContext.Current.Session[KeyCantidadGetCantidadProductos] = cantidadProductos;
        }

        #endregion

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

        #region Resumen de Campaña

        private const string KeyFechaGetResumenCampania = "fechaGetResumenCampania";
        private const string KeyDatosGetResumenCampania = "datosGetResumenCampania";
        private const int RefrescoGetResumenCampania = 30; //Lapso de tiempo en Minutos

        public static void ClearSessionResumenCampania()
        {
            HttpContext.Current.Session[KeyFechaGetResumenCampania] = null;
            HttpContext.Current.Session[KeyDatosGetResumenCampania] = null;
        }

        public static bool CheckDataSessionResumenCampania()
        {
            if (HttpContext.Current.Session[KeyFechaGetResumenCampania] != null &&
                HttpContext.Current.Session[KeyDatosGetResumenCampania] != null)
            {
                var fecha = Convert.ToDateTime(HttpContext.Current.Session[KeyFechaGetResumenCampania]);
                var diferencia = DateTime.Now - fecha;
                if (diferencia.TotalMinutes > RefrescoGetResumenCampania)
                    return false;
                return true;
            }
            return false;
        }

        public static dynamic GetDataSessionResumenCampania()
        {
            return HttpContext.Current.Session[KeyDatosGetResumenCampania];
        }

        public static void SetDataSessionResumenCampania(dynamic resumen)
        {
            HttpContext.Current.Session[KeyFechaGetResumenCampania] = DateTime.Now;
            HttpContext.Current.Session[KeyDatosGetResumenCampania] = resumen;
        }

        #endregion
    }
}
