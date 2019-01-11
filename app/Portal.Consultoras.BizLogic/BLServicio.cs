using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

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

        // se movio a Util.GetPaisID
        //private int GetPaisID(string ISO)
        //{
        //    List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
        //    {
        //        new KeyValuePair<string, string>("1", Constantes.CodigosISOPais.Argentina),
        //        new KeyValuePair<string, string>("2", Constantes.CodigosISOPais.Bolivia),
        //        new KeyValuePair<string, string>("3", Constantes.CodigosISOPais.Chile),
        //        new KeyValuePair<string, string>("4", Constantes.CodigosISOPais.Colombia),
        //        new KeyValuePair<string, string>("5", Constantes.CodigosISOPais.CostaRica),
        //        new KeyValuePair<string, string>("6", Constantes.CodigosISOPais.Ecuador),
        //        new KeyValuePair<string, string>("7", Constantes.CodigosISOPais.Salvador),
        //        new KeyValuePair<string, string>("8", Constantes.CodigosISOPais.Guatemala),
        //        new KeyValuePair<string, string>("9", Constantes.CodigosISOPais.Mexico),
        //        new KeyValuePair<string, string>("10", Constantes.CodigosISOPais.Panama),
        //        new KeyValuePair<string, string>("11", Constantes.CodigosISOPais.Peru),
        //        new KeyValuePair<string, string>("12", Constantes.CodigosISOPais.PuertoRico),
        //        new KeyValuePair<string, string>("13", Constantes.CodigosISOPais.Dominicana),
        //        new KeyValuePair<string, string>("14", Constantes.CodigosISOPais.Venezuela),
        //    };
        //    string paisId;
        //    try
        //    {
        //        paisId = (from c in listaPaises
        //                  where c.Value == ISO.ToUpper()
        //                  select c.Key).SingleOrDefault();
        //    }
        //    catch (Exception)
        //    {
        //        throw new Exception("Hubo un error en obtener el País");
        //    }
        //    if (paisId == null) paisId = "0";
        //    return int.Parse(paisId);
        //}

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
