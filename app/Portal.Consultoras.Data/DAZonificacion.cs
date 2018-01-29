using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAZonificacion : DataAccess
    {
        public DAZonificacion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetZonaByPais(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetZonaByPais");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetRegionByPais(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetRegionByPais");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPais()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPais");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPaisActivo()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPaisActivo");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPaisNumeroCampaniasByPaisID(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPaisNumeroCampaniasByPaisID");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCampania()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampania");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetTerritorio()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTerritorio");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetZonasActivasFIC(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetZonasActivasFIC");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetZonasInactivasFIC(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetZonasInactivasFIC");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public void InsInsCronogramaFIC(string CampaniaCodigo, string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCronogramaFIC");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, CodigoZona);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CampaniaCodigo);

            Context.ExecuteNonQuery(command);
        }

        public void DelCronogramaFIC(string CampaniaCodigo, string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCronogramaFIC");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, CodigoZona);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CampaniaCodigo);

            Context.ExecuteNonQuery(command);
        }

        public void InsCronogramaFICMasivo(int CampaniaCodigo, IEnumerable<BECronogramaFIC> cronogramaIFC)
        {
            var dtCronograma = new DataTable();
            dtCronograma.Columns.Add("CodigoConsultora", typeof(string));
            dtCronograma.Columns.Add("Zona", typeof(string));

            foreach (BECronogramaFIC be in cronogramaIFC)
            {
                dtCronograma.Rows.Add(be.CodigoConsultora, be.Zona);
            }
            dtCronograma.AcceptChanges();

            var command = new SqlCommand("dbo.InsCronogramaFICMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@CronogramaFIC", SqlDbType.Structured);
            parameter.TypeName = "dbo.CronogramaFICType";
            parameter.Value = dtCronograma;
            command.Parameters.Add(parameter);

            var parameter2 = new SqlParameter("@CodigoCampania", SqlDbType.VarChar);
            parameter2.Value = CampaniaCodigo.ToString();
            command.Parameters.Add(parameter2);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetCronogramaFICByCampania(string CampaniaCodigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCronogramaFICByCampania");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.Int32, CampaniaCodigo);

            return Context.ExecuteReader(command);
        }

        public void UpdCronogramaFIC(string CampaniaCodigo, string CodigoZona, DateTime? Fecha)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdCronogramaFIC");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.AnsiString, CampaniaCodigo);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, CodigoZona);
            Context.Database.AddInParameter(command, "@FechaLimite", DbType.DateTime, Fecha);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetCronogramaFICByZona(string CampaniaCodigo, string ZonaCodigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCronogramaFICByZona");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.AnsiString, CampaniaCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, ZonaCodigo);

            return Context.ExecuteReader(command);
        }

        public void DelCronogramaFICConsultora(string CampaniaCodigo, string CodigoZona, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCronogramaFICConsultora");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.AnsiString, CampaniaCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, CodigoZona);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetApeZona(int regionID, string codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetApeZona");
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, regionID);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, codigo);

            return Context.ExecuteReader(command);
        }

        public void UpdApeZona(int zonaID, int cantidadDias)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdApeZona");
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, zonaID);
            Context.Database.AddInParameter(command, "@CantidadDias", DbType.Int32, cantidadDias);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetPaisDD()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPaisDD");

            return Context.ExecuteReader(command);
        }

        public IDataReader SearchTerritorioByZona(string codigoZona, string codigoTerritorio)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.SearchTerritorioByZona");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            Context.Database.AddInParameter(command, "@CodigoTerritorio", DbType.String, codigoTerritorio);
            return Context.ExecuteReader(command);
        }
        
        public IDataReader GetSegmentoBanner()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSegmento");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetZonificacionJerarquia()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetZonificacionJerarquia");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetSegmentoInternoBanner()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetSegmentoInterno");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetRegionByPaisParametroCarga(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetRegionByPaisParametroCarga");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetZonaByPaisParametroCarga(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetZonaByPaisParametroCarga");
            return Context.ExecuteReader(command);
        }

    }
}