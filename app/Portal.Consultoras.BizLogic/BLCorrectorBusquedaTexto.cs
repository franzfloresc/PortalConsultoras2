using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;

namespace Portal.Consultoras.BizLogic
{
    public class BLCorrectorBusquedaTexto
    {
        private readonly string REGEXP = "[a-zA-ZáéíóúAÉÍÓÚÑñ\\']+";
        private readonly List<string> FILTER = new List<string> { "hola", "mas", "lts", "edp", "noc", "del", "rcto", "len" };
        private readonly string ALPHABET = "abcdefghijklmnopqrstuvwxyzáéíóúñ'";

        private readonly List<BEProductoBusqueda> productos;
        private readonly Dictionary<string, long> PalabraConteo = new Dictionary<string, long>();

        private long N;

        /**********************************************************/

        public BLCorrectorBusquedaTexto(List<BEProductoBusqueda> productos)
        {
            this.productos = productos;
            Init();
        }

        /**********************************************************/

        private void Init()
        {
            string palabra;
            foreach (BEProductoBusqueda producto in productos)
            {
                string word = "";
                if (!string.IsNullOrEmpty(producto.Marca)) word += producto.Marca + " ";
                if (!string.IsNullOrEmpty(producto.Categoria)) word += producto.Categoria + " ";
                if (!string.IsNullOrEmpty(producto.Nombres)) word += producto.Nombres + " ";
                if (!string.IsNullOrEmpty(producto.Descripcion)) word += producto.Descripcion + " ";

                var match = Regex.Match(word.Trim().ToLower(), REGEXP);
                while (match.Success)
                {
                    palabra = match.Value;
                    if (IsValidWord(palabra))
                    {
                        if (PalabraConteo.ContainsKey(palabra)) PalabraConteo[palabra]++;
                        else PalabraConteo.Add(palabra, 1);
                    }
                    match.NextMatch();
                }
            }

            N = PalabraConteo.Sum(pr => pr.Value);
        }

        private bool IsValidWord(string palabra)
        {
            if (string.IsNullOrEmpty(palabra)) return false;
            if (palabra.Length < 3) return false;
            if (FILTER.Contains(palabra.ToLower())) return false;

            return true;
        }

        /**********************************************************/

        public List<string> Tokens(string word)
        {
            List<string> listPalabra = new List<string>();
            string palabra;

            var match = Regex.Match(word.Trim().ToLower(), REGEXP);
            while (match.Success)
            {
                palabra = match.Value;
                if (IsValidWord(palabra)) listPalabra.Add(palabra);
                match.NextMatch();
            }
            return listPalabra;
        }

        public List<string> Edits1(string word)
        {
            HashSet<string> delTraRepIns = new HashSet<string>();

            for (int i = 0; i < word.Length; i++)
            {
                delTraRepIns.Add(word.Substring(0, i) + word.Substring(i + 1));
            }
            for (int i = 0; i < word.Length - 1; i++)
            {
                delTraRepIns.Add(word.Substring(0, i) + word.Substring(i + 1, i + 2) + word.Substring(i, i + 1) + word.Substring(i + 2));
            }
            for (int i = 0; i < word.Length; i++)
            {
                for (int j = 0; j < ALPHABET.Length; j++)
                {
                    delTraRepIns.Add(word.Substring(0, i) + ALPHABET[j] + word.Substring(i + 1));
                }
            }
            for (int i = 0; i <= word.Length; i++)
            {
                for (int j = 0; j < ALPHABET.Length; j++)
                {
                    delTraRepIns.Add(word.Substring(0, i) + ALPHABET[j] + word.Substring(i));
                }
            }

            return new List<string>(delTraRepIns);
        }

        public List<string> Edits2(string word)
        {
            HashSet<string> temp = new HashSet<string>();
            foreach (string e1 in Edits1(word))
            {
                foreach (string e2 in Edits1(e1)) temp.Add(e2);
            }
            return new List<string>(temp);
        }

        public List<string> Known(List<string> word)
        {
            HashSet<string> temp = new HashSet<string>();
            foreach (string w in word)
            {
                if (PalabraConteo.ContainsKey(w)) temp.Add(w);
            }
            return new List<string>(temp);
        }

