﻿using System.Web;

namespace Portal.Consultoras.Web.Helpers
{
    public static class SessionExtensions
    {
        /// <summary>
        /// Make a unique name
        /// </summary>
        /// <param name="uniqueKey">unique pref key</param>
        /// <param name="name">Identifier common name</param>
        /// <returns>Computed string</returns>
        public static string MakeUniqueName(string uniqueKey, string name)
        {
            return uniqueKey + "_" + name;
        }

        public static void SetUniqueSession(this HttpSessionStateBase session, string uniqueKey, string name, object value)
        {
            session[MakeUniqueName(uniqueKey, name)] = value;
        }

        public static object GetUniqueSession(this HttpSessionStateBase session, string uniqueKey, string name)
        {
            return session[MakeUniqueName(uniqueKey, name)];
        }

        /// <summary>
        /// Obtiene y castea si no es null
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="uniqueKey"></param>
        /// <param name="name"></param>
        /// <param name="session"></param>
        /// <returns></returns>
        public static T GetUniqueSession<T>(this HttpSessionStateBase session, string uniqueKey, string name) where T : class
        {
            var getUniqueSession = GetUniqueSession(session, uniqueKey, name);
            return getUniqueSession == null ? null : (T)getUniqueSession;
        }
    }
}