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
            TipoPersonalizacion = row.ToString("TipoEstrategia");
            CUV2 = row.ToString("CUV2");
            AnioCampanaVenta = row.ToString("CampaniaID");
            CodPais = row.ToString("Pais");
            DescripcionCUV2 = row.ToString("DescripcionCUV2");
            DescripcionCorta = row.ToString("DescripcionCorta");
            ImagenUrl = row.ToString("ImagenUrl");
            PrecioNormal = row.ToDecimal("PrecioNormal");
            PrecioOfertaDigital = row.ToDecimal("PrecioOfertaDigital");
            LimiteVenta = row.ToInt32("LimiteVenta");
            Activo = row.ToInt32("Activo");
            CUVPrecioTachado = row.ToString("CUVPrecioTachado");
            PrecioTachado = row.ToDecimal("PrecioTachado");
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
            
                CodPais = row.ToString("Pais");

            
                Campania = row.ToString("Campania");

            
                CUV = row.ToString("CUV");

            
                NombreEvento = row.ToString("NombreEvento");

            
                DiasAntesFacturacion = row.ToInt32("DiasAntes");

            
                DiasDespuesFacturacion = row.ToInt32("DiasDespues");

            
                FlagHabilitarEvento = row.ToInt32("FlagHabilitarEvento");

            
                FlagHabilitarCompraXCompra = row.ToInt32("FlagHabilitarCompraXCompra");

            
                FlagHabilitarSubCampania = row.ToInt32("FlagHabilitarSubCampania");
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
            
                Personalizacion = row.ToString("Personalizacion");
            
                Medio = row.ToString("Medio");
            
                BO = row.ToString("BO");
            
                CL = row.ToString("CL");
            
                CO = row.ToString("CO");
            
                CR = row.ToString("CR");
            
                DO = row.ToString("DO");
            
                EC = row.ToString("EC");
            
                GT = row.ToString("GT");
            
                MX = row.ToString("MX");
            
                PA = row.ToString("PA");
            
                PE = row.ToString("PE");
            
                PR = row.ToString("PR");
            
                SV = row.ToString("SV");
            
                VE = row.ToString("VE");
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
            
                CodPais = row.ToString("Pais");

            
                Campania = row.ToString("Campania");

            
                CUV = row.ToString("CUV");

            
                CodigoTO = row.ToString("CodigoTO");

            
                CodigoSAP = row.ToString("SAP");

            
                Descripcion = row.ToString("Descripcion");

            
                PrecioValorizado = row.ToDecimal("PrecioValorizado");

            
                PrecioOferta = row.ToDecimal("PrecioOferta");

            
                UnidadesPermitidas = row.ToInt32("UnidadesPermitidas");

            
                EsSubCampania = row.ToInt32("EsSubCampania");

            
                HabilitarOferta = row.ToInt32("HabilitarOferta");

            
                FlagImagenCargada = row.ToInt32("FlagImagenCargada");

            
                FlagImagenMINI = row.ToInt32("FlagImagenMINI");
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

            
                CodPais = row.ToString("Pais");

            
                Campania = row.ToString("Campania");

            
                CUV = row.ToString("CUV");

            
                Nombre = row.ToString("Nombre");

            
                Descripcion1 = row.ToString("Descripcion1");

            
                FlagImagenCargada = row.ToString("FlagImagenCargada");
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
