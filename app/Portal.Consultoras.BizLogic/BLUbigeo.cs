namespace Portal.Consultoras.BizLogic
{
    using Data;
    using Entities;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;

    public class BLUbigeo
    {
        public BEUbigeo GetUbigeoPorCodigoTerritorio(int paisID, string codigoZona, string codigoTerritorio)
        {
            var ubigeo = new BEUbigeo();
            var daUbigeo = new DAUbigeo(paisID);

            using (IDataReader reader = daUbigeo.GetUbigeoPorCodigoTerritorio(codigoZona, codigoTerritorio))
                if (reader.Read())
                {
                    ubigeo = new BEUbigeo(reader);
                }
            return ubigeo;
        }
        public BEUbigeo GetUbigeoPorCodigoUbigeo(int paisID, string codigoUbigeo)
        {
            var ubigeo = new BEUbigeo();
            var daUbigeo = new DAUbigeo(paisID);

            using (IDataReader reader = daUbigeo.GetUbigeoPorCodigoUbigeo(codigoUbigeo))
                if (reader.Read())
                {
                    ubigeo = new BEUbigeo(reader);
                }
            return ubigeo;
        }
        public List<BEUnidadGeografica> GetUnidadesGeograficasPorNivel(int paisID, int nivel,string codigoPadre)
        {
            var vListaUnidadGeografica = new List<BEUnidadGeografica>();          
                if (paisID > 0)
                {               
                    var daUbigeo = new DAUbigeo(paisID, 1);
                    using (IDataReader reader = daUbigeo.GetUbigeosPorNivel(nivel, codigoPadre))
                    while (reader.Read())
                    {
                        var vUnidadGeografica = new BEUnidadGeografica(reader);
                        vListaUnidadGeografica.Add(vUnidadGeografica);
                    }
                }
                return vListaUnidadGeografica;                          
        }
        
        public List<BEUnidadGeografica> GetUbigeosPorPais(int paisID)
        {
            List<BEUnidadGeografica> vListaUnidadGeografica = new List<BEUnidadGeografica>();

            DAUbigeo daUbigeo = new DAUbigeo(paisID,1);                
            using (IDataReader reader = daUbigeo.GetUbigeosPorPais())
            {
                while (reader.Read())
                {
                    var vUnidadGeografica = new BEUnidadGeografica(reader);
                    vListaUnidadGeografica.Add(vUnidadGeografica);
                }
            }
            return ArmarArbol(1, vListaUnidadGeografica, vListaUnidadGeografica.Where(l => l.NivelUbigeo == 1).ToList()); 
        }

        public List<BEUnidadGeografica> ArmarArbol(int nivel, List<BEUnidadGeografica> source, List<BEUnidadGeografica> parent)
        {
            var resultado = new List<BEUnidadGeografica>();
            foreach (var item in parent)
            {
                var nivelActual = item.NivelUbigeo;
                if (nivelActual == nivel)
                {
                    var hijos = ObtenerHijos(nivelActual, source, item.CodigoUbigeo);
                    if (hijos.Count > 0)
                    {
                        item.Ubigeo = ArmarArbol(nivel + 1, source, hijos);
                    }
                    resultado.Add(item);
                }
            }

            return resultado;
        }

        public List<BEUnidadGeografica> ObtenerHijos(int nivel, List<BEUnidadGeografica> source, string CodigoUbigeo)
        {
            string codigo = CodigoUbigeo.Substring(0, nivel * 6);             
            var listaHijos = source.Where(r => r.CodigoUbigeo.Substring(0, nivel * 6) == codigo).ToList();
            return listaHijos;
        }
    
    }   
}