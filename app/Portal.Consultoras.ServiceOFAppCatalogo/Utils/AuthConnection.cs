using System;
using System.Net;
using System.Net.Http;
using DotNetOpenAuth.OAuth2;

namespace Portal.Consultoras.ServiceCatalogoPersonalizado.Utils
{
    public class AuthConnection
    {
        public string UrlAuthorizationServer { get; set; }
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }

        public string AuthorizationPath { get; set; }
        public string TokenPath { get; set; }

        public AuthConnection()
        {

        }

        protected bool AcceptAllCertifications(object sender, System.Security.Cryptography.X509Certificates.X509Certificate certification, System.Security.Cryptography.X509Certificates.X509Chain chain, System.Net.Security.SslPolicyErrors sslPolicyErrors)
        {
            return true;
        }

        public string GetResultFromWebService(string urlWebService)
        {
            ServicePointManager.ServerCertificateValidationCallback = new System.Net.Security.RemoteCertificateValidationCallback(AcceptAllCertifications);


            var token = "";

            var urlAuthorizationServer = UrlAuthorizationServer;
            var clientId = ClientId;
            var clientSecret = ClientSecret;

            //Configurar server auth:INI
            var uriAuthorizationServer = new Uri(urlAuthorizationServer);

            var authorizationServer = new AuthorizationServerDescription
            {
                AuthorizationEndpoint = new Uri(uriAuthorizationServer, AuthorizationPath),
                TokenEndpoint = new Uri(uriAuthorizationServer, TokenPath)
            };

            var _webServerClient = new WebServerClient(authorizationServer, clientId, clientSecret);

            //Configurar server auth:FIN

            var state = _webServerClient.GetClientAccessToken();
            token = state.AccessToken;

            var resourceServerUri = new Uri(urlWebService);
            var client = new HttpClient(_webServerClient.CreateAuthorizingHandler(token));
            var result = client.GetStringAsync(resourceServerUri).Result;


            return result;
        }
    }
}