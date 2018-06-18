using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using Portal.Consultoras.Common;

using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLEscalaDescuento : IEscalaDescuentoBusinessLogic
    {
        public List<BEEscalaDescuento> GetEscalaDescuento(int paisID)
        {
            var lstEscalaDescuento = (List<BEEscalaDescuento>)CacheManager<BEEscalaDescuento>.GetData(paisID, ECacheItem.EscalaDescuento);

            if (lstEscalaDescuento == null || lstEscalaDescuento.Count == 0)
            {
                if (!new BLPais().EsPaisHana(paisID)) // Validar si informacion de pais es de origen Normal o Hana
                {
                    using (var reader = new DAEscalaDescuento(paisID).GetEscalaDescuento())
                    {
                        lstEscalaDescuento = reader.MapToCollection<BEEscalaDescuento>();
                    }
                }
                else
                {
                    lstEscalaDescuento = new DAHEscalaDescuento().GetEscalaDescuento(paisID);
                }

                CacheManager<BEEscalaDescuento>.AddData(paisID, ECacheItem.EscalaDescuento, lstEscalaDescuento);
            }

            return lstEscalaDescuento;
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
    }
}
