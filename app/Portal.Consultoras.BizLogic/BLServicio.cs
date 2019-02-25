using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLServicio
    {
        public IList<BEServicio> SelectServicio(string Descripcion)
        {
            List<BEServicio> servicios = new List<BEServicio>();

            var daServicio = new DAServicio();
            using (IDataReader reader = daServicio.GetServicios(Descripcion))
                while (reader.Read())
                {
                    servicios.Add(new BEServicio(reader));
                }
            return servicios;
        }

        public IList<BEServicioCampania> SelectServicioByCampaniaPais(int PaisId, int CampaniaId)
        {
            IList<BEServicioCampania> servicios = (IList<BEServicioCampania>)CacheManager<BEServicioCampania>.GetData(PaisId, ECacheItem.ServiciosBelcorp, CampaniaId.ToString());
            if (servicios == null)
            {
                servicios = new List<BEServicioCampania>();
                var daServicio = new DAServicio();
                using (IDataReader reader = daServicio.GetServicioByCampaniaPais(PaisId, CampaniaId))
                    while (reader.Read())
                    {
                        servicios.Add(new BEServicioCampania(reader));
                    }
                CacheManager<BEServicioCampania>.AddData(PaisId, ECacheItem.ServiciosBelcorp, CampaniaId.ToString(), servicios);
            }
            return servicios;
        }

        public IList<BEServicioCampania> SelectServicioByCampaniaPaisAdministrador(int PaisId, int CampaniaId)
        {
            List<BEServicioCampania> servicios = new List<BEServicioCampania>();

            var daServicio = new DAServicio();
            using (IDataReader reader = daServicio.GetServicioByCampaniaPais(PaisId, CampaniaId))
                while (reader.Read())
                {
                    servicios.Add(new BEServicioCampania(reader));
                }
            return servicios;
        }

        public IList<BEParametro> SelectParametros()
        {
            List<BEParametro> parametros = new List<BEParametro>();

            var daServicio = new DAServicio();
            using (IDataReader reader = daServicio.GetParametros())
                while (reader.Read())
                {
                    parametros.Add(new BEParametro(reader));
                }
            return parametros;
        }

        public IList<BEServicioParametro> SelectParametrosbyServicio(int ServicioId)
        {
            List<BEServicioParametro> parametros = new List<BEServicioParametro>();

            var daServicio = new DAServicio();
            using (IDataReader reader = daServicio.GetParametrobyServicio(ServicioId))
                while (reader.Read())
                {
                    parametros.Add(new BEServicioParametro(reader));
                }
            return parametros;
        }

        public IList<BEEstadoServicio> SelectEstadoServiciobyPais(int ServicioId, int CampaniaId)
        {
            List<BEEstadoServicio> parametros = new List<BEEstadoServicio>();

            var daServicio = new DAServicio();
            using (IDataReader reader = daServicio.GetEstadoServiciobyPais(ServicioId, CampaniaId))
                while (reader.Read())
                {
                    parametros.Add(new BEEstadoServicio(reader));
                }
            return parametros;
        }

        public int InsServicio(BEServicio servicio)
        {
            var daServicio = new DAServicio();
            return daServicio.InsServicio(servicio);
        }

        public int UpdServicio(BEServicio servicio)
        {
            var daServicio = new DAServicio();
            return daServicio.UpdServicio(servicio);
        }

        public int DelServicio(int ServicioId)
        {
            var daServicio = new DAServicio();
            return daServicio.DelServicio(ServicioId);
        }

        public int DelServicioParametro(int ServicioId, int ParametroId)
        {
            var daServicio = new DAServicio();
            return daServicio.DelServicioParametro(ServicioId, ParametroId);
        }

        public int InsServicioParametro(int ServicioId, int ParametroId)
        {
            var daServicio = new DAServicio();
            return daServicio.InsServicioParametro(ServicioId, ParametroId);
        }

        public int InsServicioCampania(int CampaniaId, int ServicioId, string CodigoISO)
        {
            var daServicio = new DAServicio();
            CacheManager<BEServicioCampania>.RemoveData(Util.GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());

            return daServicio.InsServicioCampania(CampaniaId, ServicioId, CodigoISO);
        }

        public int InsServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO)
        {
            var daServicio = new DAServicio();
            CacheManager<BEServicioCampania>.RemoveData(Util.GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());

            return daServicio.InsServicioCampaniaRango(CampaniaId, CampaniaFinalId, ServicioId, CodigoISO);
        }

        public int DelServicioCampania(int CampaniaId, int ServicioId, string CodigoISO)
        {
            var daServicio = new DAServicio();
            CacheManager<BEServicioCampania>.RemoveData(Util.GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());

            return daServicio.DelServicioCampania(CampaniaId, ServicioId, CodigoISO);
        }

        public int DelServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO)
        {
            var daServicio = new DAServicio();
            CacheManager<BEServicioCampania>.RemoveData(Util.GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());

            return daServicio.DelServicioCampaniaRango(CampaniaId, CampaniaFinalId, ServicioId, CodigoISO);
        }

        public void DeleteCacheServicio(string CodigoISO, int CampaniaId)
        {
            CacheManager<BEServicioCampania>.RemoveData(Util.GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());
        }

        public BEServicioSegmentoZona GetServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId)
        {
            BEServicioSegmentoZona obeServicioSegmentoZona = null;

            var daServicio = new DAServicio();
            using (IDataReader reader = daServicio.GetServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId))
                while (reader.Read())
                {
                    obeServicioSegmentoZona = new BEServicioSegmentoZona()
                    {
                        Segmento = Convert.ToInt32(reader["Segmento"]),
                        ConfiguracionZona = Convert.ToString(reader["ConfiguracionZona"]),
                        SegmentoInternoID = Convert.ToString(reader["SegmentoInternoID"])
                    };
                }
            return obeServicioSegmentoZona;
        }

        public List<BEServicioSegmentoZona> GetServicioCampaniaSegmentoZonaAsignados(int ServicioId, int PaisId, int Tipo)
        {
            List<BEServicioSegmentoZona> lista = new List<BEServicioSegmentoZona>();

            var daServicio = new DAServicio();
            using (IDataReader reader = daServicio.GetServicioCampaniaSegmentoZonaAsignados(ServicioId, PaisId, Tipo))
                while (reader.Read())
                {
                    if (Tipo == 1)
                    {
                        lista.Add(new BEServicioSegmentoZona()
                        {
                            PaisId = Convert.ToInt32(reader["PaisId"]),
                            NombrePais = Convert.ToString(reader["NombrePais"])
                        });
                    }
                    else
                    {
                        lista.Add(new BEServicioSegmentoZona()
                        {
                            CampaniaId = Convert.ToInt32(reader["CampaniaId"]),
                            DesCampania = Convert.ToString(reader["CampaniaId"])
                        });
                    }
                }
            return lista;
        }

        public void UpdServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInterno)
        {
            DAServicio daServicio = new DAServicio();
            daServicio.UpdServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId, Segmento, ConfiguracionZona, SegmentoInterno);
            CacheManager<BEServicioCampania>.RemoveData(PaisId, ECacheItem.ServiciosBelcorp, CampaniaId.ToString());
        }
    }
}
