using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using common = Portal.Consultoras.Common.Constantes;

namespace Portal.Consultoras.BizLogic
{
    public class BLZonificacion
    {
        public IList<BEZona> SelectZona(int paisID, string codigo, int rowCount)
        {
            IList<BEZona> zonas = SelectAllZonas(paisID);

            return (from zona in zonas
                    where zona.Codigo.Contains(codigo)
                    select zona).Take(rowCount).ToList();
        }

        public IList<BEZona> SelectZonaById(int paisID, int ZonaID)
        {
            IList<BEZona> zonas = SelectAllZonas(paisID);

            return (from zona in zonas
                    where zona.ZonaID.Equals(ZonaID)
                    select zona).ToList();
        }

        public IList<BEPais> SelectPaises()
        {
            IList<BEPais> paises = (IList<BEPais>)CacheManager<BEPais>.GetData(ECacheItem.Paises);
            if (paises == null)
            {
                paises = new List<BEPais>();
                var masterCountry = ConfigurationManager.AppSettings["masterCountry"];
                int paisMaster = 0;
                if (int.TryParse(Util.Trim(masterCountry), out paisMaster))
                {
                    var daZonificacion = new DAZonificacion(paisMaster);
                    using (IDataReader reader = daZonificacion.GetPais())
                        while (reader.Read())
                            paises.Add(new BEPais(reader));
                    CacheManager<BEPais>.AddData(ECacheItem.Paises, paises);
                }
            }

            var arrPaisesEsika = Util.Trim(WebConfig.PaisesEsika).Split(';');

            foreach (var pais in paises)
            {
                pais.MarcaEnfoque = (arrPaisesEsika.Any(p => p == pais.CodigoISO) ? common.Marca.Esika : common.Marca.LBel);
            }

            return paises;
        }

        public BEPais SelectPais(int paisID)
        {
            return SelectPaises().FirstOrDefault(pais => pais.PaisID == paisID);
        }

        public int GetPaisNumeroCampaniasByPaisID(int paisID)
        {
            int nroCampanias = -1;
            DAZonificacion daZonificacion = new DAZonificacion(paisID);

            using (IDataReader reader = daZonificacion.GetPaisNumeroCampaniasByPaisID(paisID))
            {
                if (reader.Read()) nroCampanias = Convert.ToInt32(reader["NroCampanias"]);
            }
            return nroCampanias;
        }

        public IList<BECampania> SelectCampanias(int paisID)
        {
          
            IList<BECampania>   campanias = new List<BECampania>();
                var daZonificacion = new DAZonificacion(paisID);
                using (IDataReader reader = daZonificacion.GetCampania())
                    while (reader.Read())
                        campanias.Add(new BECampania(reader));
            return campanias;
        }

        public IList<BETerritorio> SelectTerritorio(int paisID, string codigo, int rowCount)
        {
            IList<BETerritorio> territorios = SelectAllTerritorios(paisID);

            return (from terri in territorios
                    where terri.Codigo.Contains(codigo)
                    select terri).Take(rowCount).ToList();
        }

        public IList<BEZona> SelectAllZonas(int paisID)
        {

            IList<BEZona> zonas = (IList<BEZona>)CacheManager<BEZona>.GetData(paisID, ECacheItem.Zonas);
            if (zonas == null)
            {
                zonas = new List<BEZona>();
                var daZonificacion = new DAZonificacion(paisID);
                using (IDataReader reader = daZonificacion.GetZonaByPais(paisID))
                    while (reader.Read())
                        zonas.Add(new BEZona(reader));
                CacheManager<BEZona>.AddData(paisID, ECacheItem.Zonas, zonas);
            }
            return zonas;
        }

        public IList<BERegion> SelectAllRegiones(int paisID)
        {
            IList<BERegion> regiones = (IList<BERegion>)CacheManager<BERegion>.GetData(paisID, ECacheItem.Regiones);
            if (regiones == null)
            {
                regiones = new List<BERegion>();
                var daZonificacion = new DAZonificacion(paisID);
                using (IDataReader reader = daZonificacion.GetRegionByPais(paisID))
                    while (reader.Read())
                        regiones.Add(new BERegion(reader));
                CacheManager<BERegion>.AddData(paisID, ECacheItem.Regiones, regiones);
            }

            return regiones;
        }

