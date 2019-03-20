﻿using System.Runtime.Serialization;
namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    [DataContract]
    public class Indicador
    {
        [DataMember]
        public string Titulo { get; set; }
        [DataMember]
        public string Valor { get; set; }
        [DataMember]
        public string UrlImagen { get; set; }
    }
}