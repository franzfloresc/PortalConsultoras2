using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

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
                var DAZonificacion = new DAZonificacion(int.Parse(ConfigurationManager.AppSettings["masterCountry"]));
                using (IDataReader reader = DAZonificacion.GetPais())
                    while (reader.Read())
                        paises.Add(new BEPais(reader));
                CacheManager<BEPais>.AddData(ECacheItem.Paises, paises);
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
            DAZonificacion DAZonificacion = new DAZonificacion(paisID);
            try
            {
                using (IDataReader reader = DAZonificacion.GetPaisNumeroCampaniasByPaisID(paisID))
                {
                    if (reader.Read()) nroCampanias = Convert.ToInt32(reader["NroCampanias"]);
                }
            }
            catch (Exception) { }
            return nroCampanias;
        }

        public IList<BECampania> SelectCampanias(int paisID)
        {
            IList<BECampania> campanias = (IList<BECampania>)CacheManager<BECampania>.GetData(paisID, ECacheItem.Campanias);
            if (campanias == null)
            {
                campanias = new List<BECampania>();
                var DAZonificacion = new DAZonificacion(paisID);
                using (IDataReader reader = DAZonificacion.GetCampania())
                    while (reader.Read())
                        campanias.Add(new BECampania(reader));
                CacheManager<BECampania>.AddData(paisID, ECacheItem.Campanias, campanias);
            }
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
                var DAZonificacion = new DAZonificacion(paisID);
                using (IDataReader reader = DAZonificacion.GetZonaByPais(paisID))
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
                var DAZonificacion = new DAZonificacion(paisID);
                using (IDataReader reader = DAZonificacion.GetRegionByPais(paisID))
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
                var DAZonificacion = new DAZonificacion(paisID);
                using (IDataReader reader = DAZonificacion.GetTerritorio())
                    while (reader.Read())
                        territorios.Add(new BETerritorio(reader));
                CacheManager<BETerritorio>.AddData(paisID, ECacheItem.Territorios, territorios);
            }
            return territorios;
        }

        public IList<BEZona> SelectZonasActivasFIC(int paisID, int CampaniaID)
        {
            IList<BEZona> zonas = new List<BEZona>();
            var DAZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = DAZonificacion.GetZonasActivasFIC(CampaniaID))
            {
                while (reader.Read()) { zonas.Add(new BEZona(reader)); }
            }
            return zonas;
        }

        public IList<BEZona> SelectZonasInactivasFIC(int paisID, int CampaniaID)
        {
            IList<BEZona> zonas = new List<BEZona>();
            var DAZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = DAZonificacion.GetZonasInactivasFIC(CampaniaID))
            {
                while (reader.Read()) { zonas.Add(new BEZona(reader)); }
            }
            return zonas;
        }

        public void InsInsCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona)
        {
            var DAZonificacion = new DAZonificacion(paisID);

            DAZonificacion.InsInsCronogramaFIC(CampaniaCodigo, CodigoZona);
        }

        public void DelCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona)
        {
            var DAZonificacion = new DAZonificacion(paisID);

            DAZonificacion.DelCronogramaFIC(CampaniaCodigo, CodigoZona);
        }

        public void InsCronogramaFICMasivo(int paisID, int campaniaID, IList<BECronogramaFIC> cronogramaFIC)
        {
            var DAZonificacion = new DAZonificacion(paisID);

            List<BECronogramaFIC> lstFinal = new List<BECronogramaFIC>();

            foreach (BECronogramaFIC be in cronogramaFIC)
            {
                BECronogramaFIC item = new BECronogramaFIC();
                item.CodigoConsultora = be.CodigoConsultora;
                item.Zona = be.Zona;
                lstFinal.Add(item);
            }

            DAZonificacion.InsCronogramaFICMasivo(campaniaID, lstFinal);
        }

        public IList<BECronogramaFIC> GetCronogramaFICByCampania(int paisID, string CodigoCampania)
        {
            var ListCFIC = new List<BECronogramaFIC>();
            var DAZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = DAZonificacion.GetCronogramaFICByCampania(CodigoCampania))
            {
                while (reader.Read()) { ListCFIC.Add(new BECronogramaFIC(reader)); }
            }
            return ListCFIC;
        }

        public void UpdCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona, DateTime? Fecha)
        {
            var DAZonificacion = new DAZonificacion(paisID);

            DAZonificacion.UpdCronogramaFIC(CampaniaCodigo, CodigoZona, Fecha);
        }

        public IList<BECronogramaFIC> GetCronogramaFICByZona(int paisID, string CampaniaCodigo, string ZonaCodigo)
        {
            var ListCFIC = new List<BECronogramaFIC>();
            var DAZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = DAZonificacion.GetCronogramaFICByZona(CampaniaCodigo, ZonaCodigo))
            {
                while (reader.Read()) { ListCFIC.Add(new BECronogramaFIC(reader)); }
            }
            return ListCFIC;
        }

        public void DelCronogramaFICConsultora(int paisID, string CampaniaCodigo, string CodigoZona, string CodigoConsultora)
        {
            var DAZonificacion = new DAZonificacion(paisID);

            DAZonificacion.DelCronogramaFICConsultora(CampaniaCodigo, CodigoZona, CodigoConsultora);
        }

        public IList<BEZona> SelectApeZona(int paisID, int regionID, string codigo)
        {
            IList<BEZona> zonas = new List<BEZona>();

            var DAZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = DAZonificacion.GetApeZona(regionID, codigo))
                while (reader.Read())
                    zonas.Add(new BEZona(reader));

            return zonas;
        }

        public void UpdApeZona(int paisID, int zonaID, int cantidadDias)
        {
            var DAZonificacion = new DAZonificacion(paisID);

            DAZonificacion.UpdApeZona(zonaID, cantidadDias);
        }

        public IList<BEPais> SelectPaisesDD()
        {
            IList<BEPais> paises = (IList<BEPais>)CacheManager<BEPais>.GetData(ECacheItem.PaisesDD);
            if (paises == null)
            {
                paises = new List<BEPais>();
                var DAZonificacion = new DAZonificacion(int.Parse(ConfigurationManager.AppSettings["masterCountry"]));
                using (IDataReader reader = DAZonificacion.GetPaisDD())
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

        //RQ_BS - R2133
        public IList<BESegmentoBanner> GetSegmentoBanner(int PaisID)
        {
            var ListaSegmentoBanner = new List<BESegmentoBanner>();
            var daZonificacion = new DAZonificacion(PaisID);

            using (IDataReader reader = daZonificacion.GetSegmentoBanner())
                while (reader.Read())
                    ListaSegmentoBanner.Add(new BESegmentoBanner(reader));

            return ListaSegmentoBanner;
        }

        //RQ_BS - R2133
        public IList<BEZonificacionJerarquia> GetZonificacionJerarquia(int PaisID)
        {
            var ListaJerarquia = new List<BEZonificacionJerarquia>();
            var daZonificacion = new DAZonificacion(PaisID);

            using (IDataReader reader = daZonificacion.GetZonificacionJerarquia())
                while (reader.Read())
                    ListaJerarquia.Add(new BEZonificacionJerarquia(reader));

            return ListaJerarquia;
        }
        /* CGI(CSR) – REQ – 2544 – INICIO – 12/05/2015 – Creacion de Metodo GetSegmentoInternoBanner para Segmento en los Banners*/
        public IList<BESegmentoBanner> GetSegmentoInternoBanner(int PaisID)
        {
            var ListaSegmentoBanner = new List<BESegmentoBanner>();    
            var daZonificacion = new DAZonificacion(PaisID);   

            using (IDataReader reader = daZonificacion.GetSegmentoInternoBanner())  
                while (reader.Read())
                    ListaSegmentoBanner.Add(new BESegmentoBanner(reader));
            return ListaSegmentoBanner;
        }
        /* CGI(CSR) – REQ – 2544 – FIN */

        //R2015121 - Parámetro

        public IList<BEGetRegionByPaisParametroCarga> GetRegionByPaisParametroCarga(int paisID)
        {
            IList<BEGetRegionByPaisParametroCarga> zonas = new List<BEGetRegionByPaisParametroCarga>();
            var DAZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = DAZonificacion.GetRegionByPaisParametroCarga(paisID))
            {
                while (reader.Read()) { zonas.Add(new BEGetRegionByPaisParametroCarga(reader)); }
            }
            return zonas;

        }

        public IList<BEGetZonaByPaisParametroCarga> GetZonaByPaisParametroCarga(int paisID)
        {
            IList<BEGetZonaByPaisParametroCarga> zonas = new List<BEGetZonaByPaisParametroCarga>();
            var DAZonificacion = new DAZonificacion(paisID);
            using (IDataReader reader = DAZonificacion.GetZonaByPaisParametroCarga(paisID))
            {
                while (reader.Read()) { zonas.Add(new BEGetZonaByPaisParametroCarga(reader)); }
            }
            return zonas;
        }


        //R20151221 Fín Parámetro
    }
}