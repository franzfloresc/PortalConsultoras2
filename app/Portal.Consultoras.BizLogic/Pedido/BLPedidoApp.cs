using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido.App;
using Portal.Consultoras.Common;
using Portal.Consultoras.PublicService.Cryptography;
using Portal.Consultoras.Data.ServiceCalculoPROL;

using System;
using System.Linq;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLPedidoApp : IPedidoAppBusinessLogic
    {
        private readonly IProductoBusinessLogic _productoBusinessLogic;
        private readonly IPedidoWebBusinessLogic _pedidoWebBusinessLogic;
        private readonly IPedidoWebDetalleBusinessLogic _pedidoWebDetalleBusinessLogic;
        private readonly IEstrategiaBusinessLogic _estrategiaBusinessLogic;
        private readonly IConfiguracionProgramaNuevasBusinessLogic _configuracionProgramaNuevasBusinessLogic;
        private readonly IConsultoraConcursoBusinessLogic _consultoraConcursoBusinessLogic;
        private readonly IUsuarioBusinessLogic _usuarioBusinessLogic;

        private List<ObjMontosProl> montosProl = new List<ObjMontosProl> { new ObjMontosProl() };

        public BLPedidoApp() : this(new BLProducto(), 
                                    new BLPedidoWeb(),
                                    new BLPedidoWebDetalle(),
                                    new BLEstrategia(),
                                    new BLConfiguracionProgramaNuevas(),
                                    new BLConsultoraConcurso(),
                                    new BLUsuario())
        { }

        public BLPedidoApp(IProductoBusinessLogic productoBusinessLogic, 
                            IPedidoWebBusinessLogic pedidoWebBusinessLogic,
                            IPedidoWebDetalleBusinessLogic pedidoWebDetalleBusinessLogic,
                            IEstrategiaBusinessLogic estrategiaBusinessLogic,
                            IConfiguracionProgramaNuevasBusinessLogic configuracionProgramaNuevasBusinessLogic,
                            IConsultoraConcursoBusinessLogic consultoraConcursoBusinessLogic,
                            IUsuarioBusinessLogic usuarioBusinessLogic)
        {
            _productoBusinessLogic = productoBusinessLogic;
            _pedidoWebBusinessLogic = pedidoWebBusinessLogic;
            _pedidoWebDetalleBusinessLogic = pedidoWebDetalleBusinessLogic;
            _estrategiaBusinessLogic = estrategiaBusinessLogic;
            _configuracionProgramaNuevasBusinessLogic = configuracionProgramaNuevasBusinessLogic;
            _consultoraConcursoBusinessLogic = consultoraConcursoBusinessLogic;
            _usuarioBusinessLogic = usuarioBusinessLogic;
        }

        public BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar)
        {
            try
            {
                //Validación producto no existe
                var producto = _productoBusinessLogic.SelectProductoByCodigoDescripcionSearchRegionZona(
                                    productoBuscar.PaisID,
                                    productoBuscar.CampaniaID,
                                    productoBuscar.CodigoDescripcion,
                                    productoBuscar.RegionID,
                                    productoBuscar.ZonaID,
                                    productoBuscar.CodigoRegion,
                                    productoBuscar.CodigoZona,
                                    productoBuscar.Criterio,
                                    productoBuscar.RowCount,
                                    productoBuscar.ValidarOpt).FirstOrDefault();
                if (producto == null) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

                //Informacion de palancas
                var usuario = _usuarioBusinessLogic.GetSesionUsuarioPedidoApp(productoBuscar.PaisID, productoBuscar.CodigoUsuario);

                //Validación producto en catalogos
                var bloqueoProductoCatalogo = BloqueoProductosCatalogo(usuario.RevistaDigital, usuario.CodigosRevistaImpresa, producto, productoBuscar);
                if (!bloqueoProductoCatalogo) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validación Gana +
                var bloqueoProductoDigitales = BloqueoProductosDigitales(usuario, producto, productoBuscar);
                if (!bloqueoProductoDigitales) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validación producto agotado
                if (!producto.TieneStock) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_AGOTADO, null, producto);

                //Validación producto liquidaciones
                if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_LIQUIDACION, null, producto);

                //Validación producto showroom
                if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom)
                {
                    if (usuario.EsShowRoom) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_SHOWROOM, null, producto);
                    else return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_SHOWROOM_NODISPONIBLE, null, producto);
                }

                //Información de producto con oferta en revista
                if (usuario.RevistaDigital != null)
                {
                    var desactivaRevistaGana = _pedidoWebBusinessLogic.ValidarDesactivaRevistaGana(productoBuscar.PaisID, 
                                                    productoBuscar.CampaniaID,
                                                    productoBuscar.CodigoZona);
                    var tieneRDC = usuario.RevistaDigital.TieneRDC && usuario.RevistaDigital.EsActiva;
                    if (!producto.EsExpoOferta && producto.CUVRevista.Length != 0 && desactivaRevistaGana == 0 && !tieneRDC)
                    {
                        if (WebConfig.PaisesEsika.Contains(Util.GetPaisISO(productoBuscar.PaisID))) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA, null, producto);
                        else return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL, null, producto);
                    }
                }

                return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.SUCCESS, null, producto);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, productoBuscar.CodigoUsuario, productoBuscar.PaisID);
                return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_INTERNO, ex.Message);
            }
        }

        //public BEPedidoDetalleAppResult Insert(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    var mensaje = string.Empty;

        //    try
        //    {
        //        var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
        //                                                            pedidoDetalle.ConsultoraID,
        //                                                            pedidoDetalle.CampaniaID,
        //                                                            pedidoDetalle.UsuarioPrueba,
        //                                                            pedidoDetalle.AceptacionConsultoraDA);

        //        if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
        //            return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

        //        var result = ValidarStockEstrategia(pedidoDetalle, out mensaje);
        //        if (!result) return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

        //        if (pedidoDetalle.Producto.TipoOfertaSisID == 0)
        //        {
        //            var tipoEstrategiaID = 0;
        //            int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);
        //            pedidoDetalle.Producto.TipoOfertaSisID = tipoEstrategiaID;
        //        }

        //        var esOfertaNueva = (pedidoDetalle.Producto.FlagNueva == "1");
        //        if (esOfertaNueva) AgregarProductoZE(pedidoDetalle);

        //        var codeResult = PedidoInsertar(pedidoDetalle);
        //        if (codeResult != Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS) return PedidoInsertarRespuesta(codeResult);

        //        return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS, null, pedidoDetalle);
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.SaveLog(ex, pedidoDetalle.ConsultoraID, pedidoDetalle.PaisID);
        //        return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_INTERNO, ex.Message);
        //    }
        //}

        //public void UpdateProl(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;
        //    var puntajes = string.Empty;
        //    var puntajesExigidos = string.Empty;

        //    try
        //    {
        //        var lista = ServicioProl_CalculoMontosProl(pedidoDetalle);

        //        if (lista.Any())
        //        {
        //            var oRespuestaProl = lista[0];

        //            decimal.TryParse(oRespuestaProl.AhorroCatalogo, out montoAhorroCatalogo);
        //            decimal.TryParse(oRespuestaProl.AhorroRevista, out montoAhorroRevista);
        //            decimal.TryParse(oRespuestaProl.MontoTotalDescuento, out montoDescuento);
        //            decimal.TryParse(oRespuestaProl.MontoEscala, out montoEscala);

        //            if (oRespuestaProl.ListaConcursoIncentivos != null)
        //            {
        //                puntajes = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => c.puntajeconcurso.Split('|')[0]).ToArray());
        //                puntajesExigidos = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => (c.puntajeconcurso.IndexOf('|') > -1 ? c.puntajeconcurso.Split('|')[1] : "0")).ToArray());
        //            }
        //        }

        //        var bePedidoWeb = new BEPedidoWeb
        //        {
        //            PaisID = pedidoDetalle.PaisID,
        //            CampaniaID = pedidoDetalle.CampaniaID,
        //            ConsultoraID = pedidoDetalle.ConsultoraID,
        //            CodigoConsultora = pedidoDetalle.CodigoConsultora,
        //            MontoAhorroCatalogo = montoAhorroCatalogo,
        //            MontoAhorroRevista = montoAhorroRevista,
        //            DescuentoProl = montoDescuento,
        //            MontoEscala = montoEscala
        //        };

        //        _pedidoWebBusinessLogic.UpdateMontosPedidoWeb(bePedidoWeb);

        //        if (!string.IsNullOrEmpty(pedidoDetalle.CodigosConcursos))
        //            _consultoraConcursoBusinessLogic.ActualizarInsertarPuntosConcurso(pedidoDetalle.PaisID, pedidoDetalle.CodigoConsultora, pedidoDetalle.CampaniaID.ToString(), pedidoDetalle.CodigosConcursos, puntajes, puntajesExigidos);
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.SaveLog(ex, pedidoDetalle.ConsultoraID, pedidoDetalle.PaisID);
        //    }
        //}

        //public List<BEPedidoWebDetalle> GetDetalle(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    var pedidos = new List<BEPedidoWebDetalle>();

        //    try
        //    {
        //        pedidos = ObtenerPedidoWebDetalle(pedidoDetalle);
        //        pedidos.Where(x => x.ClienteID == 0).Update(x => x.NombreCliente = pedidoDetalle.NombreConsultora);
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.SaveLog(ex, pedidoDetalle.ConsultoraID, pedidoDetalle.PaisID);
        //    }

        //    return pedidos;
        //}

        #region GetCUV
        private bool BloqueoProductosCatalogo(BERevistaDigital revistaDigital, string codigosRevistaImpresa, BEProducto producto, BEProductoAppBuscar productoBuscar)
        {
            if (producto == null) return true;

            revistaDigital = revistaDigital ?? new BERevistaDigital();

            if (!revistaDigital.TieneRDC) return true;

            if (!revistaDigital.EsActiva) return true;

            if (revistaDigital.BloquearRevistaImpresaGeneral != null)
            {
                if (revistaDigital.BloquearRevistaImpresaGeneral == 1) return !codigosRevistaImpresa.Contains(producto.CodigoCatalogo.ToString());
            }
            else
            {
                if (revistaDigital.BloqueoRevistaImpresa) return !codigosRevistaImpresa.Contains(producto.CodigoCatalogo.ToString());
            }

            return true;
        }

        private bool BloqueoProductosDigitales(BEUsuario usuario, BEProducto producto, BEProductoAppBuscar productoBuscar)
        {
            var result = true;

            if (producto == null) return true;

            if (usuario.RevistaDigital != null && usuario.RevistaDigital.BloqueoProductoDigital)
            {
                result = !(
                            producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                          || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                          || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                        );
            }

            if (result && usuario.OfertaDelDiaModel != null && usuario.OfertaDelDiaModel.BloqueoProductoDigital)
            {
                result = (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaDelDia);
            }

            if (result && usuario.GuiaNegocio != null && usuario.GuiaNegocio.BloqueoProductoDigital)
            {
                result = (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);
            }

            if (result && usuario.OptBloqueoProductoDigital)
            {
                result = (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaParaTi);
            }

            if (result && usuario.RevistaDigital.TieneRDCR)
            {
                var dato = usuario.GuiaNegocio.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.BloquearProductoGnd) ?? new BEConfiguracionPaisDatos();
                dato.Valor1 = Util.Trim(dato.Valor1);
                if (dato.Estado && dato.Valor1 != string.Empty)
                {
                    result = (!dato.Valor1.Contains(producto.CUV));
                }
            }

            return result;
        }

        private BEProductoApp ProductoBuscarRespuesta(string codigoRespuesta, string mensajeRespuesta = null, BEProducto producto = null)
        {
            return new BEProductoApp()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoAppValidacion.ProductoBuscar.Message[codigoRespuesta] : mensajeRespuesta,
                Producto = producto
            };
        }
        #endregion

        //#region Insert
        //private BEPedidoDetalleAppResult PedidoInsertarRespuesta(string codigoRespuesta, string mensajeRespuesta = null, BEPedidoDetalleApp pedidoDetalle = null)
        //{
        //    return new BEPedidoDetalleAppResult()
        //    {
        //        CodigoRespuesta = codigoRespuesta,
        //        MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoAppValidacion.PedidoInsertar.Message[codigoRespuesta] : mensajeRespuesta,
        //        PedidoDetalle = pedidoDetalle
        //    };
        //}

        //private bool ValidarStockEstrategia(BEPedidoDetalleApp pedidoDetalle, out string mensaje)
        //{
        //    var resultado = false;
        //    mensaje = string.Empty;

        //    mensaje = ValidarMontoMaximo(pedidoDetalle, out resultado);

        //    if (mensaje == string.Empty || resultado)
        //        mensaje = ValidarStockEstrategiaMensaje(pedidoDetalle);

        //    return mensaje == string.Empty || resultado;
        //}

        //private string ValidarMontoMaximo(BEPedidoDetalleApp pedidoDetalle, out bool resul)
        //{
        //    var mensaje = string.Empty;
        //    resul = false;

        //    if (!pedidoDetalle.TieneValidacionMontoMaximo)
        //        return mensaje;

        //    if (pedidoDetalle.MontoMaximoPedido == Convert.ToDecimal(9999999999.00))
        //        return mensaje;

        //    var listaProducto = ObtenerPedidoWebDetalle(pedidoDetalle);

        //    var totalPedido = listaProducto.Sum(p => p.ImporteTotal);
        //    var descuentoProl = listaProducto.Any() ? listaProducto[0].DescuentoProl : 0;

        //    if (totalPedido > pedidoDetalle.MontoMaximoPedido && pedidoDetalle.Cantidad < 0)
        //        resul = true;

        //    var montoActual = (pedidoDetalle.Producto.PrecioCatalogo * pedidoDetalle.Cantidad) + (totalPedido - descuentoProl);
        //    if (montoActual > pedidoDetalle.MontoMaximoPedido)
        //    {
        //        var FechaHoy = DateTime.Now.AddHours(pedidoDetalle.ZonaHoraria).Date;
        //        var EsDiasFacturacion = FechaHoy >= pedidoDetalle.FechaInicioFacturacion.Date && FechaHoy <= pedidoDetalle.FechaFinFacturacion.Date;

        //        var strmen = (EsDiasFacturacion ? "VALIDADO" : "GUARDADO");
        //        mensaje = string.Format("Haz superado el límite de tu línea de crédito de {0}{1}. Por favor modifica tu pedido para que sea {2} con éxito.", pedidoDetalle.Simbolo, pedidoDetalle.MontoMaximoPedido, strmen);
        //    }

        //    return mensaje;
        //}

        //private List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    var detallesPedidoWeb = new List<BEPedidoWebDetalle>();

        //    var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
        //    {
        //        PaisId = pedidoDetalle.PaisID,
        //        CampaniaId = pedidoDetalle.CampaniaID,
        //        ConsultoraId = pedidoDetalle.ConsultoraID,
        //        Consultora = pedidoDetalle.NombreConsultora,
        //        CodigoPrograma = pedidoDetalle.CodigoPrograma,
        //        NumeroPedido = pedidoDetalle.ConsecutivoNueva
        //    };

        //    detallesPedidoWeb = _pedidoWebDetalleBusinessLogic.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();

        //    pedidoDetalle.PedidoID = detallesPedidoWeb.Any() ? detallesPedidoWeb.First().PedidoID : 0;

        //    return detallesPedidoWeb;
        //}

        //private string ValidarStockEstrategiaMensaje(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    var mensaje = string.Empty;

        //    var tipoEstrategiaID = 0;
        //    int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);

        //    var entidad = new BEEstrategia
        //    {
        //        PaisID = pedidoDetalle.PaisID,
        //        Cantidad = pedidoDetalle.Cantidad,
        //        CUV2 = pedidoDetalle.Producto.CUV,
        //        CampaniaID = pedidoDetalle.CampaniaID,
        //        ConsultoraID = pedidoDetalle.ConsultoraID.ToString(),
        //        FlagCantidad = tipoEstrategiaID
        //    };

        //    mensaje = _estrategiaBusinessLogic.ValidarStockEstrategia(entidad);

        //    mensaje = Util.Trim(mensaje);

        //    return mensaje == "OK" ? string.Empty : mensaje;
        //}

        //private string PedidoInsertar(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    var result = InsertarValidarKitInicio(pedidoDetalle);
        //    if (!result) return Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_KIT_INICIO;

        //    var tipoEstrategiaID = 0;
        //    int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);

        //    var obePedidoWebDetalle = new BEPedidoWebDetalle
        //    {
        //        PaisID = pedidoDetalle.PaisID,
        //        IPUsuario = pedidoDetalle.IPUsuario,
        //        CampaniaID = pedidoDetalle.CampaniaID,
        //        ConsultoraID = pedidoDetalle.ConsultoraID,
        //        PedidoID = pedidoDetalle.PedidoID,
        //        SubTipoOfertaSisID = 0,
        //        TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
        //        CUV = pedidoDetalle.Producto.CUV,
        //        Cantidad = pedidoDetalle.Cantidad,
        //        PrecioUnidad = pedidoDetalle.Producto.PrecioCatalogo,
        //        TipoEstrategiaID = tipoEstrategiaID,
        //        OrigenPedidoWeb = Constantes.OrigenPedidoWeb.AppPedido,
        //        ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID,
        //        ClienteID = pedidoDetalle.ClienteID,
        //        OfertaWeb = false,
        //        IndicadorMontoMinimo = pedidoDetalle.Producto.IndicadorMontoMinimo,
        //        EsSugerido = false,
        //        EsKitNueva = false,
        //        MarcaID = Convert.ToByte(pedidoDetalle.Producto.MarcaID),
        //        DescripcionProd = pedidoDetalle.Producto.Descripcion,
        //        ImporteTotal = pedidoDetalle.Cantidad * pedidoDetalle.Producto.PrecioCatalogo,
        //        Nombre = pedidoDetalle.ClienteID == 0 ? pedidoDetalle.NombreConsultora : pedidoDetalle.ClienteDescripcion
        //    };

        //    result = AdministradorPedido(pedidoDetalle, obePedidoWebDetalle, Constantes.PedidoAccion.INSERT);
        //    if (!result) return Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_GRABAR;

        //    return Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS;
        //}

        //private bool InsertarValidarKitInicio(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    var resultado = true;

        //    if (pedidoDetalle.EsConsultoraNueva)
        //    {
        //        var olstPedidoWebDetalle = ObtenerPedidoWebDetalle(pedidoDetalle);
        //        var detCuv = olstPedidoWebDetalle.FirstOrDefault(d => d.CUV == pedidoDetalle.Producto.CUV) ?? new BEPedidoWebDetalle();
        //        detCuv.CUV = Util.Trim(detCuv.CUV);
        //        if (detCuv.CUV != string.Empty)
        //        {
        //            var obeConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas(pedidoDetalle);
        //            if (obeConfiguracionProgramaNuevas.IndProgObli == "1" && obeConfiguracionProgramaNuevas.CUVKit == detCuv.CUV)
        //                resultado = false;
        //        }
        //    }

        //    return resultado;
        //}

        //private BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    var configuracionProgramaNuevas = new BEConfiguracionProgramaNuevas();

        //    var obeConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas()
        //    {
        //        CampaniaInicio = pedidoDetalle.CampaniaID.ToString(),
        //        CodigoRegion = pedidoDetalle.CodigoRegion,
        //        CodigoZona = pedidoDetalle.CodigoZona
        //    };

        //    if (pedidoDetalle.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva ||
        //            pedidoDetalle.ConsultoraNueva == Constantes.EstadoActividadConsultora.Reactivada ||
        //            pedidoDetalle.ConsecutivoNueva == Constantes.ConsecutivoNuevaConsultora.Consecutivo3)
        //    {
        //        var PaisesFraccionKit = WebConfig.PaisesFraccionKitNuevas;
        //        if (PaisesFraccionKit.Contains(pedidoDetalle.CodigoISO))
        //        {
        //            obeConfiguracionProgramaNuevas.CodigoNivel = pedidoDetalle.ConsecutivoNueva == 1 ? "02" : pedidoDetalle.ConsecutivoNueva == 2 ? "03" : string.Empty;
        //            obeConfiguracionProgramaNuevas = _configuracionProgramaNuevasBusinessLogic.GetConfiguracionProgramaDespuesPrimerPedido(pedidoDetalle.PaisID, obeConfiguracionProgramaNuevas);
        //        }
        //    }
        //    else
        //    {
        //        obeConfiguracionProgramaNuevas = _configuracionProgramaNuevasBusinessLogic.GetConfiguracionProgramaNuevas(pedidoDetalle.PaisID, obeConfiguracionProgramaNuevas);
        //    }

        //    return configuracionProgramaNuevas;
        //}

        //private bool AdministradorPedido(BEPedidoDetalleApp pedidoDetalle, BEPedidoWebDetalle obePedidoWebDetalle, string tipoAdm)
        //{
        //    var resultado = true;

        //    var olstTempListado = ObtenerPedidoWebDetalle(pedidoDetalle);

        //    if (obePedidoWebDetalle.PedidoDetalleID == 0)
        //    {
        //        if (olstTempListado.Any(p => p.CUV == obePedidoWebDetalle.CUV))
        //            obePedidoWebDetalle.TipoPedido = "X";
        //    }
        //    else
        //    {
        //        if (olstTempListado.Any(p => p.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID))
        //            obePedidoWebDetalle.TipoPedido = "X";
        //    }

        //    if (tipoAdm == Constantes.PedidoAccion.INSERT)
        //    {
        //        var cantidad = 0;
        //        var result = ValidarInsercion(olstTempListado, obePedidoWebDetalle, out cantidad);
        //        if (result != 0)
        //        {
        //            tipoAdm = Constantes.PedidoAccion.UPDATE;
        //            obePedidoWebDetalle.Stock = obePedidoWebDetalle.Cantidad;
        //            obePedidoWebDetalle.Cantidad += cantidad;
        //            obePedidoWebDetalle.ImporteTotal = obePedidoWebDetalle.Cantidad * obePedidoWebDetalle.PrecioUnidad;
        //            obePedidoWebDetalle.PedidoDetalleID = result;
        //            obePedidoWebDetalle.Flag = 2;
        //            obePedidoWebDetalle.OrdenPedidoWD = 1;
        //        }
        //    }

        //    var totalClientes = CalcularTotalCliente(olstTempListado, obePedidoWebDetalle, tipoAdm == "D" ? obePedidoWebDetalle.PedidoDetalleID : (short)0, tipoAdm);
        //    var totalImporte = CalcularTotalImporte(olstTempListado, obePedidoWebDetalle, tipoAdm == "I" ? (short)0 : obePedidoWebDetalle.PedidoDetalleID, tipoAdm);

        //    obePedidoWebDetalle.ImporteTotalPedido = totalImporte;
        //    obePedidoWebDetalle.Clientes = totalClientes;

        //    obePedidoWebDetalle.CodigoUsuarioCreacion = pedidoDetalle.CodigoUsuario;
        //    obePedidoWebDetalle.CodigoUsuarioModificacion = pedidoDetalle.CodigoUsuario;

        //    var quitoCantBackOrder = false;
        //    if (tipoAdm == Constantes.PedidoAccion.UPDATE && obePedidoWebDetalle.PedidoDetalleID != 0)
        //    {
        //        var oldPedidoWebDetalle = olstTempListado.FirstOrDefault(x => x.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID) ?? new BEPedidoWebDetalle();

        //        if (oldPedidoWebDetalle.AceptoBackOrder && obePedidoWebDetalle.Cantidad < oldPedidoWebDetalle.Cantidad)
        //            quitoCantBackOrder = true;
        //    }

        //    var indPedidoAutentico = new BEIndicadorPedidoAutentico
        //    {
        //        PedidoID = obePedidoWebDetalle.PedidoID,
        //        CampaniaID = obePedidoWebDetalle.CampaniaID,
        //        PedidoDetalleID = obePedidoWebDetalle.PedidoDetalleID,
        //        IndicadorIPUsuario = obePedidoWebDetalle.IPUsuario,
        //        IndicadorFingerprint = string.Empty,
        //        IndicadorToken = string.IsNullOrEmpty(pedidoDetalle.Identifier) ? string.Empty : AESAlgorithm.Encrypt(pedidoDetalle.Identifier)
        //    };
        //    obePedidoWebDetalle.IndicadorPedidoAutentico = indPedidoAutentico;

        //    switch (tipoAdm)
        //    {
        //        case Constantes.PedidoAccion.INSERT:
        //            _pedidoWebDetalleBusinessLogic.InsPedidoWebDetalle(obePedidoWebDetalle);
        //            break;
        //        case Constantes.PedidoAccion.UPDATE:
        //            _pedidoWebDetalleBusinessLogic.UpdPedidoWebDetalle(obePedidoWebDetalle);
        //            break;
        //        case Constantes.PedidoAccion.DELETE:
        //            _pedidoWebDetalleBusinessLogic.DelPedidoWebDetalle(obePedidoWebDetalle);
        //            break;
        //    }

        //    if (tipoAdm == Constantes.PedidoAccion.UPDATE && quitoCantBackOrder)
        //        _pedidoWebDetalleBusinessLogic.QuitarBackOrderPedidoWebDetalle(obePedidoWebDetalle);

        //    return resultado;
        //}

        //private short ValidarInsercion(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, out int cantidad)
        //{
        //    var temp = new List<BEPedidoWebDetalle>(pedido);
        //    var obe = temp.FirstOrDefault(p => p.ClienteID == itemPedido.ClienteID && p.CUV == itemPedido.CUV) ?? new BEPedidoWebDetalle();
        //    cantidad = obe.Cantidad;
        //    return obe.PedidoDetalleID;
        //}

        //private int CalcularTotalCliente(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, short pedidoDetalleId, string adm)
        //{
        //    var temp = new List<BEPedidoWebDetalle>(pedido);
        //    if (pedidoDetalleId == 0)
        //    {
        //        if (adm == Constantes.PedidoAccion.INSERT) temp.Add(itemPedido);
        //        else temp.Where(p => p.PedidoDetalleID == itemPedido.PedidoDetalleID).Update(p => p.ClienteID = itemPedido.ClienteID);
        //    }
        //    else
        //    {
        //        temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();
        //    }

        //    return temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        //}

        //private decimal CalcularTotalImporte(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, short pedidoDetalleId, string adm)
        //{
        //    var temp = new List<BEPedidoWebDetalle>(pedido);
        //    if (pedidoDetalleId == 0) temp.Add(itemPedido);
        //    else temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();

        //    return temp.Sum(p => p.ImporteTotal) + (adm == "U" ? itemPedido.ImporteTotal : 0);
        //}

        //private void AgregarProductoZE(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    pedidoDetalle.OrigenPedidoWeb = pedidoDetalle.OrigenPedidoWeb < 0 ? 0 : pedidoDetalle.OrigenPedidoWeb;
        //    var tipoEstrategiaID = 0;
        //    int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);
        //    pedidoDetalle.Producto.TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID > 0 ? pedidoDetalle.Producto.TipoOfertaSisID : tipoEstrategiaID;
        //    pedidoDetalle.Producto.ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID > 0 ? pedidoDetalle.Producto.ConfiguracionOfertaID : pedidoDetalle.Producto.TipoOfertaSisID;

        //    EliminarDetallePackNueva(pedidoDetalle);
        //}

        //private void EliminarDetallePackNueva(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    var lstPedidoWebDetalle = ObtenerPedidoWebDetalle(pedidoDetalle);
        //    var packNuevas = lstPedidoWebDetalle.Where(x => x.FlagNueva && !x.EsOfertaIndependiente);

        //    foreach (var item in packNuevas)
        //    {
        //        DeletePedido(pedidoDetalle, item);
        //    }
        //}

        //private void DeletePedido(BEPedidoDetalleApp pedidoDetalle, BEPedidoWebDetalle obe)
        //{
        //    AdministradorPedido(pedidoDetalle, obe, Constantes.PedidoAccion.DELETE);
        //}
        //#endregion

        //#region UpdatePROL
        //private List<ObjMontosProl> ServicioProl_CalculoMontosProl(BEPedidoDetalleApp pedidoDetalle)
        //{
        //    montosProl = new List<ObjMontosProl> { new ObjMontosProl() };

        //    var detallesPedidoWeb = ObtenerPedidoWebDetalle(pedidoDetalle);

        //    if (detallesPedidoWeb.Any())
        //    {
        //        var cuvs = string.Join("|", detallesPedidoWeb.Select(p => p.CUV).ToArray());
        //        var cantidades = string.Join("|", detallesPedidoWeb.Select(p => p.Cantidad).ToArray());

        //        using (var sv = new ServicesCalculoPrecioNiveles())
        //        {
        //            sv.Url = WebConfig.Ambiente.ToUpper() == "QA" ? WebConfig.QA_Prol_ServicesCalculos : WebConfig.PR_Prol_ServicesCalculos;
        //            montosProl = sv.CalculoMontosProlxIncentivos(pedidoDetalle.CodigoISO, pedidoDetalle.CampaniaID.ToString(), pedidoDetalle.CodigoConsultora, pedidoDetalle.CodigoZona, cuvs, cantidades, pedidoDetalle.CodigosConcursos).ToList();
        //            montosProl = montosProl ?? new List<ObjMontosProl>();
        //        }
        //    }

        //    return montosProl;
        //}
        //#endregion  
    }
}
