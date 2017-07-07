using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class MisDatosModel
    {
        // EPD-2811 Colombia requiere campos de solo lectura debido a la LEY de actualizacion de datos
        private string _paisISO = "";
        public string PaisISO {
            get
            {
                return _paisISO;
            }
            set
            {
                if( value != null )
                {
                    if( value == "CO" )
                    {
                        TextoSobrenombre = "Nombre: ";
                        TextoCorreoElectronico = "Correo Electrónico:";
                        TextoTelefono = "Teléfono:";
                        TextoCelular = "Celular:";
                        TextoBoton = "Aceptar";
                    }
                    _paisISO = value;
                }
            }
        }

        public string CodigoUsuario { get; set; }
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
        public string CadenaParametrosUTMs {get {return @"utm_source=Transactional&utm_medium=email&utm_content=ConfirmarCuenta&utm_campaing=Registro"; } }//Google Analytics

        // EPD-2811 Colombia requiere campos de solo lectura debido a la LEY de actualizacion de datos
        public string TextoSobrenombre { get; set; }
        public string TextoCorreoElectronico { get; set; }
        public string TextoTelefono { get; set; }
        public string TextoCelular { get; set; }
        public string TextoBoton { get; set; }

        public MisDatosModel()
        {
            // EPD-2811 Colombia requiere campos de solo lectura debido a la LEY de actualizacion de datos
            TextoSobrenombre = "¿Qu&eacute nombre te gustaría que te digamos?:";
            TextoCorreoElectronico = "* Tu Correo Electrónico:";
            TextoTelefono = "Tu Teléfono:";
            TextoCelular = "Tu Celular:";
            TextoBoton = "Actualizar";
        }
    }
}