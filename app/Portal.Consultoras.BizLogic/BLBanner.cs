using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLBanner
    {
        private DABanner DABanner;

        public BLBanner()
        {
            DABanner = new DABanner();
        }

        //RQ_SB - R2133
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
                        int index = 0, bannerID;
                        var paises = new List<int>();
                        var paises2 = new List<BEBannerSegmentoZona>();

                        while (reader.Read())
                        {
                            bannerID = Convert.ToInt32(reader[0]);
                            if (banners[index].BannerID != bannerID)
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

                                while (index < banners.Count && banners[index].BannerID != bannerID)
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

        //RQ_SB - R2133
        public IList<BEBannerInfo> SelectBannerByConsultora(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva)
        {
            IList<BEBanner> banners = SelectBanner(campaniaID);
            IList<BEGrupoBanner> grupos = SelectGrupoBanner(campaniaID);
            var bannersByConsultora = new List<BEBannerInfo>();
            BEGrupoBanner grupo = null; BEGrupoConsultora consultora = null;

            foreach (BEBanner banner in banners)
            {
                if (banner.FlagConsultoraNueva)
                {
                    if (consultoraNueva && banner.Paises != null && banner.Paises.Contains(paisID))
                    {
                        BEBannerInfo temp = new BEBannerInfo(banner);
                        List<BEBannerSegmentoZona> segzona = banner.PaisesSegZona.Where(p => p.PaisId == paisID).ToList();
                        if (segzona.Count > 0)
                        {
                            temp.Segmento = segzona[0].Segmento;
                            temp.ConfiguracionZona = segzona[0].ConfiguracionZona;
                        }

                        bannersByConsultora.Add(temp);
                    }
                    continue;
                }
                else if (banner.FlagGrupoConsultora)
                {
                    grupo = grupos.ToList().Find(x => x.GrupoBannerID == banner.GrupoBannerID);
                    if (grupo != null && grupo.Consultoras != null)
                        consultora = grupo.Consultoras.ToList().Find(y => y.ConsultoraCodigo == codigoConsultora && y.PaisID == paisID);

                    if (consultora != null)
                    {
                        BEBannerInfo temp = new BEBannerInfo(banner);
                        List<BEBannerSegmentoZona> segzona = banner.PaisesSegZona.Where(p => p.PaisId == paisID).ToList();
                        if (segzona.Count > 0)
                        {
                            temp.Segmento = segzona[0].Segmento;
                            temp.ConfiguracionZona = segzona[0].ConfiguracionZona;
                        }

                        bannersByConsultora.Add(temp);
                    }
                    continue;
                }
                else if (banner.Paises != null && banner.Paises.Contains(paisID))
                {
                    BEBannerInfo temp = new BEBannerInfo(banner);
                    List<BEBannerSegmentoZona> segzona = banner.PaisesSegZona.Where(p => p.PaisId == paisID).ToList();
                    if (segzona.Count > 0)
                    {
                        temp.Segmento = segzona[0].Segmento;
                        temp.ConfiguracionZona = segzona[0].ConfiguracionZona;
                    }

                    bannersByConsultora.Add(temp);
                    continue;
                }
            }
            return bannersByConsultora;
        }

        public int UpdOrdenNumberBanner(int paisID, List<BEBannerOrden> lstBanners)
        {
            DABanner DABanner = new DABanner();
            int result = DABanner.UpdOrdenNumberBanner(lstBanners);

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
            if (grupos == null)
            {
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
                        int GrupoBannerId, index = 0;
                        var consultoras = new List<BEGrupoConsultora>();
                        while (reader.Read())
                        {
                            GrupoBannerId = Convert.ToInt32(reader[0]);
                            if (grupos[index].GrupoBannerID != GrupoBannerId)
                            {
                                if (consultoras.Count > 0)
                                    grupos[index].Consultoras = consultoras.ToArray();

                                consultoras.Clear();

                                while (index < grupos.Count && grupos[index].GrupoBannerID != GrupoBannerId)
                                    index++;

                                if (index >= grupos.Count)
                                    break;
                            }
                            consultoras.Add(new BEGrupoConsultora(reader));   
                        }

                        if (consultoras.Count > 0)
                            grupos[index].Consultoras = consultoras.ToArray();

                        //List<BEGrupoConsultora> consultoras = new List<BEGrupoConsultora>();
                        //while (reader.Read())
                        //{
                        //    BEGrupoConsultora consultora = new BEGrupoConsultora(reader);
                        //    consultoras.Add(consultora);
                        //}

                        //foreach (var item in grupos)
                        //    item.Consultoras = consultoras.FindAll(x => x.GrupoBannerID == item.GrupoBannerID).ToArray();
                    }
                }
                CacheManager<BEGrupoBanner>.AddData(ECacheItem.GruposBanner, campaniaID.ToString(), grupos);
            }
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
            List<int> listID = new List<int>();
            List<int> listCampaniaId = new List<int>();

            foreach(BEBanner banner in listBanner)
            {
                if (!listCampaniaId.Contains(banner.CampaniaID)) listCampaniaId.Add(banner.CampaniaID);
                DABanner.InsUpdBanner(banner);
                listID.Add(banner.BannerID);
            }
            foreach (int campaniaId in listCampaniaId)
            {
                CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, campaniaId.ToString());
                CacheManager<BEBanner>.RemoveData(ECacheItem.BannersBienvenida, campaniaId.ToString());
            }
            
            return listID;
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
            if(comparison == 0)
                comparison = banner1.Orden.CompareTo(banner2.Orden);
            return comparison;
        }

        public IList<BEParametro> GetParametrosBanners()
        {
            List<BEParametro> Parametros = new List<BEParametro>();

            var DABanner = new DABanner();
            using (IDataReader reader = DABanner.GetParametrosBanners())
                while (reader.Read())
                {
                    Parametros.Add(new BEParametro(reader));
                }
            return Parametros;
        }

		public int GetPaisBannerMarquesina(string CampaniaID, int IdBanner)
        {
            int pais;
            pais = 0;
            var DABanner = new DABanner();
            using (IDataReader reader = DABanner.GetPaisBannerMarquesina(CampaniaID, IdBanner))
                while (reader.Read())
                {
                    pais = Convert.ToInt32(reader[0]);
                }
            return pais;
        }

        //RQ_SB - R2133
        public IList<BEBanner> SelectBannerBienvenida(int campaniaID)
        {
            List<BEBanner> banners = (List<BEBanner>)CacheManager<BEBanner>.GetData(ECacheItem.BannersBienvenida, campaniaID.ToString());
            if (banners == null)
            {
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
                        int index = 0, bannerID;
                        var paises = new List<int>();
                        var paises2 = new List<BEBannerSegmentoZona>();

                        while (reader.Read())
                        {
                            bannerID = Convert.ToInt32(reader[0]);
                            if (banners[index].BannerID != bannerID)
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

                                while (index < banners.Count && banners[index].BannerID != bannerID)
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
                CacheManager<BEBanner>.AddData(ECacheItem.BannersBienvenida, campaniaID.ToString(), banners);
            }
            return banners;
        }

        //RQ_SB - R2133
        public IList<BEBannerInfo> SelectBannerByConsultoraBienvenida(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva)
        {
            IList<BEBanner> banners = SelectBannerBienvenida(campaniaID);
            IList<BEGrupoBanner> grupos = SelectGrupoBanner(campaniaID);
            var bannersByConsultora = new List<BEBannerInfo>();
            BEGrupoBanner grupo = null; BEGrupoConsultora consultora = null;

            foreach (BEBanner banner in banners)
            {
                if (banner.FlagConsultoraNueva)
                {
                    if (consultoraNueva && banner.Paises != null && banner.Paises.Contains(paisID))
                    {
                        /*CGI(RSA) - REQ 2544 INICIO*/
                        List<BEBannerSegmentoZona> segzona = banner.PaisesSegZona.Where(p => p.PaisId == paisID).ToList();
                        if (segzona.Count > 0)
                        {
                            segzona.ForEach(seg =>
                            {
                                BEBannerInfo temp = new BEBannerInfo(banner);
                                temp.Segmento = seg.Segmento;
                                temp.ConfiguracionZona = seg.ConfiguracionZona;
                                bannersByConsultora.Add(temp);
                            });
                        }
                        /*CGI(RSA) - REQ 2544 FIN*/
                    }
                    continue;
                }
                else if (banner.FlagGrupoConsultora)
                {
                    grupo = grupos.ToList().Find(x => x.GrupoBannerID == banner.GrupoBannerID);
                    if (grupo != null && grupo.Consultoras != null)
                        consultora = grupo.Consultoras.ToList().Find(y => y.ConsultoraCodigo == codigoConsultora && y.PaisID == paisID);

                    if (consultora != null)
                    {
                        /*CGI(RSA) - REQ 2544 INICIO*/
                        List<BEBannerSegmentoZona> segzona = banner.PaisesSegZona.Where(p => p.PaisId == paisID).ToList();
                        if (segzona.Count > 0)
                        {
                            segzona.ForEach(seg =>
                            {
                                BEBannerInfo temp = new BEBannerInfo(banner);
                                temp.Segmento = seg.Segmento;
                                temp.ConfiguracionZona = seg.ConfiguracionZona;
                                bannersByConsultora.Add(temp);
                            });
                        }
                        /*CGI(RSA) - REQ 2544 FIN*/
                    }
                    continue;
                }
                else if (banner.Paises != null && banner.Paises.Contains(paisID))
                {
                    /*CGI(RSA) - REQ 2544 INICIO*/
                    List<BEBannerSegmentoZona> segzona = banner.PaisesSegZona.Where(p => p.PaisId == paisID).ToList();
                    if (segzona.Count > 0)
                    {
                        segzona.ForEach(seg =>
                        {
                            BEBannerInfo temp = new BEBannerInfo(banner);
                            temp.Segmento = seg.Segmento;
                            temp.ConfiguracionZona = seg.ConfiguracionZona;
                            bannersByConsultora.Add(temp);
                        });
                    }
                    /*CGI(RSA) - REQ 2544 FIN*/
                    continue;
                }
            }
            return bannersByConsultora;
        }

        //RQ_SB - R2133
        public BEBannerSegmentoZona GetBannerSegmentoSeccion(int CampaniaId, int BannerId, int PaisId)
        {
            BEBannerSegmentoZona oBEBannerSegmentoZona = null;

            var DABanner = new DABanner();
            using (IDataReader reader = DABanner.GetBannerSegmentoSeccion(CampaniaId, BannerId, PaisId))
                while (reader.Read())
                {
                    oBEBannerSegmentoZona = new BEBannerSegmentoZona()
                    {
                        Segmento = Convert.ToInt32(reader["Segmento"]),
                        ConfiguracionZona = Convert.ToString(reader["ConfiguracionZona"]),
                        SegmentoInterno = Convert.ToString(reader["SegmentoInterno"])/*CGI(RSA) - REQ 2544*/
                    };
                }
            return oBEBannerSegmentoZona;
        }

        //RQ_SB - R2133
        public List<BEBannerSegmentoZona> GetBannerPaisesAsignados(int CampaniaId, int BannerId)
        {
            List<BEBannerSegmentoZona> Lista = new List<BEBannerSegmentoZona>();

            var DABanner = new DABanner();
            using (IDataReader reader = DABanner.GetBannerPaisesAsignados(CampaniaId, BannerId))
                while (reader.Read())
                {
                    Lista.Add(new BEBannerSegmentoZona()
                    {
                        PaisId = Convert.ToInt32(reader["PaisId"]),
                        NombrePais = Convert.ToString(reader["NombrePais"])
                    });
                }
            return Lista;
        }

        //RQ_SB - R2133
        /*RE2544 - CS(CGI) - Agregando nuevo parametro - 15/05/2015 */  
        public void UpdBannerPaisSegmentoZona(int CampaniaId, int BannerId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInterno)
        {
            DABanner DABanner = new DABanner();
            DABanner.UpdBannerPaisSegmentoZona(CampaniaId, BannerId, PaisId, Segmento, ConfiguracionZona, SegmentoInterno);
            CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, CampaniaId.ToString());
            CacheManager<BEBanner>.RemoveData(ECacheItem.BannersBienvenida, CampaniaId.ToString());
        }

        //RQ_SB - R2133
        public void DeleteCacheBanner(int CampaniaID)
        {
            CacheManager<BEBanner>.RemoveData(ECacheItem.Banners, CampaniaID.ToString());
        }

    }
}
