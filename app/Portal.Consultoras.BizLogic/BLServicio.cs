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
    public class BLServicio
    {
        public IList<BEServicio> SelectServicio(string Descripcion)
        {
            List<BEServicio> Servicios = new List<BEServicio>();

            var DAServicio = new DAServicio();
            using (IDataReader reader = DAServicio.GetServicios(Descripcion))
                while (reader.Read())
                {
                    Servicios.Add(new BEServicio(reader));
                }
            return Servicios;
        }
        public IList<BEServicioCampania> SelectServicioByCampaniaPais(int PaisId, int CampaniaId)
        {
            IList<BEServicioCampania> Servicios = (IList<BEServicioCampania>)CacheManager<BEServicioCampania>.GetData(PaisId, ECacheItem.ServiciosBelcorp, CampaniaId.ToString());
            if (Servicios == null)
            {
                Servicios = new List<BEServicioCampania>();
                var DAServicio = new DAServicio();
                using (IDataReader reader = DAServicio.GetServicioByCampaniaPais(PaisId, CampaniaId))
                    while (reader.Read())
                    {
                        Servicios.Add(new BEServicioCampania(reader));
                    }
                CacheManager<BEServicioCampania>.AddData(PaisId, ECacheItem.ServiciosBelcorp, CampaniaId.ToString(), Servicios);
            }
            return Servicios;
        }
        public IList<BEServicioCampania> SelectServicioByCampaniaPaisAdministrador(int PaisId, int CampaniaId)
        {
            List<BEServicioCampania> Servicios = new List<BEServicioCampania>();

            var DAServicio = new DAServicio();
            using (IDataReader reader = DAServicio.GetServicioByCampaniaPais(PaisId, CampaniaId))
                while (reader.Read())
                {
                    Servicios.Add(new BEServicioCampania(reader));
                }
            return Servicios;
        }
        public IList<BEParametro> SelectParametros()
        {
            List<BEParametro> Parametros = new List<BEParametro>();

            var DAServicio = new DAServicio();
            using (IDataReader reader = DAServicio.GetParametros())
                while (reader.Read())
                {
                    Parametros.Add(new BEParametro(reader));
                }
            return Parametros;
        }
        public IList<BEServicioParametro> SelectParametrosbyServicio(int ServicioId)
        {
            List<BEServicioParametro> Parametros = new List<BEServicioParametro>();

            var DAServicio = new DAServicio();
            using (IDataReader reader = DAServicio.GetParametrobyServicio(ServicioId))
                while (reader.Read())
                {
                    Parametros.Add(new BEServicioParametro(reader));
                }
            return Parametros;
        }
        public IList<BEEstadoServicio> SelectEstadoServiciobyPais(int ServicioId, int CampaniaId)
        {
            List<BEEstadoServicio> Parametros = new List<BEEstadoServicio>();

            var DAServicio = new DAServicio();
            using (IDataReader reader = DAServicio.GetEstadoServiciobyPais(ServicioId, CampaniaId))
                while (reader.Read())
                {
                    Parametros.Add(new BEEstadoServicio(reader));
                }
            return Parametros;
        }

        public int InsServicio(BEServicio servicio)
        {
            var DAServicio = new DAServicio();
            return DAServicio.InsServicio(servicio);
        }
        public int UpdServicio(BEServicio servicio)
        {
            var DAServicio = new DAServicio();
            return DAServicio.UpdServicio(servicio);
        }
        public int DelServicio(int ServicioId)
        {
            var DAServicio = new DAServicio();
            return DAServicio.DelServicio(ServicioId);
        }
        public int DelServicioParametro(int ServicioId, int ParametroId)
        {
            var DAServicio = new DAServicio();
            return DAServicio.DelServicioParametro(ServicioId, ParametroId);
        }
        public int InsServicioParametro(int ServicioId, int ParametroId)
        {
            var DAServicio = new DAServicio();
            return DAServicio.InsServicioParametro(ServicioId, ParametroId);
        }
        public int InsServicioCampania(int CampaniaId, int ServicioId, string CodigoISO)
        {
            var DAServicio = new DAServicio();
            CacheManager<BEServicioCampania>.RemoveData(GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());

            return DAServicio.InsServicioCampania(CampaniaId, ServicioId, CodigoISO);
        }
        public int InsServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO)
        {
            var DAServicio = new DAServicio();
            CacheManager<BEServicioCampania>.RemoveData(GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());

            return DAServicio.InsServicioCampaniaRango(CampaniaId, CampaniaFinalId, ServicioId, CodigoISO);
        }
        public int DelServicioCampania(int CampaniaId, int ServicioId, string CodigoISO)
        {
            var DAServicio = new DAServicio();
            CacheManager<BEServicioCampania>.RemoveData(GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());

            return DAServicio.DelServicioCampania(CampaniaId, ServicioId, CodigoISO);
        }
        public int DelServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO)
        {
            var DAServicio = new DAServicio();
            CacheManager<BEServicioCampania>.RemoveData(GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());

            return DAServicio.DelServicioCampaniaRango(CampaniaId, CampaniaFinalId, ServicioId, CodigoISO);
        }

        //RQ_DC - R2133
        public void DeleteCacheServicio(string CodigoISO, int CampaniaId)
        {
            CacheManager<BEServicioCampania>.RemoveData(GetPaisID(CodigoISO), ECacheItem.ServiciosBelcorp, CampaniaId.ToString());
        }

        private int GetPaisID(string ISO)
        {
            List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
            {
                new KeyValuePair<string, string>("1", "AR"),
                new KeyValuePair<string, string>("2", "BO"),
                new KeyValuePair<string, string>("3", "CL"),
                new KeyValuePair<string, string>("4", "CO"),
                new KeyValuePair<string, string>("5", "CR"),
                new KeyValuePair<string, string>("6", "EC"),
                new KeyValuePair<string, string>("7", "SV"),
                new KeyValuePair<string, string>("8", "GT"),
                new KeyValuePair<string, string>("9", "MX"),
                new KeyValuePair<string, string>("10", "PA"),
                new KeyValuePair<string, string>("11", "PE"),
                new KeyValuePair<string, string>("12", "PR"),
                new KeyValuePair<string, string>("13", "DO"),
                new KeyValuePair<string, string>("14", "VE"),
            };
            string paisID = "0";
            try
            {
                paisID = (from c in listaPaises
                          where c.Value == ISO.ToUpper()
                          select c.Key).SingleOrDefault();
            }
            catch (Exception)
            {
                throw new Exception("Hubo un error en obtener el País");
            }
            return int.Parse(paisID);
        }

        //RQ_PBS - R2161
        public BEServicioSegmentoZona GetServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId)
        {
            BEServicioSegmentoZona oBEServicioSegmentoZona = null;

            var DAServicio = new DAServicio();
            using (IDataReader reader = DAServicio.GetServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId))
                while (reader.Read())
                {
                    oBEServicioSegmentoZona = new BEServicioSegmentoZona()
                    {
                        Segmento = Convert.ToInt32(reader["Segmento"]),
                        ConfiguracionZona = Convert.ToString(reader["ConfiguracionZona"]),
                        SegmentoInternoID = Convert.ToString(reader["SegmentoInternoID"])/*CGI(RSA) - REQ 2544*/
                    };
                }
            return oBEServicioSegmentoZona;
        }

        //RQ_PBS - R2161
        public List<BEServicioSegmentoZona> GetServicioCampaniaSegmentoZonaAsignados(int ServicioId, int PaisId, int Tipo)
        {
            List<BEServicioSegmentoZona> Lista = new List<BEServicioSegmentoZona>();

            var DAServicio = new DAServicio();
            using (IDataReader reader = DAServicio.GetServicioCampaniaSegmentoZonaAsignados(ServicioId, PaisId, Tipo))
                while (reader.Read())
                {
                    if (Tipo == 1)
                    {
                        Lista.Add(new BEServicioSegmentoZona()
                        {
                            PaisId = Convert.ToInt32(reader["PaisId"]),
                            NombrePais = Convert.ToString(reader["NombrePais"])
                        });
                    }
                    else
                    {
                        Lista.Add(new BEServicioSegmentoZona()
                        {
                            CampaniaId = Convert.ToInt32(reader["CampaniaId"]),
                            DesCampania = Convert.ToString(reader["CampaniaId"])
                        });
                    }
                }
            return Lista;
        }

        //RQ_PBS - R2161
        /*RE2544 - CS(CGI) - 14/05/2015 */     
        public void UpdServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInterno)
        {
            DAServicio DAServicio = new DAServicio();
            DAServicio.UpdServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId, Segmento, ConfiguracionZona, SegmentoInterno);
            CacheManager<BEServicioCampania>.RemoveData(PaisId, ECacheItem.ServiciosBelcorp, CampaniaId.ToString());
        }
    }
}
