using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace Portal.Consultoras.Web.Models.Encuesta
{
    public class EncuestaCalificacionModel
    {
        public EncuestaCalificacionModel()
        {
            EncuestaMotivo = new HashSet<EncuestaMotivoModel>();
        }
        public int EncuestaCalificacionId { get; set; }
        public int EncuestaId { get; set; }
        public string Descripcion { get; set; }
        public string EstiloCalificacion { get; set; }
        public string ImagenCalificacion { get; set; }
        public int TipoCalificacion { get; set; }
        public string CreatedBy { get; set; }
        public string CreateHost { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoCampania { get; set; }
        public int CanalId { get; set; }
        public ICollection<EncuestaMotivoModel> EncuestaMotivo { get; set; }
        public string XMLMotivo { get; set; }
        public static string ListToXML(List<EncuestaMotivoModel> lista)
        {
            string strOut = string.Empty;
            if (lista == null)
                return strOut;
            if (lista.Count > 0)
            {
                StringBuilder sb = new StringBuilder();

                sb.Append("<motivos>");
                foreach (var item in lista)
                {
                    var obs = string.IsNullOrEmpty(item.Observacion) ? "" : item.Observacion.Replace("&", "&amp;");
                    sb.AppendFormat("<motivo>" +
                        "<id>{0}</id>" +
                        "<obs>{1}</obs>" +
                        "</motivo>", item.EncuestaMotivoId, obs);
                }
                sb.Append("</motivos>");
                strOut = sb.ToString();

            }
            return strOut;
        }
    }
}
