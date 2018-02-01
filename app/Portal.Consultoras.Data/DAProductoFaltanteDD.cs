using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAProductoFaltanteDD : DataAccess
    {
        public DAProductoFaltanteDD(int paisID)
            : base(paisID, EDbSource.Digitacion)
        {

        }

        public int InsProductoFaltante(string PaisISO, string UsuarioCreacion,IEnumerable<BEProductoFaltante> productosFaltantes)
        {
            var productosFaltantesReader = new GenericDataReader<BEProductoFaltante>(productosFaltantes);

            var command = new SqlCommand("dbo.InsProductoFaltante");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@ProductosFaltantes", SqlDbType.Structured);
            parameter.TypeName = "dbo.ProductoFaltanteType";
            parameter.Value = productosFaltantesReader;
            command.Parameters.Add("@PaisISO", SqlDbType.Char).Value = PaisISO;
            command.Parameters.Add("@UsuarioCreacion", SqlDbType.Char).Value = UsuarioCreacion;
            command.Parameters.Add(parameter);
            
            return Context.ExecuteNonQuery(command);
        }

        public int InsProductoFaltanteMasivo(string PaisISO, string UsuarioCreacion, IEnumerable<BEProductoFaltante> productosFaltantes)
        {
            var productosFaltantesReader = new GenericDataReader<BEProductoFaltante>(productosFaltantes);

            var command = new SqlCommand("dbo.InsProductoFaltanteMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@ProductosFaltantes", SqlDbType.Structured);
            parameter.TypeName = "dbo.ProductoFaltanteType";
            parameter.Value = productosFaltantesReader;
            command.Parameters.Add("@PaisISO", SqlDbType.Char).Value = PaisISO;
            command.Parameters.Add("@UsuarioCreacion", SqlDbType.Char).Value = UsuarioCreacion;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        public int DelProductoFaltante(BEProductoFaltante prod, string paisISO, string CodigoUsuario, out bool Deleted)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelProductoFaltante");
            Context.Database.AddInParameter(command, "@PaisISO", DbType.AnsiString, paisISO);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.AnsiString, prod.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, prod.CUV);
            Context.Database.AddInParameter(command, "@Zona", DbType.AnsiString, prod.Zona);
            Context.Database.AddOutParameter(command, "@Deleted", DbType.Boolean, 1);

            int result = Context.ExecuteNonQuery(command);
            Deleted = Convert.ToBoolean(command.Parameters["@Deleted"].Value);
            return result;
        }

    }
}
