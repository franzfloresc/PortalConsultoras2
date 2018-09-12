using Portal.Consultoras.Common;
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
    public class BLEscalaDescuentoZona
    {
        public List<BEEscalaDescuentoZona> ListarEscalaDescuentoZona(int paisID, int campaniaID, string region, string zona)
        {
            List<BEEscalaDescuentoZona> lista = new List<BEEscalaDescuentoZona>();
            try
            {
                var da = new DAEscalaDescuentoZona(paisID);
                using (IDataReader reader = da.ListarEscalaDescuentoZona(campaniaID, region, zona))
                {
                    while (reader.Read())
                    {
                        lista.Add(new BEEscalaDescuentoZona(reader));
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<BEEscalaDescuentoZona>();
            }
            return lista;
        }

        public List<BEEscalaDescuento> GetEscalaDescuentoZona(int paisID, int campaniaID, string region, string zona)
        {
            IDataReader reader = null;
            List<BEEscalaDescuento> lista = default(List<BEEscalaDescuento>);
            try
            {
                lista = new List<BEEscalaDescuento>();
                var da = new DAEscalaDescuentoZona(paisID);
                reader = da.ListarEscalaDescuentoZona(campaniaID, region, zona);
                while (reader.Read())
                {
                    lista.Add(new BEEscalaDescuentoZona().GetEscalaDescuento(reader));
                }
                if (lista.Count == 0)
                {
                    if (!new BLPais().EsPaisHana(paisID))
                    {
                        reader = new DAEscalaDescuento(paisID).GetEscalaDescuento();
                        while (reader.Read())
                        {
                            lista.Add(new BEEscalaDescuentoZona().GetEscalaDescuento(reader));
                        }
                    }
                    else
                    {
                        lista = new DAHEscalaDescuento().GetEscalaDescuento(paisID);
                    }
                }
                reader.Close();
                reader.Dispose();
            }
            catch (Exception ex)
            {
                lista = new List<BEEscalaDescuento>();
            }
            return lista;
        }

    }
}
