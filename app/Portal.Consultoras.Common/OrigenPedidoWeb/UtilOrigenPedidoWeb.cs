﻿namespace Portal.Consultoras.Common.OrigenPedidoWeb
{
    public static class UtilOrigenPedidoWeb
    {
        private static OrigenPedidoWebModel Formatear(OrigenPedidoWebModel modelo)
        {
            try
            {
                modelo = modelo ?? new OrigenPedidoWebModel();
                modelo.Dispositivo = (modelo.Dispositivo ?? "").Trim() ?? ConsOrigenPedidoWeb.IncorrectoDispositivo;
                modelo.Pagina = (modelo.Pagina ?? "").Trim() ?? ConsOrigenPedidoWeb.Incorrecto;
                modelo.Palanca = (modelo.Palanca ?? "").Trim() ?? ConsOrigenPedidoWeb.Incorrecto;
                modelo.Seccion = (modelo.Seccion ?? "").Trim() ?? ConsOrigenPedidoWeb.Incorrecto;
            }
            catch
            {
                // ignored
            }

            return modelo;
        }
        
        public static OrigenPedidoWebModel GetModelo(string origen)
        {
            var modelo = new OrigenPedidoWebModel();
            try
            {
                origen = origen ?? "";
                if (origen.Length < 7) return modelo;

                modelo.Dispositivo = origen.Substring(0, 1);
                modelo.Pagina = origen.Substring(1, 2);
                modelo.Palanca = origen.Substring(3, 2);
                modelo.Seccion = origen.Substring(5, 2);
                modelo = Formatear(modelo);
            }
            catch
            {
                // ignored
            }

            return modelo;
        }

        public static string ToStr(OrigenPedidoWebModel modelo)
        {
            try
            {
                modelo = Formatear(modelo);
                return string.Format(ConsOrigenPedidoWeb.StrFormat, modelo.Dispositivo, modelo.Pagina, modelo.Palanca, modelo.Seccion);
            }
            catch
            {
                // ignored
            }

            return "";
        }

        public static int ToInt(OrigenPedidoWebModel modelo)
        {
            try
            {
                string origenStr = ToStr(modelo);
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
        
        public static string GetSeccionSegunFicha(bool ficha, bool fichaCarrusel, bool desplegable = false)
        {
            string codigo = "";
            try
            {
                if (!ficha && !fichaCarrusel)
                {
                    codigo = desplegable ? ConsOrigenPedidoWeb.Seccion.DesplegableBuscador : ConsOrigenPedidoWeb.Seccion.Carrusel;
                }
                else if (ficha && !fichaCarrusel)
                {
                    codigo = ConsOrigenPedidoWeb.Seccion.Ficha;
                }
                else if (!ficha && fichaCarrusel)
                {
                    codigo = ConsOrigenPedidoWeb.Seccion.CarruselVerMas;
                }
            }
            catch
            {
                // ignored
            }

            return codigo;
        }

        public static string GetPalancaSegunMarca(int marcaId)
        {
            string codigo = "";
            try
            {

                if (marcaId == Constantes.Marca.LBel)
                {
                    codigo = ConsOrigenPedidoWeb.Palanca.CatalogoLbel;
                }
                else if (marcaId == Constantes.Marca.Esika)
                {
                    codigo = ConsOrigenPedidoWeb.Palanca.CatalogoEsika;
                }
                else if (marcaId == Constantes.Marca.Cyzone)
                {
                    codigo = ConsOrigenPedidoWeb.Palanca.CatalogoCyzone;
                }
            }
            catch
            {
                // ignored
            }

            return codigo;
        }
        
        public static string GetPalancaSegunTipoEstrategia(string codigoTipoEstrategia, bool materialGanancia = false, bool recomendaciones = false, bool suscripcion = true)
        {
            string codigo = "";
            try
            {
                switch (codigoTipoEstrategia)
                {
                    case Constantes.TipoEstrategiaCodigo.Liquidacion:
                        codigo = ConsOrigenPedidoWeb.Palanca.Liquidacion;
                        break;
                    case Constantes.TipoEstrategiaCodigo.ShowRoom:
                        codigo = ConsOrigenPedidoWeb.Palanca.Showroom;
                        break;
                    case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                        codigo = ConsOrigenPedidoWeb.Palanca.Lanzamientos;
                        break;
                    case Constantes.TipoEstrategiaCodigo.OfertaDelDia:
                        codigo = ConsOrigenPedidoWeb.Palanca.OfertaDelDia;
                        break;
                    case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
                        codigo = ConsOrigenPedidoWeb.Palanca.Gnd;
                        break;
                    case Constantes.TipoEstrategiaCodigo.HerramientasVenta:
                        codigo = ConsOrigenPedidoWeb.Palanca.HerramientasVenta;
                        break;
                    case Constantes.TipoEstrategiaCodigo.OfertaParaTi:
                    case Constantes.TipoEstrategiaCodigo.OfertasParaMi:
                    case Constantes.TipoEstrategiaCodigo.PackAltoDesembolso:

                        if (materialGanancia && (recomendaciones || suscripcion))
                        {
                            codigo = ConsOrigenPedidoWeb.Palanca.Ganadoras;
                        }
                        else
                        {
                            codigo = ConsOrigenPedidoWeb.Palanca.OfertasParaTi;
                        }
                        break;
                }
            }
            catch
            {
                // ignored
            }

            return codigo;
        }
    }
}
