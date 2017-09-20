using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

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
                    var propertyInfo = propertiesToMap[dataReader.GetName(index).ToUpper()];
                    if ((propertyInfo != null) && propertyInfo.CanWrite && dataReader[index] != DBNull.Value)
                    {
                        propertyInfo.SetValue(newObject, dataReader.GetValue(index), null);
                    }
                }

                entities.Add(newObject);
            }
            dataReader.Close();
            return entities;
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
