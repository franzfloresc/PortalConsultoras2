using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETipoEstrategia
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string OfertaID { get; set; }

        [DataMember]
        public string DescripcionOferta { get; set; }

        [DataMember]
        public int TipoEstrategiaID { get; set; }

        [DataMember]
        public string DescripcionEstrategia { get; set; }

        [DataMember]
        public string ImagenEstrategia { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public int FlagActivo { get; set; }

        [DataMember]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public int FlagNueva { get; set; }

        [DataMember]
        public int FlagRecoPerfil { get; set; }

        [DataMember]
        public int FlagRecoProduc { get; set; }

        [DataMember]
        public string CodigoPrograma { get; set; }

        [DataMember]
        public int FlagMostrarImg { get; set; }

        [DataMember]
        public int CodigoGeneral { get; set; }

        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public bool MostrarImgOfertaIndependiente { get; set; }

        [DataMember]
        public string ImagenOfertaIndependiente { get; set; }

        [DataMember]
        public int FlagValidarImagen { get; set; }

        [DataMember]
        public int PesoMaximoImagen { get; set; }

        public BETipoEstrategia(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoEstrategiaID") && row["TipoEstrategiaID"] != DBNull.Value)
                TipoEstrategiaID = Convert.ToInt32(row["TipoEstrategiaID"]);

            if (DataRecord.HasColumn(row, "DescripcionEstrategia") && row["DescripcionEstrategia"] != DBNull.Value)
                DescripcionEstrategia = row["DescripcionEstrategia"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionOferta") && row["DescripcionOferta"] != DBNull.Value)
                DescripcionOferta = row["DescripcionOferta"].ToString();

            if (DataRecord.HasColumn(row, "Orden") && row["Orden"] != DBNull.Value)
                Orden = Convert.ToInt32(row["Orden"]);

            if (DataRecord.HasColumn(row, "FlagActivo")) FlagActivo = Convert.ToInt32(row["FlagActivo"]);

            if (DataRecord.HasColumn(row, "OfertaID") && row["OfertaID"] != DBNull.Value)
                OfertaID = row["OfertaID"].ToString();

            if (DataRecord.HasColumn(row, "ImagenEstrategia") && row["ImagenEstrategia"] != DBNull.Value)
                ImagenEstrategia = row["ImagenEstrategia"].ToString();

            if (DataRecord.HasColumn(row, "FlagNueva") && row["FlagNueva"] != DBNull.Value)
                FlagNueva = Convert.ToInt32(row["FlagNueva"]);

            if (DataRecord.HasColumn(row, "FlagRecoPerfil") && row["FlagRecoPerfil"] != DBNull.Value)
                FlagRecoPerfil = Convert.ToInt32(row["FlagRecoPerfil"]);

            if (DataRecord.HasColumn(row, "FlagRecoProduc") && row["FlagRecoProduc"] != DBNull.Value)
                FlagRecoProduc = Convert.ToInt32(row["FlagRecoProduc"]);

            if (DataRecord.HasColumn(row, "CodigoPrograma") && row["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = Convert.ToString(row["CodigoPrograma"]);

            if (DataRecord.HasColumn(row, "FlagMostrarImg") && row["FlagMostrarImg"] != DBNull.Value)
                FlagMostrarImg = Convert.ToInt32(row["FlagMostrarImg"]);

            if (DataRecord.HasColumn(row, "CodigoGeneral") && row["CodigoGeneral"] != DBNull.Value)
                CodigoGeneral = Convert.ToInt32(row["CodigoGeneral"]);

            if (DataRecord.HasColumn(row, "Codigo") && row["Codigo"] != DBNull.Value)
                Codigo = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "MostrarImgOfertaIndependiente") && row["MostrarImgOfertaIndependiente"] != DBNull.Value)
                MostrarImgOfertaIndependiente = Convert.ToBoolean(row["MostrarImgOfertaIndependiente"]);

            if (DataRecord.HasColumn(row, "ImagenOfertaIndependiente") && row["ImagenOfertaIndependiente"] != DBNull.Value)
                ImagenOfertaIndependiente = row["ImagenOfertaIndependiente"].ToString();

            if (DataRecord.HasColumn(row, "FlagValidarImagen") && row["FlagValidarImagen"] != DBNull.Value)
                FlagValidarImagen = Convert.ToInt32(row["FlagValidarImagen"]);

            if (DataRecord.HasColumn(row, "PesoMaximoImagen") && row["PesoMaximoImagen"] != DBNull.Value)
                PesoMaximoImagen = Convert.ToInt32(row["PesoMaximoImagen"]);
        }

    }
}
