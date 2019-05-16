﻿using System;
using JWT;
using Portal.Consultoras.Common;
using Portal.Consultoras.PublicService.Cryptography;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers
{
    public class ChatbotProvider
    {
        public string GetToken(UsuarioModel user, ConfiguracionManagerProvider provider)
        {
            var jwtKey = provider.GetConfiguracionManager(Constantes.ConfiguracionManager.JsonWebTokenSecretKey);
            var secret = provider.GetConfiguracionManager(Constantes.ConfiguracionManager.ChatbotSecret);

            return GetToken(user, secret, jwtKey);
        }

        public string GetToken(UsuarioModel user, string secret, string jwtKey)
        {
            var tokenData = "{\"Documento\": \"" + user.DocumentoIdentidad + "\", \"TipoDocumento\": \"1\", \"key\": \"" + DateTime.Now.Ticks +"\"}";
            var token = AESAlgorithm.EncryptToAES(tokenData, secret);

            var payload = new
            {
                CodigoIso = user.CodigoISO,
                Token = token
            };

            var parameter = JsonWebToken.Encode(payload, jwtKey, JwtHashAlgorithm.HS256);

            return parameter;
        }
    }
}