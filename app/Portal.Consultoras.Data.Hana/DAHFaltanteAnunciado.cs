using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHFaltanteAnunciado
    {
        public List<BEProductoFaltante> GetProductoFaltanteAnunciado(int paisId, int campaniaId)
        {
            var listBe = new List<BEProductoFaltante>();

            try
            {
                var codigoIsoHana = Common.Util.GetPaisIsoHanna(paisId);
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");

                string urlConParametros = rutaServiceHana + "ObtenerFaltanteAnunciado/" + codigoIsoHana + "/" + campaniaId;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                var listaHana = JsonConvert.DeserializeObject<List<FaltanteAnunciadoHana>>(responseFromServer);

                foreach (var faltanteAnunciadoHana in listaHana)
                {
                    var beProductoFaltante = new BEProductoFaltante
                    {
                        CUV = faltanteAnunciadoHana.codigoVenta,
                        Descripcion = string.IsNullOrEmpty(faltanteAnunciadoHana.DESPROD)
                            ? "Sin Descripción"
                            : faltanteAnunciadoHana.DESPROD,
                        Zona = faltanteAnunciadoHana.codigoZona ?? "",
                        Estado = faltanteAnunciadoHana.estadoActivo,
                        CampaniaID = campaniaId
                    };

                    listBe.Add(beProductoFaltante);
                }
            }
            catch (Exception)
            {
                listBe = new List<BEProductoFaltante>();
            }

            return listBe;
        }
    }
}