using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class AdministrarHistorialDetaListModel : ICloneable
    {
        public int Proc { set; get; }
        public int IdContenidoDeta { get; set; }
        public int IdContenido { get; set; }
        public string CodigoDetalle { get; set; }        
        public string Descripcion { get; set; }        
        public string RutaContenido { get; set; }        
        public string Accion { get; set; }        
        public int Orden { get; set; }        
        public string Tipo { get; set; }        
        public bool Estado { get; set; }
        public string Ancho{ get; set; }
        public string Alto { get; set; }
        public string CUV { get; set; }
        public int Campania { set; get; }
        public String LimitDetMensaje { get; set; }
        public IEnumerable<CampaniaModel> ListaCampanias { set; get; }
        public IEnumerable<AdministrarHistorialDetaActModel> ListaAccion { set; get; }
        public IEnumerable<AdministrarHistorialDetaActModel> ListaCodigoDetalle { set; get; }


        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }

}