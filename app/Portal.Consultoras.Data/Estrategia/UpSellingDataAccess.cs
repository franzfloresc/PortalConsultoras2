using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Estrategia;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.Data.Estrategia
{
    public class UpSellingDataAccess : DataAccess
    {
        public UpSellingDataAccess(int paisId) : base(paisId, EDbSource.Portal)
        { }

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

                var data = reader.MapToCollection<UpSelling>(closeReaderFinishing: true);
                return data;
            }
        }

        public UpSelling Insertar(UpSelling upSelling)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSelling_Insert"))
            {
                Context.Database.AddInParameter(command, "@CodigoCampana", DbType.Int32, upSelling.CodigoCampana);
                Context.Database.AddInParameter(command, "@TextoMetaPrincipal", DbType.String, upSelling.TextoMetaPrincipal);
                Context.Database.AddInParameter(command, "@TextoInferior", DbType.String, upSelling.TextoInferior);
                Context.Database.AddInParameter(command, "@TextoGanastePrincipal", DbType.String, upSelling.TextoGanastePrincipal);
                Context.Database.AddInParameter(command, "@TextoGanasteBoton", DbType.String, upSelling.TextoGanasteBoton);
                Context.Database.AddInParameter(command, "@TextoGanastePremio", DbType.String, upSelling.TextoGanastePremio);
                Context.Database.AddInParameter(command, "@ImagenFondoPrincipalDesktop", DbType.String, upSelling.ImagenFondoPrincipalDesktop);
                Context.Database.AddInParameter(command, "@ImagenFondoPrincipalMobile", DbType.String, upSelling.ImagenFondoPrincipalMobile);
                Context.Database.AddInParameter(command, "@ImagenFondoGanasteMobile", DbType.String, upSelling.ImagenFondoGanasteMobile);
                Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, upSelling.Activo);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, upSelling.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@FechaCreacion", DbType.DateTime, upSelling.FechaCreacion);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSelling>(closeReaderFinishing: true);
            }
        }

        public UpSelling Actualizar(UpSelling upSelling)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSelling_Update"))
            {
                Context.Database.AddInParameter(command, "@CodigoCampana", DbType.Int32, upSelling.CodigoCampana);
                Context.Database.AddInParameter(command, "@TextoMetaPrincipal", DbType.String, upSelling.TextoMetaPrincipal);
                Context.Database.AddInParameter(command, "@TextoInferior", DbType.String, upSelling.TextoInferior);
                Context.Database.AddInParameter(command, "@TextoGanastePrincipal", DbType.String, upSelling.TextoGanastePrincipal);
                Context.Database.AddInParameter(command, "@TextoGanasteBoton", DbType.String, upSelling.TextoGanasteBoton);
                Context.Database.AddInParameter(command, "@TextoGanastePremio", DbType.String, upSelling.TextoGanastePremio);
                Context.Database.AddInParameter(command, "@ImagenFondoPrincipalDesktop", DbType.String, upSelling.ImagenFondoPrincipalDesktop);
                Context.Database.AddInParameter(command, "@ImagenFondoPrincipalMobile", DbType.String, upSelling.ImagenFondoPrincipalMobile);
                Context.Database.AddInParameter(command, "@ImagenFondoGanasteMobile", DbType.String, upSelling.ImagenFondoGanasteMobile);
                Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, upSelling.Activo);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, upSelling.UsuarioModificacion);
                Context.Database.AddInParameter(command, "@FechaModificacion", DbType.DateTime, upSelling.FechaModificacion);
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSelling.UpSellingId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSelling>(closeReaderFinishing: true);
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

        public List<UpSellingDetalle> ObtenerDetalles(int upSellingId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Select"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToCollection<UpSellingDetalle>(closeReaderFinishing: true);
            }
        }

        public UpSellingDetalle InsertarDetalle(UpSellingDetalle regalo)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Insert"))
            {
                Context.Database.AddInParameter(command, "@CUV", DbType.String, regalo.CUV);
                Context.Database.AddInParameter(command, "@Nombre", DbType.String, regalo.Nombre);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, regalo.Descripcion);
                Context.Database.AddInParameter(command, "@Imagen", DbType.String, regalo.Imagen);
                Context.Database.AddInParameter(command, "@Stock", DbType.Int32, regalo.Stock);
                Context.Database.AddInParameter(command, "@Orden", DbType.Int32, regalo.Orden);
                Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, regalo.Activo);
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, regalo.UpSellingId);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, regalo.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@FechaCreacion", DbType.DateTime, regalo.FechaCreacion);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSellingDetalle>(closeReaderFinishing: true);
            }
        }

        public UpSellingDetalle ObtenerDetalle(int upSellingDetalleId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Select_By_Id"))
            {
                Context.Database.AddInParameter(command, "@UpSellingDetalleId", DbType.Int32, upSellingDetalleId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSellingDetalle>(closeReaderFinishing: true);
            }
        }

        public UpSellingDetalle ActualizarDetalle(UpSellingDetalle regalo)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Update"))
            {
                Context.Database.AddInParameter(command, "@CUV", DbType.String, regalo.CUV);
                Context.Database.AddInParameter(command, "@Nombre", DbType.String, regalo.Nombre);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, regalo.Descripcion);
                Context.Database.AddInParameter(command, "@Imagen", DbType.String, regalo.Imagen);
                Context.Database.AddInParameter(command, "@Stock", DbType.Int32, regalo.Stock);
                Context.Database.AddInParameter(command, "@Orden", DbType.Int32, regalo.Orden);
                Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, regalo.Activo);
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, regalo.UpSellingId);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, regalo.UsuarioModificacion);
                Context.Database.AddInParameter(command, "@FechaModificacion", DbType.DateTime, regalo.FechaModificacion);
                Context.Database.AddInParameter(command, "@UpSellingDetalleId", DbType.Int32, regalo.UpSellingDetalleId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSellingDetalle>(closeReaderFinishing: true);
            }
        }

        public int EliminarDetalle(int upSellingDetalleId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.UpSellingDetalle_Delete"))
            {
                Context.Database.AddInParameter(command, "@UpSellingDetalleId", DbType.Int32, upSellingDetalleId);
                var reader = Context.ExecuteReader(command);

                var recordsAffected = reader.RecordsAffected;
                if (!reader.IsClosed)
                    reader.Close();

                return recordsAffected;
            }
        }

        public UpSellingRegalo ObtenerMontoMeta(int campaniaId, long consultoraId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetOfertaFinalRegaloMontoMeta"))
            {
                Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, campaniaId);
                Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int32, consultoraId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSellingRegalo>(closeReaderFinishing: true);
            }
        }

        public int InsertarRegalo(UpSellingRegalo entidad)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.InsertUpSellingRegalo"))
            {
                Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, entidad.CampaniaId);
                Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int32, entidad.ConsultoraId);
                Context.Database.AddInParameter(command, "@MontoPedido", DbType.Decimal, entidad.MontoPedido);
                Context.Database.AddInParameter(command, "@GapMinimo", DbType.Decimal, entidad.GapMinimo);
                Context.Database.AddInParameter(command, "@GapMaximo", DbType.Decimal, entidad.GapMaximo);
                Context.Database.AddInParameter(command, "@GapAgregar", DbType.Decimal, entidad.GapAgregar);
                Context.Database.AddInParameter(command, "@MontoMeta", DbType.Decimal, entidad.MontoMeta);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@TipoRango", DbType.String, entidad.TipoRango);
                Context.Database.AddInParameter(command, "@MontoPedidoFinal", DbType.Decimal, entidad.MontoPedidoFinal);
                Context.Database.AddInParameter(command, "@UpSellingDetalleId", DbType.Int32, entidad.UpSellingDetalleId);

                return Convert.ToInt32(Context.ExecuteScalar(command));
            }
        }

        public UpSellingRegalo ObtenerRegaloGanado(int campaniaid, long consultoraId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetObtenerOfertaFinalRegaloSorpresa"))
            {
                Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, campaniaid);
                Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int32, consultoraId);

                var reader = Context.ExecuteReader(command);
                return reader.MapToObject<UpSellingRegalo>(closeReaderFinishing: true);
            }
        }

        public IEnumerable<UpSellingMontoMeta> ListarReporteMontoMeta(int upSellingId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.OfertaFinalMontoMeta_Select"))
            {
                Context.Database.AddInParameter(command, "@UpSellingId", DbType.Int32, upSellingId);
                var reader = Context.ExecuteReader(command);

                var lista = reader.MapToCollection<UpSellingMontoMeta>(closeReaderFinishing: true);
                return lista;
            }
        }
    }
}
