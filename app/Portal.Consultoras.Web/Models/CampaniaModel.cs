﻿using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class CampaniaModel
    {
        public int CampaniaID { get; set; }
        public string Codigo { get; set; }
        public int Anio { get; set; }
        public int NroCampania { get; set; }
        public string NombreCorto { get; set; }
        public byte PaisID { get; set; }
        public bool Activo { get; set; }
        public string PedidoID { get; set; }
        public string strPedidoID { get; set; }
    }
}