using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Providers
{
    public class TablaLogicaProvider
    {
        public virtual List<TablaLogicaDatosModel> ObtenerConfiguracion(int paisId, short key)
        {
            using (var cliente = new SACServiceClient())
            {
                var datos = cliente.GetTablaLogicaDatos(paisId, key);
                if (datos == null)
                    return new List<TablaLogicaDatosModel>();

                var mapped = Mapper.Map<IEnumerable<BETablaLogicaDatos>, List<TablaLogicaDatosModel>>(datos);

                return mapped ?? new List<TablaLogicaDatosModel>();
            }
        }
    }
}
