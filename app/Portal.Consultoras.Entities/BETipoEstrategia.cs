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
            TipoEstrategiaID = row.ToInt32("TipoEstrategiaID");
            DescripcionEstrategia = row.ToString("DescripcionEstrategia");
            DescripcionOferta = row.ToString("DescripcionOferta");
            Orden = row.ToInt32("Orden");
            FlagActivo = row.ToInt32("FlagActivo");
            if (DataRecord.HasColumn(row, "OfertaID") )
                OfertaID = Convert.ToString(row["OfertaID"]);
            ImagenEstrategia = row.ToString("ImagenEstrategia");
            FlagNueva = row.ToInt32("FlagNueva");
            FlagRecoPerfil = row.ToInt32("FlagRecoPerfil");
            FlagRecoProduc = row.ToInt32("FlagRecoProduc");
            CodigoPrograma = row.ToString("CodigoPrograma");
            FlagMostrarImg = row.ToInt32("FlagMostrarImg");
            CodigoGeneral = row.ToInt32("CodigoGeneral");
            Codigo = row.ToString("Codigo");
            MostrarImgOfertaIndependiente = row.ToBoolean("MostrarImgOfertaIndependiente");
            ImagenOfertaIndependiente = row.ToString("ImagenOfertaIndependiente");
            FlagValidarImagen = row.ToInt32("FlagValidarImagen");
            PesoMaximoImagen = row.ToInt32("PesoMaximoImagen");
        }

        public BETipoEstrategia()
        {
        }
    }
}
