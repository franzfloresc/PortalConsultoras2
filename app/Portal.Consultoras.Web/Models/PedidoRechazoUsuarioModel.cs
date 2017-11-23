﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceUnete;
using System.ComponentModel.DataAnnotations;
using Portal.Consultoras.Web.Annotations;
namespace Portal.Consultoras.Web.Models
{
    public class PedidoRechazoUsuarioModel
    {
        public string CodigoISO { get; set; }
        //[RequiredIf("CodigoISO", "PE", ErrorMessage = "Este campo es obligatorio")]
        [Required(ErrorMessage = "Campo obligatorio")]
        public string TipoRechazo { get; set; }
        //[RequiredIf("CodigoISO", "PE", ErrorMessage = "Este campo es obligatorio")]
        public string MotivoRechazo { get; set; }
        public int SolicitudPostulanteID { get; set; }

        public string NombreCompleto { get; set; }
    }
}