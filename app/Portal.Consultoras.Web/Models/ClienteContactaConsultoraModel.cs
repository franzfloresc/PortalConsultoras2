using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ClienteContactaConsultoraModel
    {
        public long ConsultoraID { get; set; }
        public string NombreConsultora { get; set; }
        public bool Afiliado { get; set; }
        public bool EsPrimeraVez { get; set; }
        //R2442 - JICM - Agregando nuevos campos     
        public bool EmailActivo { get; set; }       
        public string NombreCompleto { get; set; }
        [Required(ErrorMessage = "Ingresar el correo electrónico")]
        [EmailAddress(ErrorMessage = "Correo Electronico Invalido")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Ingresar el celular")]
        [RegularExpression("([0-9]+)", ErrorMessage = "Ingresar solo numeros")] 
        public string Celular { get; set; }
        [RegularExpression("([0-9]+)", ErrorMessage = "Ingresar solo numeros")] 
        public string Telefono { get; set; }
        //[Compare("Email", ErrorMessage = "Verifica que ambos correos coincidan.")]
        public string EmailConfirmacion { get; set; }
        //R2442 - FIN



        public string Usuario { get; set; }
        public string Nombres { get; set; }
        public string CodigoUsuario { get; set; }
        public string CodigoUsuarioAnterior { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoFicticio { get; set; }
        public Boolean Simular { get; set; }
        public string CodigoConsultoraFicticia { get; set; }
        public Int32 Simulador { get; set; }
        public Int32 PaisID { get; set; }
        public Int64 ConsultoraFicticiaID { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }

        public string ActualizarClave { get; set; }
        public string ConfirmarClave { get; set; }
        public string CorreoAnterior { get; set; }
        public bool AceptoContrato { get; set; } //2532 EGL

        //R2116
        public string m_Apellidos { get; set; }
        public string m_Nombre { get; set; }
        //R2116

    }
}