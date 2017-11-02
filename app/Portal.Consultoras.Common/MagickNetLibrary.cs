using ImageMagick;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public static class MagickNetLibrary
    {
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
