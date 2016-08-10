using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.ServiceOFAppCatalogo.Data
{
    public class DAProducto : DataAccess
    {
        public DAProducto(string codigoISo)
            : base(codigoISo)
        {

        }
        public IDataReader ObtenerProductosMostrar(int campaniaId, string codigoConsultora, int zonaId, string codigoRegion, string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoOfertaFinalMostrar_SB2");            
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, zonaId);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);

            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerProductosHistorialAppCatalogo(string codigoIso, int campaniaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoCatalogoByCodigoIsoCampa");
            Context.Database.AddInParameter(command, "@CodigoIso", DbType.String, codigoIso);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);

            return Context.ExecuteReader(command);
        }        
    }
}