using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAContratoAceptacion : DataAccess
    {
        public DAContratoAceptacion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int AceptarContratoAceptacion(long consultoraid, string codigoconsultora, string origen, string direccionIP, string InformacionSOMobile, string imei, string deviceID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsContrato");
            Context.Database.AddInParameter(command, "@consultoraid", DbType.Int32, consultoraid);
            Context.Database.AddInParameter(command, "@codigoconsultora", DbType.AnsiString, codigoconsultora);
            Context.Database.AddInParameter(command, "@origen", DbType.String, origen);
            Context.Database.AddInParameter(command, "@direccionIP", DbType.String, direccionIP);
            Context.Database.AddInParameter(command, "@InformacionSOMobile", DbType.String, InformacionSOMobile);
            Context.Database.AddInParameter(command, "@imei", DbType.String, imei);
            Context.Database.AddInParameter(command, "@deviceID", DbType.String, deviceID);
            return Context.ExecuteNonQuery(command);
        }

        public IDataReader ReporteContratoAceptacion(string codigoconsultora, string cedula, DateTime? fechaInicio, DateTime? FechaFin )
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerReporteContratoAceptacion");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoconsultora);
            Context.Database.AddInParameter(command, "@Cedula", DbType.String, cedula);
            Context.Database.AddInParameter(command, "@fechaInicio", DbType.DateTime, fechaInicio);
            Context.Database.AddInParameter(command, "@fechaFin", DbType.DateTime, FechaFin);
            return Context.ExecuteReader(command);
        }
        
        public IDataReader GetContratoAceptacion(long consultoraid)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetContratos");
            Context.Database.AddInParameter(command, "@consultoraid", DbType.Int32, consultoraid);

            return Context.ExecuteReader(command);
        }
    }
}