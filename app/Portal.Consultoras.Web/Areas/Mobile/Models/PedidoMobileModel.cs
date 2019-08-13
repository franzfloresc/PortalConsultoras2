﻿using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class PedidoMobileModel
    {
        public List<BEEstrategia> ListaEstrategias { get; set; }

        public int PaisId { get; set; }

        public string Simbolo { get; set; }

        public decimal Total { get; set; }

        public string TotalStr { get; set; }

        public string DescripcionTotal { get; set; }

        public decimal TotalMinimo { get; set; }

        public string TotalMinimoStr { get; set; }

        public string DescuentoStr { get; set; }

        public string MontoConDsctoStr { get; set; }

        public string DescripcionTotalMinimo { get; set; }

        public List<BEPedidoWebDetalle> ListaProductos { get; set; }

        public List<BEPedidoFICDetalle> ListaProductosFIC { get; set; }

        public int CantidadProductos { get; set; }

        public string CampaniaActual { get; set; }

        public string CampaniaNro { get; set; }

        public string DescripcionCampaniaActual
        {
            get
            {
                return "C-" + (string.IsNullOrEmpty(CampaniaActual) ? "00" : CampaniaActual.Substring(CampaniaActual.Length - 2));
            }
        }

        public string CodigoIso { get; set; }

        public List<ServiceCliente.BECliente> ListaClientes { get; set; }

        public int ClienteId { get; set; }

        public string Nombre { get; set; }

        public decimal MontoAhorroCatalogo { get; set; }

        public decimal MontoAhorroRevista { get; set; }

        public string GananciaFormat { get; set; }

        public string FormatoMontoAhorroRevista { get; set; }

        public string NombreConsultora { get; set; }

        public int TieneCupon { get; set; }

        public bool EmailActivo { get; set; }

        public string EMail { get; set; }

        public string Celular { get; set; }

        public int TieneMasVendidos { get; set; }

        public int TieneOfertaLog { get; set; }

        public PartialSectionBpt PartialSectionBpt { get; set; }

        public bool MostrarPopupPrecargados { get; set; }

        public int EstadoPedido { get; set; }
        public decimal? GananciaRevista { get; set; }
        public decimal? GananciaWeb { get; set; }
        public decimal? GananciaOtros { get; set; }

        public string FormatoMontoAhorroCatalogo
        {
            get
            {
                return Util.DecimalToStringFormat(MontoAhorroCatalogo, CodigoIso);
            }
        }
        public string FormatoGananciaRevista
        {
            get
            {
                if (GananciaRevista != null)
                    return Util.DecimalToStringFormat(GananciaRevista.Value, CodigoIso);
                else
                    return Util.DecimalToStringFormat(Decimal.Zero, CodigoIso);
            }
        }
        public string FormatoGananciaWeb
        {
            get
            {
                if (GananciaWeb != null)
                    return Util.DecimalToStringFormat(GananciaWeb.Value, CodigoIso);
                else
                    return Util.DecimalToStringFormat(Decimal.Zero, CodigoIso);
            }
        }
        public string FormatoGananciaOtros
        {
            get
            {
                if (GananciaOtros != null)
                    return Util.DecimalToStringFormat(GananciaOtros.Value, CodigoIso);
                else
                    return Util.DecimalToStringFormat(Decimal.Zero, CodigoIso);
            }
        }
        public string FormatoTotalMontoGanancia
        {
            get
            {
                if (GananciaOtros != null && GananciaWeb != null && GananciaRevista != null)
                    return Util.DecimalToStringFormat((GananciaOtros.Value + GananciaWeb.Value + GananciaRevista.Value + MontoAhorroCatalogo), CodigoIso);
                else
                    return Util.DecimalToStringFormat(Decimal.Zero, CodigoIso);
            }
        }

        #region CaminoBrillante
        public decimal montoIncentivo { get; set; }
        #endregion
    }
}