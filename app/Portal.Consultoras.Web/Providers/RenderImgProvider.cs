﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Common.MagickNet;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;

namespace Portal.Consultoras.Web.Providers
{
    public class RenderImgProvider
    {
        protected TablaLogicaProvider _tablaLogicaProvider;

        public RenderImgProvider()
        {
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        public string ImagenesResizeProceso(string urlImagen, string codigoIso, bool esAppCalatogo = false)
        {
            string mensajeErrorImagenResize;
            bool actualizar = true;
            var listaImagenesResize = ObtenerListaImagenesResize(urlImagen, codigoIso, esAppCalatogo, actualizar);
            if (listaImagenesResize != null && listaImagenesResize.Count > 0)
                mensajeErrorImagenResize = MagickNetLibrary.GuardarImagenesResize(listaImagenesResize, actualizar);
            else
                mensajeErrorImagenResize = "No se genero imagenes small y medium, lista vacia de render";

            return mensajeErrorImagenResize;
        }

        public List<EntidadMagickResize> ObtenerListaImagenesResize(string rutaImagen, string codigoIso, bool esAppCalatogo = false, bool actualizar = false)
        {
            var listaImagenesResize = new List<EntidadMagickResize>();

            if (!Util.ExisteUrlRemota(rutaImagen))
            {
                return listaImagenesResize;
            }

            var rutaImagenSmall = "";
            var rutaImagenMedium = "";

            if (esAppCalatogo)
            {
                string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);
                string soloExtension = Path.GetExtension(rutaImagen);

                var extensionNombreImagenSmall = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall;
                var extensionNombreImagenMedium = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium;

                rutaImagenSmall = ConfigS3.GetUrlFileS3Matriz(codigoIso, soloImagen + extensionNombreImagenSmall + soloExtension);
                rutaImagenMedium = ConfigS3.GetUrlFileS3Matriz(codigoIso, soloImagen + extensionNombreImagenMedium + soloExtension);
            }
            else
            {
                rutaImagenSmall = Util.GenerarRutaImagenResize(rutaImagen, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall);
                rutaImagenMedium = Util.GenerarRutaImagenResize(rutaImagen, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium);
            }

            int ancho = 0;
            int alto = 0;

            EntidadMagickResize entidadResize;
            if (!Util.ExisteUrlRemota(rutaImagenSmall) || actualizar)
            {
                GetDimensionesImagen(rutaImagen, Constantes.ConfiguracionImagenResize.TipoImagenSmall, out alto, out ancho);

                if (ancho > 0 && alto > 0)
                {
                    entidadResize = new EntidadMagickResize
                    {
                        RutaImagenOriginal = rutaImagen,
                        RutaImagenResize = rutaImagenSmall,
                        Width = ancho,
                        Height = alto,
                        TipoImagen = Constantes.ConfiguracionImagenResize.TipoImagenSmall,
                        CodigoIso = codigoIso
                    };
                    listaImagenesResize.Add(entidadResize);
                }
            }

            if (!Util.ExisteUrlRemota(rutaImagenMedium) || actualizar)
            {
                GetDimensionesImagen(rutaImagen, Constantes.ConfiguracionImagenResize.TipoImagenMedium, out alto, out ancho);

                if (ancho > 0 && alto > 0)
                {
                    entidadResize = new EntidadMagickResize
                    {
                        RutaImagenOriginal = rutaImagen,
                        RutaImagenResize = rutaImagenMedium,
                        Width = ancho,
                        Height = alto,
                        TipoImagen = Constantes.ConfiguracionImagenResize.TipoImagenMedium,
                        CodigoIso = codigoIso
                    };
                    listaImagenesResize.Add(entidadResize);
                }
            }


            return listaImagenesResize;
        }

        private void GetDimensionesImagen(string urlImagen, string tipoImg, out int alto, out int ancho)
        {
            ancho = 0;
            alto = 0;

            // valores estandar de base de datos
            var hBase = 0;
            var wMax = 0;
            if (tipoImg == Constantes.ConfiguracionImagenResize.TipoImagenSmall)
            {
                hBase = _tablaLogicaProvider.GetTablaLogicaDatoCodigoInt(Constantes.PaisID.Peru, Constantes.TablaLogica.ValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeHeightSmall, true);
                wMax = _tablaLogicaProvider.GetTablaLogicaDatoCodigoInt(Constantes.PaisID.Peru, Constantes.TablaLogica.ValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhMaxSmall, true);
            }
            else if (tipoImg == Constantes.ConfiguracionImagenResize.TipoImagenMedium)
            {
                hBase = _tablaLogicaProvider.GetTablaLogicaDatoCodigoInt(Constantes.PaisID.Peru, Constantes.TablaLogica.ValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeHeightMedium, true);
                wMax = _tablaLogicaProvider.GetTablaLogicaDatoCodigoInt(Constantes.PaisID.Peru, Constantes.TablaLogica.ValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhMaxMedium, true);
            }

            if (hBase == 0 && wMax == 0)
                return;

            // Obtener las dimensiones
            byte[] imageData = new WebClient().DownloadData(urlImagen);
            MemoryStream imgStream = new MemoryStream(imageData);
            Image img = Image.FromStream(imgStream);

            imgStream.Close();

            ancho = img.Width;
            alto = img.Height;

            img.Dispose();

            // calculo matematico para escalar
            if (alto > hBase && hBase > 0)
            {
                ancho = Convert.ToInt32(ancho * (Convert.ToDecimal(hBase) / Convert.ToDecimal(alto)));
                alto = hBase;
            }
            if (ancho > wMax && wMax > 0)
            {
                alto = Convert.ToInt32(alto * (Convert.ToDecimal(wMax) / Convert.ToDecimal(ancho)));
                ancho = wMax;
            }
        }

    }
}