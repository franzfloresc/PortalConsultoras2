﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class BaseProvider
    {
        protected ConfiguracionManagerProvider _configuracionManager;

        public BaseProvider() : this(new ConfiguracionManagerProvider())
        {
        }

        public BaseProvider(ConfiguracionManagerProvider configuracionManagerProvider)
        {
            _configuracionManager = configuracionManagerProvider;
        }

        public string GetFormatDecimalPais(string isoPais)
        {
            var listaPaises = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.KeyPaisFormatDecimal);
            if (listaPaises == "" || isoPais == "") return ",|.|2";
            if (listaPaises.Contains(isoPais)) return ".||0";
            return ",|.|2";
        }

        public string ObtenerRutaImagenResize(string rutaImagen, string rutaNombreExtension, string codigoIso)
        {
            string ruta = "";

            if (string.IsNullOrEmpty(rutaImagen))
                return ruta;

            var valorAppCatalogo = Constantes.ConfiguracionImagenResize.ValorTextoDefaultAppCatalogo;

            if (rutaImagen.ToLower().Contains(valorAppCatalogo))
            {
                string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);
                string soloExtension = Path.GetExtension(rutaImagen);
                
                ruta = ConfigCdn.GetUrlFileCdnMatriz(codigoIso, soloImagen + rutaNombreExtension + soloExtension);
            }
            else
            {
                ruta = Util.GenerarRutaImagenResize(rutaImagen, rutaNombreExtension);
            }

            return ruta;
        }
        
        public string GetFechaPromesa(TimeSpan horaCierre, int diasFaltantes, DateTime fechaInicioCampania, bool esMobile)
        {
            var time = DateTime.Today.Add(horaCierre);
            string fecha = null;

            if (esMobile)
            {
                string hrCierrePortal = time.ToString("hh:mm tt").Replace(". ", "").ToUpper();

                fecha = diasFaltantes > 0
                    ? " CIERRA EL " + fechaInicioCampania.Day + " " + Util.NombreMes(fechaInicioCampania.Month).ToUpper()
                    : " CIERRA HOY";

                return fecha + " - " + hrCierrePortal.Replace(".", "");
            }
            else
            {
                var culture = CultureInfo.GetCultureInfo("es-PE");
                fecha = diasFaltantes > 0
                    ? fechaInicioCampania.ToString("dd MMM", culture).ToUpper()
                    : "HOY";

                return fecha + " - " + time.ToString("hh:mm tt", CultureInfo.InvariantCulture).ToLower();
            }

        }

    }

}