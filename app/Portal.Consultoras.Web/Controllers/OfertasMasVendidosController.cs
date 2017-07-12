﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasMasVendidosController : BaseEstrategiaController
    {
               
        [HttpGet]
        public JsonResult ObtenerOfertas(string cuv) 
        {
            var model =  new EstrategiaOutModel();

            var listModel = ConsultarMasVendidosModel();
           
            model.Lista = listModel;

            model = ActualizarPosicion(model);

            return Json(model, JsonRequestBehavior.AllowGet);
        }

        private EstrategiaOutModel ActualizarPosicion(EstrategiaOutModel model)
        {
            if (model != null)
            {
                for (int i =0;i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                }
            }
            return model;
        }

        [HttpPost]
        public JsonResult ActualizarModel(EstrategiaOutModel model)
        {
            try
            {
                var listaPedido = ObtenerPedidoWebDetalle();
                if (model != null)
                {
                    if (model.Lista != null)
                    {
                        for (int i = 0; i <= model.Lista.Count - 1; i++)
                        {
                            model.Lista[i].IsAgregado = listaPedido.Any(p => p.CUV == model.Lista[i].CUV2.Trim());
                        }
                    }
                    if (model.Item != null)
                    {
                        model.Item.IsAgregado = listaPedido.Any(p => p.CUV == model.Item.CUV2.Trim());
                    }
                }
                return Json(new { success = true, data = model });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message });
            }
        }
    }
}