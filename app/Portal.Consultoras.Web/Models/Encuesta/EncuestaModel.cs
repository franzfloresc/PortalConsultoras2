﻿using Portal.Consultoras.Common;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.Encuesta
{
    public class EncuestaModel
    {
        public EncuestaModel()
        {
            EncuestaCalificacion = new HashSet<EncuestaCalificacionModel>();
            EncuestaId = 0;
        }
        public int EncuestaId { get; set; }
        public string CodigoCampania { get; set; }
        public string Descripcion { get; set; }
        public ICollection<EncuestaCalificacionModel> EncuestaCalificacion { get; set; }

    }
}
