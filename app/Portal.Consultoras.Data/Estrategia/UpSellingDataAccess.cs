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
        public UpSellingDataAccess(int paisId) : base(paisId, EDbSource.Portal)
        { }

        //todo: complete access

        /// <summary>
        /// No stored procedure created yet
        /// </summary>
        /// <param name="upSellingId"></param>
        /// <returns></returns>
        public UpSelling Obtener(int? upSellingId)
        {
            var upSellings = Obtener(upSellingId, null);

            return upSellings.FirstOrDefault();
        }

        public IEnumerable<UpSelling> Obtener(int? upSellingId, string codigoCampana)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSelling_Select"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);
                Context.Database.AddInParameter(command, "@codigoCampana", DbType.String, codigoCampana);

                var reader = Context.ExecuteReader(command);

                var data = reader.MapToCollection<UpSelling>(true);
                return data;
            }
        }

        public UpSelling Insertar(UpSelling upSelling)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSelling_Insert"))
            {
                Context.Database.AddInParameter(command, "@CodigoCampana", DbType.Int32, upSelling.CodigoCampana);
                Context.Database.AddInParameter(command, "@MontoMeta", DbType.Decimal, upSelling.MontoMeta);
                Context.Database.AddInParameter(command, "@TextoMeta1", DbType.String, upSelling.TextoMeta);
                Context.Database.AddInParameter(command, "@TextoMeta2", DbType.String, upSelling.TextoMetaSecundario);
                Context.Database.AddInParameter(command, "@TextoGanaste1", DbType.String, upSelling.TextoGanaste);
                Context.Database.AddInParameter(command, "@TextoGanaste2", DbType.String, upSelling.TextoGanasteSecundario);
                Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, upSelling.Activo);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, upSelling.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@FechaCreacion", DbType.DateTime, upSelling.FechaCreacion);
                Context.Database.AddInParameter(command, "@UsuarioModicacion", DbType.String, upSelling.UsuarioModicacion);
                Context.Database.AddInParameter(command, "@FechaModificacion", DbType.DateTime, upSelling.FechaModificacion);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSelling>(true);
            }
        }

        public UpSelling Actualizar(UpSelling upSelling)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSelling_Update"))
            {
                Context.Database.AddInParameter(command, "@CodigoCampana", DbType.Int32, upSelling.CodigoCampana);
                Context.Database.AddInParameter(command, "@MontoMeta", DbType.Decimal, upSelling.MontoMeta);
                Context.Database.AddInParameter(command, "@TextoMeta1", DbType.String, upSelling.TextoMeta);
                Context.Database.AddInParameter(command, "@TextoMeta2", DbType.String, upSelling.TextoMetaSecundario);
                Context.Database.AddInParameter(command, "@TextoGanaste1", DbType.String, upSelling.TextoGanaste);
                Context.Database.AddInParameter(command, "@TextoGanaste2", DbType.String, upSelling.TextoGanasteSecundario);
                Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, upSelling.Activo);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, upSelling.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@FechaCreacion", DbType.DateTime, upSelling.FechaCreacion);
                Context.Database.AddInParameter(command, "@UsuarioModicacion", DbType.String, upSelling.UsuarioModicacion);
                Context.Database.AddInParameter(command, "@FechaModificacion", DbType.DateTime, upSelling.FechaModificacion);
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSelling.UpSellingId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSelling>(true);
            }
        }

        public int Eliminar(int upSellingId)
        {
            using (var command = Context.Database.GetStoredProcCommand("DBO.UpSelling_Delete"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);
                var reader = Context.ExecuteReader(command);
                return reader.RecordsAffected;
            }
        }

        public List<UpSellingDetalle> ObtenerDetalle(int upSellingId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Select"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToCollection<UpSellingDetalle>(true);
            }
        }

        public UpSellingDetalle InsertarDetalle(UpSellingDetalle regalo)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Insert"))
            {
                Context.Database.AddInParameter(command, "@CUV", DbType.String, regalo.UpSellingId);
                Context.Database.AddInParameter(command, "@Nombre", DbType.String, regalo.Nombre);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, regalo.Descripcion);
                Context.Database.AddInParameter(command, "@Imagen", DbType.String, regalo.Imagen);
                Context.Database.AddInParameter(command, "@Stock", DbType.Int32, regalo.Stock);
                Context.Database.AddInParameter(command, "@Orden", DbType.Int32, regalo.Orden);
                Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, regalo.Activo);
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, regalo.UpSellingId);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, regalo.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@FechaCreacion", DbType.DateTime, regalo.FechaCreacion);
                Context.Database.AddInParameter(command, "@UsuarioModicacion", DbType.String, regalo.UsuarioModicacion);
                Context.Database.AddInParameter(command, "@FechaModificacion", DbType.DateTime, regalo.FechaModificacion);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSellingDetalle>(true);
            }
        }


        public UpSellingDetalle ActualizarDetalle(UpSellingDetalle regalo)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Update"))
            {
                Context.Database.AddInParameter(command, "@CUV", DbType.String, regalo.UpSellingId);
                Context.Database.AddInParameter(command, "@Nombre", DbType.String, regalo.Nombre);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, regalo.Descripcion);
                Context.Database.AddInParameter(command, "@Imagen", DbType.String, regalo.Imagen);
                Context.Database.AddInParameter(command, "@Stock", DbType.Int32, regalo.Stock);
                Context.Database.AddInParameter(command, "@Orden", DbType.Int32, regalo.Orden);
                Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, regalo.Activo);
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, regalo.UpSellingId);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, regalo.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@FechaCreacion", DbType.DateTime, regalo.FechaCreacion);
                Context.Database.AddInParameter(command, "@UsuarioModicacion", DbType.String, regalo.UsuarioModicacion);
                Context.Database.AddInParameter(command, "@FechaModificacion", DbType.DateTime, regalo.FechaModificacion);
                Context.Database.AddInParameter(command, "@UpSellingDetalleId", DbType.Int32, regalo.UpSellingDetalleId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSellingDetalle>(true);
            }
        }

        public int EliminarDetalle(int upSellingDetalleId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Delete"))
            {
                Context.Database.AddInParameter(command, "@UpSellingDetalleId", DbType.Int32, upSellingDetalleId);
                var reader = Context.ExecuteReader(command);
                return reader.RecordsAffected;
            }
        }
    }
}
