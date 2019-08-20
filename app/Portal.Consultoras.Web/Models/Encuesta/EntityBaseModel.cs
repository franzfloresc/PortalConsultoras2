using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.Encuesta
{
    public class EntityBaseModel
    {
        public string CreatedBy { get; set; }
        public DateTime? CreateOn { get; set; }
        public string CreateHost { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public int ModifiedHost { get; set; }
        public bool? Status { get; set; }
    }
}