        public List<string> Candidates(string word)
        {
            List<string> result = new List<string> { word };

            var known0 = Known(result);
            if (known0.Count > 0) return known0;

            var known1 = Known(Edits1(word));
            if (known1.Count > 0) return known1;

            var known2 = Known(Edits2(word));
            if (known2.Count > 0) return known2;

            return result;
        }

        private List<string> Max(List<string> candidates, int n)
        {
            var ListDictionary = PalabraConteo.Where(pc => candidates.Contains(pc.Key)).ToList();
            ListDictionary.Sort((pair1, pair2) => pair1.Value.CompareTo(pair2.Value));
            return ListDictionary.Take(n).Select(pc => pc.Key).ToList();
        }

        public string Correct(string word)
        {
            List<string> result = Max(Candidates(word), 1);
            if (result == null || result.Count == 0) return word;
            return result.First();
        }

        public string CorrectText(string text)
        {
            string result = "";
            foreach (string palabra in Tokens(text))
            {
                result += Correct(palabra) + " ";
            }
            return result.Trim();
        }

        public double Pword(string word)
        {
            if (!PalabraConteo.ContainsKey(word)) return 0;
            return PalabraConteo[word] / Convert.ToDouble(N);
        }

        public double Pwords(string word)
        {
            double result = 0;
            foreach (string palabra in Tokens(word))
            {
                result += Pword(palabra);
            }
            return result;
        }

        public int PwordsSum(List<string> words)
        {
            int t = 0;
            foreach (string w in words)
            {
                if (Pword(w) == 0) continue;
                t++;
            }
            return t;
        }

        //public List<Dictionary<string, List<BEProductoBusqueda>>> getProductosByText(string text, bool correction)
        //{

        //    return Observable.create(new ObservableOnSubscribe<Map<string, List<ProductModel>>>() {
        //        public void subscribe(ObservableEmitter<Map<string, List<ProductModel>>> emitter)
        //        { 
        //            try
        //            {
        //                Map<string, List<ProductModel>> result = new HashMap<>();
        //                string correct = correction ? CorrectText(text) : text;

        //                string[] filters = correct.split(" ");
        //                List<ProductModel> models = new ArrayList<>();
        //                Integer pw = correction ? PwordsSum(Arrays.asList(filters)) : filters.length;

        //                if (correction && pw > 0)
        //                {
        //                    correct = quisisteDecir(correct);
        //                    filters = correct.split(" ");
        //                }

        //                for (ProductModel model : productos)
        //                {
        //                    if (Contiene(model.getMarca() + model.getCategoria() + model.getNombres() + model.getDescripcion(), filters, pw))
        //                    {
        //                        models.add(model);
        //                    }
        //                }

        //                result.put(correct, models);

        //                emitter.onNext(result);
        //                emitter.onComplete();

        //            }
        //            catch (Exception ex) { emitter.onError(ex); }
        //        }
        //    });
        //}

        //public Observable<string> CorrectText(final List<string> text)
        //{
        //    return Observable.create(new ObservableOnSubscribe<string>() {
        //        public void subscribe(ObservableEmitter<string> emitter) throws Exception
        //        {
        //            try
        //            {
        //                Map<Double, string> result = new HashMap<Double, string>();
        //                Double res = 0.;

        //                for (string t : text)
        //                {
        //                    string ct = CorrectText(t);
        //                    Double pw = Pwords(ct);

        //                    result.put(pw, ct);

        //                    if (pw > res)
        //                    {
        //                        res = pw;
        //                    }
        //                }

        //                emitter.onNext(result.get(res));
        //                emitter.onComplete();

        //            }
        //            catch (Exception ex) {
        //                emitter.onError(ex);
        //            }
        //        }
        //    });
        //}

        public string quisisteDecir(string correct)
        {
            string result = "";
            string[] c2 = correct.Split(' ');

            for (int i = 0; i < c2.Length; i++)
            {
                if (Pword(c2[i]) > 0) result += c2[i] + " ";
            }
            return result.Trim();
        }

        public bool Contiene(string text, string[] filters, int pw)
        {
            int t = 0;
            foreach (string filter in filters)
            {
                if (!text.ToLower().Contains(filter)) break;
                t++;
            }
            return t > 0 && t >= pw;
        }
    }
}