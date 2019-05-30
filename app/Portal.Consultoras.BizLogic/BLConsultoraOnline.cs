using Newtonsoft.Json;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using Portal.Consultoras.Entities.Search.RequestRecomendacion;
using Portal.Consultoras.Entities.Search.ResponseRecomendacion;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Search.RequestRecomendacion.Estructura;
using ResponseRecomendacion = Portal.Consultoras.Entities.Search.ResponseRecomendacion.Estructura;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraOnline
    {

        public IList<BEMisPedidos> GetSolicitudesPedidoPendiente(int PaisID, long ConsultoraId, int Campania)
        {
            var daMisPedidos = new DAConsultoraOnline(PaisID);
            var misPedidos = new List<BEMisPedidos>();
            using (IDataReader reader = daMisPedidos.GetSolicitudesPedidoPendiente(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidos(reader);
                    misPedidos.Add((BEMisPedidos)entidad.Clone());
                }

                return misPedidos;
            }
        }

        public IList<BEMisPedidos> GetMisPedidos(int PaisID, long ConsultoraId, int Campania)
        {
            var daMisPedidos = new DAConsultoraOnline(PaisID);
            var misPedidos = new List<BEMisPedidos>();
            using (IDataReader reader = daMisPedidos.GetSolicitudesPedido(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidos(reader);
                    misPedidos.Add((BEMisPedidos)entidad.Clone());
                }

                return misPedidos;
            }
        }

        public IList<BEMisPedidosDetalle> GetMisPedidosDetalle(int PaisID, long PedidoID)
        {
            var daMisPedidos = new DAConsultoraOnline(PaisID);
            var miPedidoDetalles = new List<BEMisPedidosDetalle>();
            using (IDataReader reader = daMisPedidos.GetSolicitudesPedidoDetalle(PedidoID))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidosDetalle(reader);
                    miPedidoDetalles.Add((BEMisPedidosDetalle)entidad.Clone());
                }

                return miPedidoDetalles;
            }
        }

        public IList<BEMisPedidosDetalle> GetMisPedidosDetalleAll(int paisId, int campaniaId, long consultoraId)
        {
            var daMisPedidos = new DAConsultoraOnline(paisId);
            var detalles = new List<BEMisPedidosDetalle>();
            using (IDataReader reader = daMisPedidos.GetSolicitudesPedidoDetalleAll(campaniaId, consultoraId))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidosDetalle(reader);
                    detalles.Add((BEMisPedidosDetalle)entidad.Clone());
                }

                return detalles;
            }
        }


        public IList<BEMisPedidos> GetMisPedidosClienteOnline(int paisID, long consultoraId, int campania)
        {
            var daMisPedidos = new DAConsultoraOnline(paisID);
            var misPedidos = new List<BEMisPedidos>();
            using (IDataReader reader = daMisPedidos.GetMisPedidosClienteOnline(consultoraId, campania))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidos(reader);
                    misPedidos.Add((BEMisPedidos)entidad.Clone());
                }
                return misPedidos;
            }
        }

        public BEMisPedidos GetPedidoClienteOnlineBySolicitudClienteId(int paisID, long solicitudClienteId)
        {
            var dAMisPedidos = new DAConsultoraOnline(paisID);
            BEMisPedidos miPedido = null;
            using (IDataReader reader = dAMisPedidos.GetPedidoClienteOnlineBySolicitudClienteId(solicitudClienteId))
            {
                if (reader.Read()) miPedido = new BEMisPedidos(reader);
            }
            return miPedido;
        }

        public int GetCantidadPedidosConsultoraOnline(int PaisID, long ConsultoraId)
        {
            var cantidad = -1;
            var daConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = daConsultoraOnline.GetCantidadPedidosConsultoraOnline(ConsultoraId))
            {
                while (reader.Read())
                {
                    cantidad = reader.GetInt32(reader.GetOrdinal("Cantidad"));
                }
            }
            return cantidad;
        }

        public IList<BEProducto> GetValidarCUVMisPedidos(int PaisID, int Campania, string InputCUV, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var daConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = daConsultoraOnline.GetValidarCUVSolicitudPedido(Campania, InputCUV, RegionID, ZonaID, CodigoRegion, CodigoZona))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }
            return productos;
        }

        public int GetCantidadSolicitudesPedido(int PaisID, long ConsultoraId, int Campania)
        {
            var cant = -1;
            var daConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = daConsultoraOnline.GetCantidadSolicitudesPedido(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    cant = reader.GetInt32(reader.GetOrdinal("Cantidad"));
                }
            }
            return cant;
        }

        public string GetSaldoHorasSolicitudesPedido(int PaisID, long ConsultoraId, int Campania)
        {
            var saldo = "";
            var daConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = daConsultoraOnline.GetSaldoHorasSolicitudesPedido(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    saldo = reader.GetString(reader.GetOrdinal("SaldoHoras"));
                }
            }
            return saldo;
        }

        public IList<BEEstrategia> GetRecomendados(RecomendadoRequest RecomendadoRequest)
        {
            try
            {
                RecomendadoRequest.cantidadProductos = 1000;

                var EstrategiasMs = GetRecomendadosApiMS(RecomendadoRequest);

                var CodigoTipoEstrategiasNoAplica = new List<String>() {
                    Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada,
                    Constantes.TipoEstrategiaCodigo.OfertaDelDia,
                    Constantes.TipoEstrategiaCodigo.PackNuevas
                };
                EstrategiasMs = EstrategiasMs.Where(x => x.CodigoEstrategia != 2003 && !CodigoTipoEstrategiasNoAplica.Contains(x.CodigoTipoEstrategia)).ToList();

                EstrategiasMs = EstrategiasMs.OrderBy(x => x.Precio2).ToList();

                EstrategiasMs = GetRecomendadosAlgorithm(RecomendadoRequest, EstrategiasMs);

                var Estrategias = MapearRecomendados(EstrategiasMs, RecomendadoRequest);

                return Estrategias;
            }
            catch (Exception)
            {
                return new List<BEEstrategia>();
            }
        }

        public List<ResponseRecomendacion.Estrategia> GetRecomendadosApiMS(RecomendadoRequest RecomendadoRequest)
        {


            var httpClient = new HttpClient { BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["UrlMicroservicioPersonalizacionSearch"]) };
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var dataString = JsonConvert.SerializeObject(RecomendadoRequest);
            HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
            var response = httpClient.PostAsync(string.Concat("recomendaciones/", RecomendadoRequest.codigoPais, "/", RecomendadoRequest.codigocampania, "/", RecomendadoRequest.origen), contentPost).GetAwaiter().GetResult();
            var jsonString = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();

            var respuesta = JsonConvert.DeserializeObject<OutputOfertaLista>(jsonString);

            return (List<ResponseRecomendacion.Estrategia>)respuesta.Result;
        }

        public List<BEEstrategia> MapearRecomendados(List<ResponseRecomendacion.Estrategia> Estrategias, RecomendadoRequest RecomendadoRequest)
        {

            var estrategias = new List<BEEstrategia>();

            foreach (var item in Estrategias)
            {
                try
                {
                    var estrategia = new BEEstrategia
                    {
                        CampaniaID = Convert.ToInt32(item.CodigoCampania),
                        CodigoEstrategia = item.CodigoEstrategia.ToString(),
                        CodigoProducto = item.CodigoProducto,
                        CUV2 = item.CUV2,
                        DescripcionCUV2 = item.DescripcionCUV2,
                        DescripcionEstrategia = item.DescripcionTipoEstrategia,
                        DescripcionMarca = item.MarcaDescripcion,
                        EstrategiaID = item.EstrategiaId,
                        FlagNueva = Convert.ToInt32(item.FlagNueva),
                        FlagRevista = item.FlagRevista,
                        FotoProducto01 = item.ImagenURL,
                        ImagenURL = item.ImagenEstrategia,
                        IndicadorMontoMinimo = Convert.ToInt32(item.IndicadorMontoMinimo),
                        LimiteVenta = item.LimiteVenta,
                        MarcaID = item.MarcaId,
                        Orden = item.Orden,
                        Precio = item.Precio,
                        Precio2 = item.Precio2,
                        PrecioString = Util.DecimalToStringFormat(item.Precio2, RecomendadoRequest.codigoPais),
                        PrecioTachado = Util.DecimalToStringFormat(item.Precio, RecomendadoRequest.codigoPais),
                        GananciaString = Util.DecimalToStringFormat(item.Ganancia, RecomendadoRequest.codigoPais),
                        Ganancia = item.Ganancia,
                        TextoLibre = item.TextoLibre,
                        TieneVariedad = Convert.ToInt32(item.TieneVariedad),
                        TipoEstrategiaID = item.TipoEstrategiaId,
                        TipoEstrategiaImagenMostrar = 6,
                        EsSubCampania = Convert.ToInt32(item.EsSubCampania),
                        Niveles = item.Niveles,
                        CantidadPack = item.CantidadPack
                    };
                    estrategia.TipoEstrategia = new BETipoEstrategia { Codigo = item.CodigoTipoEstrategia };

                    if (estrategia.Precio2 > 0)
                    {
                        List<BEEstrategiaProducto> compoponentes = new List<BEEstrategiaProducto>();
                        foreach (var componente in item.Componentes)
                        {
                            var estrategiaTono = new BEEstrategiaProducto
                            {
                                Grupo = componente.Grupo.ToString(),
                                CUV = componente.Cuv,
                                SAP = componente.CodigoSap,
                                Orden = componente.Orden,
                                Precio = componente.PrecioUnitario,
                                Digitable = Convert.ToInt32(componente.IndicadorDigitable),
                                Cantidad = componente.Cantidad,
                                FactorCuadre = componente.FactorCuadre,
                                IdMarca = componente.MarcaId,
                                NombreMarca = componente.NombreMarca,
                                NombreComercial = componente.NombreComercial,
                                Volumen = componente.Volumen,
                                NombreBulk = componente.NombreBulk
                            };

                            compoponentes.Add(estrategiaTono);
                        }

                        estrategia.EstrategiaProducto = compoponentes;

                        estrategias.Add(estrategia);
                    }
                }
                catch (Exception)
                {
                    return estrategias;
                }
            }

            return estrategias;
        }

        public List<ResponseRecomendacion.Estrategia> GetRecomendadosAlgorithm(RecomendadoRequest RecomendadoRequest, List<ResponseRecomendacion.Estrategia> Estrategias)
        {
            var EstrategiasRecomendadas = GetExactPackCombination(RecomendadoRequest.productosSolicitados, Estrategias);

            if (EstrategiasRecomendadas.Count == 0)
            {
                var ExactPacksCombinations = new List<ResponseRecomendacion.Estrategia>();

                var ExistPacksCombinations = true;

                foreach (var item in RecomendadoRequest.productosSolicitados)
                {
                    var EstrategiaCombination = GetExactIndividualCombinations(item, Estrategias);

                    ExactPacksCombinations = ExactPacksCombinations.Concat(EstrategiaCombination).ToList();

                    if (EstrategiaCombination.Count == 0)
                    {
                        ExistPacksCombinations = false;
                    }
                }

                if (ExistPacksCombinations) EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(ExactPacksCombinations).ToList();
            }

            if (EstrategiasRecomendadas.Count == 0)
            {
                var ExactPacksCombinations = new List<ResponseRecomendacion.Estrategia>();
                var ExistPacksCombinations = true;
                var CantidadAdicionalesTotal = 0;

                foreach (var item in RecomendadoRequest.productosSolicitados)
                {
                    var CantidadAdicionales = 0;
                    var EstrategiaCombination = GetNotExactIndividualCombinations(item, Estrategias, out CantidadAdicionales);

                    CantidadAdicionalesTotal = CantidadAdicionalesTotal + CantidadAdicionales;
                    ExactPacksCombinations = ExactPacksCombinations.Concat(EstrategiaCombination).ToList();

                    if (EstrategiaCombination.Count == 0)
                    {
                        ExistPacksCombinations = false;
                    }

                    if (CantidadAdicionalesTotal > 2)
                    {
                        ExistPacksCombinations = false;
                    }
                }

                if (ExistPacksCombinations) EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(ExactPacksCombinations).ToList();
            }

            if (EstrategiasRecomendadas.Count == 0)
            {
                var CantidadAdicionales = 0;
                var NotExactPackCombination = GetNotExactPackCombination(RecomendadoRequest.productosSolicitados, Estrategias, out CantidadAdicionales);

                EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(NotExactPackCombination).ToList();
            }

            if (EstrategiasRecomendadas.Count == 0)
            {
                var ExactPacksCombinations = new List<ResponseRecomendacion.Estrategia>();
                var ExistPacksCombinations = true;
                var CantidadAdicionalesTotal = 0;

                foreach (var item in RecomendadoRequest.productosSolicitados)
                {
                    var CantidadAdicionales = 0;
                    var EstrategiaCombination = GetNotExactIndividualWithAditionalCombinations(item, Estrategias, out CantidadAdicionales);

                    CantidadAdicionalesTotal = CantidadAdicionalesTotal + CantidadAdicionales;
                    ExactPacksCombinations = ExactPacksCombinations.Concat(EstrategiaCombination).ToList();

                    if (EstrategiaCombination.Count == 0)
                    {
                        ExistPacksCombinations = false;
                    }

                    if (CantidadAdicionalesTotal > 2)
                    {
                        ExistPacksCombinations = false;
                    }
                }

                if (ExistPacksCombinations) EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(ExactPacksCombinations).ToList();
            }

            if (EstrategiasRecomendadas.Count == 0)
            {
                var NotExactPacksCombinations = GetNotExactPacksCombinations(RecomendadoRequest.productosSolicitados, Estrategias);

                EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(NotExactPacksCombinations).ToList();
            }

            return EstrategiasRecomendadas;
        }

        public List<ResponseRecomendacion.Estrategia> GetExactPackCombination(List<ProductoSolicitado> ProductosSolicitados, List<ResponseRecomendacion.Estrategia> Estrategias)
        {
            var ExisteOfertaExacta = true;

            var EstrategiasRecomendadas = new List<ResponseRecomendacion.Estrategia>();

            var SapList = new List<String>();

            ProductosSolicitados.ForEach(x => { SapList.Add(x.CodigoSap); });

            foreach (var estrategia in Estrategias)
            {
                if (estrategia.Componentes.Exists(comp => !SapList.Contains(comp.CodigoSap))) { continue; }
                if (estrategia.Componentes.Count != ProductosSolicitados.Count) { continue; }

                ProductosSolicitados.ForEach(y =>
                {
                    ExisteOfertaExacta = estrategia.Componentes.Exists(comp => comp.CodigoSap == y.CodigoSap && comp.Cantidad == y.Cantidad);
                });

                if (ExisteOfertaExacta)
                {
                    EstrategiasRecomendadas.Add(estrategia);
                    break;
                }
            }

            return EstrategiasRecomendadas;
        }

        public List<ResponseRecomendacion.Estrategia> GetExactIndividualCombinations(ProductoSolicitado ProductoSolicitado, List<ResponseRecomendacion.Estrategia> Estrategias)
        {
            var EstrategiasRecomendadas = new List<ResponseRecomendacion.Estrategia>();

            var EstrategiasIndividuales = new List<ResponseRecomendacion.Estrategia>();

            foreach (var estrategia in Estrategias)
            {
                if (estrategia.Componentes.Exists(comp => !comp.CodigoSap.Equals(ProductoSolicitado.CodigoSap))) { continue; }

                EstrategiasIndividuales.Add(estrategia);
            }

            EstrategiasIndividuales = EstrategiasIndividuales.OrderByDescending(x => x.Componentes[0].Cantidad).ToList();

            foreach (var estrategia in EstrategiasIndividuales)
            {
                var residuo = ProductoSolicitado.Cantidad % estrategia.Componentes[0].Cantidad;
                var cociente = ProductoSolicitado.Cantidad / estrategia.Componentes[0].Cantidad;
                if (residuo == 0)
                {
                    for (int i = 1; i <= cociente; i++)
                    {
                        EstrategiasRecomendadas.Add(estrategia);
                    }
                    break;
                }
                else
                {
                    var ProductosSolicitados = new List<ProductoSolicitado>() {
                        new ProductoSolicitado
                        {
                            Cantidad = residuo,
                            CodigoSap = ProductoSolicitado.CodigoSap
                        }
                    };

                    var EstrategiasExactPackCombination = GetExactPackCombination(ProductosSolicitados, EstrategiasIndividuales);

                    if (EstrategiasExactPackCombination.Count != 0)
                    {
                        for (int i = 1; i <= cociente; i++)
                        {
                            EstrategiasRecomendadas.Add(estrategia);
                        }

                        EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(EstrategiasExactPackCombination).ToList();
                        break;
                    }
                    else
                    {
                        foreach (var estrategia2 in EstrategiasIndividuales)
                        {
                            var residuo2 = residuo % estrategia2.Componentes[0].Cantidad;
                            var cociente2 = residuo / estrategia2.Componentes[0].Cantidad;
                            if (residuo2 == 0)
                            {
                                for (int i = 1; i <= cociente; i++)
                                {
                                    EstrategiasRecomendadas.Add(estrategia);
                                }

                                for (int i = 1; i <= cociente2; i++)
                                {
                                    EstrategiasRecomendadas.Add(estrategia2);
                                }

                                break;
                            }
                        }
                    }
                }
            }

            return EstrategiasRecomendadas;
        }

        public List<ResponseRecomendacion.Estrategia> GetNotExactIndividualCombinations(ProductoSolicitado ProductoSolicitado, List<ResponseRecomendacion.Estrategia> Estrategias, out int CantidadAdicionales)
        {
            var EstrategiasRecomendadas = new List<ResponseRecomendacion.Estrategia>();

            var EstrategiasIndividuales = new List<ResponseRecomendacion.Estrategia>();
            CantidadAdicionales = 0;

            foreach (var estrategia in Estrategias)
            {
                if (estrategia.Componentes.Exists(comp => !comp.CodigoSap.Equals(ProductoSolicitado.CodigoSap))) { continue; }

                EstrategiasIndividuales.Add(estrategia);
            }

            EstrategiasIndividuales = EstrategiasIndividuales.OrderByDescending(x => x.Componentes[0].Cantidad).ToList();

            foreach (var estrategia in EstrategiasIndividuales)
            {
                var residuo = ProductoSolicitado.Cantidad % estrategia.Componentes[0].Cantidad;
                var cociente = ProductoSolicitado.Cantidad / estrategia.Componentes[0].Cantidad;
                if (residuo == 0)
                {
                    for (int i = 1; i <= cociente; i++)
                    {
                        EstrategiasRecomendadas.Add(estrategia);
                    }
                    break;
                }
                else
                {
                    CantidadAdicionales = ((cociente + 1) * estrategia.Componentes[0].Cantidad - ProductoSolicitado.Cantidad);

                    if (CantidadAdicionales <= 2)
                    {
                        for (int i = 1; i <= cociente + 1; i++)
                        {
                            EstrategiasRecomendadas.Add(estrategia);
                        }
                        break;
                    }
                }
            }

            return EstrategiasRecomendadas;
        }

        public List<ResponseRecomendacion.Estrategia> GetNotExactPackCombination(List<ProductoSolicitado> ProductosSolicitados, List<ResponseRecomendacion.Estrategia> Estrategias, out int CantidadAdicionales)
        {
            var ExisteOfertaNoExacta = true;
            CantidadAdicionales = 0;

            var EstrategiasRecomendadas = new List<ResponseRecomendacion.Estrategia>();

            var SapList = new List<String>();

            ProductosSolicitados.ForEach(x => { SapList.Add(x.CodigoSap); });

            foreach (var estrategia in Estrategias)
            {
                if (estrategia.Componentes.Exists(comp => !SapList.Contains(comp.CodigoSap)))
                {

                    foreach (var productosolicitado in ProductosSolicitados)
                    {
                        ExisteOfertaNoExacta = estrategia.Componentes.Exists(comp => comp.CodigoSap == productosolicitado.CodigoSap && comp.Cantidad == productosolicitado.Cantidad);
                        if (!ExisteOfertaNoExacta)
                        {
                            break;
                        }
                    }

                    if (ExisteOfertaNoExacta)
                    {
                        var ComponentesNoExactos = estrategia.Componentes.Where(comp => !SapList.Contains(comp.CodigoSap));

                        foreach (var ComponenteNoExacto in ComponentesNoExactos)
                        {
                            CantidadAdicionales = CantidadAdicionales + ComponenteNoExacto.Cantidad;
                        }

                        if (CantidadAdicionales <= 2)
                        {
                            EstrategiasRecomendadas.Add(estrategia);
                            break;
                        }
                    }
                }
                else
                {
                    if (estrategia.Componentes.Count == ProductosSolicitados.Count)
                    {
                        foreach (var productoSolicitado in ProductosSolicitados)
                        {
                            var componente = estrategia.Componentes.FirstOrDefault(comp => comp.CodigoSap == productoSolicitado.CodigoSap && comp.Cantidad > productoSolicitado.Cantidad);
                            CantidadAdicionales = CantidadAdicionales + (componente.Cantidad - productoSolicitado.Cantidad);
                        }

                        if (CantidadAdicionales <= 2)
                        {
                            EstrategiasRecomendadas.Add(estrategia);
                            break;
                        }
                    }
                }
            }

            return EstrategiasRecomendadas;
        }

        public List<ResponseRecomendacion.Estrategia> GetNotExactIndividualWithAditionalCombinations(ProductoSolicitado ProductoSolicitado, List<ResponseRecomendacion.Estrategia> Estrategias, out int CantidadAdicionales)
        {
            var EstrategiasRecomendadas = new List<ResponseRecomendacion.Estrategia>();

            var EstrategiasIndividuales = new List<ResponseRecomendacion.Estrategia>();
            CantidadAdicionales = 0;

            foreach (var estrategia in Estrategias)
            {
                if (estrategia.Componentes.Exists(comp => comp.CodigoSap.Equals(ProductoSolicitado.CodigoSap)))
                {
                    EstrategiasIndividuales.Add(estrategia);
                }
            }

            EstrategiasIndividuales = EstrategiasIndividuales.OrderByDescending(x => x.Componentes.First(y => y.CodigoSap.Equals(ProductoSolicitado.CodigoSap)).Cantidad).ToList();

            foreach (var estrategia in EstrategiasIndividuales)
            {
                var residuo = ProductoSolicitado.Cantidad % estrategia.Componentes.First(y => y.CodigoSap.Equals(ProductoSolicitado.CodigoSap)).Cantidad;
                var cociente = ProductoSolicitado.Cantidad / estrategia.Componentes.First(y => y.CodigoSap.Equals(ProductoSolicitado.CodigoSap)).Cantidad;
                if (residuo == 0)
                {
                    CantidadAdicionales = estrategia.Componentes.Where(y => !y.CodigoSap.Equals(ProductoSolicitado.CodigoSap)).Sum(x => x.Cantidad) * cociente;
                    if (CantidadAdicionales <= 2)
                    {
                        for (int i = 1; i <= cociente; i++)
                        {
                            EstrategiasRecomendadas.Add(estrategia);
                        }
                        break;
                    }
                }
            }

            return EstrategiasRecomendadas;
        }

        public List<ResponseRecomendacion.Estrategia> GetNotExactPacksCombinations(List<ProductoSolicitado> ProductosSolicitados, List<ResponseRecomendacion.Estrategia> Estrategias)
        {
            var EstrategiasRecomendadas = new List<ResponseRecomendacion.Estrategia>();
            int CantidadAdicionalesGenral = 0;
            var ExistPacksCombinations = true;

            foreach (var ProductoSolicitado in ProductosSolicitados)
            {
                var ProductosSolicitadosClone = new List<ProductoSolicitado>();
                ProductosSolicitadosClone.Add(ProductoSolicitado);

                var ExactPackCombination = GetExactPackCombination(ProductosSolicitadosClone, Estrategias);

                if (ExactPackCombination.Count > 0)
                {
                    EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(ExactPackCombination).ToList();
                }
                else
                {
                    var ExactPacksCombinations = GetExactIndividualCombinations(ProductoSolicitado, Estrategias);
                    if (ExactPacksCombinations.Count > 0)
                    {
                        EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(ExactPacksCombinations).ToList();
                    }
                    else
                    {
                        var CantidadAdicionales = 0;
                        var NotExactPackCombination = GetNotExactPackCombination(ProductosSolicitadosClone, Estrategias, out CantidadAdicionales);
                        if (NotExactPackCombination.Count > 0)
                        {
                            EstrategiasRecomendadas = EstrategiasRecomendadas.Concat(NotExactPackCombination).ToList();
                            CantidadAdicionalesGenral = CantidadAdicionalesGenral + CantidadAdicionales;
                        }
                        else
                        {
                            ExistPacksCombinations = false;
                        }
                    }
                }
            }

            if (!ExistPacksCombinations || CantidadAdicionalesGenral > 2)
            {
                EstrategiasRecomendadas = new List<ResponseRecomendacion.Estrategia>();
            }

            return EstrategiasRecomendadas;
        }
    }
}
