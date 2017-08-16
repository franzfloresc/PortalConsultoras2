﻿using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionPais
    {
        public List<BEConfiguracionPais> GetList(BEConfiguracionPais entidad)
        {
            var lista = new List<BEConfiguracionPais>();

            try
            {
                var da = new DAConfiguracionPais(entidad.Detalle.PaisID);
                using (IDataReader reader = da.GetList(entidad))
                {
                    while (reader.Read())
                    {
                        lista.Add( new BEConfiguracionPais(reader));
                    }
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine(exc.StackTrace);
                lista = new List<BEConfiguracionPais>();
            }
            return lista;
        }

        public BEConfiguracionPais Get(int paisId, int configuracionPaisId)
        {
            var configuracionPais = new BEConfiguracionPais();

            try
            {
                var da = new DAConfiguracionPais(paisId);
                using (IDataReader reader = da.Get(configuracionPaisId))
                {
                    if (reader.Read())
                    {
                        configuracionPais = new BEConfiguracionPais(reader);
                    }
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine(exc.StackTrace);
            }
            return configuracionPais;
        }

        public List<BEConfiguracionPais> GetList(int paisId, bool tienePerfil)
        {
            var lista = new List<BEConfiguracionPais>();

            try
            {
                var da = new DAConfiguracionPais(paisId);
                using (IDataReader reader = da.GetList(tienePerfil))
                {
                    while (reader.Read())
                    {
                        lista.Add(new BEConfiguracionPais(reader));
                    }
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine(exc.StackTrace);
                lista = new List<BEConfiguracionPais>();
            }
            return lista;
        }

        public void Update(BEConfiguracionPais entidad)
        {
            var dAConfiguracionPais = new DAConfiguracionPais(entidad.PaisID);
            dAConfiguracionPais.Update(entidad);
        }
    }
}
