using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

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
                Context.Database.AddInParameter(command, "@TieneImagen", DbType.Int32, entidad.Imagen);
                Context.Database.AddInParameter(command, "@Activo", DbType.Int32, entidad.Activo);
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@CodigoConcurso", DbType.String, entidad.CodigoConcurso);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaDetalle(int idEstrategiaDetalle)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstrategiaDetalle"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, idEstrategiaDetalle);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader FiltrarEstrategia(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.FiltrarEstrategia"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                Context.Database.AddInParameter(command, "@CUV2", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@AgregarEnMatriz", DbType.Boolean, entidad.AgregarEnMatriz);
                Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.String, entidad.UsuarioRegistro);
                	 


                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetImagenesByEstrategiaMatrizComercialImagen(BEEstrategia entidad, int numeroPagina, int registros)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetImagenesByEstrategiaMatrizComercialImagen"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                Context.Database.AddInParameter(command, "@CUV2", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@NumeroPagina", DbType.Int32, numeroPagina);
                Context.Database.AddInParameter(command, "@Registros", DbType.Int32, registros);
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
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarEstrategia_SB2"))
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
                Context.Database.AddInParameter(command, "@Precio", DbType.Decimal, entidad.Precio);
                Context.Database.AddInParameter(command, "@FlagCEP", DbType.Int32, entidad.FlagCEP);
                Context.Database.AddInParameter(command, "@CUV2", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@EtiquetaID2", DbType.Int32, entidad.EtiquetaID2);
                Context.Database.AddInParameter(command, "@Precio2", DbType.Decimal, entidad.Precio2);
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
                Context.Database.AddInParameter(command, "@CodigoEstrategia", DbType.String, entidad.CodigoEstrategia);
                Context.Database.AddInParameter(command, "@TieneVariedad", DbType.Int32, entidad.TieneVariedad);
                Context.Database.AddInParameter(command, "@Ganancia", DbType.Decimal, entidad.Ganancia);
                Context.Database.AddInParameter(command, "@EsOfertaIndependiente", DbType.Boolean, entidad.EsOfertaIndependiente);
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@CodigoConcurso", DbType.String, entidad.CodigoConcurso);
                Context.Database.AddInParameter(command, "@ImagenMiniaturaURL", DbType.String, entidad.ImagenMiniaturaURL);
                Context.Database.AddInParameter(command, "@EsSubCampania", DbType.Int32, entidad.EsSubCampania);
                Context.Database.AddInParameter(command, "@Niveles", DbType.String, entidad.Niveles);
                Context.Database.AddOutParameter(command, "@Retorno", DbType.Int32, 1000);
                Context.ExecuteNonQuery(command);
                result = Convert.ToInt32(command.Parameters["@Retorno"].Value);
            }
            return result;
        }

        public int InsertEstrategiaDetalle(BEEstrategiaDetalle entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarEstrategiaDetalle"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
                Context.Database.AddInParameter(command, "@FlagIndividual", DbType.Boolean, entidad.FlagIndividual);
                Context.Database.AddInParameter(command, "@Slogan", DbType.String, entidad.Slogan);
                Context.Database.AddInParameter(command, "@ImgHomeDesktop", DbType.String, entidad.ImgHomeDesktop);
                Context.Database.AddInParameter(command, "@ImgFondoDesktop", DbType.String, entidad.ImgFondoDesktop);
                Context.Database.AddInParameter(command, "@ImgFichaDesktop", DbType.String, entidad.ImgFichaDesktop);
                Context.Database.AddInParameter(command, "@ImgFichaFondoDesktop", DbType.String, entidad.ImgFichaFondoDesktop);
                Context.Database.AddInParameter(command, "@UrlVideoDesktop", DbType.String, entidad.UrlVideoDesktop);
                Context.Database.AddInParameter(command, "@ImgHomeMobile", DbType.String, entidad.ImgHomeMobile);
                Context.Database.AddInParameter(command, "@ImgFondoMobile", DbType.String, entidad.ImgFondoMobile);
                Context.Database.AddInParameter(command, "@ImgFichaMobile", DbType.String, entidad.ImgFichaMobile);
                Context.Database.AddInParameter(command, "@ImgFichaFondoMobile", DbType.String, entidad.ImgFichaFondoMobile);
                Context.Database.AddInParameter(command, "@UrlVideoMobile", DbType.String, entidad.UrlVideoMobile);
                Context.Database.AddOutParameter(command, "@Retorno", DbType.Int32, 0);
                Context.ExecuteNonQuery(command);
                result = Convert.ToInt32(command.Parameters["@Retorno"].Value);
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

        public int EliminarEstrategia(BEEstrategia entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EliminarEstrategia"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, entidad.EstrategiaID);
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
                Context.Database.AddInParameter(command, "@CodigoAgrupacion", DbType.String, entidad.CodigoAgrupacion);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaOfertaWeb(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasOfertaWeb"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@ZonaID", DbType.String, entidad.Zona);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaPackNuevas(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasPackNuevas"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.ConsultoraID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaLanzamiento(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasLanzamiento"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.ConsultoraID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaOfertaParaTi(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasOPT"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.ConsultoraID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaRevistaDigital(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasRevistaDigital"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.ConsultoraID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaGuiaDeNegocioDigitalizada(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasGuiaDeNegocioDigitalizada"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.ConsultoraID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaHerramientasVenta(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasHerramientasVenta"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.ConsultoraID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaShowRoom(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("ListarEstrategiasShowRoom"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.ConsultoraID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaMasVendidos(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarOfertasMasVendidos"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, entidad.ConsultoraID);
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

        public IDataReader GetRegionZonaZE(int RegionID, int ZonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetRegionZonaZE");
            Context.Database.AddInParameter(command, "@region", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@zona", DbType.Int32, ZonaID);

            return Context.ExecuteReader(command);
        }

        public string GetImagenOfertaPersonalizadaOF(int campaniaID, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetImagenOfertaPersonalizadaOF_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, cuv);

            return Context.ExecuteScalar(command).ToString();
        }
        
        public IDataReader GetEstrategiaODD(int codCampania, string codConsultora, DateTime fechaInicioFact)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEstrategiasODD"))
            {
                Context.Database.AddInParameter(command, "@CodCampania", DbType.Int32, codCampania);
                Context.Database.AddInParameter(command, "@CodConsultora", DbType.String, codConsultora);
                if (fechaInicioFact == default(DateTime))
                    Context.Database.AddInParameter(command, "@FechaInicioFact", DbType.Date, DBNull.Value);
                else
                    Context.Database.AddInParameter(command, "@FechaInicioFact", DbType.Date, fechaInicioFact);
                return Context.ExecuteReader(command);
            }
        }

        public int ActivarDesactivarEstrategias(string UsuarioModificacion, string EstrategiasActivas, string EstrategiasDesactivas)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActivarDesactivarEstrategias"))
            {
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, UsuarioModificacion);
                Context.Database.AddInParameter(command, "@EstrategiasActivas", DbType.String, EstrategiasActivas);
                Context.Database.AddInParameter(command, "@EstrategiasDesactivas", DbType.String, EstrategiasDesactivas);

                result = int.Parse(Context.ExecuteScalar(command).ToString());
            }
            return result;
        }

        #region Producto Comentario

        public int InsertarProductoComentario(BEProductoComentario entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertProductoComentario"))
            {
                Context.Database.AddInParameter(command, "@CodigoSap", DbType.String, entidad.CodigoSap);
                Context.Database.AddInParameter(command, "@CodigoGenerico", DbType.String, entidad.CodigoGenerico);

                result = int.Parse(Context.ExecuteScalar(command).ToString());
            }
            return result;
        }

        public int InsertarProductoComentarioDetalle(BEProductoComentarioDetalle entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertProductoComentarioDetalle"))
            {
                Context.Database.AddInParameter(command, "@ProdComentarioId", DbType.Int64, entidad.ProdComentarioId);
                Context.Database.AddInParameter(command, "@Valorizado", DbType.Int16, entidad.Valorizado);
                Context.Database.AddInParameter(command, "@Recomendado", DbType.Boolean, entidad.Recomendado);
                Context.Database.AddInParameter(command, "@Comentario", DbType.String, entidad.Comentario);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.CodigoConsultora);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CodTipoOrigen", DbType.Int32, entidad.CodTipoOrigen);

                result = int.Parse(Context.ExecuteScalar(command).ToString());
            }
            return result;
        }

        public IDataReader GetProductoComentarioByCodSap(string codigoSap)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoComentarioByCodSap"))
            {
                Context.Database.AddInParameter(command, "@CodigoSap", DbType.String, codigoSap);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetUltimoProductoComentarioByCodigoSap(string codigoSap)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUltimoProductoComentarioByCodSap"))
            {
                Context.Database.AddInParameter(command, "@CodigoSap", DbType.String, codigoSap);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetListaProductoComentarioDetalleaResumen(BEProductoComentarioFilter filter)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetListaProductoComentarioDetalleResumen"))
            {
                Context.Database.AddInParameter(command, "@CodigoSAP", DbType.String, filter.Valor);
                Context.Database.AddInParameter(command, "@Limite", DbType.Int32, filter.Limite);
                Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, filter.Cantidad);
                Context.Database.AddInParameter(command, "@Ordenar", DbType.Int16, filter.Ordenar);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetListaProductoComentarioDetalleAprobar(BEProductoComentarioFilter filter)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetListaProductoComentarioDetalleAprobar"))
            {
                Context.Database.AddInParameter(command, "@Estado", DbType.Int16, filter.Estado);
                Context.Database.AddInParameter(command, "@Tipo", DbType.Int16, filter.Tipo);
                Context.Database.AddInParameter(command, "@Codigo", DbType.String, filter.Valor);
                Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, filter.CampaniaID);
                Context.Database.AddInParameter(command, "@Limite", DbType.Int32, filter.Limite);
                Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, filter.Cantidad);
                Context.Database.AddInParameter(command, "@Ordenar", DbType.Int16, filter.Ordenar);
                return Context.ExecuteReader(command);
            }
        }

        public int AprobarProductoComentarioDetalle(int prodComentarioId, long prodComentarioDetalleId, Int16 estado)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.AprobarProductoComentarioDetalle"))
            {
                Context.Database.AddInParameter(command, "@ProdComentarioId", DbType.Int32, prodComentarioId);
                Context.Database.AddInParameter(command, "@ProdComentarioDetalleId", DbType.Int64, prodComentarioDetalleId);
                Context.Database.AddInParameter(command, "@Estado", DbType.Int16, estado);
                result = int.Parse(Context.ExecuteScalar(command).ToString());
            }
            return result;
        }
        #endregion

        #region ActualizarDescripcion
        public IDataReader ActualizarDescripcionEstrategia(int campaniaId, int tipoEstrategiaId, List<BEDescripcionEstrategia> listaDescripcionEstrategias)
        {
            var command =
                new SqlCommand("dbo.ActualizarDescripcionEstrategia") { CommandType = CommandType.StoredProcedure };

            command.Parameters.Add(new SqlParameter("@DescripcionEstrategia", SqlDbType.Structured)
            {
                TypeName = "dbo.DescripcionEstrategiaType",
                Value = new GenericDataReader<BEDescripcionEstrategia>(listaDescripcionEstrategias)
            });
            command.Parameters.Add(new SqlParameter("@CampaniaId", SqlDbType.Int) { Value = campaniaId });
            command.Parameters.Add(new SqlParameter("@TipoEstrategiaId", SqlDbType.Int) { Value = tipoEstrategiaId });
            return Context.ExecuteReader(command);
        }
        #endregion
        
        public List<int> InsertarEstrategiaMasiva(BEEstrategiaMasiva entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarEstrategiaMasiva"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaXML", DbType.Xml, entidad.EstrategiaXML.ToString());
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, entidad.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);
                Context.Database.AddOutParameter(command, "@RetornoActualizacion", DbType.Int32, 1000);
                Context.Database.AddOutParameter(command, "@RetornoInsercion", DbType.Int32, 1000);
                Context.ExecuteNonQuery(command);
                List<int> result = new List<int>() { Convert.ToInt32(command.Parameters["@RetornoActualizacion"].Value), Convert.ToInt32(command.Parameters["@RetornoInsercion"].Value) };
                return result;
            }
        }
        public List<int> InsertarProductoShowroomMasiva(BEEstrategiaMasiva entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarProductoShowroomMasiva"))
            {
                Context.Database.AddInParameter(command, "@EstrategiaXML", DbType.Xml, entidad.EstrategiaXML.ToString());
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);
                Context.Database.AddOutParameter(command, "@RetornoActualizacion", DbType.Int32, 1000);
                Context.ExecuteNonQuery(command);
                List<int> result = new List<int>() { Convert.ToInt32(command.Parameters["@RetornoActualizacion"].Value) };
                return result;
            }
        }

        #region Nuevo Masivo

        public int GetCantidadOfertasPersonalizadas(int campaniaId, int tipoConfigurado, string codigoEstrategia)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCantidadOfertasPersonalizadas"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
                Context.Database.AddInParameter(command, "@TipoConfigurado", DbType.Int32, tipoConfigurado);
                Context.Database.AddInParameter(command, "@CodigoEstrategia", DbType.String, codigoEstrategia);
                command.CommandTimeout = 0;
                result = int.Parse(Context.ExecuteScalar(command).ToString());
            }
            return result;
        }

        public IDataReader GetOfertasPersonalizadasByTipoConfigurado(int campaniaId, int tipoConfigurado, string estrategiaCodigo, int pagina, int cantidadCuv)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOfertasPersonalizadasByTipoConfigurado"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
                Context.Database.AddInParameter(command, "@TipoConfigurado", DbType.Int32, tipoConfigurado);
                Context.Database.AddInParameter(command, "@EstrategiaCodigo", DbType.String, estrategiaCodigo);
                Context.Database.AddInParameter(command, "@Pagina", DbType.Int32, pagina);
                Context.Database.AddInParameter(command, "@CantCuv", DbType.Int32, cantidadCuv);
                command.CommandTimeout = 0;
                return Context.ExecuteReader(command);
            }
        }

        public int GetCantidadOfertasPersonalizadasTemporal(int nroLote, int tipoConfigurado)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCantidadOfertasPersonalizadasTemporal"))
            {
                Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
                Context.Database.AddInParameter(command, "@TipoConfigurado", DbType.Int32, tipoConfigurado);

                result = int.Parse(Context.ExecuteScalar(command).ToString());
            }
            return result;
        }

        public int EstrategiaTemporalDelete(int nroLote)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EstrategiaTemporalDelete"))
            {
                Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }

        public IDataReader GetOfertasPersonalizadasByTipoConfiguradoTemporal(int tipoConfigurado, int nroLote)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOfertasPersonalizadasByTipoConfiguradoTemporal"))
            {
                Context.Database.AddInParameter(command, "@TipoConfigurado", DbType.Int32, tipoConfigurado);
                Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetEstrategiaProgramaNuevas(BEEstrategia entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstrategiaProgramaNuevas"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV2);
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@CodigoEstrategia", DbType.String, entidad.CodigoEstrategia);

                return Context.ExecuteReader(command);
            }
        }

        public int EstrategiaTemporalInsertarMasivo(int campaniaId, string estrategiaCodigo, int pagina, int cantidadCuv, int nroLote)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EstrategiaTemporalInsertarMasivo"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
                Context.Database.AddInParameter(command, "@EstrategiaCodigo", DbType.String, estrategiaCodigo);
                Context.Database.AddInParameter(command, "@Pagina", DbType.Int32, pagina);
                Context.Database.AddInParameter(command, "@CantidadCuv", DbType.Int32, cantidadCuv);
                Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
                Context.Database.AddOutParameter(command, "@NroLoteFinal", DbType.Int32, 100000);
                Context.ExecuteReader(command);
                return Convert.ToInt32(command.Parameters["@NroLoteFinal"].Value);
            }
        }

        public bool EstrategiaTemporalActualizarPrecioNivel(int nroLote, int pagina)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EstrategiaTemporalActualizarPrecioNivel"))
            {
                Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
                Context.Database.AddInParameter(command, "@Pagina", DbType.Int32, pagina);
                Context.ExecuteReader(command);
                return true;
            }
        }

        public bool EstrategiaTemporalActualizarSetDetalle(int nroLote, int pagina)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EstrategiaTemporalActualizarSetDetalle"))
            {
                Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
                Context.Database.AddInParameter(command, "@Pagina", DbType.Int32, pagina);
                Context.ExecuteReader(command);
                return true;
            }
        }

        public int EstrategiaTemporalInsertarEstrategiaMasivo(int nroLote)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EstrategiaTemporalInsertarEstrategiaMasivo"))
            {
                Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
                Context.Database.AddOutParameter(command, "@NroLoteFinal", DbType.Int32, 100000);
                Context.ExecuteReader(command);
                return Convert.ToInt32(command.Parameters["@NroLoteFinal"].Value);
            }
        }
        #endregion
    }
}