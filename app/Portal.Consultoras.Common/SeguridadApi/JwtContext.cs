using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class JwtContext
    {
        

        private JwtContext() { }
        public static JwtContext Instance
        {
            get { return Singleton.instance; }
        }
        private abstract class Singleton
        {
            static Singleton() { } 
            public static readonly JwtContext instance = new JwtContext();

        }
        public  string Application { get; set; }
        public  string Url      { get { return ConfigurationManager.AppSettings["UrlLogDynamo"] ?? ""; } }
        public  string Nombre   { get { return ConfigurationManager.AppSettings["JwtUsuario"] ?? ""; } }
        public  string Password { get { return ConfigurationManager.AppSettings["JwtPassword"] ?? ""; } }
    }
}
