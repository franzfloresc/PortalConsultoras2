using ImageMagick;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common.MagickNet
{
    public static class MagickNetLibrary
    {
        /// <summary>
        /// Genera imagenes con el tamaño especificado en cada item de la lista enviada como parámetro
        /// </summary>
        /// <param name="lista">Lista con los valores de cada imagen a generar</param>
        /// <returns>Proceso correctamente retorna vacio, sino retorna un mensaje de error</returns>
        public static string CargarImagenesResize(List<EntidadMagickResize> lista)
        {
            var resultado = "";

            foreach (var item in lista)
            {
                if (!Util.ExisteUrlRemota(item.RutaImagenResize))
                {
                    var nombreImagen = Path.GetFileName(item.RutaImagenResize);
                    var resultadoImagenResize = GuardarImagenResize(item.CodigoIso, item.RutaImagenOriginal, nombreImagen, item.Width, item.Height);

                    resultado += resultadoImagenResize
                        ? ""
                        : "No se genero la imagen " + item.TipoImagen + ", favor volver a guardar.";
                }
            }

            return resultado;
        }

        public static bool GuardarImagenResize(string codigoIso, string rutaImagenOriginal, string nombreImagenGuardar, int width, int height)
        {
            var resultado = true;

            string soloImagen = Path.GetFileName(rutaImagenOriginal);

            var rutaImagenResize = rutaImagenOriginal.Clone().ToString();
            rutaImagenResize = rutaImagenResize.Replace(soloImagen, nombreImagenGuardar);

            if (!Util.ExisteUrlRemota(rutaImagenResize))
            {
                var esOk = GuardarImagen(codigoIso, rutaImagenOriginal, width, height, nombreImagenGuardar);

                resultado = esOk;
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
