using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;

namespace Portal.Consultoras.Web.Models
{
    public class MisReclamosModel
    {
        public MisReclamosModel()
        {
            Complemento = new HashSet<ProductoComplementarioModel>();
            Reemplazo = new HashSet<ProductoComplementarioModel>();
            flagLimiteReclamo = false;
        }
        public int CDRWebID { get; set; }
        public int PedidoID { get; set; }
        public int NumeroPedido { get; set; }
        public int CampaniaID { get; set; }
        public List<CampaniaModel> ListaCampania { get; set; }
        public List<CampaniaModel> ListaPedido { get; set; }
        public string Campania { get; set; }
        public string EstadoSsic { get; set; }
        public string CUV { get; set; }
        public int Cantidad { get; set; }
        public string DescripcionProd { get; set; }
        public string EstadoSsic2 { get; set; }
        public string CUV2 { get; set; }
        public int Cantidad2 { get; set; }
        public string DescripcionProd2 { get; set; }
        public string DescripcionConfirma { get; set; }
        public string DescripcionConfirma2 { get; set; }
        public string Motivo { get; set; }
        public string Operacion { get; set; }
        public List<Campo> ListaMotivo { get; set; }
        public int CDRWebDetalleID { get; set; }
        public string GrupoID { get; set; }
        public string Accion { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }

        public List<CDRWebModel> ListaCDRWeb { get; set; }

        public decimal MontoMinimo { get; set; }

        public int TieneHistoricoCDR { get; set; }
        public string UrlPoliticaCdr { get; set; }
        public string MensajeGestionCdrInhabilitada { get; set; }

        public int limiteMinimoTelef { get; set; }
        public int limiteMaximoTelef { get; set; }

        public bool TieneCDRExpress { get; set; }
        public bool EsConsultoraNueva { get; set; }
        public bool? TipoDespacho { get; set; }
        public decimal FleteDespacho { get; set; }
        public string MensajeDespacho { get; set; }
        public bool EsMovilOrigen { get; set; }
        public bool EsMovilFin { get; set; }
        public MensajesCDRExpressModel MensajesExpress { get; set; }
        public int? CantidadReclamosPorPedido { get; set; }
        public ICollection<ProductoComplementarioModel> Complemento { get; set; }
        public ICollection<ProductoComplementarioModel> Reemplazo { get; set; }
        public static string ListToXML(List<ProductoComplementarioModel> lista)
        {
            string strOut = string.Empty;
            if (lista == null)
                return strOut;
            if (lista.Count > 0)
            {
                StringBuilder sb = new StringBuilder();

                sb.Append("<reemplazos>");
                foreach (var item in lista)
                {
                    sb.AppendFormat("<reemplazo>" +
                        "<cuv>{0}</cuv>" +
                        "<cantidad>{1}</cantidad>" +
                        "<descripcion>{2}</descripcion>" +
                        "<simbolo>{3}</simbolo>" +
                        "<precio>{4}</precio>" +
                        "<estado>{5}</estado>" +
                        "<codigorechazo>{6}</codigorechazo>" +
                        "<obs>{7}</obs>" +
                        "</reemplazo>", item.CUV, item.Cantidad,  item.Descripcion.Replace("&", "&amp;"), item.Simbolo, item.Precio, item.Estado, item.CodigoMotivoRechazo, item.Observacion);
                }
                sb.Append("</reemplazos>");
                strOut = sb.ToString();

            }
            return strOut;
        }

        public static List<ProductoComplementarioModel> XMLToList(string xml)
        {
            if (string.IsNullOrEmpty(xml))
                return new List<ProductoComplementarioModel>();
            var lista = new List<ProductoComplementarioModel>();
            try
            {
                XmlDocument xmlDocument = new XmlDocument();
                xmlDocument.LoadXml(xml);
                XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/reemplazos/reemplazo");
                foreach (XmlNode xmlNode in xmlNodeList)
                {
                    ProductoComplementarioModel obj = new ProductoComplementarioModel();
                    obj.CUV = xmlNode["cuv"].InnerText;
                    obj.Descripcion = xmlNode["descripcion"].InnerText;
                    obj.Cantidad = xmlNode["cantidad"].InnerText == "" ? 0 : Convert.ToInt32(xmlNode["cantidad"].InnerText);
                    obj.Precio = xmlNode["precio"].InnerText == "" ? 0 : Convert.ToDecimal(xmlNode["precio"].InnerText);
                    obj.Simbolo = xmlNode["simbolo"].InnerText;
                    obj.Estado = xmlNode["estado"].InnerText == "" ? 0 : Convert.ToInt32(xmlNode["estado"].InnerText);
                    obj.CodigoMotivoRechazo = xmlNode["codigorechazo"].InnerText;
                    obj.Observacion = xmlNode["obs"].InnerText;
                    lista.Add(obj);
                }
            }
            catch (Exception)
            {
                lista = null;
            }
            return lista;
        }
        public int MostrarTab { get; set; }
        public bool flagLimiteReclamo { get; set; }
    }
}