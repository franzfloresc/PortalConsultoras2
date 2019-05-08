﻿using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoEnLineaModel
    {
        public string CodigoIso { get; set; }
        public string Simbolo { get; set; }
        public decimal MontoDeuda { get; set; }
        public DateTime FechaVencimiento { get; set; }
        public int AplicaPorcentaje { get; set; }

        public decimal PorcentajeGastosAdministrativos { get; set; }

        public PagoVisaModel PagoVisaModel { get; set; }

        public List<PagoEnLineaTipoPagoModel> ListaTipoPago { get; set; }

        public List<PagoEnLineaMedioPagoModel> ListaMedioPago { get; set; }

        public List<PagoEnLineaMedioPagoDetalleModel> ListaMetodoPago { get; set; }
        public PagoEnLineaMedioPagoDetalleModel MetodoPagoSeleccionado { get; set; }

        #region Propiedades luego de la respuesta de la pasarela de pago

        public int PagoEnLineaResultadoLogId { get; set; }
        public string NombreConsultora { get; set; }
        public string PrimerApellido { get; set; }
        public string TarjetaEnmascarada { get; set; }
        public string NumeroOperacion { get; set; }
        public decimal SaldoPendiente { get; set; }
        public string MensajeInformacionPagoExitoso { get; set; }
        public string DescripcionCodigoAccion { get; set; }

        #endregion

        #region Propiedad para notificaciones

        public decimal MontoGastosAdministrativosNot { get; set; }
        public decimal MontoDeudaConGastosNot { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string MontoGastosAdministrativosNotString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoGastosAdministrativosNot, CodigoIso);
            }
        }
        public string MontoDeudaConGastosNotString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoDeudaConGastosNot, CodigoIso);
            }
        }
        public string FechaCreacionString
        {
            get
            {
                return FechaCreacion.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : FechaCreacion.ToString("dd/MM/yyyy HH:mm");
            }
        }

        #endregion

        public int origen { get; set; }

        public string MontoDeudaString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoDeuda, CodigoIso);
            }
        }

        public string FechaVencimientoString
        {
            get
            {
                return FechaVencimiento.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : FechaVencimiento.ToString("dd/MM/yyyy");
            }
        }

        public decimal MontoGastosAdministrativosBruto
        {
            get
            {
                return decimal.Round(MontoDeuda * (PorcentajeGastosAdministrativos / 100), 2);
            }
        }

        public string MontoGastosAdministrativosBrutoString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoGastosAdministrativosBruto, CodigoIso);
            }
        }
       
        public decimal MontoGastosAdministrativos
        {
            get
            {
                return AplicaPorcentaje == 1 ? decimal.Round(MontoDeuda * (PorcentajeGastosAdministrativos / 100), 2) : 0;
            }
        }

        public string MontoGastosAdministrativosString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoGastosAdministrativos, CodigoIso);
            }
        }

        public decimal MontoDeudaConGastos
        {
            get
            {
                return AplicaPorcentaje == 1 ? decimal.Round(MontoDeuda * (1 + PorcentajeGastosAdministrativos / 100), 2) : decimal.Round(MontoDeuda, 2);
            }
        }

        public string MontoDeudaConGastosString
        {
            get
            {
                return Util.DecimalToStringFormat(MontoDeudaConGastos, CodigoIso);
            }
        }

        public string SaldoPendienteString
        {
            get
            {
                return Util.DecimalToStringFormat(SaldoPendiente, CodigoIso);
            }
        }

        public string DeviceSessionId { get; set; }
        public string TipoPago { get; set; }
        public string NumeroReferencia { get; set; }
        public bool EsMobile { get; set; }
        public string Bancos { get; set; }

        public PagoEnLineaModel()
        {
            EsMobile = false;
        }

    }
}