﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceUnete;
using System.ComponentModel.DataAnnotations;
using Portal.Consultoras.Web.Annotations;
namespace Portal.Consultoras.Web.Models
{
    public class RechazoModel
    {
        public string CodigoISO { get; set; }
        [Required(ErrorMessage = "Campo obligatorio")]
        public string TipoRechazo { get; set; }
        public string MotivoRechazo { get; set; }
        public int SolicitudPostulanteID { get; set; }

        public string NombreCompleto { get; set; }
    }
}