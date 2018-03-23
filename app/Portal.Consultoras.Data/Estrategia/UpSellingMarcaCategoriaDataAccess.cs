using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Estrategia;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Estrategia
{
    public class UpSellingMarcaCategoriaDataAccess : DataAccess
    {
        public UpSellingMarcaCategoriaDataAccess(int paisId) : base(paisId, EDbSource.Portal)
        { }


        public IEnumerable<UpsellingMarcaCategoria> UpsellingMarcaCategoriaObtener(int upSellingId, string MarcaID, string CategoriaID)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetUpsellingMarcaCategoriaLista"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);
                Context.Database.AddInParameter(command, "@MarcaID", DbType.String, MarcaID);
                Context.Database.AddInParameter(command, "@CategoriaID", DbType.String, CategoriaID);

                var reader = Context.ExecuteReader(command);

                var data = reader.MapToCollection<UpsellingMarcaCategoria>(true);
                return data;
            }
        }


        public UpsellingMarcaCategoria UpsellingMarcaCategoriaInsertar(int upSellingId, string MarcaID, string CategoriaID)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.InsertarUpsellingMarcaCategoria"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);
                Context.Database.AddInParameter(command, "@MarcaID", DbType.String, MarcaID);
                Context.Database.AddInParameter(command, "@CategoriaID", DbType.String, CategoriaID);

                var reader = Context.ExecuteReader(command);

                var data = reader.MapToObject<UpsellingMarcaCategoria>(true);
                return data;
            }


        }


        public bool UpsellingMarcaCategoriaEliminar(int upSellingId, string MarcaID, string CategoriaID)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.EliminarUpsellingMarcaCategoria"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);
                Context.Database.AddInParameter(command, "@MarcaID", DbType.String, MarcaID);
                Context.Database.AddInParameter(command, "@CategoriaID", DbType.String, CategoriaID); 

                var rowsAffected =   Context.ExecuteNonQuery(command); 

                return rowsAffected>0;
            }
        }

        public bool UpsellingMarcaCategoriaFlagsEditar(int upSellingId, bool CategoriaApoyada, bool CategoriaMonto)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpsellingMarcaCategoriaFlagsEditar"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);
                Context.Database.AddInParameter(command, "@CategoriaApoyada", DbType.Boolean, CategoriaApoyada);
                Context.Database.AddInParameter(command, "@CategoriaMonto", DbType.Boolean, CategoriaMonto);

                var rowsAffected = Context.ExecuteNonQuery(command);

                return rowsAffected > 0;
            }
        }
       
    }
}
