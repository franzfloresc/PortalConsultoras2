using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAEstrategiaProducto : DataAccess
    {
        public DAEstrategiaProducto(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public int InsertEstrategiaProducto(BEEstrategiaProducto entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertEstrategiaProducto"))
            {
                Context.Database.AddOutParameter(command, "@Retorno", DbType.Int32, entidad.EstrategiaProductoID);
                Context.Database.AddInParameter(command, "@EstrategiaProductoID", DbType.Int32, entidad.EstrategiaProductoID);
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                Context.Database.AddInParameter(command, "@Campania", DbType.Int32, entidad.Campania);
                Context.Database.AddInParameter(command, "@CodigoEstrategia", DbType.Int32, entidad.CodigoEstrategia);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@Grupo", DbType.String, entidad.Grupo);
                Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entidad.Orden);
                Context.Database.AddInParameter(command, "@CUV2", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@SAP", DbType.String, entidad.SAP);
                Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, entidad.Cantidad);
                Context.Database.AddInParameter(command, "@Precio", DbType.Decimal, entidad.Precio);
                Context.Database.AddInParameter(command, "@PrecioValorizado", DbType.Decimal, entidad.PrecioValorizado);
                Context.Database.AddInParameter(command, "@Digitable", DbType.Int32, entidad.Digitable);
                Context.Database.AddInParameter(command, "@CodigoError", DbType.Int32, entidad.CodigoError);
                Context.Database.AddInParameter(command, "@CodigoErrorObs", DbType.Int32, entidad.CodigoErrorObs);
                Context.Database.AddInParameter(command, "@FactorCuadre", DbType.Int32, entidad.FactorCuadre);

                Context.Database.AddInParameter(command, "@NombreProducto", DbType.String, entidad.NombreProducto);
                Context.Database.AddInParameter(command, "@IdMarca", DbType.Int16, entidad.IdMarca);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);

                Context.ExecuteNonQuery(command);

                result = Convert.ToInt32(command.Parameters["@Retorno"].Value);
            }
            return result;
        }

        public IDataReader GetEstrategiaProducto(BEEstrategia entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstrategiaProducto");
            Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);

            return Context.ExecuteReader(command);
        }

        public int UpdateEstrategiaProducto(BEEstrategiaProducto entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateEstrategiaProducto"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@Precio", DbType.Decimal, entidad.Precio);
                Context.Database.AddInParameter(command, "@NombreProducto", DbType.String, entidad.NombreProducto);
                Context.Database.AddInParameter(command, "@Descripcion1", DbType.String, entidad.Descripcion1);
                Context.Database.AddInParameter(command, "@ImagenProducto", DbType.String, entidad.ImagenProducto);
                Context.Database.AddInParameter(command, "@IdMarca", DbType.Int16, entidad.IdMarca);
                Context.Database.AddInParameter(command, "@Activo", DbType.Int16, entidad.Activo);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);

                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }

        public bool DeleteEstrategiaProducto(BEEstrategiaProducto entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.DeleteEstrategiaProducto"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);

                result = Context.ExecuteNonQuery(command);
            }
            return (result > 0);
        }
    }
}