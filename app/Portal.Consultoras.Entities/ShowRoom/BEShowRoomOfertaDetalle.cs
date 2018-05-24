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
            if (DataRecord.HasColumn(row, "OfertaShowRoomDetalleID"))
                OfertaShowRoomDetalleID = Convert.ToInt32(row["OfertaShowRoomDetalleID"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "NombreSet"))
                NombreSet = Convert.ToString(row["NombreSet"]);
            if (DataRecord.HasColumn(row, "Posicion"))
                Posicion = Convert.ToInt32(row["Posicion"]);
            if (DataRecord.HasColumn(row, "NombreProducto"))
                NombreProducto = Convert.ToString(row["NombreProducto"]);
            if (DataRecord.HasColumn(row, "Descripcion1"))
                Descripcion1 = Convert.ToString(row["Descripcion1"]);
            if (DataRecord.HasColumn(row, "Descripcion2"))
                Descripcion2 = Convert.ToString(row["Descripcion2"]);
            if (DataRecord.HasColumn(row, "Descripcion3"))
                Descripcion3 = Convert.ToString(row["Descripcion3"]);
            if (DataRecord.HasColumn(row, "Imagen"))
                Imagen = Convert.ToString(row["Imagen"]);
            if (DataRecord.HasColumn(row, "UsuarioCreacion"))
                UsuarioCreacion = Convert.ToString(row["UsuarioCreacion"]);
            if (DataRecord.HasColumn(row, "FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]);
            if (DataRecord.HasColumn(row, "UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "Posicion"))
                Posicion = Convert.ToInt32(row["Posicion"]);
            if (DataRecord.HasColumn(row, "MarcaProducto"))
                MarcaProducto = Convert.ToString(row["MarcaProducto"]);
            if (DataRecord.HasColumn(row, "CodigoEstrategia"))
                CodigoEstrategia = Convert.ToString(row["CodigoEstrategia"]);
            if (DataRecord.HasColumn(row, "SAP"))
                SAP = Convert.ToString(row["SAP"]);
            if (DataRecord.HasColumn(row, "Grupo"))
                Grupo = Convert.ToString(row["Grupo"]);

        }
    }
}
