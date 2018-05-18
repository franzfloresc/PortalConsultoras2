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

        public BEPagoEnLineaResultadoLog(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "PagoEnLineaResultadoLogId"))
                PagoEnLineaResultadoLogId = DbConvert.ToInt32(datarec["PagoEnLineaResultadoLogId"]);
            if (DataRecord.HasColumn(datarec, "ConsultoraId"))
                ConsultoraId = DbConvert.ToInt64(datarec["ConsultoraId"]);            
            if (DataRecord.HasColumn(datarec, "CodigoConsultora"))
                CodigoConsultora = DbConvert.ToString(datarec["CodigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "NumeroDocumento"))
                NumeroDocumento = DbConvert.ToString(datarec["NumeroDocumento"]);
            if (DataRecord.HasColumn(datarec, "CampaniaId"))
                CampaniaId = DbConvert.ToInt32(datarec["CampaniaId"]);
            if (DataRecord.HasColumn(datarec, "FechaVencimiento"))
                FechaVencimiento = DbConvert.ToDateTime(datarec["FechaVencimiento"]);            
            if (DataRecord.HasColumn(datarec, "MontoPago"))
                MontoPago = DbConvert.ToDecimal(datarec["MontoPago"]);
            if (DataRecord.HasColumn(datarec, "MontoGastosAdministrativos"))
                MontoGastosAdministrativos = DbConvert.ToDecimal(datarec["MontoGastosAdministrativos"]);
            if (DataRecord.HasColumn(datarec, "TipoTarjeta"))
                TipoTarjeta = DbConvert.ToString(datarec["TipoTarjeta"]);
            if (DataRecord.HasColumn(datarec, "CodigoError"))
                CodigoError = DbConvert.ToString(datarec["CodigoError"]);
            if (DataRecord.HasColumn(datarec, "MensajeError"))
                MensajeError = DbConvert.ToString(datarec["MensajeError"]);
            if (DataRecord.HasColumn(datarec, "IdGuidTransaccion"))
                IdGuidTransaccion = DbConvert.ToString(datarec["IdGuidTransaccion"]);
            if (DataRecord.HasColumn(datarec, "IdGuidExternoTransaccion"))
                IdGuidExternoTransaccion = DbConvert.ToString(datarec["IdGuidExternoTransaccion"]);
            if (DataRecord.HasColumn(datarec, "MerchantId"))
                MerchantId = DbConvert.ToString(datarec["MerchantId"]);
            if (DataRecord.HasColumn(datarec, "IdTokenUsuario"))
                IdTokenUsuario = DbConvert.ToString(datarec["IdTokenUsuario"]);
            if (DataRecord.HasColumn(datarec, "AliasNameTarjeta"))
                AliasNameTarjeta = DbConvert.ToString(datarec["AliasNameTarjeta"]);
            if (DataRecord.HasColumn(datarec, "FechaTransaccion"))
                FechaTransaccion = DbConvert.ToDateTime(datarec["FechaTransaccion"]);
            if (DataRecord.HasColumn(datarec, "ResultadoValidacionCVV2"))
                ResultadoValidacionCVV2 = DbConvert.ToString(datarec["ResultadoValidacionCVV2"]);
            if (DataRecord.HasColumn(datarec, "CsiMensaje"))
                CsiMensaje = DbConvert.ToString(datarec["CsiMensaje"]);
            if (DataRecord.HasColumn(datarec, "IdUnicoTransaccion"))
                IdUnicoTransaccion = DbConvert.ToString(datarec["IdUnicoTransaccion"]);
            if (DataRecord.HasColumn(datarec, "Etiqueta"))
                Etiqueta = DbConvert.ToString(datarec["Etiqueta"]);
            if (DataRecord.HasColumn(datarec, "RespuestaSistemAntifraude"))
                RespuestaSistemAntifraude = DbConvert.ToString(datarec["RespuestaSistemAntifraude"]);
            if (DataRecord.HasColumn(datarec, "CsiPorcentajeDescuento"))
                CsiPorcentajeDescuento = DbConvert.ToDecimal(datarec["CsiPorcentajeDescuento"]);
            if (DataRecord.HasColumn(datarec, "NumeroCuota"))
                NumeroCuota = DbConvert.ToString(datarec["NumeroCuota"]);
            if (DataRecord.HasColumn(datarec, "TokenTarjetaGuardada"))
                TokenTarjetaGuardada = DbConvert.ToString(datarec["TokenTarjetaGuardada"]);
            if (DataRecord.HasColumn(datarec, "CsiImporteComercio"))
                CsiImporteComercio = DbConvert.ToDecimal(datarec["CsiImporteComercio"]);
            if (DataRecord.HasColumn(datarec, "CsiCodigoPrograma"))
                CsiCodigoPrograma = DbConvert.ToString(datarec["CsiCodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "DescripcionIndicadorComercioElectronico"))
                DescripcionIndicadorComercioElectronico = DbConvert.ToString(datarec["DescripcionIndicadorComercioElectronico"]);
            if (DataRecord.HasColumn(datarec, "IndicadorComercioElectronico"))
                IndicadorComercioElectronico = DbConvert.ToString(datarec["IndicadorComercioElectronico"]);
            if (DataRecord.HasColumn(datarec, "DescripcionCodigoAccion"))
                DescripcionCodigoAccion = DbConvert.ToString(datarec["DescripcionCodigoAccion"]);
            if (DataRecord.HasColumn(datarec, "NombreBancoEmisor"))
                NombreBancoEmisor = DbConvert.ToString(datarec["NombreBancoEmisor"]);
            if (DataRecord.HasColumn(datarec, "ImporteCuota"))
                ImporteCuota = DbConvert.ToDecimal(datarec["ImporteCuota"]);
            if (DataRecord.HasColumn(datarec, "CsiTipoCobro"))
                CsiTipoCobro = DbConvert.ToString(datarec["CsiTipoCobro"]);
            if (DataRecord.HasColumn(datarec, "NumeroReferencia"))
                NumeroReferencia = DbConvert.ToString(datarec["NumeroReferencia"]);
            if (DataRecord.HasColumn(datarec, "Respuesta"))
                Respuesta = DbConvert.ToString(datarec["Respuesta"]);
            if (DataRecord.HasColumn(datarec, "NumeroOrdenTienda"))
                NumeroOrdenTienda = DbConvert.ToString(datarec["NumeroOrdenTienda"]);
            if (DataRecord.HasColumn(datarec, "CodigoAccion"))
                CodigoAccion = DbConvert.ToString(datarec["CodigoAccion"]);
            if (DataRecord.HasColumn(datarec, "ImporteAutorizado"))
                ImporteAutorizado = DbConvert.ToDecimal(datarec["ImporteAutorizado"]);
            if (DataRecord.HasColumn(datarec, "CodigoAutorizacion"))
                CodigoAutorizacion = DbConvert.ToString(datarec["CodigoAutorizacion"]);
            if (DataRecord.HasColumn(datarec, "CodigoTienda"))
                CodigoTienda = DbConvert.ToString(datarec["CodigoTienda"]);
            if (DataRecord.HasColumn(datarec, "NumeroTarjeta"))
                NumeroTarjeta = DbConvert.ToString(datarec["NumeroTarjeta"]);
            if (DataRecord.HasColumn(datarec, "OrigenTarjeta"))
                OrigenTarjeta = DbConvert.ToString(datarec["OrigenTarjeta"]);
            if (DataRecord.HasColumn(datarec, "EstadoSsicc"))
                EstadoSsicc = DbConvert.ToInt32(datarec["EstadoSsicc"]);
            if (DataRecord.HasColumn(datarec, "Visualizado"))
                Visualizado = DbConvert.ToBoolean(datarec["Visualizado"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion"))
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion"))
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion"))
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion"))
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
        }

    }
}
