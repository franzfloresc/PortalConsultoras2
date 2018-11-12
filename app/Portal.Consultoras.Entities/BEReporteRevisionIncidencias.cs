using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEReporteCuvResumido
    {
        public BEReporteCuvResumido(IDataRecord row)
        {
            Cuv = row.ToString("Cuv");
            SAP = row.ToString("SAP");
            DescripcionProd = row.ToString("DescripcionProd");
            Palanca = row.ToString("Palanca");
            imagenURL = row.ToString("imagenURL");
            Activo = row.ToString("Activo");
            PuedeDigitarse = row.ToString("PuedeDigitarse");
            PrecioSet = row.ToDecimal("PrecioSet");
        }

        #region Member Properties
        [DataMember]
        public string Cuv { get; set; }

        [DataMember]
        public string SAP { get; set; }

        [DataMember]
        public string DescripcionProd { get; set; }

        [DataMember]
        public string Palanca { get; set; }

        [DataMember]
        public string imagenURL { get; set; }

        [DataMember]
        public string Activo { get; set; }

        [DataMember]
        public string PuedeDigitarse { get; set; }

        [DataMember]
        public decimal PrecioSet { get; set; }

        #endregion
    }

    [DataContract]
    public class BEReporteCuvDetallado
    {
        public BEReporteCuvDetallado(IDataRecord row)
        {
            CuvPadre = row.ToString("CuvPadre");
            CuvHijo = row.ToString("CuvHijo");
            CodigoEstrategia = row.ToString("CodigoEstrategia");
            Grupo = row.ToString("Grupo");
            SAP = row.ToString("SAP");
            MarcaEstrategia = row.ToString("MarcaEstrategia");
            MarcaMatriz = row.ToString("MarcaMatriz");
            FactorCuadre = row.ToInt32("FactorCuadre");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
            PrecioPublico = row.ToDecimal("PrecioPublico");
            Digitable = row.ToInt32("Digitable");
            NombreProducto = row.ToString("NombreProducto");
            ImagenTipos = row.ToString("ImagenTipos");
            ImagenTonos = row.ToString("ImagenTonos");
            NombreBulk = row.ToString("NombreBulk");
        }

        #region Member Properties
        [DataMember]
        public string CuvPadre { get; set; }

        [DataMember]
        public string CuvHijo { get; set; }

        [DataMember]
        public string CodigoEstrategia { get; set; }

        [DataMember]
        public string Grupo { get; set; }

        [DataMember]
        public string SAP { get; set; }

        [DataMember]
        public string MarcaEstrategia { get; set; }

        [DataMember]
        public string MarcaMatriz { get; set; }

        [DataMember]
        public int FactorCuadre { get; set; }

        [DataMember]
        public decimal PrecioUnitario { get; set; }

        [DataMember]
        public decimal PrecioPublico { get; set; }

        [DataMember]
        public int Digitable { get; set; }

        [DataMember]
        public string NombreProducto { get; set; }

        [DataMember]
        public string ImagenTipos { get; set; }
        [DataMember]
        public string ImagenTonos { get; set; }
        [DataMember]
        public string NombreBulk { get; set; }

        #endregion
    }

    [DataContract]
    public class BEReporteMovimientosPedido
    {
        public BEReporteMovimientosPedido(IDataRecord row)
        {
            Cuv = row.ToString("Cuv");
            Descripcion = row.ToString("Descripcion");
            FechaAccion = row.ToString("FechaAccion");
            Origen = row.ToString("Origen");
            Mensaje = row.ToString("Mensaje");
        }

        #region Member Properties
        [DataMember]
        public string Cuv { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string FechaAccion { get; set; }

        [DataMember]
        public string Origen { get; set; }

        [DataMember]
        public string Mensaje { get; set; }

        #endregion
    }

    [DataContract]
    public class BEReporteEstrategiasPorConsultora
    {
        public BEReporteEstrategiasPorConsultora(IDataRecord row)
        {
            CUV = row.ToString("CUV");
            Descripcion = row.ToString("Descripcion");
        }

        #region Member Properties
        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        #endregion
    }
}
