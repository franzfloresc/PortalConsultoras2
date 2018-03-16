using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPayPalPagos : DataAccess
    {
        public DAPayPalPagos(int paisID)
            : base(paisID, EDbSource.Digitacion)
        {

        }

        public int InsDatosPago(string chrCodigoConsultora, string chrCodigoTerritorio, decimal montoAbono, string chrNumeroTarjeta, DateTime datFechaTransaccion, Int16 estado)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ESE_Insertar_DatosPago");
            Context.Database.AddInParameter(command, "@chrCodigoConsultora", DbType.AnsiString, chrCodigoConsultora);
            Context.Database.AddInParameter(command, "@chrCodigoTerritorio", DbType.AnsiString, chrCodigoTerritorio);
            Context.Database.AddInParameter(command, "@mnyMontoAbono", DbType.Decimal, montoAbono);
            Context.Database.AddInParameter(command, "@chrNumeroTarjeta", DbType.AnsiString, chrNumeroTarjeta);
            Context.Database.AddInParameter(command, "@datFechaTransaccion", DbType.DateTime, datFechaTransaccion);
            Context.Database.AddInParameter(command, "@bitEstado", DbType.Int16, estado);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int InsAbonoPago(string chrCodigoPais, string chrCodigoConsultora, decimal mnyMontoAbono, string chrCodigoAutorizacionBanco, string chrCodigoTransaccion, int chrResultado)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ESE_InsertarAbono");
            Context.Database.AddInParameter(command, "@chrCodigoPais", DbType.AnsiString, chrCodigoPais);
            Context.Database.AddInParameter(command, "@chrCodigoConsultora", DbType.String, chrCodigoConsultora);
            Context.Database.AddInParameter(command, "@mnyMontoAbono", DbType.Decimal, mnyMontoAbono);
            Context.Database.AddInParameter(command, "@chrCodigoAutorizacionBanco", DbType.AnsiString, chrCodigoAutorizacionBanco);
            Context.Database.AddInParameter(command, "@chrCodigoTransaccion", DbType.AnsiString, chrCodigoTransaccion);
            Context.Database.AddInParameter(command, "@chrResultado", DbType.Int32, chrResultado);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public IDataReader ValidarPagoExistente(decimal mnyMontoAbono, string chrNumeroTarjeta, DateTime datFecha)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ESE_Seleccionar_DatosPago");
            Context.Database.AddInParameter(command, "@mnyMontoAbono", DbType.Decimal, mnyMontoAbono);
            Context.Database.AddInParameter(command, "@chrNumeroTarjeta", DbType.AnsiString, chrNumeroTarjeta);
            Context.Database.AddInParameter(command, "@datFecha", DbType.DateTime, datFecha);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetReporteAbonos(string chrCodigoPais, string chrCodigoConsultora, int intDia, int intMes, int intAnho, string chrRETCodigoTransaccion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ESE_SeleccionarAbonosConsultoras_2");
            Context.Database.AddInParameter(command, "@chrCodigoPais", DbType.AnsiString, chrCodigoPais);
            Context.Database.AddInParameter(command, "@chrCodigoConsultora", DbType.AnsiString, chrCodigoConsultora);
            Context.Database.AddInParameter(command, "@intDia", DbType.Int32, intDia);
            Context.Database.AddInParameter(command, "@intMes", DbType.Int32, intMes);
            Context.Database.AddInParameter(command, "@intAnho", DbType.Int32, intAnho);
            Context.Database.AddInParameter(command, "@chrRETCodigoTransaccion", DbType.AnsiString, chrRETCodigoTransaccion);

            return Context.ExecuteReader(command);
        }

        public int InsPaypalDescarga(string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPaypalDescarga");
            Context.Database.AddOutParameter(command, "@NumeroLote", DbType.Int32, 4);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, codigoUsuario);

            Context.ExecuteNonQuery(command);

            var numeroLote = Convert.ToInt32(command.Parameters["@NumeroLote"].Value);

            return numeroLote;
        }

        public DataSet GetPagoPaypalNoEnviadas(int numeroLote, DateTime fechaEjecucion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ProcesoDescargaPaypal");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLote);
            Context.Database.AddInParameter(command, "@FechaEjecucion", DbType.DateTime, fechaEjecucion);

            return Context.ExecuteDataSet(command);
        }

        public void UpdPaypalDescarga(int numeroLote, int estado, string mensaje, string mensajeExcepcion, string nombreArchivoPaypal, string nombreServidor)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPaypalDescarga");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLote);
            Context.Database.AddInParameter(command, "@Estado", DbType.Int32, estado);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@NombreArchivoPaypal", DbType.String, nombreArchivoPaypal);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.String, nombreServidor);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);

            Context.ExecuteNonQuery(command);
        }

        public void UpdPaypalPasarelaPago(int numeroLote)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPaypalPasarelaPago");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLote);

            Context.ExecuteNonQuery(command);
        }
    }
}