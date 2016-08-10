using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System.Data.SqlClient;
using System;

namespace Portal.Consultoras.Data
{
    public class DAEstrategia : DataAccess
    {
        public DAEstrategia(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetEstrategia(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategias"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV2);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader FiltrarEstrategia(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.FiltrarEstrategia"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetTallaColor(BETallaColor entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarTallaColorCUV"))
            {
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                return Context.ExecuteReader(command);
            }
        }

        public int InsertTallaColorCUV(BETallaColor entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarTallaColorCUV"))
            {
                Context.Database.AddInParameter(command, "@ID", DbType.Int32, entidad.ID);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@Tipo", DbType.String, entidad.Tipo);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, entidad.DescripcionTallaColor);
                Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.String, entidad.UsuarioRegistro);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);
                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }

        public int InsertEstrategia(BEEstrategia entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarEstrategia"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CampaniaIDFin", DbType.Int32, entidad.CampaniaIDFin);
                Context.Database.AddInParameter(command, "@NumeroPedido", DbType.Int32, entidad.NumeroPedido);
                Context.Database.AddInParameter(command, "@Activo", DbType.Int32, entidad.Activo);
                Context.Database.AddInParameter(command, "@ImagenURL", DbType.String, entidad.ImagenURL);
                Context.Database.AddInParameter(command, "@LimiteVenta", DbType.Int32, entidad.LimiteVenta);
                Context.Database.AddInParameter(command, "@DescripcionCUV2", DbType.String, entidad.DescripcionCUV2);
                Context.Database.AddInParameter(command, "@FlagDescripcion", DbType.Int32, entidad.FlagDescripcion);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV1);
                Context.Database.AddInParameter(command, "@EtiquetaID", DbType.Int32, entidad.EtiquetaID);
                Context.Database.AddInParameter(command, "@Precio", DbType.String, entidad.Precio);
                Context.Database.AddInParameter(command, "@FlagCEP", DbType.Int32, entidad.FlagCEP);
                Context.Database.AddInParameter(command, "@CUV2", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@EtiquetaID2", DbType.Int32, entidad.EtiquetaID2);
                Context.Database.AddInParameter(command, "@Precio2", DbType.String, entidad.Precio2);
                Context.Database.AddInParameter(command, "@FlagCEP2", DbType.Int32, entidad.FlagCEP2);
                Context.Database.AddInParameter(command, "@TextoLibre", DbType.String, entidad.TextoLibre);
                Context.Database.AddInParameter(command, "@FlagTextoLibre", DbType.Int32, entidad.FlagTextoLibre);
                Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, entidad.Cantidad);
                Context.Database.AddInParameter(command, "@FlagCantidad", DbType.Int32, entidad.FlagCantidad);
                Context.Database.AddInParameter(command, "@Zona", DbType.String, entidad.Zona);
                Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entidad.Orden);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, entidad.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);
                Context.Database.AddInParameter(command, "@ColorFondo", DbType.String, entidad.ColorFondo);
                Context.Database.AddInParameter(command, "@FlagEstrella", DbType.String, entidad.FlagEstrella);
                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }

        public IDataReader GetOfertaByCUV(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConsultarOfertaByCUV"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CUV2", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                Context.Database.AddInParameter(command, "@CUV1", DbType.String, entidad.CUV1);
                Context.Database.AddInParameter(command, "@flag", DbType.Int32, entidad.Activo);
                return Context.ExecuteReader(command);
            }
        }

        public int DeshabilitarEstrategia(BEEstrategia entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.DeshabilitarEstrategia"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);                    
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);

                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }

        public int EliminarTallaColor(BETallaColor entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EliminarTallaColorCUV"))
            {
                Context.Database.AddInParameter(command, "@ID", DbType.Int32, entidad.ID);

                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }

        public int ValidarCUVsRecomendados(BEEstrategia entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarCUVsRecomendados"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@Tipo", DbType.Int32, entidad.Cantidad);

                result = Convert.ToInt32(Context.ExecuteScalar(command));
            }
            return result;
        }

        public IDataReader GetEstrategiaPedido(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasPedido_SB2"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, entidad.ConsultoraID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@ZonaID", DbType.String, entidad.Zona);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader FiltrarEstrategiaPedido(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.FiltrarEstrategiaPedido"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                Context.Database.AddInParameter(command, "@FlagNueva", DbType.Int32, entidad.FlagNueva);
                return Context.ExecuteReader(command);
            }
        }

        public string ValidarStockEstrategia(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarStockEstrategia"))
            {
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CantidadPedida", DbType.Int32, entidad.Cantidad);
                Context.Database.AddInParameter(command, "@flagPedido", DbType.Int32, entidad.FlagCantidad);
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, entidad.ConsultoraID);
                return Context.ExecuteScalar(command).ToString();
            }
        }
		// 1747 - Inicio
        public IDataReader GetRegionZonaZE(int RegionID, int ZonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetRegionZonaZE");
            Context.Database.AddInParameter(command, "@region", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@zona", DbType.Int32, ZonaID);

            return Context.ExecuteReader(command);
        }
		// 1747 - Fin
    }
}
