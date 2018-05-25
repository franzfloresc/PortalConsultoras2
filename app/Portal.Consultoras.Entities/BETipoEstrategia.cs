using Portal.Consultoras.Common;

using System;
using System.Data;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETipoEstrategia
    {
        private int miFlagActivo;

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        [Column("OfertaID")]
        public string OfertaID { get; set; }

        [DataMember]
        [Column("DescripcionOferta")]
        public string DescripcionOferta { get; set; }

        [DataMember]
        [Column("TipoEstrategiaID")]
        public int TipoEstrategiaID { get; set; }

        [DataMember]
        [Column("DescripcionEstrategia")]
        public string DescripcionEstrategia { get; set; }

        [DataMember]
        [Column("ImagenEstrategia")]
        public string ImagenEstrategia { get; set; }

        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }

        [Column("FlagActivo")]
        public bool _FlagActivo { get; set; }
        [DataMember]
        public int FlagActivo
        {
            get
            {
                return (_FlagActivo ? 1 : miFlagActivo);
            }
            set
            {
                miFlagActivo = value;
            }
        }

        [DataMember]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [Column("FlagNueva")]
        public int FlagNueva { get; set; }

        [DataMember]
        [Column("FlagRecoPerfil")]
        public int FlagRecoPerfil { get; set; }

        [DataMember]
        [Column("FlagRecoProduc")]
        public int FlagRecoProduc { get; set; }

        [DataMember]
        [Column("CodigoPrograma")]
        public string CodigoPrograma { get; set; }

        [DataMember]
        [Column("FlagMostrarImg")]
        public int FlagMostrarImg { get; set; }

        [DataMember]
        [Column("CodigoGeneral")]
        public int CodigoGeneral { get; set; }

        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("MostrarImgOfertaIndependiente")]
        public bool MostrarImgOfertaIndependiente { get; set; }

        [DataMember]
        [Column("ImagenOfertaIndependiente")]
        public string ImagenOfertaIndependiente { get; set; }

        [DataMember]
        [Column("FlagValidarImagen")]
        public int FlagValidarImagen { get; set; }

        [DataMember]
        [Column("PesoMaximoImagen")]
        public int PesoMaximoImagen { get; set; }

        [DataMember]
        [Column("MensajeValidacion")]
        public string MensajeValidacion { get; set; }

        [DataMember]
        [Column("NombreComercial")]
        public string NombreComercial { get; set; }


        [Obsolete("Use MapUtil.MapToCollection")]
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
        }

        public BETipoEstrategia()
        {
        }
    }
}
