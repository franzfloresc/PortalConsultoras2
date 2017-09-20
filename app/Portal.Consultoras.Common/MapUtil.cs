using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Reflection;

namespace Portal.Consultoras.Common
{
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
                    string drColName = dataReader.GetName(index).ToUpper();
                    if (!propertiesToMap.ContainsKey(drColName)) continue;

                    var propertyInfo = propertiesToMap[drColName];
                    if ((propertyInfo != null) && propertyInfo.CanWrite && dataReader[index] != DBNull.Value)
                    {
                        var value = Convert.ChangeType(dataReader.GetValue(index), propertyInfo.PropertyType);
                        propertyInfo.SetValue(newObject, value, null);
                        //propertyInfo.SetValue(newObject, dataReader.GetValue(index), null);
                    }
                }

                entities.Add(newObject);
            }
            dataReader.Close();
            return entities;
        }

        public static TSource MapToObject<TSource>(this IDataReader dataReader) where TSource : class, new()
        {
            var businessEntityType = typeof(TSource);
            var entity = new TSource();

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
            if (dataReader.Read())
            {
                for (int index = 0; index < dataReader.FieldCount; index++)
                {
                    string drColName = dataReader.GetName(index).ToUpper();
                    if (!propertiesToMap.ContainsKey(drColName)) continue;

                    var propertyInfo = propertiesToMap[drColName];
                    if ((propertyInfo != null) && propertyInfo.CanWrite && dataReader[index] != DBNull.Value)
                    {
                        var value = Convert.ChangeType(dataReader.GetValue(index), propertyInfo.PropertyType);
                        propertyInfo.SetValue(entity, value, null);
                        //propertyInfo.SetValue(newObject, dataReader.GetValue(index), null);
                    }
                }
            }
            dataReader.Close();
            return entity;
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
