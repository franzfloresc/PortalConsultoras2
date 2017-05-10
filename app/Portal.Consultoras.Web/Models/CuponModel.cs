﻿using System;

namespace Portal.Consultoras.Web.Models
{
    public class CuponModel
    {
        public int CuponConsultoraId { get; set; }
        public string CodigoConsultora { get; set; }
        public int CampaniaId { get; set; }
        public int CuponId { get; set; }
        public decimal ValorAsociado { get; set; }
        public int EstadoCupon { get; set; }
        public bool EnvioCorreo { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public string TipoCupon { get; set; }
    }
}