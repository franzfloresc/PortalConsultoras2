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
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        public int CampaniaId { get; set; }
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
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }

        public BEPagoEnLineaResultadoLog(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "PagoEnLineaResultadoLogId") && datarec["PagoEnLineaResultadoLogId"] != DBNull.Value)
                PagoEnLineaResultadoLogId = DbConvert.ToInt32(datarec["PagoEnLineaResultadoLogId"]);
            if (DataRecord.HasColumn(datarec, "CodigoConsultora") && datarec["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = DbConvert.ToString(datarec["CodigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "NumeroDocumento") && datarec["NumeroDocumento"] != DBNull.Value)
                NumeroDocumento = DbConvert.ToString(datarec["NumeroDocumento"]);
            if (DataRecord.HasColumn(datarec, "CampaniaId") && datarec["CampaniaId"] != DBNull.Value)
                CampaniaId = DbConvert.ToInt32(datarec["CampaniaId"]);
            if (DataRecord.HasColumn(datarec, "TipoTarjeta") && datarec["TipoTarjeta"] != DBNull.Value)
                TipoTarjeta = DbConvert.ToString(datarec["TipoTarjeta"]);
            if (DataRecord.HasColumn(datarec, "CodigoError") && datarec["CodigoError"] != DBNull.Value)
                CodigoError = DbConvert.ToString(datarec["CodigoError"]);
            if (DataRecord.HasColumn(datarec, "MensajeError") && datarec["MensajeError"] != DBNull.Value)
                MensajeError = DbConvert.ToString(datarec["MensajeError"]);
            if (DataRecord.HasColumn(datarec, "IdGuidTransaccion") && datarec["IdGuidTransaccion"] != DBNull.Value)
                IdGuidTransaccion = DbConvert.ToString(datarec["IdGuidTransaccion"]);
            if (DataRecord.HasColumn(datarec, "IdGuidExternoTransaccion") && datarec["IdGuidExternoTransaccion"] != DBNull.Value)
                IdGuidExternoTransaccion = DbConvert.ToString(datarec["IdGuidExternoTransaccion"]);
            if (DataRecord.HasColumn(datarec, "MerchantId") && datarec["MerchantId"] != DBNull.Value)
                MerchantId = DbConvert.ToString(datarec["MerchantId"]);
            if (DataRecord.HasColumn(datarec, "IdTokenUsuario") && datarec["IdTokenUsuario"] != DBNull.Value)
                IdTokenUsuario = DbConvert.ToString(datarec["IdTokenUsuario"]);
            if (DataRecord.HasColumn(datarec, "AliasNameTarjeta") && datarec["AliasNameTarjeta"] != DBNull.Value)
                AliasNameTarjeta = DbConvert.ToString(datarec["AliasNameTarjeta"]);
            if (DataRecord.HasColumn(datarec, "FechaTransaccion") && datarec["FechaTransaccion"] != DBNull.Value)
                FechaTransaccion = DbConvert.ToDateTime(datarec["FechaTransaccion"]);
            if (DataRecord.HasColumn(datarec, "ResultadoValidacionCVV2") && datarec["ResultadoValidacionCVV2"] != DBNull.Value)
                ResultadoValidacionCVV2 = DbConvert.ToString(datarec["ResultadoValidacionCVV2"]);
            if (DataRecord.HasColumn(datarec, "CsiMensaje") && datarec["CsiMensaje"] != DBNull.Value)
                CsiMensaje = DbConvert.ToString(datarec["CsiMensaje"]);
            if (DataRecord.HasColumn(datarec, "IdUnicoTransaccion") && datarec["IdUnicoTransaccion"] != DBNull.Value)
                IdUnicoTransaccion = DbConvert.ToString(datarec["IdUnicoTransaccion"]);
            if (DataRecord.HasColumn(datarec, "Etiqueta") && datarec["Etiqueta"] != DBNull.Value)
                Etiqueta = DbConvert.ToString(datarec["Etiqueta"]);
            if (DataRecord.HasColumn(datarec, "RespuestaSistemAntifraude") && datarec["RespuestaSistemAntifraude"] != DBNull.Value)
                RespuestaSistemAntifraude = DbConvert.ToString(datarec["RespuestaSistemAntifraude"]);
            if (DataRecord.HasColumn(datarec, "CsiPorcentajeDescuento") && datarec["CsiPorcentajeDescuento"] != DBNull.Value)
                CsiPorcentajeDescuento = DbConvert.ToDecimal(datarec["CsiPorcentajeDescuento"]);
            if (DataRecord.HasColumn(datarec, "NumeroCuota") && datarec["NumeroCuota"] != DBNull.Value)
                NumeroCuota = DbConvert.ToString(datarec["NumeroCuota"]);
            if (DataRecord.HasColumn(datarec, "TokenTarjetaGuardada") && datarec["TokenTarjetaGuardada"] != DBNull.Value)
                TokenTarjetaGuardada = DbConvert.ToString(datarec["TokenTarjetaGuardada"]);
            if (DataRecord.HasColumn(datarec, "CsiImporteComercio") && datarec["CsiImporteComercio"] != DBNull.Value)
                CsiImporteComercio = DbConvert.ToDecimal(datarec["CsiImporteComercio"]);
            if (DataRecord.HasColumn(datarec, "CsiCodigoPrograma") && datarec["CsiCodigoPrograma"] != DBNull.Value)
                CsiCodigoPrograma = DbConvert.ToString(datarec["CsiCodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "DescripcionIndicadorComercioElectronico") && datarec["DescripcionIndicadorComercioElectronico"] != DBNull.Value)
                DescripcionIndicadorComercioElectronico = DbConvert.ToString(datarec["DescripcionIndicadorComercioElectronico"]);
            if (DataRecord.HasColumn(datarec, "IndicadorComercioElectronico") && datarec["IndicadorComercioElectronico"] != DBNull.Value)
                IndicadorComercioElectronico = DbConvert.ToString(datarec["IndicadorComercioElectronico"]);
            if (DataRecord.HasColumn(datarec, "DescripcionCodigoAccion") && datarec["DescripcionCodigoAccion"] != DBNull.Value)
                DescripcionCodigoAccion = DbConvert.ToString(datarec["DescripcionCodigoAccion"]);
            if (DataRecord.HasColumn(datarec, "NombreBancoEmisor") && datarec["NombreBancoEmisor"] != DBNull.Value)
                NombreBancoEmisor = DbConvert.ToString(datarec["NombreBancoEmisor"]);
            if (DataRecord.HasColumn(datarec, "ImporteCuota") && datarec["ImporteCuota"] != DBNull.Value)
                ImporteCuota = DbConvert.ToDecimal(datarec["ImporteCuota"]);
            if (DataRecord.HasColumn(datarec, "CsiTipoCobro") && datarec["CsiTipoCobro"] != DBNull.Value)
                CsiTipoCobro = DbConvert.ToString(datarec["CsiTipoCobro"]);
            if (DataRecord.HasColumn(datarec, "NumeroReferencia") && datarec["NumeroReferencia"] != DBNull.Value)
                NumeroReferencia = DbConvert.ToString(datarec["NumeroReferencia"]);
            if (DataRecord.HasColumn(datarec, "Respuesta") && datarec["Respuesta"] != DBNull.Value)
                Respuesta = DbConvert.ToString(datarec["Respuesta"]);
            if (DataRecord.HasColumn(datarec, "NumeroOrdenTienda") && datarec["NumeroOrdenTienda"] != DBNull.Value)
                NumeroOrdenTienda = DbConvert.ToString(datarec["NumeroOrdenTienda"]);
            if (DataRecord.HasColumn(datarec, "CodigoAccion") && datarec["CodigoAccion"] != DBNull.Value)
                CodigoAccion = DbConvert.ToString(datarec["CodigoAccion"]);
            if (DataRecord.HasColumn(datarec, "ImporteAutorizado") && datarec["ImporteAutorizado"] != DBNull.Value)
                ImporteAutorizado = DbConvert.ToDecimal(datarec["ImporteAutorizado"]);
            if (DataRecord.HasColumn(datarec, "CodigoAutorizacion") && datarec["CodigoAutorizacion"] != DBNull.Value)
                CodigoAutorizacion = DbConvert.ToString(datarec["CodigoAutorizacion"]);
            if (DataRecord.HasColumn(datarec, "CodigoTienda") && datarec["CodigoTienda"] != DBNull.Value)
                CodigoTienda = DbConvert.ToString(datarec["CodigoTienda"]);
            if (DataRecord.HasColumn(datarec, "NumeroTarjeta") && datarec["NumeroTarjeta"] != DBNull.Value)
                NumeroTarjeta = DbConvert.ToString(datarec["NumeroTarjeta"]);
            if (DataRecord.HasColumn(datarec, "OrigenTarjeta") && datarec["OrigenTarjeta"] != DBNull.Value)
                OrigenTarjeta = DbConvert.ToString(datarec["OrigenTarjeta"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion") && datarec["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion") && datarec["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion") && datarec["FechaCreacion"] != DBNull.Value)
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion") && datarec["FechaModificacion"] != DBNull.Value)
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
        }

    }
}
