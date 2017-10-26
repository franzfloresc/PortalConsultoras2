﻿using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfirmacionEntrega
    {
        [DataMember]
        public string PaisISO { get; set; }
        [DataMember]
        public int IdentificadorEntrega { get; set; }
        [DataMember]
        public string NumeroPedido { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public DateTime Fecha { get; set; }
        [DataMember]
        public string Latitud { get; set; }
        [DataMember]
        public string Longitud { get; set; }
        [DataMember]
        public string TipoEntrega { get; set; }
        [DataMember]
        public string Novedad { get; set; }
        [DataMember]
        public string Observacion { get; set; }
        [DataMember]
        public string CodigoPlataforma { get; set; }
        [DataMember]
        public string Foto1 { get; set; }
        [DataMember]
        public string Foto2 { get; set; }
        [DataMember]
        public string Foto3 { get; set; }
        [DataMember]
        public string Firma { get; set; }
    }
}
