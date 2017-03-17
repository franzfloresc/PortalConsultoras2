using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePROLConsultas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseEstrategiaController : BaseController
    {
        public List<BEEstrategia> ConsultarEstrategias(string cuv)
        {
            List<BEEstrategia> lst = new List<BEEstrategia>();

            if (Session["ListadoEstrategiaPedido"] != null)
            {
                lst = (List<BEEstrategia>)Session["ListadoEstrategiaPedido"];
                return lst;
            }

            var entidad = new BEEstrategia();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.ConsultoraID = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID.ToString() : userData.ConsultoraID.ToString();
            entidad.CUV2 = cuv ?? "";
            entidad.Zona = userData.ZonaID.ToString();

            var listaTemporal = new List<BEEstrategia>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaTemporal = sv.GetEstrategiasPedido(entidad).ToList();
            }
            listaTemporal = listaTemporal ?? new List<BEEstrategia>();

            if (listaTemporal.Count == 0)
            {
                Session["ListadoEstrategiaPedido"] = lst;
                return lst;
            }

            var codigoISO = userData.CodigoISO;
            var simbolo = userData.Simbolo;
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

            string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                string codigoSap = "";
                foreach (var beEstrategia in listaTemporal)
                {
                    if (!string.IsNullOrEmpty(beEstrategia.CodigoProducto))
                        codigoSap += beEstrategia.CodigoProducto + "|";
                }

                codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                var listaTieneStock = new List<Lista>();

                try
                {
                    if (!string.IsNullOrEmpty(codigoSap))
                    {
                        using (var sv = new wsConsulta())
                        {
                            sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                            listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    listaTieneStock = new List<Lista>();
                }

                foreach (var beEstrategia in listaTemporal)
                {
                    var add = false;
                    if (beEstrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                    {
                        bool tieneStockProl = false;
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beEstrategia.CodigoProducto);
                        if (itemStockProl != null)
                            tieneStockProl = itemStockProl.estado == 1;

                        add = tieneStockProl || add;
                    }
                    else
                        add = true;

                    if (add)
                    {
                        beEstrategia.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, beEstrategia.FotoProducto01, carpetapais);
                        beEstrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, beEstrategia.ImagenURL, carpetapais);
                        beEstrategia.Simbolo = userData.Simbolo;
                        beEstrategia.TieneStockProl = true;
                        beEstrategia.PrecioString = Util.DecimalToStringFormat(beEstrategia.Precio2, userData.CodigoISO);
                        beEstrategia.PrecioTachado = Util.DecimalToStringFormat(beEstrategia.Precio, userData.CodigoISO);

                        lst.Add(beEstrategia);
                    }
                }
            }
            else
            {
                listaTemporal.Update(x =>
                {
                    x.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais);
                    x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais);
                    x.Simbolo = userData.Simbolo;
                    x.TieneStockProl = true;
                    x.PrecioString = Util.DecimalToStringFormat(x.Precio2, userData.CodigoISO);
                    x.PrecioTachado = Util.DecimalToStringFormat(x.Precio, userData.CodigoISO);
                });

                lst.AddRange(listaTemporal);
            }

            Session["ListadoEstrategiaPedido"] = lst;


            return lst;
        }

        public EstrategiaPedidoModel EstrategiaGetDetalle(int id)
        {
            var modelo = new EstrategiaPedidoModel();

            try
            {
                var lista = ConsultarEstrategias("") ?? new List<BEEstrategia>();
                modelo = Mapper.Map<BEEstrategia, EstrategiaPedidoModel>(lista.Find(e => e.EstrategiaID == id) ?? new BEEstrategia());
            }
            catch (Exception ex)
            {
                modelo = new EstrategiaPedidoModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return modelo;
        }
    }
}