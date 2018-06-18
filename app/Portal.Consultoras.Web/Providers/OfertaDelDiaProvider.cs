using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceOferta;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaDelDiaProvider
    {
        //public List<OfertaDelDiaModel> GetOfertas(UsuarioModel model)
        //{
        //    List<ServiceOferta.BEEstrategia> ofertasDelDia;

        //    using (var osc = new OfertaServiceClient())
        //    {
        //        ofertasDelDia = osc.GetEstrategiaODD(model.PaisID, model.CampaniaID, model.CodigoConsultora, model.FechaInicioCampania.Date).ToList();
        //    }

        //    ofertasDelDia = ofertasDelDia.OrderBy(odd => odd.Orden).ToList();

        //    return Mapper.Map<List<ServiceOferta.BEEstrategia>, List<OfertaDelDiaModel>>(ofertasDelDia).ToList();
        //}
        public List<EstrategiaPedidoModel> GetOfertas(UsuarioModel model)
        {
            List<ServiceOferta.BEEstrategia> ofertasDelDia;

            using (var osc = new OfertaServiceClient())
            {
                ofertasDelDia = osc.GetEstrategiaODD(model.PaisID, model.CampaniaID, model.CodigoConsultora, model.FechaInicioCampania.Date).ToList();
            }

            ofertasDelDia = ofertasDelDia.OrderBy(odd => odd.Orden).ToList();

            return Mapper.Map<List<ServiceOferta.BEEstrategia>, List<EstrategiaPedidoModel>>(ofertasDelDia).ToList();
        }

        public TimeSpan CountdownOdd(UsuarioModel model)
        {
            DateTime hoy;
            DateTime d2;
            using (var svc = new SACServiceClient())
            {
                hoy = svc.GetFechaHoraPais(model.PaisID);
            }
            var d1 = new DateTime(hoy.Year, hoy.Month, hoy.Day, 0, 0, 0);

            if (model.EsDiasFacturacion)
            {
                var t1 = model.HoraCierreZonaNormal;
                d2 = new DateTime(hoy.Year, hoy.Month, hoy.Day, t1.Hours, t1.Minutes, t1.Seconds);
            }
            else
            {
                d2 = d1.AddDays(1);
            }
            var t2 = (d2 - hoy);
            return t2;
        }
    }
}