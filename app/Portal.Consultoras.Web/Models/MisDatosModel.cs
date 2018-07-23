namespace Portal.Consultoras.Web.Models
{
    public class MisDatosModel
    {
        public string PaisISO { get; set; }
        public string CodigoUsuario { get; set; }
        public string CodigoUsuarioReal { get; set; }
        public string NombreCompleto { get; set; }
        public string EMail { get; set; }
        public string Telefono { get; set; }
        public string TelefonoTrabajo { get; set; }
        public string Celular { get; set; }
        public string Sobrenombre { get; set; }
        public bool CompartirDatos { get; set; }
        public bool AceptoContrato { get; set; }
        public string CorreoAlerta { get; set; }
        public string CorreoAnterior { get; set; }
        public string NombreGerenteZonal { get; set; }
        public int UsuarioPrueba { get; set; }
        public string NombreConsultoraAsociada { get; set; }
        public string CodigoConsultoraAsociada { get; set; }
        public string NombreArchivoContrato { get; set; }
        public string DigitoVerificador { get; set; }
        public bool EnviarParametrosUTMs { get; set; }
        public string CadenaParametrosUTMs
        {
            get { return @"utm_source=Transactional&utm_medium=email&utm_content=ConfirmarCuenta&utm_campaing=RegistroShowRoomIntriga{{NOMBRE_EVENTO}}"; }

        }
        public string VerCambiarClave { get; set; }
        public string Zona { get; set; }
        public int limiteMinimoTelef { get; set; }
        public int limiteMaximoTelef { get; set; }
        public bool ServiceSMS { get; set; }
        public bool ActualizaDatos { get; set; }
        public int PaisID { get; set; }
        public int IniciaNumeroCelular { get; set; }
        public int IndicadorConsultoraDigital { get; set; }
    }
}