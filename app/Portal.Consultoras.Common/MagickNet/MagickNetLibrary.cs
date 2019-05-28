﻿using ImageMagick;

using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Linq;

namespace Portal.Consultoras.Common.MagickNet
{
    public static class MagickNetLibrary
    {
        public static string GuardarImagenesResizeParalelo(List<EntidadMagickResize> lista, bool actualizar = false)
        {
            var txtBuil = new StringBuilder();

            if (lista.Any())
            {
                var primerItem = lista.FirstOrDefault();

                if (primerItem != null)
                {
                    var nombreImagenOriginal = Path.GetFileName(primerItem.RutaImagenOriginal);
                    var rutaImagenTemporal = Path.Combine(Globals.RutaTemporales, nombreImagenOriginal);

                    var esOk = GuardarImagenToTemporal(primerItem.CodigoIso, primerItem.RutaImagenOriginal, rutaImagenTemporal);

                    var lstTask = lista.Select(item => Task.Run(() => GuardarImagenesResizeDetalleParalelo(item, actualizar, false))).ToArray();
                    Task.WaitAll(lstTask);

                    File.Delete(rutaImagenTemporal);

                    foreach (var item in lstTask)
                    {
                        txtBuil.Append(item.Result);
                    }
                }
            }

            return txtBuil.ToString();
        }

        private static string GuardarImagenesResizeDetalleParalelo(EntidadMagickResize item, bool actualizar = false, bool temporal = true)
        {
            var result = string.Empty;

            if (!Util.ExisteUrlRemota(item.RutaImagenResize) || actualizar)
            {
                var nombreImagen = Path.GetFileName(item.RutaImagenResize);
                var resultadoImagenResize = GuardarImagenResize(item.CodigoIso, item.RutaImagenOriginal, nombreImagen, item.Width, item.Height, actualizar, temporal);

                if (!resultadoImagenResize) result = string.Format("No se genero la imagen {0}, favor volver a guardar.", item.TipoImagen);
            }

            return result;
        }

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

        private static bool GuardarImagenResize(string codigoIso, string rutaImagenOriginal, string nombreImagenGuardar, int width, 
            int height, bool actualizar = false, bool temporal = true)
        {
            var resultado = true;

            string soloImagen = Path.GetFileName(rutaImagenOriginal) ?? "";

            var rutaImagenResize = rutaImagenOriginal.Clone().ToString();
            rutaImagenResize = rutaImagenResize.Replace(soloImagen, nombreImagenGuardar);

            if (!Util.ExisteUrlRemota(rutaImagenResize) || actualizar)
            {
                var nombreImagenOriginal = Path.GetFileName(rutaImagenOriginal);

                string rutaImagenTemporal = Path.Combine(Globals.RutaTemporales, nombreImagenOriginal);

                if (temporal)
                {
                    var esOk = GuardarImagenToTemporal(codigoIso, rutaImagenOriginal, rutaImagenTemporal);

                    if (esOk) esOk = GuardarImagen(codigoIso, rutaImagenTemporal, width, height, nombreImagenGuardar, actualizar);

                    File.Delete(rutaImagenTemporal);

                    resultado = esOk;
                }
                else
                {
                    resultado = GuardarImagen(codigoIso, rutaImagenTemporal, width, height, nombreImagenGuardar, actualizar);
                }
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

        public static string GuardarImagenesResizeParaleloHistDetalle(List<EntidadMagickResize> lista, string cadena, bool actualizar = false)
        {
            var txtBuil = new StringBuilder();

            if (lista.Any())
            {
                var primerItem = lista.FirstOrDefault();

                if (primerItem != null)
                {
                    var nombreImagenOriginal = Path.GetFileName(primerItem.RutaImagenOriginal);
                    var rutaImagenTemporal = Path.Combine(Globals.RutaTemporales, nombreImagenOriginal);

                    var esOk = GuardarImagenToTemporal(primerItem.CodigoIso, primerItem.RutaImagenOriginal, rutaImagenTemporal);

                    var lstTask = lista.Select(item => Task.Run(() => GuardarImagenesResizeHistDetalle(item, cadena, actualizar, false))).ToArray();
                    Task.WaitAll(lstTask);

                    File.Delete(rutaImagenTemporal);

                    foreach (var item in lstTask)
                    {
                        txtBuil.Append(item.Result);
                    }
                }
            }

            return txtBuil.ToString();
        }

        private static string GuardarImagenesResizeHistDetalle(EntidadMagickResize item, string cadena, bool actualizar = false, bool temporal = true)
        {
            var result = string.Empty;

            if (!Util.ExisteUrlRemota(item.RutaImagenResize) || actualizar)
            {
                var nombreImagen = Path.GetFileName(item.RutaImagenResize);
                var resultadoImagenResize = GuardarImagenResizeHistDetalle(item.CodigoIso, item.RutaImagenOriginal, nombreImagen, item.Width, item.Height, cadena, actualizar, temporal);

                if (!resultadoImagenResize) result = string.Format("No se genero la imagen {0}, favor volver a guardar.", item.TipoImagen);
            }

            return result;
        }

        private static bool GuardarImagenResizeHistDetalle(string codigoIso, string rutaImagenOriginal, string nombreImagenGuardar, int width,
            int height, string cadena, bool actualizar = false, bool temporal = true)
        {
            var resultado = true;

            string soloImagen = Path.GetFileName(rutaImagenOriginal) ?? "";

            var rutaImagenResize = rutaImagenOriginal.Clone().ToString();
            rutaImagenResize = rutaImagenResize.Replace(soloImagen, nombreImagenGuardar);

            if (!Util.ExisteUrlRemota(rutaImagenResize) || actualizar)
            {
                var nombreImagenOriginal = Path.GetFileName(rutaImagenOriginal);

                string rutaImagenTemporal = Path.Combine(Globals.RutaTemporales, nombreImagenOriginal);

                if (temporal)
                {
                    var esOk = GuardarImagenToTemporal(codigoIso, rutaImagenOriginal, rutaImagenTemporal);

                    if (esOk) esOk = GuardarImagenHistDetalle(codigoIso, rutaImagenTemporal, width, height, nombreImagenGuardar, cadena, actualizar);

                    File.Delete(rutaImagenTemporal);

                    resultado = esOk;
                }
                else
                {
                    resultado = GuardarImagenHistDetalle(codigoIso, rutaImagenTemporal, width, height, nombreImagenGuardar, cadena, actualizar);
                }
            }

            return resultado;
        }

        private static bool GuardarImagenHistDetalle(string codigoIso, string rutaImagenOriginal, int width, int height, string nombreImagenGuardar, string cadena, bool actualizar = false)
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
                string[] arrCadena;
                arrCadena = cadena.Split(',');
                var carpetaPais = string.Format("{0}/{1}/{2}", arrCadena[0], codigoIso, arrCadena[1]);

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