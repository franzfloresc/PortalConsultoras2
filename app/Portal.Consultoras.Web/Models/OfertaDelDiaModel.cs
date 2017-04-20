﻿using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class OfertaDelDiaModel : CompartirRedesSocialesModel
    {
        public int ID { get; set; }
        public string CodigoIso { get; set; }
        public int TipoEstrategiaID { get; set; }
        public int EstrategiaID { get; set; }
        public int MarcaID { get; set; }
        public string CUV { get; set; }
        public string CUV2 { get; set; }
        public int LimiteVenta { get; set; }
        public int IndicadorMontoMinimo { get; set; }
        public int FlagNueva { get; set; }
        public int TipoEstrategiaImagenMostrar { get; set; }

        public TimeSpan TeQuedan { get; set; }
        public string ImagenFondo1 { get; set; }
        public string ColorFondo1 { get; set; }
        public string ImagenBanner { get; set; }
        public string ImagenSoloHoy { get; set; }
        public string ImagenFondo2 { get; set; }
        public string ColorFondo2 { get; set; }
        public string ImagenDisplay { get; set; }
        public string NombreOferta { get; set; }
        public decimal PrecioOferta { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string DescripcionOferta { get; set; }
        public int Cantidad { get; set; }
        public bool TieneOfertaDelDia { get; set; }
        public List<OfertaDelDiaModel> ListaOfertas { get; set; }

        public string PrecioOfertaFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioOferta, CodigoIso);
            }
        }

        public string PrecioCatalogoFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioCatalogo, CodigoIso);
            }
        }

        public OfertaDelDiaModel Clone()
        {
            return (OfertaDelDiaModel)this.MemberwiseClone();
        }
    }
}