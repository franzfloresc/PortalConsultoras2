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
        //public async Task<List<OfertaDelDiaModel>> GetOfertaDelDiaModel(UsuarioModel model, ServiceUsuario.BEUsuario usuario)
        public List<OfertaDelDiaModel> GetOfertaDelDiaModel(UsuarioModel model)
        {
            //if (!(usuario.OfertaDelDia && usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)) return new List<OfertaDelDiaModel>();

            var ofertasDelDiaModel = new List<OfertaDelDiaModel>();

            try
            {
                var ofertasDelDia = ObtenerOfertasDelDia(model);

                if (!ofertasDelDia.Any())
                    return ofertasDelDiaModel;

                var personalizacionesOfertaDelDia = ObtenerPersonalizacionesOfertaDelDia(model);
                if (!personalizacionesOfertaDelDia.Any())
                    return ofertasDelDiaModel;

                ofertasDelDia = ofertasDelDia.OrderBy(odd => odd.Orden).ToList();
                var countdown = CountdownODD(model);

                var tablaLogica9301 = personalizacionesOfertaDelDia.FirstOrDefault(x => x.TablaLogicaDatosID == 9301) ?? new BETablaLogicaDatos();
                var tablaLogica9302 = personalizacionesOfertaDelDia.FirstOrDefault(x => x.TablaLogicaDatosID == 9302) ?? new BETablaLogicaDatos();

                var contOdd = 0;
                var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;

                foreach (var oferta in ofertasDelDia)
                {
                    oferta.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, oferta.ImagenURL, carpetaPais);

                    var oddModel = new OfertaDelDiaModel
                    {
                        CodigoIso = model.CodigoISO,
                        TipoEstrategiaID = oferta.TipoEstrategiaID,
                        EstrategiaID = oferta.EstrategiaID,
                        MarcaID = oferta.MarcaID,
                        CUV2 = oferta.CUV2,
                        LimiteVenta = oferta.LimiteVenta,
                        IndicadorMontoMinimo = oferta.IndicadorMontoMinimo,
                        TipoEstrategiaImagenMostrar = oferta.TipoEstrategiaImagenMostrar,
                        TeQuedan = countdown,
                        ImagenFondo1 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo1ODD"),
                            model.CodigoISO),
                        ColorFondo1 = tablaLogica9301.Codigo ?? string.Empty,
                        ImagenBanner = oferta.FotoProducto01,
                        ImagenSoloHoy = ObtenerUrlImagenOfertaDelDia(model.CodigoISO, ofertasDelDia.Count),
                        ImagenFondo2 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo2ODD"),
                            model.CodigoISO),
                        ColorFondo2 = tablaLogica9302.Codigo ?? string.Empty,
                        ImagenDisplay = oferta.FotoProducto01,
                        ID = contOdd++,
                        NombreOferta = ObtenerNombreOfertaDelDia(oferta.DescripcionCUV2),
                        DescripcionOferta = ObtenerDescripcionOfertaDelDia(oferta.DescripcionCUV2),
                        PrecioOferta = oferta.Precio2,
                        PrecioCatalogo = oferta.Precio,
                        TieneOfertaDelDia = true,
                        Orden = oferta.Orden
                    };

                    ofertasDelDiaModel.Add(oddModel);
                }
            }
            catch (Exception ex)
            {
                //logManager.LogErrorWebServicesBusWrap(ex, model.CodigoUsuario, model.PaisID.ToString(),
                //    "LoginController.GetOfertaDelDiaModel");
            }

            return ofertasDelDiaModel;
        }

        public List<ServiceOferta.BEEstrategia> ObtenerOfertasDelDia(UsuarioModel model)
        {
            List<ServiceOferta.BEEstrategia> ofertasDelDia;
            using (OfertaServiceClient osc = new OfertaServiceClient())
            {
                var lst = osc.GetEstrategiaODD(model.PaisID, model.CampaniaID, model.CodigoConsultora, model.FechaInicioCampania.Date);
                ofertasDelDia = lst.ToList();
            }
            return ofertasDelDia;
        }

        public List<BETablaLogicaDatos> ObtenerPersonalizacionesOfertaDelDia(UsuarioModel model)
        {
            List<BETablaLogicaDatos> personalizacionesOfertaDelDia;
            using (var svc = new SACServiceClient())
            {
                var lst = svc.GetTablaLogicaDatos(model.PaisID, Constantes.TablaLogica.PersonalizacionODD);
                personalizacionesOfertaDelDia = lst.ToList();
            }

            return personalizacionesOfertaDelDia;
        }

        public TimeSpan CountdownODD(UsuarioModel model)
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