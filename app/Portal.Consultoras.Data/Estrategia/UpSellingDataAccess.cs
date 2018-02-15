using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Estrategia;

namespace Portal.Consultoras.Data.Estrategia
{
    public class UpSellingDataAccess : DataAccess
    {
        private const string StoredProcedureUpSellingObtener = "dbo.UpSelling_Select";

        public UpSellingDataAccess(int paisId) : base(paisId, EDbSource.Portal)
        { }

        //todo: complete access

        public IEnumerable<UpSelling> Obtener(string codigoCampana)
        {
            using (var command = Context.Database.GetStoredProcCommand(StoredProcedureUpSellingObtener))
            {
                Context.Database.AddInParameter(command, "@codigoCampana", DbType.AnsiString, codigoCampana);

                var reader = Context.ExecuteReader(command);
                return reader.MapToCollection<UpSelling>();
            }
        }

        public IEnumerable<UpSellingDetalle> ObtenerDetalle(int upSellingId)
        {
            throw new NotImplementedException();
        }

        public UpSellingDetalle InsertarDetalle(UpSellingDetalle regalo)
        {
            throw new NotImplementedException();
        }

        public UpSelling Actualizar(UpSelling upSelling)
        {
            throw new NotImplementedException();
        }

        public UpSellingDetalle ActualizarDetalle(UpSellingDetalle regalo)
        {
            throw new NotImplementedException();
        }

        public UpSelling Insertar(UpSelling upSelling)
        {
            throw new NotImplementedException();
        }

        public void EliminarDetalle(int upSellingDetalleId)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// No stored procedure created yet
        /// </summary>
        /// <param name="upSellingId"></param>
        /// <returns></returns>
        public UpSelling Obtener(int upSellingId)
        {
            throw new NotImplementedException();
        }

        public void Eliminar(int upSellingId)
        {
            throw new NotImplementedException();
        }
    }
}
