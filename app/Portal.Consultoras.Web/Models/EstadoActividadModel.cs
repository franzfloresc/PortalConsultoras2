﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class EstadoActividadModel
    {
        public int IdEstadoActividad { get; set; }
        public int PaisId { get; set; }
        public string CodigoEstadoActividad { get; set; }
        public string Descripcion { get; set; }


    }
}