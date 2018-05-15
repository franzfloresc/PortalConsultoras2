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

        [DataMember]
        public string MensajeValidacion { get; set; }

        public BETipoEstrategia(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoEstrategiaID"))
                TipoEstrategiaID = Convert.ToInt32(row["TipoEstrategiaID"]);

            if (DataRecord.HasColumn(row, "DescripcionEstrategia"))
                DescripcionEstrategia = Convert.ToString(row["DescripcionEstrategia"]);

            if (DataRecord.HasColumn(row, "DescripcionOferta"))
                DescripcionOferta = Convert.ToString(row["DescripcionOferta"]);

            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);

            if (DataRecord.HasColumn(row, "FlagActivo"))
                FlagActivo = Convert.ToInt32(row["FlagActivo"]);

            if (DataRecord.HasColumn(row, "OfertaID") )
                OfertaID = Convert.ToString(row["OfertaID"]);

            if (DataRecord.HasColumn(row, "ImagenEstrategia"))
                ImagenEstrategia = Convert.ToString(row["ImagenEstrategia"]);

            if (DataRecord.HasColumn(row, "FlagNueva"))
                FlagNueva = Convert.ToInt32(row["FlagNueva"]);

            if (DataRecord.HasColumn(row, "FlagRecoPerfil"))
                FlagRecoPerfil = Convert.ToInt32(row["FlagRecoPerfil"]);

            if (DataRecord.HasColumn(row, "FlagRecoProduc"))
                FlagRecoProduc = Convert.ToInt32(row["FlagRecoProduc"]);

            if (DataRecord.HasColumn(row, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(row["CodigoPrograma"]);

            if (DataRecord.HasColumn(row, "FlagMostrarImg"))
                FlagMostrarImg = Convert.ToInt32(row["FlagMostrarImg"]);

            if (DataRecord.HasColumn(row, "CodigoGeneral"))
                CodigoGeneral = Convert.ToInt32(row["CodigoGeneral"]);

            if (DataRecord.HasColumn(row, "Codigo"))
                Codigo = Convert.ToString(row["Codigo"]);

            if (DataRecord.HasColumn(row, "MostrarImgOfertaIndependiente"))
                MostrarImgOfertaIndependiente = Convert.ToBoolean(row["MostrarImgOfertaIndependiente"]);

            if (DataRecord.HasColumn(row, "ImagenOfertaIndependiente"))
                ImagenOfertaIndependiente = Convert.ToString(row["ImagenOfertaIndependiente"]);

            if (DataRecord.HasColumn(row, "FlagValidarImagen"))
                FlagValidarImagen = Convert.ToInt32(row["FlagValidarImagen"]);

            if (DataRecord.HasColumn(row, "PesoMaximoImagen"))
                PesoMaximoImagen = Convert.ToInt32(row["PesoMaximoImagen"]);

            if (DataRecord.HasColumn(row, "MensajeValidacion"))
                MensajeValidacion = Convert.ToString(row["MensajeValidacion"]);
        }

        public BETipoEstrategia()
        {
        }
    }
}
