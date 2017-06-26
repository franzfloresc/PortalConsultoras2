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
        private int _LimUnidades; 
        private int _Activo;
        private string _CUVPrecioTachado;
        private decimal _PrecioTachado;

        public BEReporteValidacion(IDataRecord dataRecord)
        {
            _TipoPersonalizacion = Convert.ToString(dataRecord["TipoPersonalizacion"]);
            _CUV2 = Convert.ToString(dataRecord["CUV2"]);
            _AnioCampanaVenta = Convert.ToString(dataRecord["AnioCampanaVenta"]);
            _CodPais = Convert.ToString(dataRecord["CodPais"]);
            _DescripcionCUV2 = Convert.ToString(dataRecord["DescripcionCUV2"]);
            _DescripcionCorta = Convert.ToString(dataRecord["DescripcionCorta"]);
            _ImagenUrl = Convert.ToString(dataRecord["ImagenUrl"]);
            _PrecioNormal = Convert.ToDecimal(dataRecord["PrecioNormal"]);
            _PrecioOfertaDigital = Convert.ToDecimal(dataRecord["PrecioOfertaDigital"]);
            _LimUnidades = Convert.ToInt32(dataRecord["LimUnidades"]);
            _Activo = Convert.ToInt32(dataRecord["Activo"]);
            _CUVPrecioTachado = Convert.ToString(dataRecord["CUVPrecioTachado"]);
            _PrecioTachado = Convert.ToDecimal(dataRecord["PrecioTachado"]);
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
            get { return DescripcionCorta; }
            set { DescripcionCorta = value; }
        }

        [DataMember]
        public string ImagenUrl
        {
            get { return ImagenUrl; }
            set { ImagenUrl = value; }
        }

        [DataMember]
        public decimal PrecioNormal
        {
            get { return PrecioNormal; }
            set { PrecioNormal = value; }
        }

        [DataMember]
        public decimal PrecioOfertaDigital
        {
            get { return _PrecioOfertaDigital; }
            set { _PrecioOfertaDigital = value; }
        }

        [DataMember]
        public int LimUnidades
        {
            get { return _LimUnidades; }
            set { _LimUnidades = value; }
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
