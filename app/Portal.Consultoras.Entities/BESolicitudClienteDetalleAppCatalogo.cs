using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BESolicitudClienteDetalleAppCatalogo
    {
        [DataMember(Order = 0)]
        public int Cantidad { get; set; }
        [DataMember(Order = 1)]
        public string CUV { get; set; }
        [DataMember(Order = 2)]
        public int MarcaID { get; set; }
        [DataMember(Order = 3)]
        public string DescripcionMarca { get; set; }
        [DataMember(Order = 4)]
        public string DescripcionProducto { get; set; }
        [DataMember(Order = 5)]
        public decimal Precio { get; set; }
        [DataMember(Order = 6)]
        public string Tono { get; set; }
        [DataMember(Order = 7)]
        public string UrlImgProducto { get; set; }
    }

    public class DESolicitudClienteDetalleAppCatalogo
    {
        public int Cantidad { get; set; }
        public string CUV { get; set; }
        public int MarcaID { get; set; }
        public string DescripcionProducto { get; set; }
        public decimal Precio { get; set; }
        public string Tono { get; set; }
        public string Url { get; set; }

        public DESolicitudClienteDetalleAppCatalogo(BESolicitudClienteDetalleAppCatalogo solicitudClienteDetalleAppCatalogo)
        {
            Cantidad = solicitudClienteDetalleAppCatalogo.Cantidad;
            CUV = solicitudClienteDetalleAppCatalogo.CUV;
            MarcaID = solicitudClienteDetalleAppCatalogo.MarcaID;
            DescripcionProducto = solicitudClienteDetalleAppCatalogo.DescripcionProducto;
            Precio = solicitudClienteDetalleAppCatalogo.Precio;
            Tono = solicitudClienteDetalleAppCatalogo.Tono;
            Url = solicitudClienteDetalleAppCatalogo.UrlImgProducto;
        }
    }
}
