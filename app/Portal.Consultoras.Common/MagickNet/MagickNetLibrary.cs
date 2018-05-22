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
        public static string GuardarImagenesResize(List<EntidadMagickResize> lista, bool actualizar = false)
        {
            var txtBuil = new StringBuilder();
            foreach (var item in lista)
            {
                if (!Util.ExisteUrlRemota(item.RutaImagenResize) || actualizar)
                {
                    var nombreImagen = Path.GetFileName(item.RutaImagenResize);
                    var resultadoImagenResize = GuardarImagenResize(item.CodigoIso, item.RutaImagenOriginal, nombreImagen, item.Width, item.Height, actualizar);

                    if (!resultadoImagenResize)
                    {
                        txtBuil.Append("No se genero la imagen " + item.TipoImagen + ", favor volver a guardar.");
                    }
                }
            }

            return txtBuil.ToString();
        }

        private static bool GuardarImagenResize(string codigoIso, string rutaImagenOriginal, string nombreImagenGuardar, int width, int height, bool actualizar = false)
        {
            var resultado = true;

            string soloImagen = Path.GetFileName(rutaImagenOriginal) ?? "";

            var rutaImagenResize = rutaImagenOriginal.Clone().ToString();
            rutaImagenResize = rutaImagenResize.Replace(soloImagen, nombreImagenGuardar);

            if (!Util.ExisteUrlRemota(rutaImagenResize) || actualizar)
            {
                var nombreImagenOriginal = Path.GetFileName(rutaImagenOriginal);

                string rutaImagenTemporal = Path.Combine(Globals.RutaTemporales, nombreImagenOriginal);

                var esOk = GuardarImagenToTemporal(codigoIso, rutaImagenOriginal, rutaImagenTemporal);

                if (esOk)
                    esOk = GuardarImagen(codigoIso, rutaImagenTemporal, width, height, nombreImagenGuardar, actualizar);

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
                LogManager.SaveLog(ex, "", codigoIso, "MagickNetLibrary.GuardarImagenToTemporal");
                resultado = false;
            }
            finally
            {
                webClient.Dispose();
            }

            return resultado;
        }

        private static bool GuardarImagen(string codigoIso, string rutaImagenOriginal, int width, int height, string nombreImagenGuardar, bool actualizar = false)
        {
            var resultado = true;

            try
            {
                string rutaTemporalGuardar = Path.Combine(Globals.RutaTemporales, nombreImagenGuardar);

                MagickGeometry size = new MagickGeometry(width, height);
                size.IgnoreAspectRatio = true;

                using (MagickImage imagen = new MagickImage(rutaImagenOriginal))
                {
                    imagen.Resize(size);

                    // Guardar la imagen resize a carpeta temporal                                                               
                    imagen.Write(rutaTemporalGuardar);
                }

                //Guardar la imagen resize a Amazon
                var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;
                ConfigS3.SetFileS3(rutaTemporalGuardar, carpetaPais, nombreImagenGuardar, actualizar);
            }
            catch (Exception ex)
            {
                resultado = false;
                LogManager.SaveLog(ex, "", codigoIso, "MagickNetLibrary.GuardarImagen");
            }

            return resultado;
        }
    }
}