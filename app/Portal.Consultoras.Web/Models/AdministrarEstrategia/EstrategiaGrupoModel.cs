using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.AdministrarEstrategia
{
    [Serializable]
   
    public class EstrategiaGrupoRequest
    {
   
        public string pais { get; set; }
     
        public string estrategiaId { get; set; }
       
        public List<EstrategiaGrupoModel> EstrategiaGrupos { get; set; }
    }
    [Serializable]
   
    public class EstrategiaGrupoModel
    { 
        public string _id { get; set; }
       
        public int EstrategiaId { get; set; }
     
        public int EstrategiaGrupoId { get; set; }
       
        public string Grupo { get; set; }
     
        public string DescripcionSingular { get; set; }
      
        public string DescripcionPlural { get; set; }
         
    }
}