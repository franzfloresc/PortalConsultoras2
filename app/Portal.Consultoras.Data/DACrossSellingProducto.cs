using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DACrossSellingProducto : DataAccess
    {
        public DACrossSellingProducto(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsCrossSellingProducto(BECrossSellingProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCrossSellingProducto");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, entity.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@PrecioOferta", DbType.Decimal, entity.PrecioOferta);
            Context.Database.AddInParameter(command, "@MensajeProducto", DbType.AnsiString, entity.MensajeProducto);
            Context.Database.AddInParameter(command, "@ImagenProducto", DbType.AnsiString, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "@FlagHabilitarProducto", DbType.Int32, entity.FlagHabilitarProducto);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdCrossSellingProducto(BECrossSellingProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdCrossSellingProducto");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@MensajeProducto", DbType.AnsiString, entity.MensajeProducto);
            Context.Database.AddInParameter(command, "@ImagenProducto", DbType.AnsiString, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "@FlagHabilitarProducto", DbType.Int32, entity.FlagHabilitarProducto);

            return Context.ExecuteNonQuery(command);
        }

        public int DelCrossSellingProducto(BECrossSellingProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCrossSellingProducto");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetCrossSellingProductosAdministracion(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCrossSellingAdministracion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCrossSellingAsociacionListado(int CampaniaID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductosNoRecomendados");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCUVAsociadoByFilter(int CampaniaID, string CUV, string CodigoSegmento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCUVAsociadoByCUV");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@CodigoSegmento", DbType.AnsiString, CodigoSegmento);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetDescripcionProductoByCUV(int CampaniaID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDescripcionProductoByCUV");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return Context.ExecuteReader(command);
        }


        public IDataReader GetProductosRecomendadosHabilitados(int CampaniaID, int tipo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductosRecomendadosHabilitados");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@tipo", DbType.Int32, tipo);
            return Context.ExecuteReader(command);
        }

        public int InsCrossSellingAsociacion(BECrossSellingAsociacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCrossSellingAsociacion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@CUVAsociado", DbType.AnsiString, entity.CUVAsociado);
            Context.Database.AddInParameter(command, "@CUVAsociado2", DbType.AnsiString, entity.CUVAsociado2);
            Context.Database.AddInParameter(command, "@CodigoSegmento", DbType.AnsiString, entity.CodigoSegmento);
			Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);            
            Context.Database.AddInParameter(command, "@Precio", DbType.String, entity.EtiquetaPrecio);
            return Context.ExecuteNonQuery(command);
        }

        public int UpdCrossSellingAsociacion(BECrossSellingAsociacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdCrossSellingAsociacion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@CUVAsociado", DbType.AnsiString, entity.CUVAsociado);
            Context.Database.AddInParameter(command, "@CUVAsociado2", DbType.AnsiString, entity.CUVAsociado2);
            Context.Database.AddInParameter(command, "@CodigoSegmento", DbType.AnsiString, entity.CodigoSegmento);
			Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);            
            Context.Database.AddInParameter(command, "@Precio", DbType.String, entity.EtiquetaPrecio);
            return Context.ExecuteNonQuery(command);
        }

        public int DelCrossSellingAsociacion(BECrossSellingAsociacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCrossSellingAsociacion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@CodigoSegmento", DbType.AnsiString, entity.CodigoSegmento);

            return Context.ExecuteNonQuery(command);
        }

        public int DelCrossSellingAsociacion_Perfil(BECrossSellingAsociacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCrossSellingAsociacion_perfil");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CrossSellingAsociacionID", DbType.Int32, entity.CrossSellingAsociacionID);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetProductosRecomendadosByCUVCampaniaPortal(long ConsultoraID, int CampaniaID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoRecomendadoPortal");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return Context.ExecuteReader(command);
        }
		
 		public int UpdVisualizacionPopupProRecom(int consultoraid, int campaniaid)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdVisualizacionPopupProRecom");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraid);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaid);
            return Context.ExecuteNonQuery(command);
        }
    }
}
