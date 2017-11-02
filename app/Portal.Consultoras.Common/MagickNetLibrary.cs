using ImageMagick;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class MagickNetLibrary
    {
        public static bool GuardarImagenResize(string codigoIso, string rutaImagenOriginal, int width, int height, string nombreImagenGuardar)
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
                //throw;
            }

            return resultado;
        }
    }
}
