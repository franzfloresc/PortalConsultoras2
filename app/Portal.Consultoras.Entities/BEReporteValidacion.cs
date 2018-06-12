using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEReporteValidacion
    {
        public BEReporteValidacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoEstrategia"))
                TipoPersonalizacion = Convert.ToString(row["TipoEstrategia"]);

            if (DataRecord.HasColumn(row, "CUV2"))
                CUV2 = Convert.ToString(row["CUV2"]);

            if (DataRecord.HasColumn(row, "CampaniaID"))
                AnioCampanaVenta = Convert.ToString(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "Pais"))
                CodPais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV2"))
                DescripcionCUV2 = Convert.ToString(row["DescripcionCUV2"]);

            if (DataRecord.HasColumn(row, "DescripcionCorta"))
                DescripcionCorta = Convert.ToString(row["DescripcionCorta"]);

            if (DataRecord.HasColumn(row, "ImagenUrl"))
                ImagenUrl = Convert.ToString(row["ImagenUrl"]);

            if (DataRecord.HasColumn(row, "PrecioNormal"))
                PrecioNormal = Convert.ToDecimal(row["PrecioNormal"]);

            if (DataRecord.HasColumn(row, "PrecioOfertaDigital"))
                PrecioOfertaDigital = Convert.ToDecimal(row["PrecioOfertaDigital"]);

            if (DataRecord.HasColumn(row, "LimiteVenta"))
                LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToInt32(row["Activo"]);

            if (DataRecord.HasColumn(row, "CUVPrecioTachado"))
                CUVPrecioTachado = Convert.ToString(row["CUVPrecioTachado"]);

            if (DataRecord.HasColumn(row, "PrecioTachado"))
                PrecioTachado = Convert.ToDecimal(row["PrecioTachado"]);
        }

        #region Member Properties
        [DataMember]
        public string TipoPersonalizacion { get; set; }

        [DataMember]
        public string AnioCampanaVenta { get; set; }

        [DataMember]
        public string CUV2 { get; set; }

        [DataMember]
        public string CodPais { get; set; }

        [DataMember]
        public string DescripcionCUV2 { get; set; }

        [DataMember]
        public string DescripcionCorta { get; set; }

        [DataMember]
        public string ImagenUrl { get; set; }

        [DataMember]
        public decimal PrecioNormal { get; set; }

        [DataMember]
        public decimal PrecioOfertaDigital { get; set; }

        [DataMember]
        public int LimiteVenta { get; set; }

        [DataMember]
        public int Activo { get; set; }

        [DataMember]
        public string CUVPrecioTachado { get; set; }

        [DataMember]
        public decimal PrecioTachado { get; set; }

        #endregion
    }

    [DataContract]
    public class BEReporteValidacionSRCampania
    {
        public BEReporteValidacionSRCampania(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Pais"))
                CodPais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "NombreEvento"))
                NombreEvento = Convert.ToString(row["NombreEvento"]);

            if (DataRecord.HasColumn(row, "DiasAntes"))
                DiasAntesFacturacion = Convert.ToInt32(row["DiasAntes"]);

            if (DataRecord.HasColumn(row, "DiasDespues"))
                DiasDespuesFacturacion = Convert.ToInt32(row["DiasDespues"]);

            if (DataRecord.HasColumn(row, "FlagHabilitarEvento"))
                FlagHabilitarEvento = Convert.ToInt32(row["FlagHabilitarEvento"]);

            if (DataRecord.HasColumn(row, "FlagHabilitarCompraXCompra"))
                FlagHabilitarCompraXCompra = Convert.ToInt32(row["FlagHabilitarCompraXCompra"]);

            if (DataRecord.HasColumn(row, "FlagHabilitarSubCampania"))
                FlagHabilitarSubCampania = Convert.ToInt32(row["FlagHabilitarSubCampania"]);
        }

        #region Reporte Validacion para ShowRoom
        [DataMember]
        public string CodPais { get; set; }

        [DataMember]
        public string Campania { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string NombreEvento { get; set; }

        [DataMember]
        public int DiasAntesFacturacion { get; set; }

        [DataMember]
        public int DiasDespuesFacturacion { get; set; }

        [DataMember]
        public int FlagHabilitarEvento { get; set; }

        [DataMember]
        public int FlagHabilitarCompraXCompra { get; set; }

        [DataMember]
        public int FlagHabilitarSubCampania { get; set; }

        #endregion


    }

    [DataContract]
    public class BEReporteValidacionSRPersonalizacion
    {
        public BEReporteValidacionSRPersonalizacion(IDataRecord row)
        {
            #region Reporte Validacion para ShowRoom Hoja 2
            if (DataRecord.HasColumn(row, "Personalizacion"))
                Personalizacion = Convert.ToString(row["Personalizacion"]);
            if (DataRecord.HasColumn(row, "Medio"))
                Medio = Convert.ToString(row["Medio"]);
            if (DataRecord.HasColumn(row, "BO"))
                BO = Convert.ToString(row["BO"]);
            if (DataRecord.HasColumn(row, "CL"))
                CL = Convert.ToString(row["CL"]);
            if (DataRecord.HasColumn(row, "CO"))
                CO = Convert.ToString(row["CO"]);
            if (DataRecord.HasColumn(row, "CR"))
                CR = Convert.ToString(row["CR"]);
            if (DataRecord.HasColumn(row, "DO"))
                DO = Convert.ToString(row["DO"]);
            if (DataRecord.HasColumn(row, "EC"))
                EC = Convert.ToString(row["EC"]);
            if (DataRecord.HasColumn(row, "GT"))
                GT = Convert.ToString(row["GT"]);
            if (DataRecord.HasColumn(row, "MX"))
                MX = Convert.ToString(row["MX"]);
            if (DataRecord.HasColumn(row, "PA"))
                PA = Convert.ToString(row["PA"]);
            if (DataRecord.HasColumn(row, "PE"))
                PE = Convert.ToString(row["PE"]);
            if (DataRecord.HasColumn(row, "PR"))
                PR = Convert.ToString(row["PR"]);
            if (DataRecord.HasColumn(row, "SV"))
                SV = Convert.ToString(row["SV"]);
            if (DataRecord.HasColumn(row, "VE"))
                VE = Convert.ToString(row["VE"]);
            #endregion
        }

        #region Reporte Validacion para ShowRoom

        [DataMember]
        public string Personalizacion { get; set; }

        [DataMember]
        public string Medio { get; set; }

        [DataMember]
        public string BO { get; set; }

        [DataMember]
        public string CL { get; set; }

        [DataMember]
        public string CO { get; set; }

        [DataMember]
        public string CR { get; set; }

        [DataMember]
        public string DO { get; set; }

        [DataMember]
        public string EC { get; set; }

        [DataMember]
        public string GT { get; set; }

        [DataMember]
        public string MX { get; set; }

        [DataMember]
        public string PA { get; set; }

        [DataMember]
        public string PE { get; set; }

        [DataMember]
        public string PR { get; set; }

        [DataMember]
        public string SV { get; set; }

        [DataMember]
        public string VE { get; set; }

        #endregion


    }

    [DataContract]
    public class BEReporteValidacionSROferta
    {
        public BEReporteValidacionSROferta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Pais"))
                CodPais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "CodigoTO"))
                CodigoTO = Convert.ToString(row["CodigoTO"]);

            if (DataRecord.HasColumn(row, "SAP"))
                CodigoSAP = Convert.ToString(row["SAP"]);

            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);

            if (DataRecord.HasColumn(row, "PrecioValorizado"))
                PrecioValorizado = Convert.ToDecimal(row["PrecioValorizado"]);

            if (DataRecord.HasColumn(row, "PrecioOferta"))
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);

            if (DataRecord.HasColumn(row, "UnidadesPermitidas"))
                UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);

            if (DataRecord.HasColumn(row, "EsSubCampania"))
                EsSubCampania = Convert.ToInt32(row["EsSubCampania"]);

            if (DataRecord.HasColumn(row, "HabilitarOferta"))
                HabilitarOferta = Convert.ToInt32(row["HabilitarOferta"]);

            if (DataRecord.HasColumn(row, "FlagImagenCargada"))
                FlagImagenCargada = Convert.ToInt32(row["FlagImagenCargada"]);

            if (DataRecord.HasColumn(row, "FlagImagenMINI"))
                FlagImagenMINI = Convert.ToInt32(row["FlagImagenMINI"]);
        }

        #region Reporte Validacion para ShowRoom
        [DataMember]
        public string CodPais { get; set; }

        [DataMember]
        public string Campania { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string CodigoTO { get; set; }

        [DataMember]
        public string CodigoSAP { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public decimal PrecioValorizado { get; set; }

        [DataMember]
        public decimal PrecioOferta { get; set; }

        [DataMember]
        public int UnidadesPermitidas { get; set; }

        [DataMember]
        public int EsSubCampania { get; set; }

        [DataMember]
        public int HabilitarOferta { get; set; }

        [DataMember]
        public int FlagImagenCargada { get; set; }

        [DataMember]
        public int FlagImagenMINI { get; set; }

        #endregion


    }

    [DataContract]
    public class BEReporteValidacionSRComponentes
    {
        public BEReporteValidacionSRComponentes(IDataRecord row)
        {

            if (DataRecord.HasColumn(row, "Pais"))
                CodPais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);

            if (DataRecord.HasColumn(row, "Descripcion1"))
                Descripcion1 = Convert.ToString(row["Descripcion1"]);

            if (DataRecord.HasColumn(row, "FlagImagenCargada"))
                FlagImagenCargada = Convert.ToString(row["FlagImagenCargada"]);
        }

        #region Reporte Validacion para ShowRoom
        [DataMember]
        public string CodPais { get; set; }

        [DataMember]
        public string Campania { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string Descripcion1 { get; set; }

        [DataMember]
        public string FlagImagenCargada { get; set; }

        #endregion


    }

}
