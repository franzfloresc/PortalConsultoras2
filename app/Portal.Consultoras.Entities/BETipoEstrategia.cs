using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

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
        public int FlagMostrarImg { get; set; }      // SB2-353 

        [DataMember]
        public int CodigoGeneral { get; set; }

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

            if (DataRecord.HasColumn(row, "FlagActivo") && row["FlagActivo"] != DBNull.Value)
                FlagActivo = Convert.ToInt32(row["FlagActivo"]);

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

            if(DataRecord.HasColumn(row, "CodigoPrograma") && row["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = Convert.ToString(row["CodigoPrograma"]);

            // SB2-353
            if (DataRecord.HasColumn(row, "FlagMostrarImg") && row["FlagMostrarImg"] != DBNull.Value)
                FlagMostrarImg = Convert.ToInt32(row["FlagMostrarImg"]);

            if (DataRecord.HasColumn(row, "CodigoGeneral") && row["CodigoGeneral"] != DBNull.Value)
                CodigoGeneral = Convert.ToInt32(row["CodigoGeneral"]);
        }

    }
}
