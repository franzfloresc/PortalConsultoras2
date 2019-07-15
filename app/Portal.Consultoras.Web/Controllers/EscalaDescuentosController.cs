﻿using Portal.Consultoras.Common;
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

            string msj = _tablaLogicaProvider.GetTablaLogicaDatoValorCodigo(userData.PaisID, ConsTablaLogica.EscalaDescuento.TablaLogicaId, ConsTablaLogica.EscalaDescuento.Cod01);

            using (var srv = new PedidoServiceClient())
            {
                var List = srv.GetEscalaDescuento(userData.PaisID, userData.CampaniaID, userData.CodigorRegion, userData.CodigoZona).OrderBy(a => a.MontoDesde).ToList();

                var montoMinimo = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO));

                if (List.Any())
                {
                    decimal montoMinimoEscala = 0;
                    int i = 0;
                    var cantidad = List.Count;
                    foreach (var item in List)
                    {
                        var obj = new EscalaDescuentoModel();
                        if (i == 0)
                            obj.MontoMinimo = montoMinimo;
                        else
                            obj.MontoMinimo = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(Math.Floor(montoMinimoEscala) + 1, userData.CodigoISO));

                        obj.MontoMaximo = i + 1 == cantidad ? "más" : string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(item.MontoHasta, userData.CodigoISO));
                        montoMinimoEscala = item.MontoHasta;
                        obj.PorcentajeDescuento = Util.DecimalToStringFormat(item.PorDescuento, userData.CodigoISO);
                        model.Add(obj);
                        i++;

                    }
                }
            }

            ViewBag.MensajeImportante = msj;
            ViewData["PaisID"] = userData.PaisID;

            return View(model);
        }
    }
}
