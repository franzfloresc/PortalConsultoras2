using ImageMagick;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;

namespace Portal.Consultoras.Common.MagickNet
{
    public static class MagickNetLibrary
    {
        /// <summary>
        /// Genera imagenes con el tamaño especificado en cada item de la lista enviada como parámetro
        /// </summary>
        /// <param name="lista">Lista con los valores de cada imagen a generar</param>
        /// <returns>Proceso correctamente retorna vacio, sino retorna un mensaje de error</returns>
        public static string GuardarImagenesResize(List<EntidadMagickResize> lista)
        {
            var txtBuil = new StringBuilder();
            foreach (var item in lista)
            {
                if (!Util.ExisteUrlRemota(item.RutaImagenResize))
                {
                    var nombreImagen = Path.GetFileName(item.RutaImagenResize);
                    var resultadoImagenResize = GuardarImagenResize(item.CodigoIso, item.RutaImagenOriginal, nombreImagen, item.Width, item.Height);

                    if (!resultadoImagenResize)
                    {
                        txtBuil.Append("No se genero la imagen " + item.TipoImagen + ", favor volver a guardar.");
                    }
                }
            }

            return txtBuil.ToString();
        }

        public static bool GuardarImagenResize(string codigoIso, string rutaImagenOriginal, string nombreImagenGuardar, int width, int height)
        {
            var resultado = true;

            string soloImagen = Path.GetFileName(rutaImagenOriginal) ?? "";

            var rutaImagenResize = rutaImagenOriginal.Clone().ToString();
            rutaImagenResize = rutaImagenResize.Replace(soloImagen, nombreImagenGuardar);

            var nombreImagenOriginal = Path.GetFileName(rutaImagenOriginal);

            if (!Util.ExisteUrlRemota(rutaImagenResize))
            {
                string rutaImagenTemporal = Path.Combine(Globals.RutaTemporales, nombreImagenOriginal);

                var esOk = GuardarImagenToTemporal(codigoIso, rutaImagenOriginal, rutaImagenTemporal);

                if (esOk)
                    esOk = GuardarImagen(codigoIso, rutaImagenTemporal, width, height, nombreImagenGuardar);

                File.Delete(rutaImagenTemporal);

                resultado = esOk;
            }

            return resultado;
        }

        private static bool GuardarImagenToTemporal(string codigoIso, string rutaImagenOriginal, string rutaImagenTemporal)
        {
            var resultado = true;

            WebClient webClient = new WebClient();
            try
            {
                webClient.DownloadFile(rutaImagenOriginal, rutaImagenTemporal);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", codigoIso);
                resultado = false;
            }
            finally
            {
                webClient.Dispose();
            }

            return resultado;
        }

        private static bool GuardarImagen(string codigoIso, string rutaImagenOriginal, int width, int height, string nombreImagenGuardar)
        {
            var resultado = true;

            try
            {
                string rutaTemporalGuardar = Path.Combine(Globals.RutaTemporales, nombreImagenGuardar);

                using (MagickImage imagen = new MagickImage(rutaImagenOriginal))
                {
                    MagickGeometry size = new MagickGeometry(width, height);
                    size.IgnoreAspectRatio = true;

                    imagen.Resize(size);

                    // Guardar la imagen resize a carpeta temporal                                                               
                    imagen.Write(rutaTemporalGuardar);
                }

                //Guardar la imagen resize a Amazon
                var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;
                ConfigS3.SetFileS3(rutaTemporalGuardar, carpetaPais, nombreImagenGuardar);
            }
            catch (Exception ex)
            {
                resultado = false;
                LogManager.SaveLog(ex, "", codigoIso);
            }

            return resultado;
        }
    }
}
