﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAProducto : DataAccess
    {
        public DAProducto(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetProductoComercialByCampania(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComercialByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoComercialByPaisAndCampania(int CampaniaID, int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComercialByPaisAndCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoComercialByCampaniaBySearch(int CampaniaID, int RowCount, int Criterio, string CodigoDescripcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComercialByCampaniaBySearch");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@RowCount", DbType.Int32, RowCount);
            Context.Database.AddInParameter(command, "@Criterio", DbType.Int32, Criterio);
            Context.Database.AddInParameter(command, "@CodigoDescripcion", DbType.String, CodigoDescripcion);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoComercialByCampaniaBySearchRegionZona(int CampaniaID, int RowCount, int Criterio, string CodigoDescripcion, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona, bool validarOpt)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@RowCount", DbType.Int32, RowCount);
            Context.Database.AddInParameter(command, "@Criterio", DbType.Int32, Criterio);
            Context.Database.AddInParameter(command, "@CodigoDescripcion", DbType.String, CodigoDescripcion);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.AnsiString, CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, CodigoZona);
            Context.Database.AddInParameter(command, "@ValidarOPT", DbType.Boolean, validarOpt);

            return Context.ExecuteReader(command);
        }

        public IDataReader SearchListProductoChatbotByCampaniaRegionZona(int campaniaID, int regionID, int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int criterio, int rowCount)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComercialByCampaniaZona");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, regionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, zonaID);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.AnsiString, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, codigoZona);
            Context.Database.AddInParameter(command, "@RowCount", DbType.Int32, rowCount);
            Context.Database.AddInParameter(command, "@Criterio", DbType.Int32, criterio);
            Context.Database.AddInParameter(command, "@TextoBusqueda", DbType.String, textoBusqueda);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoComercialByCampaniaBySearchRegionZonaListaCuv(int campaniaID, string listaCuv, int regionID, int zonaID, string codigoRegion, string codigoZona, bool validarOpt)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ListaCuv", DbType.String, listaCuv);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, regionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, zonaID);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.AnsiString, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, codigoZona);
            Context.Database.AddInParameter(command, "@ValidarOPT", DbType.Boolean, validarOpt);

            return Context.ExecuteReader(command);
        }
        
        public IDataReader GetProductoComercialByListaCuv(int campaniaID, int regionID, int zonaID, string codigoRegion, string codigoZona, string listaCuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComercialByListaCuv");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, regionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, zonaID);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            Context.Database.AddInParameter(command, "@ListaCuv", DbType.String, listaCuv);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoSugeridoByCUV(int campaniaID, int consultoraID, string cuv, int regionID, int zonaID, string codigoRegion, string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoSugeridoByCUV_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, cuv);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, regionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, zonaID);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.AnsiString, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, codigoZona);

            return Context.ExecuteReader(command);
        }

        public IDataReader SelectProductoToKitInicio(int CampaniaID, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.SelectProductoToKitInicio_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@cuv", DbType.String, cuv);

            return Context.ExecuteReader(command);
        }

        public string GetNombreProducto048ByCuv(int campaniaID, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNombreProducto048ByCuv");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, cuv);

            return Context.ExecuteScalar(command).ToString();
        }

        public IDataReader GetNombreProducto048ByListaCUV(int campaniaID, string listaCUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNombreProducto048ByListaCUV");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ListaCUV", DbType.String, listaCUV);

            return Context.ExecuteReader(command);
        }

        //PL20-1237
        public int InsProductoCompartido(BEProductoCompartido ProComp)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsProductoCompartido");
            Context.Database.AddInParameter(command, "@ProductoCompCampaniaID", DbType.Int32, ProComp.PcCampaniaID);
            Context.Database.AddInParameter(command, "@ProductoCompCUV", DbType.String, ProComp.PcCuv);
            Context.Database.AddInParameter(command, "@ProductoCompPalanca", DbType.String, ProComp.PcPalanca);
            Context.Database.AddInParameter(command, "@ProductoCompDetalle", DbType.String, ProComp.PcDetalle);
            Context.Database.AddInParameter(command, "@ProductoCompApp", DbType.String, ProComp.PcApp);
            Context.Database.AddOutParameter(command, "@ProductoCompID", DbType.Int32, 0);

            Context.ExecuteNonQuery(command);
            int id = Convert.ToInt32(command.Parameters["@ProductoCompID"].Value);
            return id;
        }

        public IDataReader GetProductoCompartido(int ProCompID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoCompartido");
            Context.Database.AddInParameter(command, "@ProductoCompID", DbType.Int32, ProCompID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetListBrothersByCUV(int codCampania, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetListBrothersByCUV");
            Context.Database.AddInParameter(command, "@CodCampania", DbType.Int32, codCampania);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, cuv);

            return Context.ExecuteReader(command);
        }

    }
}
