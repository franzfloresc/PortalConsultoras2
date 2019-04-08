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
                    misPedidos.Add(entidad);
                }

                return misPedidos;
            }
        }

        //public IList<string> GetSapFromCuvlist(string cuvList, int campaniaid, int paisId)
        //{
        //    var daMisPedidos = new DAConsultoraOnline(paisId);
        //    var result = new List<string>();
        //    using (IDataReader reader = daMisPedidos.GetSapFromCuvlist(cuvList, campaniaid))
        //    {
        //        while (reader.Read())
        //        {                  
        //            result.Add(reader[0].ToString());
        //        }
        //        return result;
        //    }
        //}

        public IList<BEMisPedidos> GetMisPedidos(int PaisID, long ConsultoraId, int Campania)
        {
            var daMisPedidos = new DAConsultoraOnline(PaisID);
            var misPedidos = new List<BEMisPedidos>();
            using (IDataReader reader = daMisPedidos.GetSolicitudesPedido(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidos(reader);
                    misPedidos.Add(entidad);
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
                    miPedidoDetalles.Add(entidad);
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
                    detalles.Add(entidad);
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
                    misPedidos.Add(entidad);
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

        public IList<BESolicitudClienteDetalle> GetProductoByCampaniaByConsultoraId(int paisId, int campaniaId, long consultoraId)
        {
            var daConsultoraOnline = new DAConsultoraOnline(paisId);
            var lista = new List<BESolicitudClienteDetalle>();
            using (IDataReader reader = daConsultoraOnline.GetProductoByCampaniaByConsultoraId(campaniaId, consultoraId))
            {
                while (reader.Read())
                {
                    var entidad = new BESolicitudClienteDetalle(reader);
                    lista.Add(entidad);
                }
                return lista;
            }
        }

        public IList<BEEstrategia> GetRecomendados(RecomendadoRequest RecomendadoRequest)
        {
            var estrategias = GetRecomendadosApiMS(RecomendadoRequest);

            return estrategias;
        }

        public IList<BEEstrategia> GetRecomendadosApiMS(RecomendadoRequest RecomendadoRequest)
        {
            var httpClient = new HttpClient { BaseAddress = new Uri("http://localhost:5000/") };
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));


            //RecomendadoRequest.codigoPais = "pe";
           //RecomendadoRequest.codigocampania = "201905";
           // RecomendadoRequest.codigoZona = "1714";
            //RecomendadoRequest.origen = "sb-desktop";
        //    RecomendadoRequest.codigoConsultora = "0033938";
            //RecomendadoRequest.cuv = "14647";
            //RecomendadoRequest.personalizaciones = "";
            //RecomendadoRequest.configuracion = new Configuracion();
            //RecomendadoRequest.configuracion.sociaEmpresaria = "0";
            //RecomendadoRequest.configuracion.diaFacturacion = 1;

            //RecomendadoRequest.configuracion.suscripcionActiva = "False";
            //RecomendadoRequest.configuracion.mdo = "True";
            //RecomendadoRequest.configuracion.rd = "False";
            //RecomendadoRequest.configuracion.rdi = "False";
            //RecomendadoRequest.configuracion.rdr = "False";
            //RecomendadoRequest.configuracion.mostrarProductoConsultado = "True";
        

            RecomendadoRequest.codigoProducto = new List<string>();
            RecomendadoRequest.codigoProducto.Add("210090349");
            RecomendadoRequest.codigoProducto.Add("210090295");
            RecomendadoRequest.codigoProducto.Add("200088604");
            RecomendadoRequest.cantidadProductos = 1000;

            var dataString = JsonConvert.SerializeObject(RecomendadoRequest);
            HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
            var response = httpClient.PostAsync(string.Concat("recomendaciones/", RecomendadoRequest.codigoPais, "/", RecomendadoRequest.codigocampania, "/", RecomendadoRequest.origen), contentPost).GetAwaiter().GetResult();
            var jsonString = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();

            var respuesta = JsonConvert.DeserializeObject<OutputOfertaLista>(jsonString);


            var estrategias = new List<BEEstrategia>();

            foreach (var item in respuesta.Result)
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
                        EstrategiaID = Convert.ToInt32(item.EstrategiaId),
                        FlagNueva = Convert.ToBoolean(item.FlagNueva) ? 1 : 0,
                        FlagRevista = item.FlagRevista,
                        FotoProducto01 = item.ImagenURL,
                        ImagenURL = item.ImagenEstrategia,
                        IndicadorMontoMinimo = Convert.ToInt32(item.IndicadorMontoMinimo),
                        LimiteVenta = Convert.ToInt32(item.LimiteVenta),
                        MarcaID = Convert.ToInt32(item.MarcaId),
                        Orden = Convert.ToInt32(item.Orden),
                        Precio = Convert.ToDecimal(item.Precio),
                        Precio2 = Convert.ToDecimal(item.Precio2),
                        PrecioString = Util.DecimalToStringFormat(Convert.ToDecimal(item.Precio2), RecomendadoRequest.codigoPais),
                        PrecioTachado = Util.DecimalToStringFormat(Convert.ToDecimal(item.Precio), RecomendadoRequest.codigoPais),
                        GananciaString = Util.DecimalToStringFormat(Convert.ToDecimal(item.Ganancia), RecomendadoRequest.codigoPais),
                        Ganancia = Convert.ToDecimal(item.Ganancia),
                        TextoLibre = item.TextoLibre,
                        TieneVariedad = Convert.ToBoolean(item.TieneVariedad) ? 1 : 0,
                        TipoEstrategiaID = Convert.ToInt32(item.TipoEstrategiaId),
                        TipoEstrategiaImagenMostrar = 6,
                        EsSubCampania = Convert.ToBoolean(item.EsSubCampania) ? 1 : 0,
                        Niveles = item.Niveles,
                        // TODO: liberar comentario
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
                                Digitable = Convert.ToBoolean(componente.IndicadorDigitable) ? 1 : 0,
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
                catch (Exception ex)
                {
                    Common.LogManager.SaveLog(ex, string.Empty, RecomendadoRequest.codigoPais);
                    return estrategias;
                }
            }

            return estrategias;
        }
    }
}
