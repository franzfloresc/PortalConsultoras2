using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEReporteValidacion
    {
        #region Reporte Validacion para OPT y ODD
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
        #endregion

        public BEReporteValidacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoEstrategia"))
                _TipoPersonalizacion = Convert.ToString(row["TipoEstrategia"]);

            if (DataRecord.HasColumn(row, "CUV2"))
                _CUV2 = Convert.ToString(row["CUV2"]);

            if (DataRecord.HasColumn(row, "CampaniaID"))
                _AnioCampanaVenta = Convert.ToString(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "Pais"))
                _CodPais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV2"))
                _DescripcionCUV2 = Convert.ToString(row["DescripcionCUV2"]);

            if (DataRecord.HasColumn(row, "DescripcionCorta"))
                _DescripcionCorta = Convert.ToString(row["DescripcionCorta"]);

            if (DataRecord.HasColumn(row, "ImagenUrl"))
                _ImagenUrl = Convert.ToString(row["ImagenUrl"]);

            if (DataRecord.HasColumn(row, "PrecioNormal"))
                _PrecioNormal = Convert.ToDecimal(row["PrecioNormal"]);

            if (DataRecord.HasColumn(row, "PrecioOfertaDigital"))
                _PrecioOfertaDigital = Convert.ToDecimal(row["PrecioOfertaDigital"]);

            if (DataRecord.HasColumn(row, "LimiteVenta"))
                _LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "Activo"))
                _Activo = Convert.ToInt32(row["Activo"]);

            if (DataRecord.HasColumn(row, "CUVPrecioTachado"))
                _CUVPrecioTachado = Convert.ToString(row["CUVPrecioTachado"]);

            if (DataRecord.HasColumn(row, "PrecioTachado"))
                _PrecioTachado = Convert.ToDecimal(row["PrecioTachado"]);
        }

        #region Member Properties
        [DataMember]
        public string TipoPersonalizacion
        {
            get { return _TipoPersonalizacion; }
            set { _TipoPersonalizacion = value; }
        }

        [DataMember]
        public string AnioCampanaVenta
        {
            get { return _AnioCampanaVenta; }
            set { _AnioCampanaVenta = value; }
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
        #endregion
    }

    [DataContract]
    public class BEReporteValidacionSRCampania
    {
        #region Reporte Validacion para ShowRoom
        private string _CodPais;
        private string _Campania;
        private string _CUV;
        private string _NombreEvento;
        private int _DiasAntesFacturacion;
        private int _DiasDespuesFacturacion;
        private int _FlagHabilitarEvento;
        private int _FlagHabilitarCompraXCompra;
        private int _FlagHabilitarSubCampania;
        #endregion

        public BEReporteValidacionSRCampania(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Pais"))
                _CodPais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania"))
                _Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "CUV"))
                _CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "NombreEvento"))
                _NombreEvento = Convert.ToString(row["NombreEvento"]);

            if (DataRecord.HasColumn(row, "DiasAntes"))
                _DiasAntesFacturacion = Convert.ToInt32(row["DiasAntes"]);

            if (DataRecord.HasColumn(row, "DiasDespues"))
                _DiasDespuesFacturacion = Convert.ToInt32(row["DiasDespues"]);

            if (DataRecord.HasColumn(row, "FlagHabilitarEvento"))
                _FlagHabilitarEvento = Convert.ToInt32(row["FlagHabilitarEvento"]);

            if (DataRecord.HasColumn(row, "FlagHabilitarCompraXCompra"))
                _FlagHabilitarCompraXCompra = Convert.ToInt32(row["FlagHabilitarCompraXCompra"]);

            if (DataRecord.HasColumn(row, "FlagHabilitarSubCampania"))
                _FlagHabilitarSubCampania = Convert.ToInt32(row["FlagHabilitarSubCampania"]);
        }

        #region Reporte Validacion para ShowRoom
        [DataMember]
        public string CodPais
        {
            get { return _CodPais; }
            set { _CodPais = value; }
        }

        [DataMember]
        public string Campania
        {
            get { return _Campania; }
            set { _Campania = value; }
        }

        [DataMember]
        public string CUV
        {
            get { return _CUV; }
            set { _CUV = value; }
        }

        [DataMember]
        public string NombreEvento
        {
            get { return _NombreEvento; }
            set { _NombreEvento = value; }
        }

        [DataMember]
        public int DiasAntesFacturacion
        {
            get { return _DiasAntesFacturacion; }
            set { _DiasAntesFacturacion = value; }
        }

        [DataMember]
        public int DiasDespuesFacturacion
        {
            get { return _DiasDespuesFacturacion; }
            set { _DiasDespuesFacturacion = value; }
        }

        [DataMember]
        public int FlagHabilitarEvento
        {
            get { return _FlagHabilitarEvento; }
            set { _FlagHabilitarEvento = value; }
        }

        [DataMember]
        public int FlagHabilitarCompraXCompra
        {
            get { return _FlagHabilitarCompraXCompra; }
            set { _FlagHabilitarCompraXCompra = value; }
        }

        [DataMember]
        public int FlagHabilitarSubCampania
        {
            get { return _FlagHabilitarSubCampania; }
            set { _FlagHabilitarSubCampania = value; }
        }
        #endregion


    }

    [DataContract]
    public class BEReporteValidacionSRPersonalizacion
    {
        #region Reporte Validacion para ShowRoom
        private string _Personalizacion;
        private string _Medio;
        private string _BO;
        private string _CL;
        private string _CO;
        private string _CR;
        private string _DO;
        private string _EC;
        private string _GT;
        private string _MX;
        private string _PA;
        private string _PE;
        private string _PR;
        private string _SV;
        private string _VE;
        #endregion

        public BEReporteValidacionSRPersonalizacion(IDataRecord row)
        {
            #region Reporte Validacion para ShowRoom Hoja 2
            if (DataRecord.HasColumn(row, "Personalizacion"))
                _Personalizacion = Convert.ToString(row["Personalizacion"]);
            if (DataRecord.HasColumn(row, "Medio"))
                _Medio = Convert.ToString(row["Medio"]);
            if (DataRecord.HasColumn(row, "BO"))
                _BO = Convert.ToString(row["BO"]);
            if (DataRecord.HasColumn(row, "CL"))
                _CL = Convert.ToString(row["CL"]);
            if (DataRecord.HasColumn(row, "CO"))
                _CO = Convert.ToString(row["CO"]);
            if (DataRecord.HasColumn(row, "CR"))
                _CR = Convert.ToString(row["CR"]);
            if (DataRecord.HasColumn(row, "DO"))
                _DO = Convert.ToString(row["DO"]);
            if (DataRecord.HasColumn(row, "EC"))
                _EC = Convert.ToString(row["EC"]);
            if (DataRecord.HasColumn(row, "GT"))
                _GT = Convert.ToString(row["GT"]);
            if (DataRecord.HasColumn(row, "MX"))
                _MX = Convert.ToString(row["MX"]);
            if (DataRecord.HasColumn(row, "PA"))
                _PA = Convert.ToString(row["PA"]);
            if (DataRecord.HasColumn(row, "PE"))
                _PE = Convert.ToString(row["PE"]);
            if (DataRecord.HasColumn(row, "PR"))
                _PR = Convert.ToString(row["PR"]);
            if (DataRecord.HasColumn(row, "SV"))
                _SV = Convert.ToString(row["SV"]);
            if (DataRecord.HasColumn(row, "VE"))
                _VE = Convert.ToString(row["VE"]);
            #endregion
        }

        #region Reporte Validacion para ShowRoom

        [DataMember]
        public string Personalizacion
        {
            get { return _Personalizacion; }
            set { _Personalizacion = value; }
        }

        [DataMember]
        public string Medio
        {
            get { return _Medio; }
            set { _Medio = value; }
        }

        [DataMember]
        public string BO
        {
            get { return _BO; }
            set { _BO = value; }
        }

        [DataMember]
        public string CL
        {
            get { return _CL; }
            set { _CL = value; }
        }

        [DataMember]
        public string CO
        {
            get { return _CO; }
            set { _CO = value; }
        }

        [DataMember]
        public string CR
        {
            get { return _CR; }
            set { _CR = value; }
        }

        [DataMember]
        public string DO
        {
            get { return _DO; }
            set { _DO = value; }
        }

        [DataMember]
        public string EC
        {
            get { return _EC; }
            set { _EC = value; }
        }

        [DataMember]
        public string GT
        {
            get { return _GT; }
            set { _GT = value; }
        }

        [DataMember]
        public string MX
        {
            get { return _MX; }
            set { _MX = value; }
        }

        [DataMember]
        public string PA
        {
            get { return _PA; }
            set { _PA = value; }
        }

        [DataMember]
        public string PE
        {
            get { return _PE; }
            set { _PE = value; }
        }

        [DataMember]
        public string PR
        {
            get { return _PR; }
            set { _PR = value; }
        }

        [DataMember]
        public string SV
        {
            get { return _SV; }
            set { _SV = value; }
        }

        [DataMember]
        public string VE
        {
            get { return _VE; }
            set { _VE = value; }
        }
        #endregion


    }

    [DataContract]
    public class BEReporteValidacionSROferta
    {
        #region Reporte Validacion para ShowRoom
        private string _CodPais;
        private string _Campania;
        private string _CUV;
        private string _CodigoTO;
        private string _CodigoSAP;
        private string _Descripcion;
        private decimal _PrecioValorizado;
        private decimal _PrecioOferta;
        private int _UnidadesPermitidas;
        private int _EsSubCampania;
        private int _HabilitarOferta;
        private int _FlagImagenCargada;
        private int _FlagImagenMINI;

        #endregion

        public BEReporteValidacionSROferta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Pais"))
                _CodPais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania"))
                _Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "CUV"))
                _CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "CodigoTO"))
                _CodigoTO = Convert.ToString(row["CodigoTO"]);

            if (DataRecord.HasColumn(row, "SAP"))
                _CodigoSAP = Convert.ToString(row["SAP"]);

            if (DataRecord.HasColumn(row, "Descripcion"))
                _Descripcion = Convert.ToString(row["Descripcion"]);

            if (DataRecord.HasColumn(row, "PrecioValorizado"))
                _PrecioValorizado = Convert.ToDecimal(row["PrecioValorizado"]);

            if (DataRecord.HasColumn(row, "PrecioOferta"))
                _PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);

            if (DataRecord.HasColumn(row, "UnidadesPermitidas"))
                _UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);

            if (DataRecord.HasColumn(row, "EsSubCampania"))
                _EsSubCampania = Convert.ToInt32(row["EsSubCampania"]);

            if (DataRecord.HasColumn(row, "HabilitarOferta"))
                _HabilitarOferta = Convert.ToInt32(row["HabilitarOferta"]);

            if (DataRecord.HasColumn(row, "FlagImagenCargada"))
                _FlagImagenCargada = Convert.ToInt32(row["FlagImagenCargada"]);

            if (DataRecord.HasColumn(row, "FlagImagenMINI"))
                _FlagImagenMINI = Convert.ToInt32(row["FlagImagenMINI"]);
        }

        #region Reporte Validacion para ShowRoom
        [DataMember]
        public string CodPais
        {
            get { return _CodPais; }
            set { _CodPais = value; }
        }

        [DataMember]
        public string Campania
        {
            get { return _Campania; }
            set { _Campania = value; }
        }

        [DataMember]
        public string CUV
        {
            get { return _CUV; }
            set { _CUV = value; }
        }

        [DataMember]
        public string CodigoTO
        {
            get { return _CodigoTO; }
            set { _CodigoTO = value; }
        }

        [DataMember]
        public string CodigoSAP
        {
            get { return _CodigoSAP; }
            set { _CodigoSAP = value; }
        }

        [DataMember]
        public string Descripcion
        {
            get { return _Descripcion; }
            set { _Descripcion = value; }
        }

        [DataMember]
        public decimal PrecioValorizado
        {
            get { return _PrecioValorizado; }
            set { _PrecioValorizado = value; }
        }

        [DataMember]
        public decimal PrecioOferta
        {
            get { return _PrecioOferta; }
            set { _PrecioOferta = value; }
        }

        [DataMember]
        public int UnidadesPermitidas
        {
            get { return _UnidadesPermitidas; }
            set { _UnidadesPermitidas = value; }
        }

        [DataMember]
        public int EsSubCampania
        {
            get { return _EsSubCampania; }
            set { _EsSubCampania = value; }
        }

        [DataMember]
        public int HabilitarOferta
        {
            get { return _HabilitarOferta; }
            set { _HabilitarOferta = value; }
        }

        [DataMember]
        public int FlagImagenCargada
        {
            get { return _FlagImagenCargada; }
            set { _FlagImagenCargada = value; }
        }

        [DataMember]
        public int FlagImagenMINI
        {
            get { return _FlagImagenMINI; }
            set { _FlagImagenMINI = value; }
        }

        #endregion


    }

    [DataContract]
    public class BEReporteValidacionSRComponentes
    {
        #region Reporte Validacion para ShowRoom
        private string _CodPais;
        private string _Campania;
        private string _CUV;
        private string _Nombre;
        private string _Descripcion1;
        private string _FlagImagenCargada;
        #endregion

        public BEReporteValidacionSRComponentes(IDataRecord row)
        {

            if (DataRecord.HasColumn(row, "Pais"))
                _CodPais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania"))
                _Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "CUV"))
                _CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "Nombre"))
                _Nombre = Convert.ToString(row["Nombre"]);

            if (DataRecord.HasColumn(row, "Descripcion1"))
                _Descripcion1 = Convert.ToString(row["Descripcion1"]);

            if (DataRecord.HasColumn(row, "FlagImagenCargada"))
                _FlagImagenCargada = Convert.ToString(row["FlagImagenCargada"]);
        }

        #region Reporte Validacion para ShowRoom
        [DataMember]
        public string CodPais
        {
            get { return _CodPais; }
            set { _CodPais = value; }
        }

        [DataMember]
        public string Campania
        {
            get { return _Campania; }
            set { _Campania = value; }
        }

        [DataMember]
        public string CUV
        {
            get { return _CUV; }
            set { _CUV = value; }
        }

        [DataMember]
        public string Nombre
        {
            get { return _Nombre; }
            set { _Nombre = value; }
        }

        [DataMember]
        public string Descripcion1
        {
            get { return _Descripcion1; }
            set { _Descripcion1 = value; }
        }

        [DataMember]
        public string FlagImagenCargada
        {
            get { return _FlagImagenCargada; }
            set { _FlagImagenCargada = value; }
        }

        #endregion


    }

}
