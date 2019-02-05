using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EscalaDescuentosController : BaseController
    {
        public ActionResult Index()
        {
            var model = new List<EscalaDescuentoModel>();
            using (var srv = new PedidoServiceClient())
            {
                var List = srv.GetEscalaDescuento(userData.PaisID, userData.CampaniaID, userData.CodigorRegion, userData.CodigoZona).OrderBy(a => a.MontoDesde);
                var montoMinimo = $"{userData.Simbolo} {Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO)}";
                var simbolo = userData.Simbolo;
                if (List != null)
                {
                    if (List.Count() > 0)
                    {
                        decimal montoMinimoEscala = 0;
                        int i = 0;
                        var cantidad = List.Count();
                        foreach (var item in List)
                        {
                            var obj = new EscalaDescuentoModel();
                            if (i == 0)
                                obj.MontoMinimo = montoMinimo;
                            else
                                obj.MontoMinimo = $"{userData.Simbolo} {Util.DecimalToStringFormat(Math.Floor(montoMinimoEscala) + 1, userData.CodigoISO)}";

                            obj.MontoMaximo = i + 1 == cantidad ? "a más" : $"{userData.Simbolo} {Util.DecimalToStringFormat(Math.Floor(item.MontoHasta), userData.CodigoISO)}";
                            montoMinimoEscala = item.MontoHasta;
                            obj.PorcentajeDescuento = Util.DecimalToStringFormat(item.PorDescuento, userData.CodigoISO);
                            model.Add(obj);
                            i++;
                        }
                    }
                }
            }
            return View(model);
        }
    }
}
