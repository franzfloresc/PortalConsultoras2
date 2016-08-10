using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using StackExchange.Redis;

namespace Portal.Consultoras.ServiceOFAppCatalogo.Logic
{
    internal enum ECacheItem
    {
        Paises = 1,
        ListaProductoCatalogo = 2,
        ListaProductoCatalogoPcm = 3
    }

    internal class CacheManager<T>
    {
        private static Lazy<ConnectionMultiplexer> lazyConnection = new Lazy<ConnectionMultiplexer>(() =>
        {
            return ConnectionMultiplexer.Connect(ConfigurationManager.AppSettings["ConnAWSCacheRedis"]);
        });

        public static ConnectionMultiplexer Connection { get { return lazyConnection.Value; } }

        public static void AddData(ECacheItem cacheItem, string customKey, IList<T> value)
        {
            addData("", 0, cacheItem, customKey, value);
        }

        public static void AddData(ECacheItem cacheItem, IList<T> value)
        {
            addData("", 0, cacheItem, string.Empty, value);
        }

        public static void AddData(string codigoIso, int campaniaId, ECacheItem cacheItem, IList<T> value)
        {
            addData(codigoIso, campaniaId, cacheItem, string.Empty, value);
        }

        public static void AddData(string codigoIso, ECacheItem cacheItem, string customKey, IList<T> value)
        {
            addData(codigoIso, 0, cacheItem, customKey, value);
        }

        private static void addData(string codigoIso, int campaniaId, ECacheItem cacheItem, string customKey, IList<T> value)
        {
            if (Connection != null)
            {
                string key = getKey(codigoIso, campaniaId, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    TimeSpan TimeCache = TimeSpan.Parse(ConfigurationManager.AppSettings["TimeCacheRedis"]);
                    cache.StringSet(key, JsonConvert.SerializeObject(value), TimeCache);
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", codigoIso); }
            }
        }

        public static IList<T> GetData(string codigoIso, int campaniaId, ECacheItem cacheItem)
        {
            return getData(codigoIso, campaniaId, cacheItem, string.Empty);
        }

        public static IList<T> GetData(ECacheItem cacheItem)
        {
            return getData("", 0, cacheItem, string.Empty);
        }

        public static IList<T> GetData(ECacheItem cacheItem, string customKey)
        {
            return getData("", 0, cacheItem, customKey);
        }

        public static IList<T> GetData(string codigoIso, int campaniaId, ECacheItem cacheItem, string customKey)
        {
            return getData(codigoIso, campaniaId, cacheItem, customKey);
        }

        private static IList<T> getData(string codigoIso, int campaniaId, ECacheItem cacheItem, string customKey)
        {
            IList<T> result = null;
            if (Connection != null)
            {
                string key = getKey(codigoIso, campaniaId, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    if (cache.KeyExists(key)) result = JsonConvert.DeserializeObject<IList<T>>(cache.StringGet(key));
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", codigoIso); }
            }

            return result;
        }

        public static void RemoveData(string codigoIso, int campaniaId, ECacheItem cacheItem)
        {
            removeData(codigoIso, 0, cacheItem, string.Empty);
        }

        public static void RemoveData(string codigoIso, ECacheItem cacheItem, string customKey)
        {
            removeData(codigoIso, 0, cacheItem, customKey);
        }

        public static void RemoveData(ECacheItem cacheItem)
        {
            removeData("", 0, cacheItem, string.Empty);
        }

        public static void RemoveData(ECacheItem cacheItem, string customKey)
        {
            removeData("", 0, cacheItem, customKey);
        }

        private static void removeData(string codigoIso, int campaniaId, ECacheItem cacheItem, string customKey)
        {
            if (Connection != null)
            {
                string key = getKey(codigoIso, campaniaId, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    cache.KeyDelete(key);
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", codigoIso); }
            }
        }

        private static string getKey(string codigoIso, int campaniaId, ECacheItem cacheItem, string customKey)
        {
            string key = "Service_OFAC_";
            if (codigoIso != "") key += codigoIso + "_";
            if (campaniaId != 0) key += campaniaId + "_";
            key += cacheItem.ToString();
            if (!string.IsNullOrEmpty(customKey)) key += "_" + customKey;

            return key;
        }
    }
}