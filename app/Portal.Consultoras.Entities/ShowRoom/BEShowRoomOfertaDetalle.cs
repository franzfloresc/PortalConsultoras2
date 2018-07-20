using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomOfertaDetalle
    {
        [DataMember]
        [ViewProperty]
        public int OfertaShowRoomDetalleID { get; set; }

        [DataMember]
        [ViewProperty]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        [ViewProperty]
        public string NombreSet { get; set; }

        [DataMember]
        public string NombreProducto { get; set; }

        [DataMember]
        public string Descripcion1 { get; set; }

        [DataMember]
        public string Descripcion2 { get; set; }

        [DataMember]
        public string Descripcion3 { get; set; }

        [DataMember]
        [ViewProperty]
        public string Imagen { get; set; }

        [DataMember]
        [ViewProperty]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        [ViewProperty]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        [ViewProperty]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [ViewProperty]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public int Posicion { get; set; }

        [DataMember]
        public string MarcaProducto { get; set; }

        [DataMember]
        public string CodigoEstrategia { get; set; }

        [DataMember]
        public List<BEShowRoomTono> Tonos { get; set; }

        [DataMember]
        public string SAP { get; set; }

        [DataMember]
        public string Grupo { get; set; }

        public BEShowRoomOfertaDetalle(IDataRecord row)
        {
            OfertaShowRoomDetalleID = row.ToInt32("OfertaShowRoomDetalleID");
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            NombreSet = row.ToString("NombreSet");
            Posicion = row.ToInt32("Posicion");
            NombreProducto = row.ToString("NombreProducto");
            Descripcion1 = row.ToString("Descripcion1");
            Descripcion2 = row.ToString("Descripcion2");
            Descripcion3 = row.ToString("Descripcion3");
            Imagen = row.ToString("Imagen");
            UsuarioCreacion = row.ToString("UsuarioCreacion");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            Posicion = row.ToInt32("Posicion");
            MarcaProducto = row.ToString("MarcaProducto");
            CodigoEstrategia = row.ToString("CodigoEstrategia");
            SAP = row.ToString("SAP");
            Grupo = row.ToString("Grupo");
        }
    }
}
