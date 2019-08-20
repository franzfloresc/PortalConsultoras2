using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ChatBotListResultadosModel
    {
 
        public int ResultadosID { get; set; }
    
        public string OperadorID { get; set; }
       
        public string NombreOperador { get; set; }
        
        public string CodigoConsultora { get; set; }
        
        public string NombreConsultora { get; set; }
        
        public DateTime FechaInicio { get; set; }
        
        public DateTime FechaFin { get; set; }
        
        public string Campania { get; set; }
        
        public string Pais { get; set; }
        
        public string ConversacionID { get; set; }
  
        public string CanalDescripcion { get; set; }

        public int Resp1 { get; set; }

        public int Resp2 { get; set; }

        public int Resp3 { get; set; }

        public string RespDescrip1 { get; set; }

        public string RespDescrip2 { get; set; }

        public string RespDescrip3 { get; set; }

        public string Cualitativo { get; set; }

    }
}