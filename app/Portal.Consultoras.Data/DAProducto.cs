using System;
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

        public IDataReader GetProductoComercialByCampaniaBySearchRegionZona(int CampaniaID, int RowCount, int Criterio, string CodigoDescripcion, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona)
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
    }
}
