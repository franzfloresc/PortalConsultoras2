using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEReporteValidacion
    {
        private string _TipoPersonalizacion;
        private string _CUV2;
        private string _AnioCampanaVenta;
        private string _CodPais;
        private string _DescripcionCUV2;
        private string _DescripcionCorta;
        private string _ImagenUrl;
        private decimal _PrecioNormal;
        private decimal _PrecioOfertaDigital;
        private int _LimiteVenta; 
        private int _Activo;
        private string _CUVPrecioTachado;
        private decimal _PrecioTachado;

        public BEReporteValidacion(IDataRecord row)
        {
                if (DataRecord.HasColumn(row, "TipoEstrategia") && row["TipoEstrategia"] != DBNull.Value)
                    _TipoPersonalizacion = Convert.ToString(row["TipoEstrategia"]);

                if (DataRecord.HasColumn(row, "CUV2") && row["CUV2"] != DBNull.Value)
                    _CUV2 = Convert.ToString(row["CUV2"]);

                if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                    _AnioCampanaVenta = Convert.ToString(row["CampaniaID"]);

                if (DataRecord.HasColumn(row, "CodPais") && row["CodPais"] != DBNull.Value)
                    _CodPais = Convert.ToString(row["CodPais"]);

                if (DataRecord.HasColumn(row, "DescripcionCUV2") && row["DescripcionCUV2"] != DBNull.Value)
                    _DescripcionCUV2 = Convert.ToString(row["DescripcionCUV2"]);

                if (DataRecord.HasColumn(row, "DescripcionCorta") && row["DescripcionCorta"] != DBNull.Value)
                    _DescripcionCorta = Convert.ToString(row["DescripcionCorta"]);

                if (DataRecord.HasColumn(row, "ImagenUrl") && row["ImagenUrl"] != DBNull.Value)
                    _ImagenUrl = Convert.ToString(row["ImagenUrl"]);

                if (DataRecord.HasColumn(row, "PrecioNormal") && row["PrecioNormal"] != DBNull.Value)
                    _PrecioNormal = Convert.ToDecimal(row["PrecioNormal"]);

                if (DataRecord.HasColumn(row, "PrecioOfertaDigital") && row["PrecioOfertaDigital"] != DBNull.Value)
                    _PrecioOfertaDigital = Convert.ToDecimal(row["PrecioOfertaDigital"]);

                if (DataRecord.HasColumn(row, "LimiteVenta") && row["LimiteVenta"] != DBNull.Value)
                    _LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

                if (DataRecord.HasColumn(row, "Activo") && row["Activo"] != DBNull.Value)
                    _Activo = Convert.ToInt32(row["Activo"]);

                if (DataRecord.HasColumn(row, "CUVPrecioTachado") && row["CUVPrecioTachado"] != DBNull.Value)
                    _CUVPrecioTachado = Convert.ToString(row["CUVPrecioTachado"]);

                if (DataRecord.HasColumn(row, "PrecioTachado") && row["PrecioTachado"] != DBNull.Value)
                    _PrecioTachado = Convert.ToDecimal(row["PrecioTachado"]);
           
        }

        [DataMember]
        public string TipoPersonalizacion
        {
            get { return _TipoPersonalizacion; }
            set { _TipoPersonalizacion = value; }
        }

        [DataMember]
        public string AnioCampanaVenta
        {
            get { return _AnioCampanaVenta;  }
            set { _AnioCampanaVenta = value;  }
        }

        [DataMember]
        public string CUV2
        {
            get { return _CUV2; }
            set { _CUV2 = value; }
        }

        [DataMember]
        public string CodPais
        {
            get { return _CodPais; }
            set { _CodPais = value; }
        }

        [DataMember]
        public string DescripcionCUV2
        {
            get { return _DescripcionCUV2; }
            set { _DescripcionCUV2 = value; }
        }

        [DataMember]
        public string DescripcionCorta
        {
            get { return _DescripcionCorta; }
            set { _DescripcionCorta = value; }
        }

        [DataMember]
        public string ImagenUrl
        {
            get { return _ImagenUrl; }
            set { _ImagenUrl = value; }
        }

        [DataMember]
        public decimal PrecioNormal
        {
            get { return _PrecioNormal; }
            set { _PrecioNormal = value; }
        }

        [DataMember]
        public decimal PrecioOfertaDigital
        {
            get { return _PrecioOfertaDigital; }
            set { _PrecioOfertaDigital = value; }
        }

        [DataMember]
        public int LimiteVenta
        {
            get { return _LimiteVenta; }
            set { _LimiteVenta = value; }
        }

        [DataMember]
        public int Activo
        {
            get { return _Activo; }
            set { _Activo = value; }
        }

        [DataMember]
        public string CUVPrecioTachado
        {
            get { return _CUVPrecioTachado; }
            set { _CUVPrecioTachado = value; }
        }

        [DataMember]
        public decimal PrecioTachado
        {
            get { return _PrecioTachado; }
            set { _PrecioTachado = value; }
        }
    }
}
