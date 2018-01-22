using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLAdministrarEstrategia
    {
        public List<BEDescripcionEstrategia> ActualizarDescripcionEstrategia(int paisId, int campaniaId, int tipoEstrategiaId, List<BEDescripcionEstrategia> listaDescripcionEstrategias)
        {
            var listdDescripcionEstrategias = new List<BEDescripcionEstrategia>();
            var daEstrategia = new DAEstrategia(paisId);
            using (var reader = daEstrategia.ActualizarDescripcionEstrategia(campaniaId, tipoEstrategiaId, listaDescripcionEstrategias))
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
            var daEstrategia = new DAEstrategia(paisId);
            return daEstrategia.ActualizarTonoEstrategia(estrategiaId, codigoEstrategia, tieneVariedad);
        }
    }
}
