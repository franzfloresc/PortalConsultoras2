﻿using System;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    [Serializable]
    public class PeriodosModel
    {
        public string Isopais { get; set; }
        public string Periodo { get; set; }
        public string CampanaInicial { get; set; }
        public string CampanaFinal { get; set; }
        public long NroCampana { get; set; }
    }
}