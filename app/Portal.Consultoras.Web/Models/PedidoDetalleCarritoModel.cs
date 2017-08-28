﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class PedidoDetalleCarritoModel
    {
        public string DescripcionLarga { get; set; }
        public string DescripcionProd { get; set; }
        public int Cantidad { get; set; }
        public decimal ImporteTotal { get; set; }
    }
}