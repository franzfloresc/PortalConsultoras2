using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ConsultoraFicticiaModel
    {
        public string Usuario { get; set; }
        public string Nombres { get; set; }
        public string CodigoUsuario { get; set; }
        public string CodigoUsuarioAnterior { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoFicticio { get; set; }
        public Boolean Simular { get; set; }
        public Int64 ConsultoraID { get; set; }
        public string CodigoConsultoraFicticia { get; set; }
        public Int32 Simulador { get; set; }
        public Int32 PaisID { get; set; }
        public Int64 ConsultoraFicticiaID { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }

        public string Telefono { get; set; }
        public string TelefonoTrabajo { get; set; }
        public string Celular { get; set; }
        public string Email { get; set; }
        public string ActualizarClave { get; set; }
        public string ConfirmarClave { get; set; }
        public string CorreoAnterior { get; set; }
        public bool AceptoContrato { get; set; }

        public string m_Apellidos { get; set; }
        public string m_Nombre { get; set; }
    }
}
