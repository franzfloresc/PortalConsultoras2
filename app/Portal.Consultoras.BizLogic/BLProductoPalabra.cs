using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;

namespace Portal.Consultoras.BizLogic
{
    public class BLProductoPalabra
    {
        private static readonly string ALPHABET = "abcdefghijklmnopqrstuvwxyzáéíóúñ'";
        private static readonly string REGEXP = string.Format("[{0}]+", ALPHABET.Replace("'", "\\'"));

        private void GetTokens(List<string> listTexto, Action<string> loadTokens)
        {
            var listPalabraInvalida = new BLPalabraInvalida().GetAll().ToList();

            foreach (var texto in listTexto)
            {
                var matches = Regex.Matches(texto.Trim().ToLower(), REGEXP).GetEnumerator();
                while (matches.MoveNext())
                {
                    if (matches.Current != null)
                    {
                        var token = matches.Current.ToString();
                        if (EsPalabraValida(listPalabraInvalida, token)) loadTokens(token);
                    }
                }
            }
        }

        private bool EsPalabraValida(List<string> listPalabraInvalida, string palabra)
        {
            if (string.IsNullOrEmpty(palabra)) return false;
            if (palabra.Length < 3) return false;
            if (listPalabraInvalida.Contains(palabra.ToLower())) return false;

            return true;
        }

        public Dictionary<string, long> GetDictionaryPalabraConteo(string paisISO, int campaniaID)
        {
            int paisId = Util.GetPaisID(paisISO);
            var dictionaryPalabraConteo = CacheManager<Dictionary<string, long>>.GetDataElement(paisId, ECacheItem.ProductoPalabra, campaniaID.ToString());
            if (dictionaryPalabraConteo == null || dictionaryPalabraConteo.Count == 0)
            {
                var dAProductoPalabra = new DAProductoPalabra(paisId);
                dictionaryPalabraConteo = dAProductoPalabra.GetByCampaniaID(campaniaID);
                CacheManager<Dictionary<string, long>>.AddDataElement(paisId, ECacheItem.ProductoPalabra, campaniaID.ToString(), dictionaryPalabraConteo, new TimeSpan(1, 1, 0, 0));
            }
            return dictionaryPalabraConteo;
        }

        public List<string> GetListCandidatoFromTexto(string paisISO, int campaniaID, string texto, int iteracion, int count)
        {
            var listPalabra = GetListPalabraFromTexto(texto);
            if (listPalabra.Count == 0) return listPalabra;

            var dictionaryPalabraListCandidato = new Dictionary<string, List<string>>();
            var listPalabraUnique = new HashSet<string>(listPalabra);
            foreach (var palabra in listPalabraUnique)
            {
                dictionaryPalabraListCandidato.Add(palabra, GetListCandidatoFromPalabra(paisISO, campaniaID, palabra, iteracion, (count == 1).ToInt()));
            }
            if (count > 0) LimitDictionaryPalabraListCandidato(dictionaryPalabraListCandidato, count);

            var listTextoCandidato = new List<string>();
            foreach (var palabraListCandidato in dictionaryPalabraListCandidato)
            {
                listTextoCandidato = listTextoCandidato.Count == 0 ? palabraListCandidato.Value.Select(dc => dc).ToList() :
                    palabraListCandidato.Value.SelectMany(dc => listTextoCandidato, (dc, tc) => tc + " " + dc).ToList();
            }
            return listTextoCandidato;
        }

        public Dictionary<string, long> GetDictionaryCandidatoConteoFromPalabra(string paisISO, int campaniaID, string palabra, int iteracion, int count)
        {
            HashSet<string> listPalabra = new HashSet<string> { palabra };
            for (int i = 0; i <= iteracion; i++)
            {
                if (i > 0) listPalabra = GenerarListParecida(listPalabra);

                var dictionaryPalabraConteoExistente = GetDictionaryPalabraConteoExistente(paisISO, campaniaID, listPalabra);
                if (dictionaryPalabraConteoExistente.Count > 0) return dictionaryPalabraConteoExistente.TakeOrderedByValue(count, true);
            }
            return new Dictionary<string, long> { { palabra, 0 } };
        }

        public List<string> GetListCandidatoFromPalabra(string paisISO, int campaniaID, string palabra, int iteracion, int count)
        {
            HashSet<string> listPalabra = new HashSet<string> { palabra };
            for (int i = 0; i <= iteracion; i++)
            {
                if (i > 0) listPalabra = GenerarListParecida(listPalabra);

                var dictionaryPalabraConteoExistente = GetDictionaryPalabraConteoExistente(paisISO, campaniaID, listPalabra);
                if (dictionaryPalabraConteoExistente.Count > 0) return dictionaryPalabraConteoExistente.TakeListOrderedByValue(count, true);
            }
            return new List<string> { palabra };
        }

