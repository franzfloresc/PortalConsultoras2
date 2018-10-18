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
        MotivoSolicitud,
        Producto,
        PalabraInvalida,
        ProductoPalabra,
        SeccionConfiguracionOfertasHome,
        ConfiguracionEventoFestivo,
        GNDEstrategia,
        HVEstrategia,
        ConfiguracionValidacion,
        TablaLogicaDatos,
        ProductoProgramaNuevas,
        ProductosExclusivos,
        OpcionesVerificacion,
        DatosRestaurarClave,
        DatosPinAutenticacion,
        HorarioChat,
        HorarioBelcorpResponde,
        CredencialesSMS,
        NivelesProgramaNuevas
    }

    internal static class CacheManager<T>
    {
        private static Lazy<ConnectionMultiplexer> lazyConnection = new Lazy<ConnectionMultiplexer>(() =>
        {
            return ConnectionMultiplexer.Connect(ConfigurationManager.AppSettings["ConnAWSCacheRedis"]);
        });

        public static ConnectionMultiplexer Connection { get { return lazyConnection.Value; } }

        public static void AddData(ECacheItem cacheItem, string customKey, IList<T> value)
        {
            AddData(0, cacheItem, customKey, value);
        }
        public static void AddData(ECacheItem cacheItem, IList<T> value)
        {
            AddData(0, cacheItem, string.Empty, value);
        }
        public static void AddData(ECacheItem cacheItem, IList<T> value, TimeSpan timeCache)
        {
            AddData(0, cacheItem, string.Empty, value, timeCache);
        }
        public static void AddData(int paisID, ECacheItem cacheItem, IList<T> value)
        {
            AddData(paisID, cacheItem, string.Empty, value);
        }
        public static void AddData(int paisID, ECacheItem cacheItem, string customKey, IList<T> value)
        {
            AddData(paisID, cacheItem, customKey, value, TimeSpan.Parse(ConfigurationManager.AppSettings["TimeCacheRedis"]));
        }
        public static void AddData(int paisID, ECacheItem cacheItem, string customKey, IList<T> value, TimeSpan timeCache)
        {
            if (Connection != null)
            {
                string key = getKey(paisID, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    cache.StringSet(key, JsonConvert.SerializeObject(value), timeCache);
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", paisID.ToString()); }
            }
        }

        public static IList<T> GetData(int paisID, ECacheItem cacheItem)
        {
            return GetData(paisID, cacheItem, string.Empty);
        }
        public static IList<T> GetData(ECacheItem cacheItem)
        {
            return GetData(0, cacheItem, string.Empty);
        }
        public static IList<T> GetData(ECacheItem cacheItem, string customKey)
        {
            return GetData(0, cacheItem, customKey);
        }
        public static IList<T> GetData(int paisID, ECacheItem cacheItem, string customKey)
        {
            IList<T> result = null;
            if (Connection != null)
            {
                string key = getKey(paisID, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    if (cache.KeyExists(key)) result = JsonConvert.DeserializeObject<IList<T>>(cache.StringGet(key));
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", paisID.ToString()); }
            }

            return result;
        }

        public static T GetDataElement(int paisID, ECacheItem cacheItem)
        {
            return GetDataElement(paisID, cacheItem, string.Empty);
        }
        public static T GetDataElement(ECacheItem cacheItem)
        {
            return GetDataElement(0, cacheItem, string.Empty);
        }
        public static T GetDataElement(ECacheItem cacheItem, string customKey)
        {
            return GetDataElement(0, cacheItem, customKey);
        }
        public static T GetDataElement(int paisID, ECacheItem cacheItem, string customKey)
        {
            T result = default(T);
            if (Connection != null)
            {
                string key = getKey(paisID, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    if (cache.KeyExists(key)) result = JsonConvert.DeserializeObject<T>(cache.StringGet(key));
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", paisID.ToString()); }
            }

            return result;
        }

        public static void AddDataElement(ECacheItem cacheItem, string customKey, T value)
        {
            AddDataElement(0, cacheItem, customKey, value);
        }
        public static void AddDataElement(ECacheItem cacheItem, T value)
        {
            AddDataElement(0, cacheItem, string.Empty, value);
        }
        public static void AddDataElement(int paisID, ECacheItem cacheItem, T value)
        {
            AddDataElement(paisID, cacheItem, string.Empty, value);
        }
        public static void AddDataElement(int paisID, ECacheItem cacheItem, string customKey, T value)
        {
            AddDataElement(paisID, cacheItem, customKey, value, TimeSpan.Parse(ConfigurationManager.AppSettings["TimeCacheRedis"]));
        }
        public static void AddDataElement(int paisID, ECacheItem cacheItem, string customKey, T value, TimeSpan timeCache)
        {
            if (Connection != null)
            {
                string key = getKey(paisID, cacheItem, customKey);
                try
                {
                    IDatabase cache = Connection.GetDatabase();
                    cache.StringSet(key, JsonConvert.SerializeObject(value), timeCache);
                }
                catch (Exception ex) { LogManager.SaveLog(ex, "", paisID.ToString()); }
            }
        }

        public static void RemoveData(int paisID, ECacheItem cacheItem)
        {
            RemoveData(paisID, cacheItem, string.Empty);
        }
        public static void RemoveData(ECacheItem cacheItem)
        {
            RemoveData(0, cacheItem, string.Empty);
        }
        public static void RemoveData(ECacheItem cacheItem, string customKey)
        {
            RemoveData(0, cacheItem, customKey);
        }
        public static void RemoveData(int paisID, ECacheItem cacheItem, string customKey)
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

        public static T ValidateDataElement(int paisID, ECacheItem cacheItem, Func<T> fn)
        {
            return ValidateDataElement(paisID, cacheItem, string.Empty, fn);
        }
        public static T ValidateDataElement(ECacheItem cacheItem, Func<T> fn)
        {
            return ValidateDataElement(0, cacheItem, string.Empty, fn);
        }
        public static T ValidateDataElement(ECacheItem cacheItem, string customKey, Func<T> fn)
        {
            return ValidateDataElement(0, cacheItem, customKey, fn);
        }
        public static T ValidateDataElement(int paisID, ECacheItem cacheItem, string customKey, Func<T> fn)
        {
            var entidad = GetDataElement(paisID, cacheItem, customKey);
            if (entidad != null) return entidad;

            entidad = fn();
            AddDataElement(paisID, cacheItem, customKey, entidad);
            return entidad;
        }

        private static string getKey(int paisID, ECacheItem cacheItem, string customKey)
        {
            string key = ConfigurationManager.AppSettings["AmbienteCacheRedis"] + "_";
            key += ConfigurationManager.AppSettings["AppCacheRedis"] + "_";
            if (paisID > 0) key += paisID.ToString() + "_";
            key += cacheItem.ToString();
            if (!string.IsNullOrEmpty(customKey)) key += "_" + customKey;

            return key;
        }
    }
}