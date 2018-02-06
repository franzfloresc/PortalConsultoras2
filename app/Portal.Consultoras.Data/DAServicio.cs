using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAServicio : DataAccess
    {
        public DAServicio()
            : base()
        {

        }

        public IDataReader GetServicios(string Descripcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetServicios");
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, Descripcion);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetServicioByCampaniaPais(int PaisId, int CampaniaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetServicioByCampaniaPais");
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, PaisId);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            return Context.ExecuteReader(command);
        }

        public int InsServicio(BEServicio servicio)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsServicio");
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, servicio.Descripcion);
            Context.Database.AddInParameter(command, "@Url", DbType.AnsiString, servicio.Url);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdServicio(BEServicio servicio)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdServicio");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, servicio.ServicioId);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, servicio.Descripcion);
            Context.Database.AddInParameter(command, "@Url", DbType.AnsiString, servicio.Url);

            return Context.ExecuteNonQuery(command);
        }

        public int DelServicio(int ServicioId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelServicio");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetParametros()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetParametros");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetParametrobyServicio(int ServicioId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.getParametrobyServicio");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);

            return Context.ExecuteReader(command);
        }

        public int DelServicioParametro(int ServicioId, int ParametroId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelServicioParametro");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@ParametroId", DbType.Int32, ParametroId);

            return Context.ExecuteNonQuery(command);
        }

        public int InsServicioParametro(int ServicioId, int ParametroId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsServicioParametro");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.String, ServicioId);
            Context.Database.AddInParameter(command, "@ParametroId", DbType.AnsiString, ParametroId);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public IDataReader GetEstadoServiciobyPais(int ServicioId, int CampaniaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.getEstadoServiciobyPais");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);

            return Context.ExecuteReader(command);
        }

        public int InsServicioCampania(int CampaniaId, int ServicioId, string CodigoISO)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsServicioCampania");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@CodigoISO", DbType.AnsiString, CodigoISO);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int InsServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsServicioCampaniaRango");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@CampaniaFinalId", DbType.Int32, CampaniaFinalId);
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@CodigoISO", DbType.AnsiString, CodigoISO);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int DelServicioCampania(int CampaniaId, int ServicioId, string CodigoISO)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelServicioCampania");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@CodigoISO", DbType.AnsiString, CodigoISO);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int DelServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelServicioCampaniaRango");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@CampaniaFinalId", DbType.Int32, CampaniaFinalId);
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@CodigoISO", DbType.AnsiString, CodigoISO);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public IDataReader GetServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetServicioCampaniaSegmentoZona");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, PaisId);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetServicioCampaniaSegmentoZonaAsignados(int ServicioId, int PaisId, int Tipo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetServicioCampaniaSegmentoZonaAsignados");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, PaisId);
            Context.Database.AddInParameter(command, "@Tipo", DbType.Int32, Tipo);
            return Context.ExecuteReader(command);
        }

        public void UpdServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInterno)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdServicioCampaniaSegmentoZona");
            Context.Database.AddInParameter(command, "@ServicioId", DbType.Int32, ServicioId);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, PaisId);
            Context.Database.AddInParameter(command, "@Segmento", DbType.Int32, Segmento);
            Context.Database.AddInParameter(command, "@ConfiguracionZona", DbType.AnsiString, ConfiguracionZona);
            Context.Database.AddInParameter(command, "@SegmentoInternoID", DbType.AnsiString, SegmentoInterno);

            Context.ExecuteNonQuery(command);
        }
    }
}
