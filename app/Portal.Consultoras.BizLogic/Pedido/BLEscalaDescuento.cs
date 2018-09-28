using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using Portal.Consultoras.Common;

using System.Data;
using System.Linq;
using System;

namespace Portal.Consultoras.BizLogic
{
    public class BLEscalaDescuento : IEscalaDescuentoBusinessLogic
    {
        public List<BEEscalaDescuento> GetEscalaDescuento(int paisID, int campaniaID, string region, string zona)
        {
            List<BEEscalaDescuento> lista = default(List<BEEscalaDescuento>);
            var da = new DAEscalaDescuento(paisID);
            try
            {
                lista = this.ListarEscalaDescuentoZona(paisID, campaniaID, region, zona);
                if (lista.Count == 0)
                {
                    if (!new BLPais().EsPaisHana(paisID))
                    {
                        using (IDataReader reader = da.GetEscalaDescuento())
                        {
                            while (reader.Read())
                            {
                                lista.Add(new BEEscalaDescuento(reader));
                            }
                        }
                    }
                    else
                    {
                        lista = new DAHEscalaDescuento().GetEscalaDescuento(paisID);
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<BEEscalaDescuento>();
            }
            return lista;
        }

        public List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID, string algoritmo)
        {
            List<BEEscalaDescuento> lstParametriaOfertaFinal = (List<BEEscalaDescuento>)CacheManager<BEEscalaDescuento>.GetData(paisID, ECacheItem.ParametriaOfertaFinal);
            if (lstParametriaOfertaFinal != null)
            {
                lstParametriaOfertaFinal = lstParametriaOfertaFinal.Where(x => x.Algoritmo == algoritmo).ToList();
            }

            if (lstParametriaOfertaFinal == null || lstParametriaOfertaFinal.Count == 0)
            {
                DAEscalaDescuento daEscalaDescuento = new DAEscalaDescuento(paisID);

                List<BEEscalaDescuento> lstEscalaDescuentoTemp = new List<BEEscalaDescuento>();
                using (IDataReader reader = daEscalaDescuento.GetParametriaOfertaFinal(algoritmo))
                    while (reader.Read())
                    {
                        var entidad = new BEEscalaDescuento(reader);
                        lstEscalaDescuentoTemp.Add(entidad);
                    }

                lstParametriaOfertaFinal = new List<BEEscalaDescuento>();
                if (lstEscalaDescuentoTemp.Count > 0)
                {
                    lstParametriaOfertaFinal.AddRange(lstEscalaDescuentoTemp);
                }

                CacheManager<BEEscalaDescuento>.AddData(paisID, ECacheItem.ParametriaOfertaFinal, lstParametriaOfertaFinal);
            }

            return lstParametriaOfertaFinal;
        }

        public List<BEEscalaDescuento> ListarEscalaDescuentoZona(int paisID, int campaniaID, string region, string zona)
        {
            List<BEEscalaDescuento> lista = new List<BEEscalaDescuento>();
            try
            {
                var da = new DAEscalaDescuento(paisID);
                using (IDataReader reader = da.ListarEscalaDescuentoZona(campaniaID, region, zona))
                {
                    while (reader.Read())
                    {
                        lista.Add(new BEEscalaDescuento(reader));
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<BEEscalaDescuento>();
            }
            return lista;
        }

    }
}
