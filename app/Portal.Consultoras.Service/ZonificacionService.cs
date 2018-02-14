using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class ZonificacionService : IZonificacionService
    {
        private readonly BLZonificacion BLZonificacion;

        public ZonificacionService()
        {
            BLZonificacion = new BLZonificacion();
        }

        public IList<BEZona> SelectZonaByCodigo(int paisID, string codigo, int rowCount)
        {
            return BLZonificacion.SelectZona(paisID, codigo, rowCount);
        }

        public IList<BEZona> SelectZonaById(int paisID, int ZonaID)
        {
            return BLZonificacion.SelectZonaById(paisID, ZonaID);
        }

        public IList<BEPais> SelectPaises()
        {
            return BLZonificacion.SelectPaises();
        }

        public IList<BECampania> SelectCampanias(int paisID)
        {
            return BLZonificacion.SelectCampanias(paisID);
        }

        public IList<BEZona> SelectAllZonas(int paisID)
        {
            return BLZonificacion.SelectAllZonas(paisID);
        }

        public IList<BERegion> SelectAllRegiones(int paisID)
        {
            return BLZonificacion.SelectAllRegiones(paisID);
        }

        public IList<BEGetRegionByPaisParametroCarga> GetRegionByPaisParametroCarga(int paisID)
        {
            return BLZonificacion.GetRegionByPaisParametroCarga(paisID);
        }

        public IList<BEGetZonaByPaisParametroCarga> GetZonaByPaisParametroCarga(int paisID)
        {
            return BLZonificacion.GetZonaByPaisParametroCarga(paisID);
        }

        public IList<BETerritorio> SelectAllTerritorios(int paisID)
        {
            return BLZonificacion.SelectAllTerritorios(paisID);
        }

        public IList<BETerritorio> SelectTerritorioByCodigo(int paisID, string codigo, int rowCount)
        {
            return BLZonificacion.SelectTerritorio(paisID, codigo, rowCount);
        }

        public BEPais SelectPais(int paisID)
        {
            return BLZonificacion.SelectPais(paisID);
        }

        public IList<BEPais> GetAllPaises()
        {
            return BLZonificacion.SelectPaises();
        }

        public int GetPaisNumeroCampaniasByPaisID(int paisID)
        {
            return BLZonificacion.GetPaisNumeroCampaniasByPaisID(paisID);
        }

        public IList<BEZona> SelectZonasActivasFIC(int paisID, int CampaniaID)
        {
            return BLZonificacion.SelectZonasActivasFIC(paisID, CampaniaID);
        }

        public IList<BEZona> SelectZonasInactivasFIC(int paisID, int CampaniaID)
        {
            return BLZonificacion.SelectZonasInactivasFIC(paisID, CampaniaID);
        }

        public void InsInsCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona)
        {
            BLZonificacion.InsInsCronogramaFIC(paisID, CampaniaCodigo, CodigoZona);
        }

        public void DelCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona)
        {
            BLZonificacion.DelCronogramaFIC(paisID, CampaniaCodigo, CodigoZona);
        }

        public void InsCronogramaFICMasivo(int paisID, int campaniaID, IList<BECronogramaFIC> cronogramaFIC)
        {
            BLZonificacion.InsCronogramaFICMasivo(paisID, campaniaID, cronogramaFIC);
        }

        public IList<BECronogramaFIC> GetCronogramaFICByCampania(int paisID, string CodigoCampania)
        {
            return BLZonificacion.GetCronogramaFICByCampania(paisID, CodigoCampania);
        }

        public void UpdCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona, DateTime? Fecha)
        {
            BLZonificacion.UpdCronogramaFIC(paisID, CampaniaCodigo, CodigoZona, Fecha);
        }

        public IList<BECronogramaFIC> GetCronogramaFICByZona(int paisID, string CampaniaCodigo, string ZonaCodigo)
        {
            return BLZonificacion.GetCronogramaFICByZona(paisID, CampaniaCodigo, ZonaCodigo);
        }

        public void DelCronogramaFICConsultora(int paisID, string CampaniaCodigo, string CodigoZona, string CodigoConsultora)
        {
            BLZonificacion.DelCronogramaFICConsultora(paisID, CampaniaCodigo, CodigoZona, CodigoConsultora);
        }

        #region ApeZona

        public IList<BEZona> SelectApeZonas(int paisID, int regionID, string codigoBusqueda)
        {
            return BLZonificacion.SelectApeZona(paisID, regionID, codigoBusqueda);
        }

        public void UpdateApeZona(int paisID, int zonaID, int cantidadDias)
        {
            BLZonificacion.UpdApeZona(paisID, zonaID, cantidadDias);
        }

        #endregion

        public IList<BEPais> SelectPaisesDD()
        {
            return BLZonificacion.SelectPaisesDD();
        }

        public IList<BETerritorio> SearchTerritoriosByZona(int paisID, string codigoZona, string codigoTerritorio)
        {
            return BLZonificacion.SearchTerritoriosByZona(paisID, codigoZona, codigoTerritorio);
        }

        public IList<BESegmentoBanner> GetSegmentoBanner(int PaisID)
        {
            return BLZonificacion.GetSegmentoBanner(PaisID);
        }

        public IList<BEZonificacionJerarquia> GetZonificacionJerarquia(int PaisID)
        {
            return BLZonificacion.GetZonificacionJerarquia(PaisID);
        }

        public IList<BESegmentoBanner> GetSegmentoInternoBanner(int PaisID)
        {
            return BLZonificacion.GetSegmentoInternoBanner(PaisID);
        }

    }
}
