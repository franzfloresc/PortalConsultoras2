using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Configuration;
using System.Collections.Generic;
using Newtonsoft.Json;

using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAClienteDB
    {
        private HttpClient httpClient = null;
        private string requestUri = "api/Cliente";
        private BEAPISB2Response beAPISB2Response;
        private string ServiceResponse_SUCCESS = "0000";

        public DAClienteDB()
        {
            httpClient = new HttpClient();
            string baseAddress = ConfigurationManager.AppSettings["UrlApiSB2"];
            httpClient.BaseAddress = new Uri(baseAddress);
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            beAPISB2Response = new BEAPISB2Response();
        }
        ~DAClienteDB()
        {
            GC.SuppressFinalize(httpClient);
        }

        public List<BEClienteDB> GetClienteByClienteID(string Clientes)
        {
            List<BEClienteDB> result = new List<BEClienteDB>();

            string getRequestUri = string.Format("{0}?Clientes={1}", requestUri, Clientes);
            HttpResponseMessage response = httpClient.GetAsync(getRequestUri).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                var strResult = response.Content.ReadAsStringAsync().Result;
                beAPISB2Response = JsonConvert.DeserializeObject<BEAPISB2Response>(strResult);
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = ((Newtonsoft.Json.Linq.JArray)beAPISB2Response.Respuesta).ToObject<List<BEClienteDB>>();
            }

            return result;
        }

        public List<BEClienteDB> GetCliente(long ClienteID, short TipoContactoID, string Valor)
        {
            List<BEClienteDB> result = new List<BEClienteDB>();

            string getRequestUri = string.Format("{0}?ClienteID={1}&TipoContactoID={2}&Valor={3}", requestUri, ClienteID, TipoContactoID, Valor);
            HttpResponseMessage response = httpClient.GetAsync(getRequestUri).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                var strResult = response.Content.ReadAsStringAsync().Result;
                beAPISB2Response = JsonConvert.DeserializeObject<BEAPISB2Response>(strResult);
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = ((Newtonsoft.Json.Linq.JArray)beAPISB2Response.Respuesta).ToObject<List<BEClienteDB>>();
            }

            return result;
        }

        public long InsertCliente(BEClienteDB cliente)
        {
            long result = 0;

            HttpContent contentPost = new StringContent(JsonConvert.SerializeObject(cliente), System.Text.Encoding.UTF8, "application/json");

            HttpResponseMessage response = httpClient.PostAsync(requestUri, contentPost).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                var strResult = response.Content.ReadAsStringAsync().Result;
                beAPISB2Response = JsonConvert.DeserializeObject<BEAPISB2Response>(strResult);
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = (long)beAPISB2Response.Respuesta;
            }

            return result;
        }

        public bool UpdateCliente(BEClienteDB cliente)
        {
            bool result = false;

            HttpContent contentPost = new StringContent(JsonConvert.SerializeObject(cliente), System.Text.Encoding.UTF8, "application/json");

            HttpResponseMessage response = httpClient.PutAsync(requestUri, contentPost).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                var strResult = response.Content.ReadAsStringAsync().Result;
                beAPISB2Response = JsonConvert.DeserializeObject<BEAPISB2Response>(strResult);
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = (bool)beAPISB2Response.Respuesta;
            }

            return result;
        }

        //public bool DeleteContactoCliente(BEClienteContactoDB contactoCliente)
        //{
        //    bool result = false;

        //    string deleteRequestUri = string.Format("{0}/Delete/contactoCliente?ContactoClienteID={1}&ClienteID={2}&TipoContactoID={3}&Valor={4}", requestUri, contactoCliente.ContactoClienteID, contactoCliente.ClienteID, contactoCliente.TipoContactoID, contactoCliente.Valor);
        //    HttpResponseMessage response = httpClient.DeleteAsync(deleteRequestUri).GetAwaiter().GetResult();

        //    if (response.IsSuccessStatusCode)
        //    {
        //        var strResult = response.Content.ReadAsStringAsync().Result;
        //        beAPISB2Response = JsonConvert.DeserializeObject<BEAPISB2Response>(strResult);
        //        if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = (bool)beAPISB2Response.Respuesta;
        //    }

        //    return result;
        //}
    }
}
