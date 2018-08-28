﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class BuscadorYFiltrosModel
    {
        public BuscadorYFiltrosModel()
        {
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
        }

        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
        public string CUV { get; set; }
        public string SAP { get; set; }
        public string Imagen { get; set; }
        public string Descripcion { get; set; }
        public double Valorizado { get; set; }
        public double Precio { get; set; }
        public int MarcaId { get; set; }
        public string TipoPersonalizacion { get; set; }
        public int CodigoEstrategia { get; set; }
        public string CodigoTipoEstrategia { get; set; }
        public int LimiteVenta { get; set; }
        public bool Stock { get; set; }
        public string PrecioString { get; set; }
        public string ValorizadoString { get; set; }
        public string Agregado { get; set; }
        public int CantidadesAgregadas { get; set; }
        public int CampaniaID { get; set; }
        public int TipoEstrategiaId { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string Origen { get; set; }
    }
}