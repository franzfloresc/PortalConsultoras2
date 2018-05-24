using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAOfertaNueva : DataAccess
    {
        public DAOfertaNueva(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetOfertasNuevasByCampania(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOfertasNuevasByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPackOfertasNuevasByCampania(int paisID, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPackOfertasNuevasByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);

            return Context.ExecuteReader(command);
        }

        public int ValidarOfertasNuevas(BEOfertaNueva oBe)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarOfertasNuevas");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.AnsiString, oBe.CodigoCampania);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, oBe.CUV);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int ValidarUnidadesPermitidas(BEOfertaNueva oBe)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUnidadesPermitidas");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.AnsiString, oBe.CodigoCampania);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, oBe.CUV);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, oBe.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, oBe.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, oBe.ConfiguracionOfertaID);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int InsertOfertasNuevas(BEOfertaNueva oBe)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertOfertasNuevas");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, oBe.CampaniaID);
            Context.Database.AddInParameter(command, "@CampaniaIDFin", DbType.Int32, oBe.CampaniaIDFin);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, oBe.CUV);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, oBe.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, oBe.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.AnsiString, oBe.NumeroPedido);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, oBe.Descripcion);
            Context.Database.AddInParameter(command, "@PrecioNormal", DbType.Decimal, oBe.PrecioNormal);
            Context.Database.AddInParameter(command, "@PrecioParaTi", DbType.Decimal, oBe.PrecioParaTi);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, oBe.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@ImagenProducto01", DbType.AnsiString, oBe.ImagenProducto01);
            Context.Database.AddInParameter(command, "@ImagenProducto02", DbType.AnsiString, oBe.ImagenProducto02);
            Context.Database.AddInParameter(command, "@ImagenProducto03", DbType.AnsiString, oBe.ImagenProducto03);
            Context.Database.AddInParameter(command, "@FlagImagenActiva", DbType.Int16, oBe.FlagImagenActiva);
            Context.Database.AddInParameter(command, "@FlagHabilitarOferta", DbType.Boolean, oBe.FlagHabilitarOferta);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, oBe.UsuarioRegistro);
            Context.Database.AddInParameter(command, "@ganahasta", DbType.Decimal, oBe.ganahasta);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertasNuevas(BEOfertaNueva oBe)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdOfertasNuevas");
            Context.Database.AddInParameter(command, "@OfertaNuevaId", DbType.Int32, oBe.OfertaNuevaId);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, oBe.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, oBe.CUV);
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.AnsiString, oBe.NumeroPedido);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, oBe.Descripcion);
            Context.Database.AddInParameter(command, "@PrecioNormal", DbType.Decimal, oBe.PrecioNormal);
            Context.Database.AddInParameter(command, "@PrecioParaTi", DbType.Decimal, oBe.PrecioParaTi);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, oBe.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@ImagenProducto01", DbType.AnsiString, oBe.ImagenProducto01);
            Context.Database.AddInParameter(command, "@ImagenProducto02", DbType.AnsiString, oBe.ImagenProducto02);
            Context.Database.AddInParameter(command, "@ImagenProducto03", DbType.AnsiString, oBe.ImagenProducto03);
            Context.Database.AddInParameter(command, "@FlagImagenActiva", DbType.Int16, oBe.FlagImagenActiva);
            Context.Database.AddInParameter(command, "@FlagHabilitarOferta", DbType.Boolean, oBe.FlagHabilitarOferta);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, oBe.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@ganahasta", DbType.Decimal, oBe.ganahasta);
            return Context.ExecuteNonQuery(command);
        }

        public int DelOfertasNuevas(BEOfertaNueva oBe, int ConfiguracionOfertaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelOfertasNuevas");
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, oBe.CUV);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, oBe.CampaniaID);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, oBe.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int ObtenerEstadoPacksOfertasNuevas(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadoPacksOfertasNuevas");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int UpdEstadoPacksOfertasNuevas(string CodigoConsultora, int CambioEstado)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdEstadoPacksOfertasNuevas");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@PacksOfertaNueva", DbType.Int32, CambioEstado);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetDescripcionPackByCUV(string CUV, int CampaniaCodigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDescripcionPackByCUV");
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.Int32, CampaniaCodigo);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductosOfertaConsultoraNueva(int CampaniaID, int consultoraid)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductosOfertaConsultoraNueva");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraid);

            return Context.ExecuteReader(command);
        }

        public int UpdEstadoPacksOfertasNueva(int idconsultora, string CodigoConsultora, int campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdestadoAccesoPackNueva");
            Context.Database.AddInParameter(command, "@idconsultora", DbType.Int32, idconsultora);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campania);

            return Context.ExecuteNonQuery(command);
        }

        public int ObtenerEstadoPacksOfertasNueva(int idconsultora, int campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadoPacksOfertasNueva");
            Context.Database.AddInParameter(command, "@idconsultora", DbType.Int32, idconsultora);
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campania);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

    }
}