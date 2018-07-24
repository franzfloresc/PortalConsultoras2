using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLineaResultadoLog
    {
        [DataMember]
        public int PagoEnLineaResultadoLogId { get; set; }
        [DataMember]
        public long ConsultoraId { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public DateTime FechaVencimiento { get; set; }
        [DataMember]
        public decimal MontoPago { get; set; }
        [DataMember]
        public decimal MontoGastosAdministrativos { get; set; }
        [DataMember]
        public string TipoTarjeta { get; set; }
        [DataMember]
        public string CodigoError { get; set; }
        [DataMember]
        public string MensajeError { get; set; }
        [DataMember]
        public string IdGuidTransaccion { get; set; }
        [DataMember]
        public string IdGuidExternoTransaccion { get; set; }
        [DataMember]
        public string MerchantId { get; set; }
        [DataMember]
        public string IdTokenUsuario { get; set; }
        [DataMember]
        public string AliasNameTarjeta { get; set; }
        [DataMember]
        public DateTime FechaTransaccion { get; set; }
        [DataMember]
        public string ResultadoValidacionCVV2 { get; set; }
        [DataMember]
        public string CsiMensaje { get; set; }
        [DataMember]
        public string IdUnicoTransaccion { get; set; }
        [DataMember]
        public string Etiqueta { get; set; }
        [DataMember]
        public string RespuestaSistemAntifraude { get; set; }
        [DataMember]
        public decimal CsiPorcentajeDescuento { get; set; }
        [DataMember]
        public string NumeroCuota { get; set; }
        [DataMember]
        public string TokenTarjetaGuardada { get; set; }
        [DataMember]
        public decimal CsiImporteComercio { get; set; }
        [DataMember]
        public string CsiCodigoPrograma { get; set; }
        [DataMember]
        public string DescripcionIndicadorComercioElectronico { get; set; }
        [DataMember]
        public string IndicadorComercioElectronico { get; set; }
        [DataMember]
        public string DescripcionCodigoAccion { get; set; }
        [DataMember]
        public string NombreBancoEmisor { get; set; }
        [DataMember]
        public decimal ImporteCuota { get; set; }
        [DataMember]
        public string CsiTipoCobro { get; set; }
        [DataMember]
        public string NumeroReferencia { get; set; }
        [DataMember]
        public string Respuesta { get; set; }
        [DataMember]
        public string NumeroOrdenTienda { get; set; }
        [DataMember]
        public string CodigoAccion { get; set; }
        [DataMember]
        public decimal ImporteAutorizado { get; set; }
        [DataMember]
        public string CodigoAutorizacion { get; set; }
        [DataMember]
        public string CodigoTienda { get; set; }
        [DataMember]
        public string NumeroTarjeta { get; set; }
        [DataMember]
        public string OrigenTarjeta { get; set; }
        [DataMember]
        public int EstadoSsicc { get; set; }
        [DataMember]
        public bool Visualizado { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }

        public BEPagoEnLineaResultadoLog(IDataRecord row)
        {
            PagoEnLineaResultadoLogId = row.ToInt32("PagoEnLineaResultadoLogId");
            ConsultoraId = row.ToInt64("ConsultoraId");
            CodigoConsultora = row.ToString("CodigoConsultora");
            NumeroDocumento = row.ToString("NumeroDocumento");
            CampaniaId = row.ToInt32("CampaniaId");
            FechaVencimiento = row.ToDateTime("FechaVencimiento");
            MontoPago = row.ToDecimal("MontoPago");
            MontoGastosAdministrativos = row.ToDecimal("MontoGastosAdministrativos");
            TipoTarjeta = row.ToString("TipoTarjeta");
            CodigoError = row.ToString("CodigoError");
            MensajeError = row.ToString("MensajeError");
            IdGuidTransaccion = row.ToString("IdGuidTransaccion");
            IdGuidExternoTransaccion = row.ToString("IdGuidExternoTransaccion");
            MerchantId = row.ToString("MerchantId");
            IdTokenUsuario = row.ToString("IdTokenUsuario");
            AliasNameTarjeta = row.ToString("AliasNameTarjeta");
            FechaTransaccion = row.ToDateTime("FechaTransaccion");
            ResultadoValidacionCVV2 = row.ToString("ResultadoValidacionCVV2");
            CsiMensaje = row.ToString("CsiMensaje");
            IdUnicoTransaccion = row.ToString("IdUnicoTransaccion");
            Etiqueta = row.ToString("Etiqueta");
            RespuestaSistemAntifraude = row.ToString("RespuestaSistemAntifraude");
            CsiPorcentajeDescuento = row.ToDecimal("CsiPorcentajeDescuento");
            NumeroCuota = row.ToString("NumeroCuota");
            TokenTarjetaGuardada = row.ToString("TokenTarjetaGuardada");
            CsiImporteComercio = row.ToDecimal("CsiImporteComercio");
            CsiCodigoPrograma = row.ToString("CsiCodigoPrograma");
            DescripcionIndicadorComercioElectronico = row.ToString("DescripcionIndicadorComercioElectronico");
            IndicadorComercioElectronico = row.ToString("IndicadorComercioElectronico");
            DescripcionCodigoAccion = row.ToString("DescripcionCodigoAccion");
            NombreBancoEmisor = row.ToString("NombreBancoEmisor");
            ImporteCuota = row.ToDecimal("ImporteCuota");
            CsiTipoCobro = row.ToString("CsiTipoCobro");
            NumeroReferencia = row.ToString("NumeroReferencia");
            Respuesta = row.ToString("Respuesta");
            NumeroOrdenTienda = row.ToString("NumeroOrdenTienda");
            CodigoAccion = row.ToString("CodigoAccion");
            ImporteAutorizado = row.ToDecimal("ImporteAutorizado");
            CodigoAutorizacion = row.ToString("CodigoAutorizacion");
            CodigoTienda = row.ToString("CodigoTienda");
            NumeroTarjeta = row.ToString("NumeroTarjeta");
            OrigenTarjeta = row.ToString("OrigenTarjeta");
            EstadoSsicc = row.ToInt32("EstadoSsicc");
            Visualizado = row.ToBoolean("Visualizado");
            UsuarioCreacion = row.ToString("UsuarioCreacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
        }

    }
}
