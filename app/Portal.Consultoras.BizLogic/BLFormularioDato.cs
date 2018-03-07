using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLFormularioDato
    {
        private readonly DAFormularioDato DAFormularioDato;

        public BLFormularioDato()
        {
            DAFormularioDato = new DAFormularioDato();
        }

        public void Insert(BEFormularioDato formularioDato)
        {
            DAFormularioDato.InsFormularioDato(formularioDato);
            CacheManager<BEFormularioDato>.RemoveData(formularioDato.PaisID, ECacheItem.FormularioDatos);
        }

        public void Update(BEFormularioDato formularioDato)
        {
            DAFormularioDato.UpdFormularioDato(formularioDato);
            CacheManager<BEFormularioDato>.RemoveData(formularioDato.PaisID, ECacheItem.FormularioDatos);
        }

        public void Delete(int paisID, ETipoFormulario tipoFormularioID, int formularioDatoID)
        {
            DAFormularioDato.DelFormularioDato(paisID, (int)tipoFormularioID, formularioDatoID);
            CacheManager<BEFormularioDato>.RemoveData(paisID, ECacheItem.FormularioDatos);
        }

        private IList<BEFormularioDato> Select(int paisID)
        {
            IList<BEFormularioDato> formularioDatos = (IList<BEFormularioDato>)CacheManager<BEFormularioDato>.GetData(paisID, ECacheItem.FormularioDatos);
            if (formularioDatos == null)
            {
                formularioDatos = new List<BEFormularioDato>();
                using (IDataReader reader = DAFormularioDato.GetFormularioDatoAll(paisID))
                {
                    while (reader.Read())
                    {
                        formularioDatos.Add(new BEFormularioDato(reader));
                    }
                }
                CacheManager<BEFormularioDato>.AddData(paisID, ECacheItem.FormularioDatos, formularioDatos);
            }
            return formularioDatos;
        }

        public IList<BEFormularioDato> Select(int paisID, ETipoFormulario tipoFormularioID)
        {
            IList<BEFormularioDato> formularioDatos = Select(paisID);
            return (from formularioDato in formularioDatos
                    where formularioDato.TipoFormularioID == tipoFormularioID
                    select formularioDato).ToList();
        }

        public BEFormularioDato Select(ETipoFormulario tipoFormularioID)
        {
            IList<BEFormularioDato> formularioDatos = Select(int.Parse(ConfigurationManager.AppSettings["masterCountry"]));
            return (from formularioDato in formularioDatos
                    where formularioDato.TipoFormularioID == tipoFormularioID
                    select formularioDato).FirstOrDefault();
        }
    }
}