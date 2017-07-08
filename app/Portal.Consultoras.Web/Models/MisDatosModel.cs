﻿using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class MisDatosModel
    {
        public string PaisISO { get; set; }
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
        public string CadenaParametrosUTMs {get {return @"utm_source=Transactional&utm_medium=email&utm_content=ConfirmarCuenta&utm_campaing=Registro"; }//Google Analytics
        }
    }
}