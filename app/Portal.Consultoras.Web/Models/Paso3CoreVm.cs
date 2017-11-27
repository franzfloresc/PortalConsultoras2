namespace Portal.Consultoras.Web.Models
{
    public class Paso3CoreVm : BaseVM
    {
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public string CodigoConsultoraRecomienda { get; set; }
        public string ConsultoraRecomienda { get; set; }
        public string NumeroDocumento { get; set; }

        public bool RealizarEnvioCorreoActivacion { get; set; }
        public bool RealizarEnvioCorreoGerenteZona { get; set; }
        public string UrlConfirmacion { get; set; }
        public string Token { get; set; }

        public bool IndicadorActivo { get; set; }
        public bool IndicadorOptin { get; set; }

        public string ResultadoZona { get; set; }

        public string DireccionCadena { get; set; }

        public string UsuarioCreacion { get; set; }
        public string FuenteIngreso { get; set; }

        public string Celular { get; set; }
        public string Telefono { get; set; }

        public string Ciudad { get; set; }
        public string Direccion { get; set; }

        public string RutaBaseVistaHome { get; set; }

        public int? TieneExperiencia { get; set; }
    }
}