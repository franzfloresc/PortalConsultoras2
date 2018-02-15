using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Reflection;

namespace Portal.Consultoras.Common
{
    /// <summary>
    /// Utils for map
    /// more info: https://www.red-gate.com/simple-talk/dotnet/.net-framework/a-defense-of-reflection-in-.net/
    /// </summary>
    public static class MapUtil
    {
        /// <summary>
        /// Map only fields decorated with ColumnAttribute, otherwise ignore
        /// </summary>
        /// <param name="dataReader"></param>
        /// <returns></returns>
        public static List<TSource> MapToCollection<TSource>(this IDataReader dataReader) where TSource : class, new()
        {
            var businessEntityType = typeof(TSource);
            var entities = new List<TSource>();

            var properties = businessEntityType.GetProperties();
            var propertiesToMap = new Dictionary<string, PropertyInfo>();

            foreach (var propertyInfo in properties)
            {
                var columnName = GetColunmName(propertyInfo);
                if (!string.IsNullOrEmpty(columnName))
                {
                    propertiesToMap[columnName.ToUpper()] = propertyInfo;
                }
            }
            while (dataReader.Read())
            {
                var newObject = new TSource();
                for (int index = 0; index < dataReader.FieldCount; index++)
                {
                    string columnName = dataReader.GetName(index).ToUpper();
                    if (!propertiesToMap.ContainsKey(columnName)) continue;

                    var propertyInfo = propertiesToMap[columnName];
                    if ((propertyInfo != null) && propertyInfo.CanWrite && dataReader[index] != DBNull.Value)
                    {
                        try
                        {
                            propertyInfo.SetValue(newObject, dataReader.GetValue(index), null);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(ex);
                            throw new InvalidCastException(columnName, ex);
                        }
                    }
                }

                entities.Add(newObject);
            }

            return entities;
        }

        public static TSource MapToObject<TSource>(this IDataReader dataReader) where TSource : class, new()
        {
            return MapToCollection<TSource>(dataReader).FirstOrDefault() ?? new TSource();
        }

        private static string GetColunmName(PropertyInfo property)
        {
            var columnAttribute = property.GetCustomAttributes(typeof(ColumnAttribute), false).FirstOrDefault();
            if (columnAttribute != null)
                return ((ColumnAttribute)columnAttribute).Name;

            return null;
        }
    }
}
