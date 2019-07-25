using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DABanner : DataAccess
    {
        public DABanner()
            : base()
        {

        }

        public IDataReader GetBannerByCampania(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBannerByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetGrupoBannerByCampania(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetGrupoBannerByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public int InsUpdGrupoBanner(BEGrupoBanner grupoBanner)
        {
            var consultoras = grupoBanner.Consultoras ?? new BEGrupoConsultora[0];

            var consultorasReader = new GenericDataReader<BEGrupoConsultora>(consultoras);

            var command = new SqlCommand("dbo.InsUpdGrupoBanner");
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter;

            parameter = new SqlParameter("@CampaniaID", SqlDbType.Int);
            parameter.Value = grupoBanner.CampaniaID;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@GrupoBannerID", SqlDbType.Int);
            parameter.Value = grupoBanner.GrupoBannerID;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@TiempoRotacion", SqlDbType.Int);
            parameter.Value = grupoBanner.TiempoRotacion;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@Consultoras", SqlDbType.Structured);
            parameter.TypeName = "dbo.GrupoConsultoraType";
            parameter.Value = consultorasReader;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        public int InsUpdBanner(BEBanner banner)
        {
            var dtPaises = new DataTable();
            dtPaises.Columns.Add("Value", typeof(int));

            if (banner.Paises != null && banner.Paises.Length > 0)
            {
                foreach (int paisId in banner.Paises)
                {
                    if (paisId > 0)
                        dtPaises.Rows.Add(paisId);
                }
                dtPaises.AcceptChanges();
            }

            var command = new SqlCommand("dbo.InsUpdBanner");
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter;

            parameter = new SqlParameter("@CampaniaID", SqlDbType.Int);
            parameter.Value = banner.CampaniaID;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@BannerID", SqlDbType.Int);
            parameter.Value = banner.BannerID;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@GrupoBannerID", SqlDbType.Int);
            parameter.Value = banner.GrupoBannerID;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@Orden", SqlDbType.Int);
            parameter.Value = banner.Orden;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@Titulo", SqlDbType.VarChar, 50);
            parameter.Value = banner.Titulo;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@Archivo", SqlDbType.VarChar, 200);
            parameter.Value = banner.Archivo;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@URL", SqlDbType.VarChar, 300);
            parameter.Value = banner.URL;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@FlagGrupoConsultora", SqlDbType.Bit);
            parameter.Value = banner.FlagGrupoConsultora;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@FlagConsultoraNueva", SqlDbType.Bit);
            parameter.Value = banner.FlagConsultoraNueva;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@BannerIDOut", SqlDbType.Int);
            parameter.Direction = ParameterDirection.Output;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@Paises", SqlDbType.Structured);
            parameter.TypeName = "dbo.ListOfValues";
            parameter.Value = dtPaises;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@UdpSoloBanner", SqlDbType.Bit);
            parameter.Value = banner.UdpSoloBanner;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@TipoContenido", SqlDbType.Int);
            parameter.Value = banner.TipoContenido;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@PaginaNueva", SqlDbType.Int);
            parameter.Value = banner.PaginaNueva;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@TituloComentario", SqlDbType.VarChar, 120);
            parameter.Value = banner.TituloComentario;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@TextoComentario", SqlDbType.VarChar, 120);
            parameter.Value = banner.TextoComentario;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@TipoAccion", SqlDbType.Int);
            parameter.Value = banner.TipoAccion;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@CuvPedido", SqlDbType.VarChar, 50);
            parameter.Value = banner.CuvPedido;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@CantCuvPedido", SqlDbType.Int);
            parameter.Value = banner.CantCuvPedido;
            command.Parameters.Add(parameter);
            int result = Context.ExecuteNonQuery(command);

            if (banner.BannerID == 0)
            {
                banner.BannerID = Convert.ToInt32(command.Parameters["@BannerIDOut"].Value);
            }
            return result;
        }

        public int DelBanner(int CampaniaID, int BannerID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelBanner");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@BannerID", DbType.Int32, BannerID);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetParametrosBanners()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetParametroBanners");

            return Context.ExecuteReader(command);
        }

        public int UpdOrdenNumberBanner(IEnumerable<BEBannerOrden> lstBanners)
        {
            var bannersReader = new GenericDataReader<BEBannerOrden>(lstBanners);

            var command = new SqlCommand("dbo.UpdNroOrdenBanners");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@BannersOrden", SqlDbType.Structured);
            parameter.TypeName = "dbo.BannerOrdenType";
            parameter.Value = bannersReader;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetBannerByCampaniaBienvenida(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBannerByCampaniaBienvenida");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPaisBannerMarquesina(string CampaniaID, int IdBanner)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPaisBannerMarquesina");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, Convert.ToInt32(CampaniaID));
            Context.Database.AddInParameter(command, "@IdBanner", DbType.Int32, IdBanner);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetBannerSegmentoSeccion(int CampaniaId, int BannerId, int PaisId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBannerSegmentoSeccion");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@BannerId", DbType.Int32, BannerId);
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, PaisId);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetBannerPaisesAsignados(int CampaniaId, int BannerId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBannerPaisesAsignados");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@BannerId", DbType.Int32, BannerId);
            return Context.ExecuteReader(command);
        }

        public void UpdBannerPaisSegmentoZona(BEBannerSegmentoZona segmentoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdBannerPaisSegmentoZona");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, segmentoZona.CampaniaId);
            Context.Database.AddInParameter(command, "@BannerId", DbType.Int32, segmentoZona.BannerId);
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, segmentoZona.PaisId);
            Context.Database.AddInParameter(command, "@Segmento", DbType.Int32, segmentoZona.Segmento);
            Context.Database.AddInParameter(command, "@ConfiguracionZona", DbType.AnsiString, segmentoZona.ConfiguracionZona);
            Context.Database.AddInParameter(command, "@SegmentoInternoID", DbType.AnsiString, segmentoZona.SegmentoInterno);
            Context.Database.AddInParameter(command, "@TipoAcceso", DbType.Int32, segmentoZona.TipoAcceso);
            Context.Database.AddInParameter(command, "@CodigosConsultora", DbType.AnsiString, segmentoZona.CodigosConsultora);

            Context.ExecuteNonQuery(command);
        }

    }
}