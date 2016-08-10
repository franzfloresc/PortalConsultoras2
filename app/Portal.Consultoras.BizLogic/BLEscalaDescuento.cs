using Portal.Consultoras.Data;
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
                    //List<BEEscalaDescuento> lstEscalaDescuento = null;
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
                        lstEscalaDescuento.AddRange((List<BEEscalaDescuento>)lstEscalaDescuentoTemp);
                    }

                    CacheManager<BEEscalaDescuento>.AddData(paisID, ECacheItem.EscalaDescuento, lstEscalaDescuento);
                }                
            }
            catch (Exception) { throw; }

            return lstEscalaDescuento;
        }

        public List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID)
        {
            List<BEEscalaDescuento> lstParametriaOfertaFinal = (List<BEEscalaDescuento>)CacheManager<BEEscalaDescuento>.GetData(paisID, ECacheItem.ParametriaOfertaFinal);

            try
            {
                if (lstParametriaOfertaFinal == null || lstParametriaOfertaFinal.Count == 0)
                {
                    //List<BEEscalaDescuento> lstEscalaDescuento = null;
                    DAEscalaDescuento DAEscalaDescuento = new DAEscalaDescuento(paisID);
                    
                    List<BEEscalaDescuento> lstEscalaDescuentoTemp = new List<BEEscalaDescuento>();
                    using (IDataReader reader = DAEscalaDescuento.GetParametriaOfertaFinal())
                        while (reader.Read())
                        {
                            var entidad = new BEEscalaDescuento(reader);
                            lstEscalaDescuentoTemp.Add(entidad);
                        }

                    lstParametriaOfertaFinal = new List<BEEscalaDescuento>();
                    if (lstEscalaDescuentoTemp.Count > 0)
                    {
                        lstParametriaOfertaFinal.AddRange((List<BEEscalaDescuento>)lstEscalaDescuentoTemp);
                    }

                    CacheManager<BEEscalaDescuento>.AddData(paisID, ECacheItem.ParametriaOfertaFinal, lstParametriaOfertaFinal);
                }                
            }
            catch (Exception) { throw; }

            return lstParametriaOfertaFinal;
        }        
    }
}
