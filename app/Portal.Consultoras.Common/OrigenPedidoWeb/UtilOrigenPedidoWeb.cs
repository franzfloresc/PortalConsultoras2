namespace Portal.Consultoras.Common.OrigenPedidoWeb
{
    public static class UtilOrigenPedidoWeb
    {
        public static string Formatear(OrigenPedidoWebModel modelo)
        {
            try
            {
                return string.Format(ConsOrigenPedidoWeb.StrFormat, modelo.Dispositivo, modelo.Pagina, modelo.Palanca, modelo.Seccion);
            }
            catch
            {
                // ignored
            }

            return "";
        }

        public static int FormatearInt(OrigenPedidoWebModel modelo)
        {
            try
            {
                string origenStr = Formatear(modelo);
                int origen;
                int.TryParse(origenStr, out origen);
                return origen;
            }
            catch
            {
                // ignored
            }

            return 0;
        }

    }
}
