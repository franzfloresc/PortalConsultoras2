﻿using Newtonsoft.Json;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorBaseProvider
    {
        private const string contentType = "application/json";
        private static readonly HttpClient httpClientBuscador = new HttpClient();

        static BuscadorBaseProvider()
        {
            if (string.IsNullOrEmpty(WebConfig.RutaServiceBuscadorAPI)) return;
            httpClientBuscador.BaseAddress = new Uri(WebConfig.RutaServiceBuscadorAPI);
            httpClientBuscador.DefaultRequestHeaders.Accept.Clear();
            httpClientBuscador.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(contentType));
        }

        public async Task<string> ObtenerPersonalizaciones(string path)
        {
            var personalizacion = "";
            using (var httpClient = new HttpClient())
            {
                httpClient.BaseAddress = new Uri(WebConfig.RutaServiceBuscadorAPI);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(contentType));

                var httpResponse = await httpClient.GetAsync(path);

                if (!httpResponse.IsSuccessStatusCode) return personalizacion;
                var jsonString = await httpResponse.Content.ReadAsStringAsync();
                personalizacion = JsonConvert.DeserializeObject<string>(jsonString);
            }

            return personalizacion;
        }

        public async Task<T> PostAsync<T>(string url, object data) where T : class, new()
        {
            var dataJson = JsonConvert.SerializeObject(data);
            var stringContent = new StringContent(dataJson, Encoding.UTF8, contentType);
            var httpResponse = await httpClientBuscador.PostAsync(url, stringContent);

            if (httpResponse == null || !httpResponse.IsSuccessStatusCode) return new T();

            var httpContent = await httpResponse.Content.ReadAsStringAsync();
            var dataObject = JsonConvert.DeserializeObject<T>(httpContent);

            return dataObject;
        }

        public string ObtenerOrigen()
        {
            return Util.EsDispositivoMovil() ? "sb-mobile" : "sb-desktop";
        }

        public IList<Productos> ValidacionProductoAgregado(IList<Productos> productos, List<BEPedidoWebDetalle> pedidos, UsuarioModel userData, RevistaDigitalModel revistaDigital, bool IsMobile, bool IsHome)
        {
            var suscripcionActiva = revistaDigital.EsSuscrita && revistaDigital.EsActiva;
            if (!productos.Any()) return new List<Productos>();

            foreach (var item in productos)
            {
                var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV).ToList();
                var labelAgregado = "";

                if (pedidoAgregado.Any())
                {
                    labelAgregado = "Agregado";
                }

                item.CampaniaID = userData.CampaniaID;
                item.PrecioString = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo);
                item.ValorizadoString = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo);
                item.DescripcionEstrategia = Util.obtenerNuevaDescripcionProducto(userData.NuevasDescripcionesBuscador, suscripcionActiva, item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId, 0, true);
                item.OrigenPedidoWeb = Util.obtenerCodigoOrigenWeb(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId, IsMobile, IsHome);
                item.Agregado = labelAgregado;
                item.Stock = !item.Stock;
                item.DescripcionCompleta = item.Descripcion;
            }

            return productos;
        }
    }
}