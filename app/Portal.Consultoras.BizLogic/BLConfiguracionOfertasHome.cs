﻿using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionOfertasHome
    {
        public BEConfiguracionOfertasHome Get(int paisId, int configuracionOfertasHomeId)
        {
            var configuracionOfertasHome = new BEConfiguracionOfertasHome();

            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);
                using (IDataReader reader = da.Get(configuracionOfertasHomeId))
                {
                    if (reader.Read())
                    {
                        configuracionOfertasHome = new BEConfiguracionOfertasHome(reader);
                    }
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine(exc.StackTrace);
            }
            return configuracionOfertasHome;
        }

        public List<BEConfiguracionOfertasHome> GetList(int paisId, int campaniaId)
        {
            var lista = new List<BEConfiguracionOfertasHome>();
            var blConfiguracionPais = new BLConfiguracionPais();
            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);
                using (IDataReader reader = da.GetList(campaniaId))
                {
                    while (reader.Read())
                    {
                        var ofertaHome = new BEConfiguracionOfertasHome(reader);
                        ofertaHome.ConfiguracionPais = blConfiguracionPais.Get(paisId, ofertaHome.ConfiguracionPaisID);
                        lista.Add(ofertaHome);
                    }
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine(exc.StackTrace);
                lista = new List<BEConfiguracionOfertasHome>();
            }
            return lista;
        }

        public void Update(BEConfiguracionOfertasHome entidad)
        {
            var dAConfiguracionOfertasHome = new DAConfiguracionOfertasHome(entidad.PaisID);
            dAConfiguracionOfertasHome.Update(entidad);
        }
        
        public List<BEConfiguracionOfertasHome> GetListarSeccion(int paisId, int campaniaId)
        {
            var lista = new List<BEConfiguracionOfertasHome>();
            var blConfiguracionPais = new BLConfiguracionPais();
            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);
                using (IDataReader reader = da.GetListarSeccion(campaniaId))
                {
                    while (reader.Read())
                    {
                        var ofertaHome = new BEConfiguracionOfertasHome(reader);
                        lista.Add(ofertaHome);
                    }
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine(exc.StackTrace);
                lista = new List<BEConfiguracionOfertasHome>();
            }
            return lista;
        }

    }
}
