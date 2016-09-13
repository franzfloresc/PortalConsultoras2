namespace Portal.Consultoras.BizLogic
{
    using Data;
    using Entities;
    using System.Data;
    using System.Collections.Generic;
    using System;
    using System.Linq;

    public class BLUbigeo
    {
        public BEUbigeo GetUbigeoPorCodigoTerritorio(int paisID, string codigoZona, string codigoTerritorio)
        {
            var ubigeo = new BEUbigeo();
            var DAUbigeo = new DAUbigeo(paisID);

            using (IDataReader reader = DAUbigeo.GetUbigeoPorCodigoTerritorio(codigoZona, codigoTerritorio))
                if (reader.Read())
                {
                    ubigeo = new BEUbigeo(reader);
                }
            return ubigeo;
        }
        public BEUbigeo GetUbigeoPorCodigoUbigeo(int paisID, string codigoUbigeo)
        {
            var ubigeo = new BEUbigeo();
            var DAUbigeo = new DAUbigeo(paisID);

            using (IDataReader reader = DAUbigeo.GetUbigeoPorCodigoUbigeo(codigoUbigeo))
                if (reader.Read())
                {
                    ubigeo = new BEUbigeo(reader);
                }
            return ubigeo;
        }
        public List<BEUnidadGeografica> GetUnidadesGeograficasPorNivel(int paisID, int nivel,string codigoPadre)
        {
            var vUnidadGeografica = new BEUnidadGeografica();
            var vListaUnidadGeografica = new List<BEUnidadGeografica>();          
                if (paisID > 0)
                {               
                    var DAUbigeo = new DAUbigeo(paisID, 1);
                    using (IDataReader reader = DAUbigeo.GetUbigeosPorNivel(nivel, codigoPadre))
                    while (reader.Read())
                    {
                        vUnidadGeografica = new BEUnidadGeografica(reader);
                        vListaUnidadGeografica.Add(vUnidadGeografica);
                    }
                }
                return vListaUnidadGeografica;                          
        }
        
        public List<BEUnidadGeografica> GetUbigeosPorPais(int paisID)
        { 
            BEUnidadGeografica vUnidadGeografica = new BEUnidadGeografica();
            List<BEUnidadGeografica> vListaUnidadGeografica = new List<BEUnidadGeografica>();

            DAUbigeo DAUbigeo = new DAUbigeo(paisID,1);                
            using (IDataReader reader = DAUbigeo.GetUbigeosPorPais())
            {
                while (reader.Read())
                {
                    vUnidadGeografica = new BEUnidadGeografica(reader);
                    vListaUnidadGeografica.Add(vUnidadGeografica);
                }
            }
            return ArmarArbol(1, vListaUnidadGeografica, vListaUnidadGeografica.Where(l => l.NivelUbigeo == 1).ToList()); 
        }

        public List<BEUnidadGeografica> ArmarArbol(int nivel, List<BEUnidadGeografica> source, List<BEUnidadGeografica> parent)
        {
            var resultado = new List<BEUnidadGeografica>();
            int nivelActual;
            var hijos = new List<BEUnidadGeografica>();
            foreach (var item in parent)
            {
                nivelActual = item.NivelUbigeo;
                if (nivelActual == nivel)
                {
                    hijos = ObtenerHijos(nivelActual, source, item.CodigoUbigeo);
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
            string Codigo = CodigoUbigeo.Substring(0, nivel * 6);             
            var ListaHijos = source.Where(r => r.CodigoUbigeo.Substring(0, nivel * 6) == Codigo).ToList();
            return ListaHijos;
        }
    
    }   
}