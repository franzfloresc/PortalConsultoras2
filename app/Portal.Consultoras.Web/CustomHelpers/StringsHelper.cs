using System;

    //Portal.Consultoras.Web.Areas.Mobile.Helpers
namespace Portal.Consultoras.Web.CustomHelpers
{
    public static class StringsHelper
    {
        public static string GenerateLinkForGoogleTagManager(this string source)
        {
            var result = source;

            //Ajuste personalizado para Marcas
            if (result.IndexOf("L'BEL", StringComparison.Ordinal) > -1)
            {
                result = "Lbel";
            }
            else if (result.IndexOf("ÉSIKA", StringComparison.Ordinal) > -1)
            {
                result = "Ésika";
            }
            else if (result.IndexOf("CYZONE", StringComparison.Ordinal) > -1)
            {
                result = "Cyzone";
            }

            result = result.Replace("á", "a");
            result = result.Replace("é", "e");
            result = result.Replace("í", "i");
            result = result.Replace("ó", "o");
            result = result.Replace("ú", "u");
            result = result.Replace("ñ", "n");
            result = result.Replace("Á", "a");
            result = result.Replace("É", "e");
            result = result.Replace("Í", "i");
            result = result.Replace("Ó", "o");
            result = result.Replace("Ú", "u");
            result = result.Replace("Ñ", "n");

            result = result.ToLowerInvariant();

            result = result.Replace(" ", "-");

            return result;
        }
    }
}
