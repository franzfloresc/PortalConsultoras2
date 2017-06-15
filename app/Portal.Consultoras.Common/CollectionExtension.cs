using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Common
{
    public static class CollectionExtension
    {
        public static Dictionary<T, U> TakeOrderedByValue<T, U>(this Dictionary<T, U> dictionary, int count, bool desc = false) where U : IComparable
        {
            var listCandidatoConteo = dictionary.ToList();
            if (desc) listCandidatoConteo.Sort((pair1, pair2) => pair2.Value.CompareTo(pair1.Value));
            else listCandidatoConteo.Sort((pair1, pair2) => pair1.Value.CompareTo(pair2.Value));

            if (count == 0) return listCandidatoConteo.ToDictionary(pc => pc.Key, pc => pc.Value);
            return listCandidatoConteo.Take(count).ToDictionary(pc => pc.Key, pc => pc.Value);
        }

        public static List<T> TakeListOrderedByValue<T, U>(this Dictionary<T, U> dictionary, int count, bool desc = false) where U : IComparable
        {
            IEnumerable<KeyValuePair<T, U>> orderedDictionary = desc ? dictionary.OrderByDescending(d => d.Value) : dictionary.OrderBy(d => d.Value);
            if (count > 0) orderedDictionary = orderedDictionary.Take(count);
            return orderedDictionary.Select(pc => pc.Key).ToList();
        }
    }
}