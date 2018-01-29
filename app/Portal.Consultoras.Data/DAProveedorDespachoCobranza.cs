using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAProveedorDespachoCobranza : DataAccess
    {
        public DAProveedorDespachoCobranza(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetProveedorDespachoCobranza()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProveedorDespachoCobranza");

            return Context.ExecuteReader(command);
        }
        
        public int DelProveedorDespachoCobranza(int ProveedorDespachoCobanzaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DeleteProveedorDespachoCobranzaByID");
            Context.Database.AddInParameter(command, "@ProveedorDespachoCobanzaID", DbType.Int32, ProveedorDespachoCobanzaID);

            return Convert.ToInt16(Context.ExecuteScalar(command));
        }

        public int UpdProveedorDespachoCobranzaCabecera(BEProveedorDespachoCobranza entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("UpdateProveedorDespachoCobranzaCabecera");
            Context.Database.AddInParameter(command, "@ProveedorDespachoCobanzaID", DbType.Int16, entidad.ProveedorDespachoCobranzaID);
            Context.Database.AddInParameter(command, "@NombreComercial", DbType.String, entidad.NombreComercial);
            Context.Database.AddInParameter(command, "@RazonSocial", DbType.String, entidad.RazonSocial);
            Context.Database.AddInParameter(command, "@RFC", DbType.String, entidad.RFC);
            return Context.ExecuteNonQuery(command);
        }

        public int InsDespachoCobranzaCabecera(BEProveedorDespachoCobranza entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("InsProveedorDespachoCobranzaCabecera");
            Context.Database.AddInParameter(command, "@NombreComercial", DbType.String, entidad.NombreComercial);
            Context.Database.AddInParameter(command, "@RazonSocial", DbType.String, entidad.RazonSocial);
            Context.Database.AddInParameter(command, "@RFC", DbType.String, entidad.RFC);

            return Context.ExecuteNonQuery(command);
        }

        public int MntoCampoProveedorDespachoCobranza(BEProveedorDespachoCobranza entidad, int accion, int campoid, string valor, string valorAntiguo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("MntoCampoProveedorDespachoCobranza");

            Context.Database.AddInParameter(command, "@Accion", DbType.Int16, accion);
            Context.Database.AddInParameter(command, "@ProveedorDespachoCobanzaID", DbType.Int16, entidad.ProveedorDespachoCobranzaID);
            Context.Database.AddInParameter(command, "@CampoID", DbType.Int16, campoid);
            Context.Database.AddInParameter(command, "@Valor", DbType.String, valor);
            Context.Database.AddInParameter(command, "@valorAntiguo", DbType.String, valorAntiguo);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetProveedorDespachoCobranzaMnto(BEProveedorDespachoCobranza entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("getProveedorDespachoCobranzaMnto");
            Context.Database.AddInParameter(command, "@in_ProveedorDespachoCobranzaID", DbType.Int16, entidad.ProveedorDespachoCobranzaID);
            Context.Database.AddInParameter(command, "@CampoId", DbType.Int16, entidad.CampoId);
            return Context.ExecuteReader(command);

        }

        public IDataReader GetProveedorDespachoCobranzaBYiD(BEProveedorDespachoCobranza entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetProveedorDespachoCobranzaBYiD");

            Context.Database.AddInParameter(command, "@ProveedorDespachoCobranzaID", DbType.Int16, entidad.ProveedorDespachoCobranzaID);
            Context.Database.AddInParameter(command, "@campoId", DbType.Int16, entidad.CampoId);

            return Context.ExecuteReader(command);
        }

    }
}
