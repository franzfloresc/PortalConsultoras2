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

        #region Reporte Validacion para ShowRoom
        private string _Pais;
        private string _Campania;
        private string _CUV;
        #endregion

        #region Reporte Validacion para ShowRoom Hoja 1
        private string _NombreEvento;
        private int _DiasAntesFacturacion;
        private int _DiasDespuesFacturacion;
        private int _FlagHabilitarEvento;
        private int _FlagHabilitarCompraXCompra;
        private int _FlagHabilitarSubCampania;
        #endregion

        #region Reporte Validacion para ShowRoom Hoja 2
        #endregion

        #region Reporte Validacion para ShowRoom Hoja 3
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

        #region Reporte Validacion para ShowRoom Hoja 4
        private string _Nombre;
        private string _Descripcion1;
        private string _Descripcion2;
        private string _Descripcion3;
        #endregion

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
                //*************************SHOW ROOM *****************************   <<< 1 >>>
                #region Reporte Validacion para ShowRoom Hoja 1
                if (DataRecord.HasColumn(row, "Campania") && row["Campania"] != DBNull.Value)
                   _Campania = Convert.ToString(row["Campania"]);

                if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                    _CUV = Convert.ToString(row["CUV"]);

                if (DataRecord.HasColumn(row, "NombreEvento") && row["NombreEvento"] != DBNull.Value)
                     _NombreEvento = Convert.ToString(row["NombreEvento"]);

                if (DataRecord.HasColumn(row, "DiasAntes") && row["DiasAntes"] != DBNull.Value)
                    _DiasAntesFacturacion = Convert.ToInt32(row["DiasAntes"]);

                if (DataRecord.HasColumn(row, "DiasDespues") && row["DiasDespues"] != DBNull.Value)
                   _DiasAntesFacturacion = Convert.ToInt32(row["DiasDespues"]);

                if (DataRecord.HasColumn(row, "FlagHabilitarEvento") && row["FlagHabilitarEvento"] != DBNull.Value)
                   _FlagHabilitarEvento = Convert.ToInt32(row["FlagHabilitarEvento"]);

                if (DataRecord.HasColumn(row, "FlagHabilitarCompraXCompra") && row["FlagHabilitarCompraXCompra"] != DBNull.Value)
                   _FlagHabilitarCompraXCompra = Convert.ToInt32(row["FlagHabilitarCompraXCompra"]);

                if (DataRecord.HasColumn(row, "FlagHabilitarSubCampania") && row["FlagHabilitarSubCampania"] != DBNull.Value)
                   _FlagHabilitarSubCampania = Convert.ToInt32(row["FlagHabilitarSubCampania"]);
            #endregion
            //*************************SHOW ROOM *****************************   <<< 3 >>>
            #region Reporte Validacion para ShowRoom Hoja 3

            if (DataRecord.HasColumn(row, "CodigoTO") && row["CodigoTO"] != DBNull.Value)
                    _CodigoTO = Convert.ToString(row["CodigoTO"]);

                if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                    _Descripcion = Convert.ToString(row["Descripcion"]);

                if (DataRecord.HasColumn(row, "PrecioValorizado") && row["PrecioValorizado"] != DBNull.Value)
                    _PrecioValorizado = Convert.ToDecimal(row["PrecioValorizado"]);

                if (DataRecord.HasColumn(row, "PrecioOferta") && row["PrecioOferta"] != DBNull.Value)
                    _PrecioOferta = Convert.ToInt32(row["PrecioOferta"]);

                if (DataRecord.HasColumn(row, "UnidadesPermitidas") && row["UnidadesPermitidas"] != DBNull.Value)
                    _UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);

                if (DataRecord.HasColumn(row, "EsSubCampania") && row["EsSubCampania"] != DBNull.Value)
                    _UnidadesPermitidas = Convert.ToInt32(row["EsSubCampania"]);

                if (DataRecord.HasColumn(row, "HabilitarOferta") && row["HabilitarOferta"] != DBNull.Value)
                    _HabilitarOferta = Convert.ToInt32(row["HabilitarOferta"]);

                if (DataRecord.HasColumn(row, "FlagImagenCargada") && row["FlagImagenCargada"] != DBNull.Value)
                    _HabilitarOferta = Convert.ToInt32(row["FlagImagenCargada"]);

                if (DataRecord.HasColumn(row, "FlagImagenMINI") && row["FlagImagenMINI"] != DBNull.Value)
                    _FlagImagenMINI = Convert.ToInt32(row["FlagImagenMINI"]);

            #endregion
            //*************************SHOW ROOM *****************************   <<< 4 >>>
            #region Reporte Validacion para ShowRoom Hoja 4

            if (DataRecord.HasColumn(row, "Nombre") && row["Nombre"] != DBNull.Value)
                    _Nombre = Convert.ToString(row["Nombre"]);

                if (DataRecord.HasColumn(row, "Descripcion1") && row["Descripcion1"] != DBNull.Value)
                    _Descripcion1 = Convert.ToString(row["Descripcion1"]);

                if (DataRecord.HasColumn(row, "Descripcion2") && row["Descripcion2"] != DBNull.Value)
                    _Descripcion2 = Convert.ToString(row["Descripcion2"]);

                if (DataRecord.HasColumn(row, "Descripcion3") && row["Descripcion3"] != DBNull.Value)
                    _Descripcion3 = Convert.ToString(row["Descripcion3"]);

                #endregion
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



        #region Reporte Validacion para ShowRoom
        [DataMember]
        public string Pais
        {
            get { return _Pais; }
            set { _Pais = value; }
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
        #endregion

        #region Reporte Validacion para ShowRoom Hoja 1
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

        #region Reporte Validacion para ShowRoom Hoja 2
        #endregion

        #region Reporte Validacion para ShowRoom Hoja 3

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

        #region Reporte Validacion para ShowRoom Hoja 4

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
        public string Descripcion2
        {
            get { return _Descripcion2; }
            set { _Descripcion2 = value; }
        }

        [DataMember]
        public string Descripcion3
        {
            get { return _Descripcion3; }
            set { _Descripcion3 = value; }
        }

        #endregion
    }
}
