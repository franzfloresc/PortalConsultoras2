using Portal.Consultoras.Entities.PagoEnLinea;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.PagoEnLinea
{
    public class DAPagoEnLinea: DataAccess
    {
        public DAPagoEnLinea(int paisId)
            : base(paisId, EDbSource.Portal)
        {

        }

        public int InsertPagoEnLineaResultadoLog(BEPagoEnLineaResultadoLog entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertPagoEnLineaResultadoLog");
            Context.Database.AddOutParameter(command, "@PagoEnLineaResultadoLogId", DbType.Int32, 4);
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int32, entidad.ConsultoraId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, entidad.CodigoConsultora);
            Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.AnsiString, entidad.NumeroDocumento);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, entidad.CampaniaId);
            Context.Database.AddInParameter(command, "@FechaVencimiento", DbType.DateTime, entidad.FechaVencimiento);
            Context.Database.AddInParameter(command, "@MontoPago", DbType.Decimal, entidad.MontoPago);
            Context.Database.AddInParameter(command, "@MontoGastosAdministrativos", DbType.Decimal, entidad.MontoGastosAdministrativos);
            Context.Database.AddInParameter(command, "@TipoTarjeta", DbType.AnsiString, entidad.TipoTarjeta);
            Context.Database.AddInParameter(command, "@CodigoError", DbType.AnsiString, entidad.CodigoError);
            Context.Database.AddInParameter(command, "@MensajeError", DbType.AnsiString, entidad.MensajeError);
            Context.Database.AddInParameter(command, "@IdGuidTransaccion", DbType.AnsiString, entidad.IdGuidTransaccion);
            Context.Database.AddInParameter(command, "@IdGuidExternoTransaccion", DbType.AnsiString, entidad.IdGuidExternoTransaccion);
            Context.Database.AddInParameter(command, "@MerchantId", DbType.AnsiString, entidad.MerchantId);
            Context.Database.AddInParameter(command, "@IdTokenUsuario", DbType.AnsiString, entidad.IdTokenUsuario);
            Context.Database.AddInParameter(command, "@AliasNameTarjeta", DbType.AnsiString, entidad.AliasNameTarjeta);
            Context.Database.AddInParameter(command, "@FechaTransaccion", DbType.DateTime, entidad.FechaTransaccion);
            Context.Database.AddInParameter(command, "@ResultadoValidacionCVV2", DbType.AnsiString, entidad.ResultadoValidacionCVV2);
            Context.Database.AddInParameter(command, "@CsiMensaje", DbType.AnsiString, entidad.CsiMensaje);
            Context.Database.AddInParameter(command, "@IdUnicoTransaccion", DbType.AnsiString, entidad.IdUnicoTransaccion);
            Context.Database.AddInParameter(command, "@Etiqueta", DbType.AnsiString, entidad.Etiqueta);
            Context.Database.AddInParameter(command, "@RespuestaSistemAntifraude", DbType.AnsiString, entidad.RespuestaSistemAntifraude);
            Context.Database.AddInParameter(command, "@CsiPorcentajeDescuento", DbType.AnsiString, entidad.CsiPorcentajeDescuento);
            Context.Database.AddInParameter(command, "@NumeroCuota", DbType.AnsiString, entidad.NumeroCuota);
            Context.Database.AddInParameter(command, "@TokenTarjetaGuardada", DbType.AnsiString, entidad.TokenTarjetaGuardada);
            Context.Database.AddInParameter(command, "@CsiImporteComercio", DbType.Decimal, entidad.CsiImporteComercio);
            Context.Database.AddInParameter(command, "@CsiCodigoPrograma", DbType.AnsiString, entidad.CsiCodigoPrograma);
            Context.Database.AddInParameter(command, "@DescripcionIndicadorComercioElectronico", DbType.AnsiString, entidad.DescripcionIndicadorComercioElectronico);
            Context.Database.AddInParameter(command, "@IndicadorComercioElectronico", DbType.AnsiString, entidad.IndicadorComercioElectronico);
            Context.Database.AddInParameter(command, "@DescripcionCodigoAccion", DbType.AnsiString, entidad.DescripcionCodigoAccion);
            Context.Database.AddInParameter(command, "@NombreBancoEmisor", DbType.AnsiString, entidad.NombreBancoEmisor);
            Context.Database.AddInParameter(command, "@ImporteCuota", DbType.Decimal, entidad.ImporteCuota);
            Context.Database.AddInParameter(command, "@CsiTipoCobro", DbType.AnsiString, entidad.CsiTipoCobro);
            Context.Database.AddInParameter(command, "@NumeroReferencia", DbType.AnsiString, entidad.NumeroReferencia);
            Context.Database.AddInParameter(command, "@Respuesta", DbType.AnsiString, entidad.Respuesta);
            Context.Database.AddInParameter(command, "@NumeroOrdenTienda", DbType.AnsiString, entidad.NumeroOrdenTienda);
            Context.Database.AddInParameter(command, "@CodigoAccion", DbType.AnsiString, entidad.CodigoAccion);
            Context.Database.AddInParameter(command, "@ImporteAutorizado", DbType.Decimal, entidad.ImporteAutorizado);
            Context.Database.AddInParameter(command, "@CodigoAutorizacion", DbType.AnsiString, entidad.CodigoAutorizacion);
            Context.Database.AddInParameter(command, "@CodigoTienda", DbType.AnsiString, entidad.CodigoTienda);
            Context.Database.AddInParameter(command, "@NumeroTarjeta", DbType.AnsiString, entidad.NumeroTarjeta);
            Context.Database.AddInParameter(command, "@OrigenTarjeta", DbType.AnsiString, entidad.OrigenTarjeta);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.AnsiString, entidad.UsuarioCreacion);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@PagoEnLineaResultadoLogId"].Value);
        }

        public string ObtenerTokenTarjetaGuardadaByConsultora(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerTokenTarjetaGuardadaByConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, codigoConsultora);

            return Convert.ToString(Context.ExecuteScalar(command));
        }

        public void UpdateMontoDeudaConsultora(string codigoConsultora, decimal montoDeuda)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateMontoDeudaConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, codigoConsultora);
            Context.Database.AddInParameter(command, "@MontoDeuda", DbType.Decimal, montoDeuda);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader ObtenerPagoEnLineaById(int pagoEnLineaResultadoLogId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPagoEnLineaById");
            Context.Database.AddInParameter(command, "@PagoEnLineaResultadoLogId", DbType.Int32, pagoEnLineaResultadoLogId);

            return Context.ExecuteReader(command);
        }

        public void UpdateVisualizado(int pagoEnLineaResultadoLogId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdatePagoEnLineaVisualizado");
            Context.Database.AddInParameter(command, "@PagoEnLineaResultadoLogId", DbType.Int32, pagoEnLineaResultadoLogId);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader ObtenerUltimoPagoEnLineaByConsultoraId(long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerUltimoPagoEnLineaByConsultoraId");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, consultoraId);

            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerPagoEnLineaByFiltro(BEPagoEnLineaFiltro filtro)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPagoEnLineaByFiltro");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, filtro.CampaniaId);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, filtro.RegionId);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, filtro.ZonaId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, filtro.CodigoConsultora);
            Context.Database.AddInParameter(command, "@Estado", DbType.String, filtro.Estado);
            Context.Database.AddInParameter(command, "@PagoDesde", DbType.Date, filtro.FechaPagoDesde);
            Context.Database.AddInParameter(command, "@PagoHasta", DbType.Date, filtro.FechaPagoHasta);
            Context.Database.AddInParameter(command, "@ProcesoDesde", DbType.DateTime, filtro.FechaProcesoDesde);
            Context.Database.AddInParameter(command, "@ProcesoHasta", DbType.DateTime, filtro.FechaProcesoHasta);

            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerPagoEnLineaTipoPago()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPagoEnLineaTipoPago");

            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerPagoEnLineaMedioPago()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPagoEnLineaMedioPago");

            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerPagoEnLineaPasarelaCampos()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPagoEnLineaPasarelaCampos");

            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerPagoEnLineaMedioPagoDetalle()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPagoEnLineaMedioPagoDetalle");

            return Context.ExecuteReader(command);

        }

        public IDataReader ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(string codigoPlataforma)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma");
            Context.Database.AddInParameter(command, "@CodigoPlataforma", DbType.String, codigoPlataforma);

            return Context.ExecuteReader(command);

        }        
    }
}
