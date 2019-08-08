﻿using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.Encuesta
{
    public class EncuestaMotivoModel
    {
        public int EncuestaMotivoId { get; set; }
        public int EncuestaCalificacionId { get; set; }
        public int TipoEncuestaMotivoId { get; set; }
        public string Descripcion { get; set; }
        public string Observacion { get; set; }
    }
}
