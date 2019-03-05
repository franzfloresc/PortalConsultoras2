﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class UsuarioOpcionesModel
    {
        public byte OpcionesUsuarioId { get; set; }
        public string Opcion { get; set; }
        public string Codigo { get; set; }
        public bool CheckBox { get; set; }
        public string Descripcion { get; set; }
    }
}