        public IList<BETerritorio> SelectAllTerritorios(int paisID)
        {
            IList<BETerritorio> territorios = (IList<BETerritorio>)CacheManager<BETerritorio>.GetData(paisID, ECacheItem.Territorios);
            if (territorios == null)
            {
                territorios = new List<BETerritorio>();
                var daZonificacion = new DAZonificacion(paisID);
                using (IDataReader reader = daZonificacion.GetTerritorio())
                    while (reader.Read())
                        territorios.Add(new BETerritorio(reader));
                CacheManager<BETerritorio>.AddData(paisID, ECacheItem.Territorios, territorios);
            }
            return territorios;
        }

        public IList<BEZona> SelectZonasActivasFIC(int paisID, int CampaniaID)
        {
            IList<BEZona> zonas = new List<BEZona>();
            var daZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = daZonificacion.GetZonasActivasFIC(CampaniaID))
            {
                while (reader.Read()) { zonas.Add(new BEZona(reader)); }
            }
            return zonas;
        }

        public IList<BEZona> SelectZonasInactivasFIC(int paisID, int CampaniaID)
        {
            IList<BEZona> zonas = new List<BEZona>();
            var daZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = daZonificacion.GetZonasInactivasFIC(CampaniaID))
            {
                while (reader.Read()) { zonas.Add(new BEZona(reader)); }
            }
            return zonas;
        }

        public void InsInsCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona)
        {
            var daZonificacion = new DAZonificacion(paisID);

            daZonificacion.InsInsCronogramaFIC(CampaniaCodigo, CodigoZona);
        }

        public void DelCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona)
        {
            var daZonificacion = new DAZonificacion(paisID);

            daZonificacion.DelCronogramaFIC(CampaniaCodigo, CodigoZona);
        }

        public void InsCronogramaFICMasivo(int paisID, int campaniaID, IList<BECronogramaFIC> cronogramaFIC)
        {
            var daZonificacion = new DAZonificacion(paisID);

            List<BECronogramaFIC> lstFinal = new List<BECronogramaFIC>();

            foreach (BECronogramaFIC be in cronogramaFIC)
            {
                BECronogramaFIC item = new BECronogramaFIC();
                item.CodigoConsultora = be.CodigoConsultora;
                item.Zona = be.Zona;
                lstFinal.Add(item);
            }

            daZonificacion.InsCronogramaFICMasivo(campaniaID, lstFinal);
        }

        public IList<BECronogramaFIC> GetCronogramaFICByCampania(int paisID, string CodigoCampania)
        {
            var listCfic = new List<BECronogramaFIC>();
            var daZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = daZonificacion.GetCronogramaFICByCampania(CodigoCampania))
            {
                while (reader.Read()) { listCfic.Add(new BECronogramaFIC(reader)); }
            }
            return listCfic;
        }

        public void UpdCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona, DateTime? Fecha)
        {
            var daZonificacion = new DAZonificacion(paisID);

            daZonificacion.UpdCronogramaFIC(CampaniaCodigo, CodigoZona, Fecha);
        }

        public IList<BECronogramaFIC> GetCronogramaFICByZona(int paisID, string CampaniaCodigo, string ZonaCodigo)
        {
            var listCfic = new List<BECronogramaFIC>();
            var daZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = daZonificacion.GetCronogramaFICByZona(CampaniaCodigo, ZonaCodigo))
            {
                while (reader.Read()) { listCfic.Add(new BECronogramaFIC(reader)); }
            }
            return listCfic;
        }

        public void DelCronogramaFICConsultora(int paisID, string CampaniaCodigo, string CodigoZona, string CodigoConsultora)
        {
            var daZonificacion = new DAZonificacion(paisID);

            daZonificacion.DelCronogramaFICConsultora(CampaniaCodigo, CodigoZona, CodigoConsultora);
        }

        public IList<BEZona> SelectApeZona(int paisID, int regionID, string codigo)
        {
            IList<BEZona> zonas = new List<BEZona>();

            var daZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = daZonificacion.GetApeZona(regionID, codigo))
                while (reader.Read())
                    zonas.Add(new BEZona(reader));

            return zonas;
        }

        public void UpdApeZona(int paisID, int zonaID, int cantidadDias)
        {
            var daZonificacion = new DAZonificacion(paisID);

            daZonificacion.UpdApeZona(zonaID, cantidadDias);
        }

        public IList<BEPais> SelectPaisesDD()
        {
            IList<BEPais> paises = (IList<BEPais>)CacheManager<BEPais>.GetData(ECacheItem.PaisesDD);
            if (paises == null)
            {
                paises = new List<BEPais>();
                var daZonificacion = new DAZonificacion(int.Parse(ConfigurationManager.AppSettings["masterCountry"]));
                using (IDataReader reader = daZonificacion.GetPaisDD())
                    while (reader.Read())
                        paises.Add(new BEPais(reader));
                CacheManager<BEPais>.AddData(ECacheItem.PaisesDD, paises);
            }
            return paises;
        }

        public IList<BETerritorio> SearchTerritoriosByZona(int paisID, string codigoZona, string codigoTerritorio)
        {
            var territorios = new List<BETerritorio>();
            var daZonificacion = new DAZonificacion(paisID);

            using (IDataReader reader = daZonificacion.SearchTerritorioByZona(codigoZona, codigoTerritorio))
                while (reader.Read())
                    territorios.Add(new BETerritorio(reader));

            return territorios;
        }

        public IList<BESegmentoBanner> GetSegmentoBanner(int PaisID)
        {
            var listaSegmentoBanner = new List<BESegmentoBanner>();
            var daZonificacion = new DAZonificacion(PaisID);

            using (IDataReader reader = daZonificacion.GetSegmentoBanner())
                while (reader.Read())
                    listaSegmentoBanner.Add(new BESegmentoBanner(reader));

            return listaSegmentoBanner;
        }

        public IList<BEZonificacionJerarquia> GetZonificacionJerarquia(int PaisID)
        {
            var listaJerarquia = new List<BEZonificacionJerarquia>();
            var daZonificacion = new DAZonificacion(PaisID);

            using (IDataReader reader = daZonificacion.GetZonificacionJerarquia())
                while (reader.Read())
                    listaJerarquia.Add(new BEZonificacionJerarquia(reader));

            return listaJerarquia;
        }
        public IList<BESegmentoBanner> GetSegmentoInternoBanner(int PaisID)
        {
            var listaSegmentoBanner = new List<BESegmentoBanner>();
            var daZonificacion = new DAZonificacion(PaisID);

            using (IDataReader reader = daZonificacion.GetSegmentoInternoBanner())
                while (reader.Read())
                    listaSegmentoBanner.Add(new BESegmentoBanner(reader));
            return listaSegmentoBanner;
        }

        public IList<BEGetRegionByPaisParametroCarga> GetRegionByPaisParametroCarga(int paisID)
        {
            IList<BEGetRegionByPaisParametroCarga> zonas = new List<BEGetRegionByPaisParametroCarga>();
            var daZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = daZonificacion.GetRegionByPaisParametroCarga(paisID))
            {
                while (reader.Read()) { zonas.Add(new BEGetRegionByPaisParametroCarga(reader)); }
            }
            return zonas;

        }

        public IList<BEGetZonaByPaisParametroCarga> GetZonaByPaisParametroCarga(int paisID)
        {
            IList<BEGetZonaByPaisParametroCarga> zonas = new List<BEGetZonaByPaisParametroCarga>();
            var daZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = daZonificacion.GetZonaByPaisParametroCarga(paisID))
            {
                while (reader.Read()) { zonas.Add(new BEGetZonaByPaisParametroCarga(reader)); }
            }
            return zonas;
        }
    }
}