using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHFaltanteAnunciado
    {
        public List<BEProductoFaltante> GetProductoFaltanteAnunciado(int paisId, int campaniaId)
        {
            var listBE = new List<BEProductoFaltante>();
            var listaHana = new List<FaltanteAnunciadoHana>();

            try
            {
                var codigoIsoHana = Util.GetCodigoIsoHana(paisId);
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");

                string urlConParametros = rutaServiceHana + "ObtenerFaltanteAnunciado/" + codigoIsoHana + "/" + campaniaId;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                listaHana = JsonConvert.DeserializeObject<List<FaltanteAnunciadoHana>>(responseFromServer);

                foreach (var faltanteAnunciadoHana in listaHana)
                {
                    var beProductoFaltante = new BEProductoFaltante();
                    beProductoFaltante.CUV = faltanteAnunciadoHana.codigoVenta;
                    beProductoFaltante.Descripcion = string.IsNullOrEmpty(faltanteAnunciadoHana.DESPROD)
                        ? "Sin Descripción"
                        : faltanteAnunciadoHana.DESPROD;
                    beProductoFaltante.Zona = faltanteAnunciadoHana.codigoZona ?? "";
                    beProductoFaltante.Estado = faltanteAnunciadoHana.estadoActivo;
                    beProductoFaltante.CampaniaID = campaniaId;

                    listBE.Add(beProductoFaltante);
                }
            }
            catch (Exception ex)
            {
                listBE = new List<BEProductoFaltante>();
            }

            return listBE;
        }
    }
}
