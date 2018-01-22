using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLAdministrarEstrategia
    {
        public List<BEDescripcionEstrategia> ActualizarDescripcionEstrategia(int paisId, int campaniaId, int tipoEstrategiaId, List<BEDescripcionEstrategia> listaDescripcionEstrategias)
        {
            var listdDescripcionEstrategias = new List<BEDescripcionEstrategia>();
            var DAEstrategia = new DAEstrategia(paisId);
            using (var reader = DAEstrategia.ActualizarDescripcionEstrategia(campaniaId, tipoEstrategiaId, listaDescripcionEstrategias))
            {
                while (reader.Read())
                {
                    listdDescripcionEstrategias.Add(new BEDescripcionEstrategia(reader));
                }
            }
            return listdDescripcionEstrategias;
        }
        public int ActualizarTonoEstrategia(int paisId, int estrategiaId, string codigoEstrategia, int tieneVariedad)
        {
            var DAEstrategia = new DAEstrategia(paisId);
            return DAEstrategia.ActualizarTonoEstrategia(estrategiaId, codigoEstrategia, tieneVariedad);
        }
    }
}
