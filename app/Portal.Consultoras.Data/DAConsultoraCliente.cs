using System;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Configuration;
using System.Threading.Tasks;

using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraCliente : DataAccess
    {
        private HttpClient httpClient = null;
        private string requestUri = "api/Cliente";
        private BEAPISB2Response beAPISB2Response;
        private string ServiceResponse_SUCCESS = "0000";

        public DAConsultoraCliente(int paisID)
            : base(paisID, EDbSource.Portal)
        {
            httpClient = new HttpClient();
            string baseAddress = ConfigurationManager.AppSettings["UrlApiSB2"];
            httpClient.BaseAddress = new Uri(baseAddress);
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            beAPISB2Response = new BEAPISB2Response();
        }

        ~DAConsultoraCliente()
        {
            GC.SuppressFinalize(httpClient);
        }

        #region ConsultoraCliente
        public List<BEAnotacion> GetConsultoraCliente(long ConsultoraID)
        {
            var list = new List<BEAnotacion>();

            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.GetConsultoraCliente");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            using (var reader = Context.ExecuteReader(command))
            {
                while (reader.Read())
                {
                    var entity = new BEAnotacion
                    {
                        ConsultoraClienteID = GetDataValue<long>(reader, "ConsultoraClienteID"),
                        ConsultoraID = GetDataValue<long>(reader, "ConsultoraID"),
                        ClienteID = GetDataValue<long>(reader, "ClienteID"),
                        Favorito = GetDataValue<short>(reader, "Favorito"),
                        TipoContactoFavorito = GetDataValue<short>(reader, "TipoContactoFavorito"),

                        AnotacionID = GetDataValue<long>(reader, "AnotacionID"),
                        Descripcion = GetDataValue<string>(reader, "Descripcion")
                    };

                    list.Add(entity);
                }
            }

            return list;
        }

        public bool DeleteConsultoraCliente(long ConsultoraID, long ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.DeleteConsultoraCliente");

            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, ClienteID);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public long InsertConsultoraCliente(BEConsultoraCliente consultoraCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.InsertConsultoraCliente");

            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraCliente.ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, consultoraCliente.ClienteID);
            Context.Database.AddInParameter(command, "@Favorito", DbType.Int16, consultoraCliente.Favorito);
            Context.Database.AddInParameter(command, "@TipoContactoFavorito", DbType.Int16, consultoraCliente.TipoContactoFavorito);

            return Convert.ToInt64(Context.ExecuteScalar(command));
        }
        #endregion

        #region Cliente
        public List<BEConsultoraCliente> GetClienteByClienteID(string Clientes)
        {
            List<BEConsultoraCliente> result = new List<BEConsultoraCliente>();

            string getRequestUri = string.Format("{0}?Clientes={1}", requestUri, Clientes);
            HttpResponseMessage response = httpClient.GetAsync(getRequestUri).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                beAPISB2Response = response.Content.ReadAsAsync<BEAPISB2Response>().Result;
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = ((Newtonsoft.Json.Linq.JArray)beAPISB2Response.Respuesta).ToObject<List<BEConsultoraCliente>>();
            }

            return result;
        }

        public List<BEConsultoraCliente> GetCliente(long ClienteID,short TipoContactoID, string Valor)
        {
            List<BEConsultoraCliente> result = new List<BEConsultoraCliente>();

            string getRequestUri = string.Format("{0}?ClienteID={1}&TipoContactoID={2}&Valor={3}", requestUri,ClienteID, TipoContactoID, Valor);
            HttpResponseMessage response = httpClient.GetAsync(getRequestUri).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                beAPISB2Response = response.Content.ReadAsAsync<BEAPISB2Response>().Result;
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = ((Newtonsoft.Json.Linq.JArray)beAPISB2Response.Respuesta).ToObject<List<BEConsultoraCliente>>();
            }

            return result;
        }

        public long InsertCliente(BEConsultoraCliente cliente)
        {
            long result = 0;

            HttpResponseMessage response = httpClient.PostAsJsonAsync(requestUri, cliente).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                beAPISB2Response = response.Content.ReadAsAsync<BEAPISB2Response>().Result;
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = (long)beAPISB2Response.Respuesta;
            }

            return result;
        }

        public bool UpdateCliente(BEConsultoraCliente cliente)
        {
            bool result = false;

            HttpResponseMessage response = httpClient.PutAsJsonAsync(requestUri, cliente).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                beAPISB2Response = response.Content.ReadAsAsync<BEAPISB2Response>().Result;
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = (bool)beAPISB2Response.Respuesta;
            }

            return result;
        }

        public bool DeleteContactoCliente(BEContactoCliente contactoCliente)
        {
            bool result = false;

            string deleteRequestUri = string.Format("{0}/Delete/contactoCliente?ContactoClienteID={1}&ClienteID={2}&TipoContactoID={3}&Valor={4}", requestUri, contactoCliente.ContactoClienteID, contactoCliente.ClienteID, contactoCliente.TipoContactoID, contactoCliente.Valor);
            HttpResponseMessage response = httpClient.DeleteAsync(deleteRequestUri).GetAwaiter().GetResult();

            if (response.IsSuccessStatusCode)
            {
                beAPISB2Response = response.Content.ReadAsAsync<BEAPISB2Response>().Result;
                if (beAPISB2Response.Codigo == ServiceResponse_SUCCESS) result = (bool)beAPISB2Response.Respuesta;
            }

            return result;
        }
        #endregion

        #region Anotacion
        public bool InsertAnotacion(BEAnotacion anotacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.InsertAnotacion");

            Context.Database.AddInParameter(command, "@ConsultoraClienteID", DbType.Int64, anotacion.ConsultoraClienteID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, anotacion.Descripcion);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public bool UpdateAnotacion(BEAnotacion anotacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.UpdateAnotacion");

            Context.Database.AddInParameter(command, "@AnotacionID", DbType.Int64, anotacion.AnotacionID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, anotacion.Descripcion);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public bool DeleteAnotacion(long AnotacionID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.DeleteAnotacion");

            Context.Database.AddInParameter(command, "@AnotacionID", DbType.Int64, AnotacionID);

            return Context.ExecuteNonQuery(command) > 0;
        }
        #endregion
    }
}