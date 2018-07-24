using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    [DataContract(IsReference = true)]
    public class EstrategiaComponenteModel 
    {
        public int Cantidad { get; set; }
        public string CodigoProducto { get; set; }
        public string Cuv { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionComercial { get; set; }
        public string DescripcionMarca { get; set; }
        public int Digitable { get; set; }
        public int FactorCuadre { get; set; }
        public string Grupo { get; set; }
        public int Id { get; set; }
        public int IdMarca { get; set; }
        public string Imagen { get; set; }
        public string ImagenBulk { get; set; }
        public string ImagenProductoSugerido { get; set; }
        public string NombreBulk { get; set; }
        public string NombreComercial { get; set; }
        public int Orden { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string PrecioCatalogoString { get; set; }
        public string Volumen { get; set; }
        public List<EstrategiaComponenteModel> Hermanos { get; set; }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}