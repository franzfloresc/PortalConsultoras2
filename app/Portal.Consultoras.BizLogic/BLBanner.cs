using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLBanner
    {
        private readonly DABanner DABanner;

        public BLBanner()
        {
            DABanner = new DABanner();
        }

        public IList<BEBanner> SelectBanner(int campaniaID)
        {
            List<BEBanner> banners = (List<BEBanner>)CacheManager<BEBanner>.GetData(ECacheItem.Banners, campaniaID.ToString());
            if (banners == null)
            {
                banners = new List<BEBanner>();
                using (IDataReader reader = DABanner.GetBannerByCampania(campaniaID))
                {
                    while (reader.Read())
                    {
                        var banner = new BEBanner(reader);
                        banners.Add(banner);
                    }

                    if (banners.Count > 0 && reader.NextResult())
                    {
                        int index = 0;
                        var paises = new List<int>();
                        var paises2 = new List<BEBannerSegmentoZona>();

                        while (reader.Read())
                        {
                            var bannerId = Convert.ToInt32(reader[0]);
                            if (banners[index].BannerID != bannerId)
                            {
                                if (paises.Count > 0)
                                {
                                    banners[index].Paises = paises.ToArray();
                                }

                                if (paises2.Count > 0)
                                {
                                    banners[index].PaisesSegZona = paises2.ToArray();
                                }

                                paises.Clear();
                                paises2.Clear();

                                while (index < banners.Count && banners[index].BannerID != bannerId)
                                    index++;

                                if (index >= banners.Count)
                                    break;
                            }
                            paises.Add(Convert.ToInt32(reader[1]));
                            paises2.Add(new BEBannerSegmentoZona() { BannerId = Convert.ToInt32(reader[0]), PaisId = Convert.ToInt32(reader[1]), Segmento = Convert.ToInt32(reader[2]), ConfiguracionZona = Convert.ToString(reader[3]) });
                        }

                        if (paises.Count > 0)
                        {
                            banners[index].Paises = paises.ToArray();
                            banners[index].PaisesSegZona = paises2.ToArray();
                        }
                    }
                }
                banners.Sort(CompareBanner);
                CacheManager<BEBanner>.AddData(ECacheItem.Banners, campaniaID.ToString(), banners);
            }
            return banners;
        }

        public IList<BEBannerInfo> SelectBannerByConsultora(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva)
        {
            IList<BEBanner> banners = SelectBanner(campaniaID);
            var bannersByConsultora = new List<BEBannerInfo>();

            foreach (BEBanner banner in banners)
            {
                if (banner.Paises == null || !banner.Paises.Contains(paisID)) continue;

                var temp = new BEBannerInfo(banner);
                var segzona = banner.PaisesSegZona.FirstOrDefault(p => p.PaisId == paisID);
                if (segzona != null)
                {
                    temp.Segmento = segzona.Segmento;
                    temp.ConfiguracionZona = segzona.ConfiguracionZona;
                }

                bannersByConsultora.Add(temp);
            }

            return bannersByConsultora;
        }

        public int UpdOrdenNumberBanner(int paisID, List<BEBannerOrden> lstBanners)
        {
            DABanner daBanner = new DABanner();
            int result = daBanner.UpdOrdenNumberBanner(lstBanners);

            List<int> listCampaniaId = new List<int>();
            lstBanners.ForEach(x => { if (!listCampaniaId.Contains(x.CampaniaID)) listCampaniaId.Add(x.CampaniaID); });
            foreach (int campaniaId in listCampaniaId)
            {
                CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, campaniaId.ToString());
                CacheManager<BEBanner>.RemoveData(ECacheItem.BannersBienvenida, campaniaId.ToString());
            }

            return result;
        }

        public IList<BEGrupoBanner> SelectGrupoBanner(int campaniaID)
        {
            IList<BEGrupoBanner> grupos = (IList<BEGrupoBanner>)CacheManager<BEGrupoBanner>.GetData(ECacheItem.GruposBanner, campaniaID.ToString());
            if (grupos != null)
                return grupos;

            grupos = new List<BEGrupoBanner>();
            using (IDataReader reader = DABanner.GetGrupoBannerByCampania(campaniaID))
            {
                while (reader.Read())
                {
                    var grupo = new BEGrupoBanner(reader);
                    grupos.Add(grupo);
                }

                if (reader.NextResult())
                {
                    int index = 0;
                    var consultoras = new List<BEGrupoConsultora>();
                    while (reader.Read())
                    {
                        var grupoBannerId = Convert.ToInt32(reader[0]);
                        if (grupos[index].GrupoBannerID != grupoBannerId)
                        {
                            if (consultoras.Count > 0)
                                grupos[index].Consultoras = consultoras.ToArray();

                            consultoras.Clear();

                            while (index < grupos.Count && grupos[index].GrupoBannerID != grupoBannerId)
                                index++;

                            if (index >= grupos.Count)
                                break;
                        }
                        consultoras.Add(new BEGrupoConsultora(reader));
                    }

                    if (consultoras.Count > 0)
                        grupos[index].Consultoras = consultoras.ToArray();
                }
            }
            CacheManager<BEGrupoBanner>.AddData(ECacheItem.GruposBanner, campaniaID.ToString(), grupos);

            return grupos;
        }

        public int SaveBanner(BEBanner banner)
        {
            DABanner.InsUpdBanner(banner);
            CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, banner.CampaniaID.ToString());
            CacheManager<BEBanner>.RemoveData(ECacheItem.BannersBienvenida, banner.CampaniaID.ToString());
            return banner.BannerID;
        }

        public List<int> SaveListBanner(List<BEBanner> listBanner)
        {
            List<int> listId = new List<int>();
            List<int> listCampaniaId = new List<int>();

            foreach (BEBanner banner in listBanner)
            {
                if (!listCampaniaId.Contains(banner.CampaniaID)) listCampaniaId.Add(banner.CampaniaID);
                DABanner.InsUpdBanner(banner);
                listId.Add(banner.BannerID);
            }
            foreach (int campaniaId in listCampaniaId)
            {
                CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, campaniaId.ToString());
                CacheManager<BEBanner>.RemoveData(ECacheItem.BannersBienvenida, campaniaId.ToString());
            }

            return listId;
        }

        public void SaveGrupoBanner(BEGrupoBanner grupoBanner)
        {
            DABanner.InsUpdGrupoBanner(grupoBanner);
            CacheManager<BEGrupoBanner>.RemoveData(ECacheItem.GruposBanner, grupoBanner.CampaniaID.ToString());
            CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, grupoBanner.CampaniaID.ToString());
            CacheManager<BEBanner>.RemoveData(ECacheItem.BannersBienvenida, grupoBanner.CampaniaID.ToString());
        }

        public void DeleteBanner(int campaniaID, int bannerID)
        {
            DABanner.DelBanner(campaniaID, bannerID);
            CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, campaniaID.ToString());
            CacheManager<BEBanner>.RemoveData(ECacheItem.BannersBienvenida, campaniaID.ToString());
        }

        private static int CompareBanner(BEBanner banner1, BEBanner banner2)
        {
            int comparison = banner1.GrupoBannerID.CompareTo(banner2.GrupoBannerID);
            if (comparison == 0)
                comparison = banner1.Orden.CompareTo(banner2.Orden);
            return comparison;
        }

        public IList<BEParametro> GetParametrosBanners()
        {
            List<BEParametro> parametros = new List<BEParametro>();

            var daBanner = new DABanner();
            using (IDataReader reader = daBanner.GetParametrosBanners())
                while (reader.Read())
                {
                    parametros.Add(new BEParametro(reader));
                }
            return parametros;
        }

        public int GetPaisBannerMarquesina(string CampaniaID, int IdBanner)
        {
            int pais = 0;
            var daBanner = new DABanner();
            using (IDataReader reader = daBanner.GetPaisBannerMarquesina(CampaniaID, IdBanner))
                while (reader.Read())
                {
                    pais = Convert.ToInt32(reader[0]);
                }
            return pais;
        }

        public IList<BEBanner> SelectBannerBienvenida(int campaniaID)
        {
            List<BEBanner> banners = (List<BEBanner>)CacheManager<BEBanner>.GetData(ECacheItem.BannersBienvenida, campaniaID.ToString());
            if (banners != null)
                return banners;

            banners = new List<BEBanner>();
            using (IDataReader reader = DABanner.GetBannerByCampaniaBienvenida(campaniaID))
            {
                while (reader.Read())
                {
                    var banner = new BEBanner(reader);
                    banners.Add(banner);
                }

                if (banners.Count > 0 && reader.NextResult())
                {
                    int index = 0;
                    var paises = new List<int>();
                    var paises2 = new List<BEBannerSegmentoZona>();

                    while (reader.Read())
                    {
                        var bannerId = Convert.ToInt32(reader[0]);
                        if (banners[index].BannerID != bannerId)
                        {
                            if (paises.Count > 0)
                            {
                                banners[index].Paises = paises.ToArray();
                            }

                            if (paises2.Count > 0)
                            {
                                banners[index].PaisesSegZona = paises2.ToArray();
                            }

                            paises.Clear();
                            paises2.Clear();

                            while (index < banners.Count && banners[index].BannerID != bannerId)
                                index++;

                            if (index >= banners.Count)
                                break;
                        }

                        paises.Add(Convert.ToInt32(reader[1]));
                        paises2.Add(new BEBannerSegmentoZona()
                        {
                            BannerId = Convert.ToInt32(reader[0]),
                            PaisId = Convert.ToInt32(reader[1]),
                            Segmento = Convert.ToInt32(reader[2]),
                            ConfiguracionZona = Convert.ToString(reader[3]),
                            CodigosConsultora = Convert.ToString(reader[4]),
                            TipoAcceso = Convert.ToInt32(reader[5])
                        });
                    }

                    if (paises.Count > 0)
                    {
                        banners[index].Paises = paises.ToArray();
                        banners[index].PaisesSegZona = paises2.ToArray();
                    }
                }
            }

            banners.Sort(CompareBanner);
            CacheManager<BEBanner>.AddData(ECacheItem.BannersBienvenida, campaniaID.ToString(), banners);

            return banners;
        }

        public IList<BEBannerInfo> SelectBannerByConsultoraBienvenida(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva)
        {
            IList<BEBanner> banners = SelectBannerBienvenida(campaniaID);
            IList<BEGrupoBanner> grupos = SelectGrupoBanner(campaniaID);
            var bannersByConsultora = new List<BEBannerInfo>();
            BEGrupoConsultora consultora = null;

            foreach (BEBanner banner in banners)
            {
                if (banner.FlagConsultoraNueva)
                {
                    if (consultoraNueva && banner.Paises != null && banner.Paises.Contains(paisID))
                    {
                        bannersByConsultora.AddRange(GetBannersBySegmento(banner, paisID));
                    }
                }
                else if (banner.FlagGrupoConsultora)
                {
                    var grupo = grupos.ToList().Find(x => x.GrupoBannerID == banner.GrupoBannerID);
                    if (grupo != null && grupo.Consultoras != null)
                        consultora = grupo.Consultoras.ToList().Find(y => y.ConsultoraCodigo == codigoConsultora && y.PaisID == paisID);

                    if (consultora != null)
                    {
                        bannersByConsultora.AddRange(GetBannersBySegmento(banner, paisID));
                    }
                }
                else if (banner.Paises != null && banner.Paises.Contains(paisID))
                {
                    bannersByConsultora.AddRange(GetBannersBySegmentoRelacion(banner, paisID, codigoConsultora));
                }
            }
            return bannersByConsultora;
        }

        private static IEnumerable<BEBannerInfo> GetBannersBySegmento(BEBanner banner, int paisId)
        {
            return from seg in banner.PaisesSegZona
                   where seg.PaisId == paisId
                   select new BEBannerInfo(banner)
                   {
                       Segmento = seg.Segmento,
                       ConfiguracionZona = seg.ConfiguracionZona
                   };
        }

        private static IEnumerable<BEBannerInfo> GetBannersBySegmentoRelacion(BEBanner banner, int paisId, string codigoConsultora)
        {
            return from seg in banner.PaisesSegZona
                   where seg.PaisId == paisId
                   && ValidAccessConsultora(codigoConsultora, seg)
                   select new BEBannerInfo(banner)
                   {
                       Segmento = seg.Segmento,
                       ConfiguracionZona = seg.ConfiguracionZona
                   };
        }

        private static bool ValidAccessConsultora(string codigoConsultora, BEBannerSegmentoZona seg)
        {
            if (seg.TipoAcceso <= 0) return true;

            var consultoras = seg.CodigosConsultora.Split(',');
            if (consultoras.Length <= 0) return true;

            if (seg.TipoAcceso == Constantes.TipoAccesoSegmento.Inclusion &&
                !consultoras.Contains(codigoConsultora))
            {
                return false;
            }

            if (seg.TipoAcceso == Constantes.TipoAccesoSegmento.Exclusion &&
                consultoras.Contains(codigoConsultora))
            {
                return false;
            }

            return true;
        }

        public BEBannerSegmentoZona GetBannerSegmentoSeccion(int CampaniaId, int BannerId, int PaisId)
        {
            BEBannerSegmentoZona obeBannerSegmentoZona = null;

            var daBanner = new DABanner();
            using (IDataReader reader = daBanner.GetBannerSegmentoSeccion(CampaniaId, BannerId, PaisId))
                while (reader.Read())
                {
                    obeBannerSegmentoZona = new BEBannerSegmentoZona
                    {
                        Segmento = Convert.ToInt32(reader["Segmento"]),
                        ConfiguracionZona = Convert.ToString(reader["ConfiguracionZona"]),
                        SegmentoInterno = Convert.ToString(reader["SegmentoInterno"]),
                        TipoAcceso = Convert.ToInt32(reader["TipoAcceso"])
                    };
                }
            return obeBannerSegmentoZona;
        }

        public List<BEBannerSegmentoZona> GetBannerPaisesAsignados(int CampaniaId, int BannerId)
        {
            List<BEBannerSegmentoZona> lista = new List<BEBannerSegmentoZona>();

            var daBanner = new DABanner();
            using (IDataReader reader = daBanner.GetBannerPaisesAsignados(CampaniaId, BannerId))
                while (reader.Read())
                {
                    lista.Add(new BEBannerSegmentoZona()
                    {
                        PaisId = Convert.ToInt32(reader["PaisId"]),
                        NombrePais = Convert.ToString(reader["NombrePais"])
                    });
                }
            return lista;
        }

        public void UpdBannerPaisSegmentoZona(BEBannerSegmentoZona segmentoZona)
        {
            var daBanner = new DABanner();
            daBanner.UpdBannerPaisSegmentoZona(segmentoZona);
            CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, segmentoZona.CampaniaId.ToString());
            CacheManager<BEBanner>.RemoveData(ECacheItem.BannersBienvenida, segmentoZona.CampaniaId.ToString());
        }

        public void DeleteCacheBanner(int CampaniaID)
        {
            CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, CampaniaID.ToString());
        }

    }
}