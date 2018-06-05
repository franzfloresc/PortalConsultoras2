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
                PagoEnLineaResultadoLogId = Convert.ToInt32(datarec["PagoEnLineaResultadoLogId"]);
            if (DataRecord.HasColumn(datarec, "ConsultoraId"))
                ConsultoraId = Convert.ToInt64(datarec["ConsultoraId"]);            
            if (DataRecord.HasColumn(datarec, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(datarec["CodigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "NumeroDocumento"))
                NumeroDocumento = Convert.ToString(datarec["NumeroDocumento"]);
            if (DataRecord.HasColumn(datarec, "CampaniaId"))
                CampaniaId = Convert.ToInt32(datarec["CampaniaId"]);
            if (DataRecord.HasColumn(datarec, "FechaVencimiento"))
                FechaVencimiento = Convert.ToDateTime(datarec["FechaVencimiento"]);            
            if (DataRecord.HasColumn(datarec, "MontoPago"))
                MontoPago = Convert.ToDecimal(datarec["MontoPago"]);
            if (DataRecord.HasColumn(datarec, "MontoGastosAdministrativos"))
                MontoGastosAdministrativos = Convert.ToDecimal(datarec["MontoGastosAdministrativos"]);
            if (DataRecord.HasColumn(datarec, "TipoTarjeta"))
                TipoTarjeta = Convert.ToString(datarec["TipoTarjeta"]);
            if (DataRecord.HasColumn(datarec, "CodigoError"))
                CodigoError = Convert.ToString(datarec["CodigoError"]);
            if (DataRecord.HasColumn(datarec, "MensajeError"))
                MensajeError = Convert.ToString(datarec["MensajeError"]);
            if (DataRecord.HasColumn(datarec, "IdGuidTransaccion"))
                IdGuidTransaccion = Convert.ToString(datarec["IdGuidTransaccion"]);
            if (DataRecord.HasColumn(datarec, "IdGuidExternoTransaccion"))
                IdGuidExternoTransaccion = Convert.ToString(datarec["IdGuidExternoTransaccion"]);
            if (DataRecord.HasColumn(datarec, "MerchantId"))
                MerchantId = Convert.ToString(datarec["MerchantId"]);
            if (DataRecord.HasColumn(datarec, "IdTokenUsuario"))
                IdTokenUsuario = Convert.ToString(datarec["IdTokenUsuario"]);
            if (DataRecord.HasColumn(datarec, "AliasNameTarjeta"))
                AliasNameTarjeta = Convert.ToString(datarec["AliasNameTarjeta"]);
            if (DataRecord.HasColumn(datarec, "FechaTransaccion"))
                FechaTransaccion = Convert.ToDateTime(datarec["FechaTransaccion"]);
            if (DataRecord.HasColumn(datarec, "ResultadoValidacionCVV2"))
                ResultadoValidacionCVV2 = Convert.ToString(datarec["ResultadoValidacionCVV2"]);
            if (DataRecord.HasColumn(datarec, "CsiMensaje"))
                CsiMensaje = Convert.ToString(datarec["CsiMensaje"]);
            if (DataRecord.HasColumn(datarec, "IdUnicoTransaccion"))
                IdUnicoTransaccion = Convert.ToString(datarec["IdUnicoTransaccion"]);
            if (DataRecord.HasColumn(datarec, "Etiqueta"))
                Etiqueta = Convert.ToString(datarec["Etiqueta"]);
            if (DataRecord.HasColumn(datarec, "RespuestaSistemAntifraude"))
                RespuestaSistemAntifraude = Convert.ToString(datarec["RespuestaSistemAntifraude"]);
            if (DataRecord.HasColumn(datarec, "CsiPorcentajeDescuento"))
                CsiPorcentajeDescuento = Convert.ToDecimal(datarec["CsiPorcentajeDescuento"]);
            if (DataRecord.HasColumn(datarec, "NumeroCuota"))
                NumeroCuota = Convert.ToString(datarec["NumeroCuota"]);
            if (DataRecord.HasColumn(datarec, "TokenTarjetaGuardada"))
                TokenTarjetaGuardada = Convert.ToString(datarec["TokenTarjetaGuardada"]);
            if (DataRecord.HasColumn(datarec, "CsiImporteComercio"))
                CsiImporteComercio = Convert.ToDecimal(datarec["CsiImporteComercio"]);
            if (DataRecord.HasColumn(datarec, "CsiCodigoPrograma"))
                CsiCodigoPrograma = Convert.ToString(datarec["CsiCodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "DescripcionIndicadorComercioElectronico"))
                DescripcionIndicadorComercioElectronico = Convert.ToString(datarec["DescripcionIndicadorComercioElectronico"]);
            if (DataRecord.HasColumn(datarec, "IndicadorComercioElectronico"))
                IndicadorComercioElectronico = Convert.ToString(datarec["IndicadorComercioElectronico"]);
            if (DataRecord.HasColumn(datarec, "DescripcionCodigoAccion"))
                DescripcionCodigoAccion = Convert.ToString(datarec["DescripcionCodigoAccion"]);
            if (DataRecord.HasColumn(datarec, "NombreBancoEmisor"))
                NombreBancoEmisor = Convert.ToString(datarec["NombreBancoEmisor"]);
            if (DataRecord.HasColumn(datarec, "ImporteCuota"))
                ImporteCuota = Convert.ToDecimal(datarec["ImporteCuota"]);
            if (DataRecord.HasColumn(datarec, "CsiTipoCobro"))
                CsiTipoCobro = Convert.ToString(datarec["CsiTipoCobro"]);
            if (DataRecord.HasColumn(datarec, "NumeroReferencia"))
                NumeroReferencia = Convert.ToString(datarec["NumeroReferencia"]);
            if (DataRecord.HasColumn(datarec, "Respuesta"))
                Respuesta = Convert.ToString(datarec["Respuesta"]);
            if (DataRecord.HasColumn(datarec, "NumeroOrdenTienda"))
                NumeroOrdenTienda = Convert.ToString(datarec["NumeroOrdenTienda"]);
            if (DataRecord.HasColumn(datarec, "CodigoAccion"))
                CodigoAccion = Convert.ToString(datarec["CodigoAccion"]);
            if (DataRecord.HasColumn(datarec, "ImporteAutorizado"))
                ImporteAutorizado = Convert.ToDecimal(datarec["ImporteAutorizado"]);
            if (DataRecord.HasColumn(datarec, "CodigoAutorizacion"))
                CodigoAutorizacion = Convert.ToString(datarec["CodigoAutorizacion"]);
            if (DataRecord.HasColumn(datarec, "CodigoTienda"))
                CodigoTienda = Convert.ToString(datarec["CodigoTienda"]);
            if (DataRecord.HasColumn(datarec, "NumeroTarjeta"))
                NumeroTarjeta = Convert.ToString(datarec["NumeroTarjeta"]);
            if (DataRecord.HasColumn(datarec, "OrigenTarjeta"))
                OrigenTarjeta = Convert.ToString(datarec["OrigenTarjeta"]);
            if (DataRecord.HasColumn(datarec, "EstadoSsicc"))
                EstadoSsicc = Convert.ToInt32(datarec["EstadoSsicc"]);
            if (DataRecord.HasColumn(datarec, "Visualizado"))
                Visualizado = Convert.ToBoolean(datarec["Visualizado"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion"))
                UsuarioCreacion = Convert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(datarec["UsuarioModificacion"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(datarec["FechaModificacion"]);
        }

    }
}
