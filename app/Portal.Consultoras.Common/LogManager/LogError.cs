using System;

namespace Portal.Consultoras.Common
{
    public class LogError
    {
        public Exception Exception { get; set; }

        public string IsoPais { get; set; }

        public string CodigoUsuario { get; set; }

        public string InformacionAdicional { get; set; }

        public string Origen { get; set; }

        public string Titulo { get; set; }
    }
}