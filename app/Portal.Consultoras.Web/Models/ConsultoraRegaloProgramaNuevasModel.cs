﻿using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConsultoraRegaloProgramaNuevasOFModel
    {
        public string CodigoNivel { get; set; }
        public decimal TippingPoint { get; set; }
        public string Cuv { get; set; }
        public string DescripcionPremio { get; set; }        
        public decimal PrecioValorizado { get; set; }
        public string UrlImagenRegalo { get; set; }
        public string PrecioValorizadoFormat { get; set; }
    }
}