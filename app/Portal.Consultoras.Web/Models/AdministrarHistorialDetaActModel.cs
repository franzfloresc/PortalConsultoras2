using Portal.Consultoras.Common;
using System;


namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class AdministrarHistorialDetaActModel : ICloneable
    {

        public int IdContenidoAct { get; set; }      
        public string Codigo { get; set; }     
        public string Descripcion { get; set; }     
        public int Parent { get; set; }
        public bool Activo { get; set; }



        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}