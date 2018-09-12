using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.UnitTest.Extensions
{
    public static class DataHandlerExtensions
    {

        public static T GetDataTesting<T>(string FileName)
        {
            var CurrentDirectory = Environment.CurrentDirectory;
            var index = CurrentDirectory.IndexOf("bin");
            CurrentDirectory = CurrentDirectory.Substring(0, index);
            var CompuestaVariableMultimarcaData = CurrentDirectory + String.Format(@"DataTesting\{0}.json", FileName);

            if(File.Exists(CompuestaVariableMultimarcaData))
            {
               var JsonString = File.ReadAllText(CompuestaVariableMultimarcaData);

                if (!String.IsNullOrEmpty(JsonString))
                {
                    return new JavaScriptSerializer().Deserialize<T>(JsonString);
                }
            }

            return default(T);
        }
    }
}
