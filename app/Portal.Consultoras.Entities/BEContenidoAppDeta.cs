﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoAppDeta
    {
        public BEContenidoAppDeta()
        {

        }

        [DataMember]
        public int IdContenidoDeta { get; set; }

        [DataMember]
        public int IdContenido { get; set; }

        [DataMember]
        public string CodigoDetalle { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string RutaContenido { get; set; }

        [DataMember]
        public string Accion { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public string Tipo { get; set; }

        [DataMember]
        public int Estado { get; set; }

        [DataMember]
        public bool ActivaBoton { get; set; }

    }
}
