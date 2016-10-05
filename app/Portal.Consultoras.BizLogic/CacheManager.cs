using Newtonsoft.Json;
using Portal.Consultoras.Common;
using StackExchange.Redis;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Portal.Consultoras.BizLogic
{
    internal enum ECacheItem
    {
        Paises = 1,
        Campanias,
        Zonas,
        Regiones,
        ConsultoraCodigos,
        Territorios,
        FormularioDatos,
        Banners,
        GruposBanner,
        BannersBienvenida,
        MenuGeneral,
        BelcorpResponde,
        ServiciosBelcorp,
        FactorGanancia,
        PaisesDD,
        ItemsCarruselInicio,
        MenuMobile,
        ProveedorDespachoCobranza,
        MenuGeneralSB2,
        EscalaDescuento,
        ParametriaOfertaFinal,
        MotivoSolicitud
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
            addData(0, cacheItem, customKey, value);
        }

        public static void AddData(ECacheItem cacheItem, IList<T> value)
        {
            addData(0, cacheItem, string.Empty, value);
        }

        public static void AddData(int paisID, ECacheItem cacheItem, IList<T> value)
        {
            addData(paisID, cacheItem, string.Empty, value);
        }

        public static void AddData(int paisID, ECacheItem cacheItem, string customKey, IList<T> value)
        {
            addData(paisID, cacheItem, customKey, value);
        }

        private static void addData(int paisID, ECacheItem cacheItem, string customKey, IList<T> value)
        {
            if (Connection != null)
            {
                string key = getKey(paisID, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    TimeSpan TimeCache = TimeSpan.Parse(ConfigurationManager.AppSettings["TimeCacheRedis"]);
                    cache.StringSet(key, JsonConvert.SerializeObject(value), TimeCache);
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", paisID.ToString()); }
            }
        }

        public static IList<T> GetData(int paisID, ECacheItem cacheItem)
        {
            return getData(paisID, cacheItem, string.Empty);
        }

        public static IList<T> GetData(ECacheItem cacheItem)
        {
            return getData(0, cacheItem, string.Empty);
        }

        public static IList<T> GetData(ECacheItem cacheItem, string customKey)
        {
            return getData(0, cacheItem, customKey);
        }

        public static IList<T> GetData(int paisID, ECacheItem cacheItem, string customKey)
        {
            return getData(paisID, cacheItem, customKey);
        }

        private static IList<T> getData(int paisID, ECacheItem cacheItem, string customKey)
        {
            IList<T> result = null;
            if (Connection != null)
            {
                string key = getKey(paisID, cacheItem, customKey);                                
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    if(cache.KeyExists(key)) result = JsonConvert.DeserializeObject<IList<T>>(cache.StringGet(key));
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", paisID.ToString()); }
            }

            return result;
        }

        public static void RemoveData(int paisID, ECacheItem cacheItem)
        {
            removeData(paisID, cacheItem, string.Empty);
        }

        public static void RemoveData(int paisID, ECacheItem cacheItem, string customKey)
        {
            removeData(paisID, cacheItem, customKey);
        }

        public static void RemoveData(ECacheItem cacheItem)
        {
            removeData(0, cacheItem, string.Empty);
        }

        public static void RemoveData(ECacheItem cacheItem, string customKey)
        {
            removeData(0, cacheItem, customKey);
        }

        private static void removeData(int paisID, ECacheItem cacheItem, string customKey)
        {
            if (Connection != null)
            {
                string key = getKey(paisID, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    cache.KeyDelete(key);
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", paisID.ToString()); }
            }
        }

        private static string getKey(int paisID, ECacheItem cacheItem, string customKey)
        {
            string key = ConfigurationManager.AppSettings["AmbienteCacheRedis"] + "_";
            key += ConfigurationManager.AppSettings["AppCacheRedis"] + "_";
            if (paisID > 0) key += paisID.ToString() + "_";
            key += cacheItem.ToString();
            if (!string.IsNullOrEmpty(customKey)) key+= "_" + customKey;
            
            return key;
        }
    }
}