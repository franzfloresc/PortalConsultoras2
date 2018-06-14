using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceOferta;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using AutoMapper;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaDelDiaProvider
    {
        public List<OfertaDelDiaModel> GetOfertaDelDiaModel(UsuarioModel model)
        {
            var ofertasDelDia = GetOfertas(model);
            if (!ofertasDelDia.Any()) return new List<OfertaDelDiaModel>();

            var personalizacionesOfertaDelDia = GetPersonalizaciones(model);
            if (!personalizacionesOfertaDelDia.Any()) return new List<OfertaDelDiaModel>();


            var tablaLogica9301 = personalizacionesOfertaDelDia.FirstOrDefault(x => x.TablaLogicaDatosID == 9301) ?? new BETablaLogicaDatos();
            var tablaLogica9302 = personalizacionesOfertaDelDia.FirstOrDefault(x => x.TablaLogicaDatosID == 9302) ?? new BETablaLogicaDatos();

            var countdown = CountdownOdd(model);
            ofertasDelDia.Update(x =>
            {
                x.CodigoIso = model.CodigoISO;
                x.TeQuedan = countdown;
                x.ImagenFondo1 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo1ODD"),model.CodigoISO);
                x.ColorFondo1 = tablaLogica9301.Codigo ?? string.Empty;
                x.ImagenSoloHoy = ObtenerUrlImagenOfertaDelDia(model.CodigoISO, ofertasDelDia.Count);
                x.ImagenFondo2 =
                    string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo2ODD"), model.CodigoISO);
                x.ColorFondo2 = tablaLogica9302.Codigo ?? string.Empty;
                x.NombreOferta = ObtenerNombreOfertaDelDia(x.NombreOferta);
                x.DescripcionOferta = ObtenerDescripcionOfertaDelDia(x.DescripcionOferta);
                x.TieneOfertaDelDia = true;
            });

            return ofertasDelDia;
        }

        public List<OfertaDelDiaModel> GetOfertas(UsuarioModel model)
        {
            List<ServiceOferta.BEEstrategia> ofertasDelDia;

            using (var osc = new OfertaServiceClient())
            {
                ofertasDelDia = osc.GetEstrategiaODD(model.PaisID, model.CampaniaID, model.CodigoConsultora, model.FechaInicioCampania.Date).ToList();
            }

            ofertasDelDia = ofertasDelDia.OrderBy(odd => odd.Orden).ToList();

            return Mapper.Map<List<ServiceOferta.BEEstrategia>, List<OfertaDelDiaModel>>(ofertasDelDia).ToList();
        }

        public List<BETablaLogicaDatos> GetPersonalizaciones(UsuarioModel model)
        {
            List<BETablaLogicaDatos> personalizacionesOfertaDelDia;

            using (var svc = new SACServiceClient())
            {
                personalizacionesOfertaDelDia = svc.GetTablaLogicaDatos(model.PaisID, Constantes.TablaLogica.PersonalizacionODD).ToList();
            }

            return personalizacionesOfertaDelDia;
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

        public string ObtenerNombreOfertaDelDia(string descripcionCuv2)
        {
            var nombreOferta = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                nombreOferta = descripcionCuv2.Split('|').First();
            }

            return nombreOferta;
        }

        public string ObtenerDescripcionOfertaDelDia(string descripcionCuv2)
        {
            var descripcionOdd = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                var temp = descripcionCuv2.Split('|').ToList();
                temp = temp.Skip(1).ToList();

                var txtBuil = new StringBuilder();
                foreach (var item in temp)
                {
                    if (!string.IsNullOrEmpty(item))
                        txtBuil.Append(item.Trim() + "|");
                }

                descripcionOdd = txtBuil.ToString();
                descripcionOdd = descripcionOdd == string.Empty
                    ? string.Empty
                    : descripcionOdd.Substring(0, descripcionOdd.Length - 1);
                descripcionOdd = descripcionOdd.Replace("|", " +<br />");
                descripcionOdd = descripcionOdd.Replace("\\", "");
                descripcionOdd = descripcionOdd.Replace("(GRATIS)", "<b>GRATIS</b>");
            }

            return descripcionOdd;
        }

        public string ObtenerUrlImagenOfertaDelDia(string codigoIso, int cantidadOfertas)
        {
            var imgSh = string.Format(ConfigurationManager.AppSettings.Get("UrlImgSoloHoyODD"), codigoIso);
            var exte = imgSh.Split('.')[imgSh.Split('.').Length - 1];
            imgSh = imgSh.Substring(0, imgSh.Length - exte.Length - 1) + (cantidadOfertas > 1 ? "s" : "") + "." + exte;
            return imgSh;
        }
    }
}