using System;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using Portal.Consultoras.Data.ProgramaNuevas;

namespace Portal.Consultoras.BizLogic
{
    public class BLProducto : IProductoBusinessLogic
    {
        [Obsolete("Migrado PL50-50")]
        public IList<BEProducto> GetProductoComercialByListaCuv(int paisID, int campaniaID, int regionID, int zonaID, string codigoRegion, string codigoZona, string listaCuv)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetProductoComercialByListaCuv(campaniaID, regionID, zonaID, codigoRegion, codigoZona, listaCuv))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return productos;
        }

        public List<BEProductoDescripcion> GetProductoDescripcionByCUVandCampania(int paisID, int campaniaID, string CUV)
        {
            List<BEProductoDescripcion> productoDescripcion = new List<BEProductoDescripcion>();
            var daProductoDescripcion = new DAProductoDescripcion(paisID);

            using (IDataReader reader = daProductoDescripcion.GetProductoDescripcionByCUVandCampania(CUV, campaniaID))
            {
                while (reader.Read())
                {
                    var prod = new BEProductoDescripcion(reader);
                    productoDescripcion.Add(prod);
                }
            }
            return productoDescripcion;
        }

        public IList<BEProductoDescripcion> GetProductoComercialByPaisAndCampania(int campaniaID, string codigo, int paisID, int rowCount)
        {
            var productos = new List<BEProductoDescripcion>();
            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetProductoComercialByCampaniaAndCuv(campaniaID, codigo, rowCount))
            {
                while (reader.Read())
                {
                    var prod = new BEProductoDescripcion(reader)
                    {
                        PaisID = paisID,
                        CampaniaID = campaniaID
                    };
                    productos.Add(prod);
                }
            }
            return productos;
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcion(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount)
        {
            IList<BEProducto> productos = new List<BEProducto>();

            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetProductoComercialByCampania(campaniaID))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            var productosSel = new List<BEProducto>();
            int count = 0;
            foreach (BEProducto producto in productos)
            {
                if (criterio == 1 && producto.CUV.Contains(codigoDescripcion)
                    || criterio == 2 && producto.Descripcion.ToUpper().Contains(codigoDescripcion.ToUpper()))
                {
                    productosSel.Add(producto);
                    count++;
                    if (count >= rowCount)
                        break;
                }
            }

            return (from producto in productosSel
                    orderby (criterio == 1 ? producto.CUV : producto.Descripcion)
                    select producto).ToList();
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcionSearch(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetProductoComercialByCampaniaBySearch(campaniaID, rowCount, criterio, codigoDescripcion))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return (from producto in productos
                    orderby (criterio == 1 ? producto.CUV : producto.Descripcion)
                    select producto).ToList();
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcionSearchRegionZona(int paisID, int campaniaID, string codigoDescripcion, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona, int criterio, int rowCount, bool validarOpt)
        {
            var productos = new List<BEProducto>();


            using (IDataReader reader = new DAProducto(paisID).GetProductoComercialByCampaniaBySearchRegionZona(campaniaID, rowCount, criterio, codigoDescripcion, RegionID, ZonaID, CodigoRegion, CodigoZona, validarOpt))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            productos.Update(p =>
            {
                if (p.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ShowRoom)
                {
                    p.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    p.ConfiguracionOfertaID = 11;
                }
            });

            return (from producto in productos
                    orderby (criterio == 1 ? producto.CUV : producto.Descripcion)
                    select producto).ToList();
        }

        public IList<BEProducto> SearchListProductoChatbotByCampaniaRegionZona(string paisISO, int campaniaID,
            int regionID, int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int criterio, int rowCount)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var dAProducto = new DAProducto(Util.GetPaisID(paisISO));
            var esEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(paisISO);

            using (IDataReader reader = dAProducto.SearchListProductoChatbotByCampaniaRegionZona(campaniaID,
                regionID, zonaID, codigoRegion, codigoZona, textoBusqueda, criterio, rowCount))
            {
                while (reader.Read())
                {
                    var producto = new BEProducto(reader);
                    if ((producto.CUVRevista ?? "").Trim() != "")
                    {
                        producto.MensajeEstaEnRevista1 = esEsika ? Constantes.MensajeEstaEnRevista.EsikaWeb : Constantes.MensajeEstaEnRevista.LbelWeb;
                        producto.MensajeEstaEnRevista2 = esEsika ? Constantes.MensajeEstaEnRevista.EsikaMobile : Constantes.MensajeEstaEnRevista.LbelMobile;
                    }
                    productos.Add(producto);
                }
            }
            return productos.OrderBy(p => criterio == 1 ? p.CUV : p.Descripcion).ToList();
        }

        public IList<BEProducto> SearchSmartListProductoByCampaniaRegionZonaDescripcion(string paisISO, int campaniaID,
            int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int rowCount)
        {
            IList<BEProducto> listProducto = new List<BEProducto>();
            var bLProductoPalabra = new BLProductoPalabra();
            var listTextoCandidato = bLProductoPalabra.GetListCandidatoFromTexto(paisISO, campaniaID, textoBusqueda, 2, 1);
            if (listTextoCandidato.Count == 0) return listProducto;

            var paisId = Util.GetPaisID(paisISO);
            var dAProducto = new DAProducto(paisId);
            var esEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(paisISO);
            var listPalabra = bLProductoPalabra.GetListPalabraFromTexto(listTextoCandidato[0]).Select(p => p.ToLower()).ToList();

            listProducto = CacheManager<BEProducto>.GetData(paisId, ECacheItem.Producto, campaniaID.ToString());
            if (listProducto != null && listProducto.Count > 0)
            {
                listProducto = listProducto.Select(producto => new
                {
                    Producto = producto,
                    Repeticion = listPalabra.Count(palabra => producto.TextoBusqueda.ToLower().Contains(palabra))
                })
                    .Where(pp => pp.Repeticion > 0).OrderByDescending(pp => pp.Repeticion).ThenBy(pp => pp.Producto.CUV)
                    .Select(pp => pp.Producto).Take(rowCount).ToList();

                dAProducto.SetTieneStockByCampaniaAndZonaAndProductos(campaniaID, zonaID, codigoRegion, codigoZona, listProducto.ToList());
            }
            else
            {
                listProducto = new List<BEProducto>();
                using (IDataReader reader = dAProducto.GetByCampaniaAndZonaAndPalabras(campaniaID, zonaID, codigoRegion, codigoZona, rowCount, listPalabra))
                {
                    while (reader.Read()) listProducto.Add(new BEProducto(reader));
                }
            }

            listProducto.ToList().ForEach(p =>
            {
                if ((p.CUVRevista ?? "").Trim() != "")
                {
                    p.MensajeEstaEnRevista1 = esEsika ? Constantes.MensajeEstaEnRevista.EsikaWeb : Constantes.MensajeEstaEnRevista.LbelWeb;
                    p.MensajeEstaEnRevista2 = esEsika ? Constantes.MensajeEstaEnRevista.EsikaMobile : Constantes.MensajeEstaEnRevista.LbelMobile;
                }
            });
            return listProducto;
        }

        public IList<BEProducto> SelectProductoByListaCuvSearchRegionZona(int paisID, int campaniaID, string listaCuv, int regionID, int zonaID, string codigoRegion, string codigoZona, bool validarOpt)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetProductoComercialByCampaniaBySearchRegionZonaListaCuv(campaniaID, listaCuv, regionID, zonaID, codigoRegion, codigoZona, validarOpt))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return (from producto in productos
                    orderby producto.CUV
                    select producto).ToList();
        }

        public int UpdProductoDescripcion(BEProductoDescripcion producto, string codigoUsuario)
        {
            var daProductoDescripcion = new DAProductoDescripcion(producto.PaisID);
            return daProductoDescripcion.UpdProductoDescripcion(producto, codigoUsuario);
        }

        public IList<BEProductoDescripcion> GetProductosByCampaniaCuv(int paisID, int anioCampania, string codigoVenta)
        {
            var productos = new List<BEProductoDescripcion>();
            var daProductoComercial = new DAProductoDescripcion(paisID);

            using (IDataReader reader = daProductoComercial.GetProductosByCampaniaCuv(anioCampania, codigoVenta))
                while (reader.Read())
                {
                    var producto = new BEProductoDescripcion(reader);
                    productos.Add(producto);
                }

            return productos;
        }

        public BEProductoDescripcion GetProductoByCampaniaCuv(int paisID, int anioCampania, string codigoZona, string codigoVenta)
        {
            BEProductoDescripcion beProductoDescripcion = null;
            var daProductoComercial = new DAProductoDescripcion(paisID);

            using (IDataReader reader = daProductoComercial.GetProductoByCampaniaCuv(anioCampania, codigoZona, codigoVenta))
                if (reader.Read())
                {
                    beProductoDescripcion = new BEProductoDescripcion(reader);
                }

            return beProductoDescripcion;
        }

        #region Producto Sugerido

        public IList<BEProducto> GetProductoSugeridoByCUV(int paisID, int campaniaID, int consultoraID, string cuv, int regionID, int zonaID, string codigoRegion, string codigoZona)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetProductoSugeridoByCUV(campaniaID, consultoraID, cuv, regionID, zonaID, codigoRegion, codigoZona))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return productos;
        }

        #endregion

        public IList<BEProducto> SelectProductoToKitInicio(int paisID, int campaniaID, string cuv)
        {
            var productos = new List<BEProducto>();

            using (var reader = new DAProducto(paisID).SelectProductoToKitInicio(campaniaID, cuv))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return productos;
        }

        public string GetNombreProducto048ByCuv(int paisID, int campaniaID, string cuv)
        {
            var daProducto = new DAProducto(paisID);
            return daProducto.GetNombreProducto048ByCuv(campaniaID, cuv);
        }

        public IList<BEProductoAppCatalogo> GetNombreProducto048ByListaCUV(int paisID, int campaniaID, string listaCUV)
        {
            IList<BEProductoAppCatalogo> productos = new List<BEProductoAppCatalogo>();
            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetNombreProducto048ByListaCUV(campaniaID, listaCUV))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProductoAppCatalogo(reader));
                }
            }

            return productos;
        }

        public int InsProductoCompartido(BEProductoCompartido ProComp)
        {
            var daProducto = new DAProducto(ProComp.PaisID);
            return daProducto.InsProductoCompartido(ProComp);
        }

        public BEProductoCompartido GetProductoCompartido(int paisID, int ProCompID)
        {
            BEProductoCompartido proComp = null;
            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetProductoCompartido(ProCompID))
            {
                if (reader.Read())
                {
                    proComp = new BEProductoCompartido(reader);
                }
            }

            return proComp;
        }

        public IList<BEProducto> GetListBrothersByCUV(int paisID, int codCampania, string cuv)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var daProducto = new DAProducto(paisID);

            using (IDataReader reader = daProducto.GetListBrothersByCUV(codCampania, cuv))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return productos;
        }
        #region Programa de Nuevas
        public Enumeradores.ValidacionProgramaNuevas ValidarBusquedaProgramaNuevas(int paisID, int campaniaID, int ConsultoraID, string codigoPrograma, int consecutivoNueva, string cuv)
        {
            if (!GetFlagProgramaNuevas(paisID)) return Enumeradores.ValidacionProgramaNuevas.ContinuaFlujo;
            if (!GetRagoCuvProgramaNuevas(paisID, Convert.ToInt32(cuv))) return Enumeradores.ValidacionProgramaNuevas.ContinuaFlujo;
            List<BEProductoProgramaNuevas> lstProdcutos = GetProductosProgramaNuevasByCampaniaCache(paisID, campaniaID);
            if (lstProdcutos == null || lstProdcutos.Count == 0) return Enumeradores.ValidacionProgramaNuevas.ProductoNoExiste;
            if (!lstProdcutos.Any(x => x.CodigoCupon == cuv)) return Enumeradores.ValidacionProgramaNuevas.ProductoNoExiste;
            if (codigoPrograma == "") return Enumeradores.ValidacionProgramaNuevas.ConsultoraNoNueva;
            lstProdcutos = FiltrarProductosNuevasByNivelyCodigoPrograma(lstProdcutos, consecutivoNueva, codigoPrograma);
            if (!lstProdcutos.Any(a => a.CodigoCupon == cuv)) return Enumeradores.ValidacionProgramaNuevas.CuvNoPerteneceASuPrograma;
            return Enumeradores.ValidacionProgramaNuevas.CuvPerteneceProgramaNuevas;
        }

        public int ValidarCantidadMaximaProgramaNuevas(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, int cantidadEnPedido, string cuvIngresado, int cantidadIngresada)
        {
            if (!GetFlagProgramaNuevas(paisID)) return 0;
            List<BEProductoProgramaNuevas> lstProdcutos = GetProductosProgramaNuevasByCampaniaCache(paisID, campaniaID);
            if (lstProdcutos.Count == 0) return 0;
            lstProdcutos = FiltrarProductosNuevasByNivelyCodigoPrograma(lstProdcutos, consecutivoNueva, codigoPrograma);
            if (lstProdcutos.Count == 0) return 0;
            var CantidadMaxima = lstProdcutos.Where(a => a.CodigoCupon == cuvIngresado).Select(b => b.UnidadesMaximas).FirstOrDefault();
            if (cantidadIngresada + cantidadEnPedido > CantidadMaxima) return CantidadMaxima;
            return 0;
        }

        public BERespValidarElectivos ValidaCuvElectivo(int paisID, int campaniaID, string cuvIngresado, int consecutivoNueva, string codigoPrograma, List<string> lstCuvPedido)
        {
            if (!GetFlagProgramaNuevas(paisID)) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            List<BEProductoProgramaNuevas> lstProductos = GetProductosProgramaNuevasByCampaniaCache(paisID, campaniaID);
            if (lstProductos == null || lstProductos.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            lstProductos = FiltrarProductosNuevasByNivelyCodigoPrograma(lstProductos, consecutivoNueva, codigoPrograma);
            if (lstProductos.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            var oCuv = lstProductos.FirstOrDefault(a => a.CodigoCupon == cuvIngresado);
            if (oCuv == null) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            if (oCuv.IndicadorCuponIndependiente) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            List<BEProductoProgramaNuevas> lstElectivas = lstProductos.Where(a => !a.IndicadorCuponIndependiente && a.CodigoCupon != cuvIngresado).ToList();
            if (lstElectivas.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = (GetNivelesProgramaNuevas(paisID, nivelInput) ?? new BENivelesProgramaNuevas()).UnidadesNivel;
            if (limElectivos <= 0) limElectivos = 1;

            var listElecPedido = lstCuvPedido.Where(c => lstElectivas.Any(e => e.CodigoCupon == c)).ToList();
            var cantElecPedido = listElecPedido.Count();
            if (cantElecPedido == 1 && limElectivos == 1) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Reemplazar, listElecPedido);
            if (cantElecPedido >= limElectivos) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.NoAgregarExcedioLimite, limElectivos);

            return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.AgregarYMostrarMensaje, limElectivos) { NumElectivosEnPedido = cantElecPedido };
        }

        #region Metodos de Programa Nuevas
        private bool GetFlagProgramaNuevas(int paisID)
        {
            var blTablaLogicaDatos = new BLTablaLogicaDatos();
            var lstTabla = blTablaLogicaDatos.GetTablaLogicaDatosCache(paisID, Constantes.ProgramaNuevas.EncenderValidacion.TablaLogicaID);
            if (lstTabla.Count == 0) return false;
            if (lstTabla.Where(a => a.Codigo == Constantes.ProgramaNuevas.EncenderValidacion.FlagActivar).Select(b => b.Valor).FirstOrDefault() == "1") return true;
            return false;
        }

        private bool GetRagoCuvProgramaNuevas(int paisID, int cuv)
        {
            var blTablaLogicaDatos = new BLTablaLogicaDatos();
            var lstTabla = blTablaLogicaDatos.GetTablaLogicaDatosCache(paisID, Constantes.ProgramaNuevas.Rango.TablaLogicaID);
            if (lstTabla.Count == 0) return false;
            int cuvIni = Convert.ToInt32(lstTabla.Where(a => a.Codigo == Constantes.ProgramaNuevas.Rango.cuvInicio).Select(b => b.Descripcion).FirstOrDefault());
            int cuvFin = Convert.ToInt32(lstTabla.Where(a => a.Codigo == Constantes.ProgramaNuevas.Rango.cuvFinal).Select(b => b.Descripcion).FirstOrDefault());
            if ((cuv >= cuvIni && cuv <= cuvFin)) return true;
            return false;
        }

        private List<BEProductoProgramaNuevas> GetProductosProgramaNuevasByCampania(int paisID, int campaniaID)
        {
            var daProducto = new DAProducto(paisID);
            var productos = new List<BEProductoProgramaNuevas>();
            using (IDataReader reader = daProducto.GetProductosProgramaNuevas(campaniaID))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProductoProgramaNuevas(reader));
                }
            }
            return productos;
        }
        private List<BEProductoProgramaNuevas> GetProductosProgramaNuevasByCampaniaCache(int paisID, int campaniaID)
        {
            return CacheManager<List<BEProductoProgramaNuevas>>.ValidateDataElement(paisID, ECacheItem.ProductoProgramaNuevas, campaniaID.ToString(), () => GetProductosProgramaNuevasByCampania(paisID, campaniaID));
        }

        private List<BEProductoProgramaNuevas> FiltrarProductosNuevasByNivelyCodigoPrograma(List<BEProductoProgramaNuevas> lstProdcutos, int consecutivoNueva, string codigoPrograma)
        {
            return lstProdcutos.Where(a =>
                a.CodigoPrograma == codigoPrograma && NivelNuevaEnRango(consecutivoNueva + 1, a.CodigoNivel, a.NumeroCampanasVigentes)
            ).ToList();
        }

        private List<BENivelesProgramaNuevas> GetNivelesProgramaNuevasByCampania(int paisID, string campania)
        {
            using (var reader = new DANivelesProgramaNuevas(paisID).GetByCampania(campania))
            {
                return MapUtil.MapToCollection<BENivelesProgramaNuevas>(reader, true, true);
            }
        }
        private List<BENivelesProgramaNuevas> GetNivelesProgramaNuevasByCampaniaCache(int paisID, string campania)
        {
            return CacheManager<List<BENivelesProgramaNuevas>>.ValidateDataElement(paisID, ECacheItem.NivelesProgramaNuevas, campania, () => GetNivelesProgramaNuevasByCampania(paisID, campania));
        }
        private BENivelesProgramaNuevas GetNivelesProgramaNuevas(int paisID, BENivelesProgramaNuevas nivel)
        {
            return GetNivelesProgramaNuevasByCampaniaCache(paisID, nivel.Campania).FirstOrDefault(n =>
                n.CodigoPrograma == nivel.CodigoPrograma && NivelNuevaEnRango(Convert.ToInt32(nivel.CodigoNivel), n.CodigoNivel, n.NumeroCampanasVigentes)
            );
        }

        private bool NivelNuevaEnRango(int nivelConsultora, string nivelInicial, int campaniasVigentes)
        {
            int iNivelInicial = Convert.ToInt32(nivelInicial);
            return iNivelInicial <= nivelConsultora && nivelConsultora <= (iNivelInicial + campaniasVigentes - 1);
        }
        #endregion
        #endregion

        #region Venta exclusiva
        public Enumeradores.ValidacionVentaExclusiva ValidarVentaExclusiva(int paisID, int campaniaID, string codigoConsultora, string cuv)
        {
            if (!GetFlagVentaExclusiva(paisID)) return Enumeradores.ValidacionVentaExclusiva.ContinuaFlujo;
            if (!EsProductoExclusivo(paisID, campaniaID, cuv)) return Enumeradores.ValidacionVentaExclusiva.ContinuaFlujo;
            return GetConsultoraEnVentaExclusiva(paisID, campaniaID, codigoConsultora, cuv);
        }
        #region Metodos Venta Exclusiva
        private bool GetFlagVentaExclusiva(int paisID)
        {
            var blTablaLogicaDatos = new BLTablaLogicaDatos();
            var lstTabla = blTablaLogicaDatos.GetTablaLogicaDatosCache(paisID, Constantes.ProgramaNuevas.EncenderValidacion.TablaLogicaID);
            if (lstTabla.Count == 0) return false;
            if (lstTabla.Where(a => a.Codigo == Constantes.VentaExclusiva.EncenderValidacion.FlagActivar).Select(b => b.Valor).FirstOrDefault() == "1") return true;
            return false;
        }

        private Enumeradores.ValidacionVentaExclusiva GetConsultoraEnVentaExclusiva(int paisID, int campaniaID, string codigoConsultora, string cuv)
        {
            var daProducto = new DAProducto(paisID);
            List<string> EsVentaExclusiva = new List<string>();
            using (IDataReader reader = daProducto.GetConsultoraProductoExclusivo(campaniaID, codigoConsultora))
            {
                while (reader.Read())
                {
                    EsVentaExclusiva.Add(reader.GetString(0));
                }
            }
            if (EsVentaExclusiva.Count == 0) return Enumeradores.ValidacionVentaExclusiva.ConsultoraNoVentaExclusiva;
            if (!EsVentaExclusiva.Any(a => a.Any(b => EsVentaExclusiva.Contains(cuv)))) return Enumeradores.ValidacionVentaExclusiva.CuvNoLePerteneceAConsultora;
            return Enumeradores.ValidacionVentaExclusiva.ContinuaFlujo;
        }

        private bool EsProductoExclusivo(int paisID, int campaniaID, string cuv)
        {
            var lstProductos = GetProductosExclusivosCache(paisID, campaniaID);
            if (lstProductos == null) return false;
            if (lstProductos.Any(a => a.Any(b => lstProductos.Contains(cuv)))) return true;
            return false;
        }

        private List<string> GetProductosExclusivosCache(int paisID, int campaniaID)
        {
            return CacheManager<List<string>>.ValidateDataElement(paisID, ECacheItem.ProductosExclusivos, campaniaID.ToString(), () => GetProductosExclusivos(paisID, campaniaID));
        }

        private List<string> GetProductosExclusivos(int paisID, int campaniaID)
        {
            var daProducto = new DAProducto(paisID);
            List<string> lstProductos = new List<string>();
            using (IDataReader reader = daProducto.GetProductosExclusivos(campaniaID))
            {
                while (reader.Read())
                {
                    lstProductos.Add(reader.GetString(0));
                }
            }
            return lstProductos;
        }
        #endregion
        #endregion

        public string ValidarMatrizCampaniaMasivo(int paisID, string CUVs, int AnioCampania)
        {
            return new DAProductoDescripcion(paisID).ValidarMatrizCampaniaMasivo(CUVs, AnioCampania);
        }

        public string RegistrarProductoMasivo(int paisID, string data)
        {
            return new DAProductoDescripcion(paisID).RegistrarProductoMasivo(data);
        }

        public void UpdProductoDescripcionMasivo(int paisID, int campaniaID, IList<BEProductoDescripcion> productos, string codigoUsuario)
        {

            var daProductoDescripcion = new DAProductoDescripcion(paisID);

            //List<BEProductoDescripcion> lstFinal = new List<BEProductoDescripcion>();

            //foreach (BEProductoDescripcion be in productos)
            //{
            //    BEProductoDescripcion item = new BEProductoDescripcion();
            //    item.CampaniaID = campaniaID;
            //    item.CUV  = be.CUV;
            //    item.Descripcion  = be.Descripcion;
            //    item.PrecioProducto = be.PrecioProducto;
            //    item.FactorRepeticion = be.FactorRepeticion;
            //    lstFinal.Add(item);
            //}

            // daProductoDescripcion.UpdProductoDescripcionMasivo(paisID,campaniaID, lstFinal, codigoUsuario);
            daProductoDescripcion.UpdProductoDescripcionMasivo(paisID, campaniaID, productos, codigoUsuario);

        }

    }
}
