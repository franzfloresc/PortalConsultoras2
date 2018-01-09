using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLEscalaDescuento
    {
        public List<BEEscalaDescuento> GetEscalaDescuento(int paisID)
        {
            List<BEEscalaDescuento> lstEscalaDescuento = (List<BEEscalaDescuento>)CacheManager<BEEscalaDescuento>.GetData(paisID, ECacheItem.EscalaDescuento);

            try
            {
                if (lstEscalaDescuento == null || lstEscalaDescuento.Count == 0)
                {
                    var BLPais = new BLPais();

                    if (!BLPais.EsPaisHana(paisID)) // Validar si informacion de pais es de origen Normal o Hana
                    {
                        DAEscalaDescuento DAEscalaDescuento = new DAEscalaDescuento(paisID);


                        List<BEEscalaDescuento> lstEscalaDescuentoTemp = new List<BEEscalaDescuento>();
                        using (IDataReader reader = DAEscalaDescuento.GetEscalaDescuento())
                            while (reader.Read())
                            {
                                var entidad = new BEEscalaDescuento(reader);
                                lstEscalaDescuentoTemp.Add(entidad);
                            }

                        lstEscalaDescuento = new List<BEEscalaDescuento>();
                        if (lstEscalaDescuentoTemp.Count > 0)
                        {
                            lstEscalaDescuento.AddRange(lstEscalaDescuentoTemp);
                        }
                    }
                    else
                    {
                        var DAHEscalaDescuento = new DAHEscalaDescuento();
                        lstEscalaDescuento = DAHEscalaDescuento.GetEscalaDescuento(paisID);
                    }

                    CacheManager<BEEscalaDescuento>.AddData(paisID, ECacheItem.EscalaDescuento, lstEscalaDescuento);
                }                
            }
            catch (Exception) { throw; }

            return lstEscalaDescuento;
        }

        public List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID,string algoritmo)
        {
            List<BEEscalaDescuento> lstParametriaOfertaFinal = (List<BEEscalaDescuento>)CacheManager<BEEscalaDescuento>.GetData(paisID, ECacheItem.ParametriaOfertaFinal);
            if (lstParametriaOfertaFinal != null)
            {
                lstParametriaOfertaFinal = lstParametriaOfertaFinal.Where(x => x.Algoritmo == algoritmo).ToList();
            }            

            try
            {
                if (lstParametriaOfertaFinal == null || lstParametriaOfertaFinal.Count == 0)
                {
                    DAEscalaDescuento DAEscalaDescuento = new DAEscalaDescuento(paisID);
                    
                    List<BEEscalaDescuento> lstEscalaDescuentoTemp = new List<BEEscalaDescuento>();
                    using (IDataReader reader = DAEscalaDescuento.GetParametriaOfertaFinal(algoritmo))
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
            }
            catch (Exception) { throw; }

            return lstParametriaOfertaFinal;
        }        
    }
}