        public List<string> GetListPalabraFromTexto(string texto)
        {
            var listPalabra = new List<string>();
            GetTokens(new List<string> { texto }, token => { listPalabra.Add(token); });
            return listPalabra;
        }

        private HashSet<string> GenerarListParecida(HashSet<string> listPalabra)
        {
            var listPalabraParecida = new HashSet<string>();
            foreach (string palabra in listPalabra)
            {
                AddParecidasAgregarLetra(listPalabraParecida, palabra);
                AddParecidasReemplazarLetra(listPalabraParecida, palabra);
                AddParecidasEliminarLetra(listPalabraParecida, palabra);
                AddParecidasTransponerLetra(listPalabraParecida, palabra);
            }
            return listPalabraParecida;
        }

        private void AddParecidasAgregarLetra(HashSet<string> listPalabra, string palabra)
        {
            for (int i = 0; i <= palabra.Length; i++)
            {
                for (int j = 0; j < ALPHABET.Length; j++)
                {
                    listPalabra.Add(palabra.Substring(0, i) + ALPHABET[j] + palabra.Substring(i));
                }
            }
        }

        private void AddParecidasReemplazarLetra(HashSet<string> listPalabra, string palabra)
        {
            for (int i = 0; i < palabra.Length; i++)
            {
                for (int j = 0; j < ALPHABET.Length; j++)
                {
                    listPalabra.Add(palabra.Substring(0, i) + ALPHABET[j] + palabra.Substring(i + 1));
                }
            }
        }

        private void AddParecidasEliminarLetra(HashSet<string> listPalabra, string palabra)
        {
            for (int i = 0; i < palabra.Length; i++)
            {
                listPalabra.Add(palabra.Substring(0, i) + palabra.Substring(i + 1));
            }
        }

        private void AddParecidasTransponerLetra(HashSet<string> listPalabra, string palabra)
        {
            for (int i = 0; i < palabra.Length - 1; i++)
            {
                listPalabra.Add(palabra.Substring(0, i) + palabra.Substring(i + 1, 1) + palabra.Substring(i, 1) + palabra.Substring(i + 2));
            }
        }

        private Dictionary<string, long> GetDictionaryPalabraConteoExistente(string paisISO, int campaniaID, HashSet<string> listPalabra)
        {
            var dictionaryPalabraConteo = GetDictionaryPalabraConteo(paisISO, campaniaID);
            return listPalabra.Where(dictionaryPalabraConteo.ContainsKey).ToDictionary(p => p, p => dictionaryPalabraConteo[p]);
        }

        private void LimitDictionaryPalabraListCandidato(Dictionary<string, List<string>> dictionaryPalabraListCandidato, int limitMerge)
        {
            var dictionaryCountLimit = GetDictionaryCountLimit(dictionaryPalabraListCandidato.ToDictionary(plc => plc.Key, plc => plc.Value.Count), limitMerge);
            foreach (var palabraListCandidato in dictionaryPalabraListCandidato)
            {
                var index = dictionaryCountLimit[palabraListCandidato.Key];
                var count = palabraListCandidato.Value.Count - index;
                palabraListCandidato.Value.RemoveRange(index, count);
            }
        }

        public Dictionary<T, int> GetDictionaryCountLimit<T>(Dictionary<T, int> dictionaryCount, int limitMerge)
        {
            var dictionaryIterator = dictionaryCount.ToDictionary(dc => dc.Key, dc => new BETuplaEditable<int, int, int>(1, 1, dc.Value)).ToList();
            long mergeCount = 1;

            while (mergeCount <= limitMerge)
            {
                var cambioIterator = false;
                foreach (var iterator in dictionaryIterator)
                {
                    iterator.Value.Item1 = iterator.Value.Item2;
                    if (iterator.Value.Item2 < iterator.Value.Item3)
                    {
                        iterator.Value.Item2++;
                        cambioIterator = true;
                    }
                }
                if (!cambioIterator) break;

                mergeCount = dictionaryIterator.Aggregate(1, (result, i) => result * i.Value.Item2);
            }
            return dictionaryIterator.ToDictionary(dc => dc.Key, dc => dc.Value.Item1);
        }
    }
}
