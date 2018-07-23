using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEstrategiaProducto
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int EstrategiaProductoID { get; set; }
        [DataMember]
        public int EstrategiaID { get; set; }
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        public string Grupo { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string CUV2 { get; set; }
        [DataMember]
        public string SAP { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal Precio { get; set; }
        [DataMember]
        public decimal PrecioValorizado { get; set; }
        [DataMember]
        public int Digitable { get; set; }
        [DataMember]
        public string CodigoError { get; set; }
        [DataMember]
        public string CodigoErrorObs { get; set; }
        [DataMember]
        public int FactorCuadre { get; set; }

        [DataMember]
        public string NombreProducto { get; set; }
        [DataMember]
        public string Descripcion1 { get; set; }
        [DataMember]
        public string ImagenProducto { get; set; }
        [DataMember]
        public int IdMarca { get; set; }
        [DataMember]
        public string NombreMarca { get; set; }
        [DataMember]
        public Int16 Activo { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public string NombreComercial { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Volumen { get; set; }
        [DataMember]
        public string ImagenBulk { get; set; }
        [DataMember]
        public string NombreBulk { get; set; }


        public BEEstrategiaProducto(IDataRecord row)
        {
            EstrategiaProductoID = DataRecord.GetColumn<int>(row, "EstrategiaProductoID");
            EstrategiaID = DataRecord.GetColumn<int>(row, "EstrategiaID");
            Campania = DataRecord.GetColumn<int>(row, "Campania");
            CUV = DataRecord.GetColumn<string>(row, "CUV");
            CUV2 = DataRecord.GetColumn<string>(row, "CUV2");
            SAP = DataRecord.GetColumn<string>(row, "SAP");
            Grupo = DataRecord.GetColumn<string>(row, "Grupo");
            Orden = DataRecord.GetColumn<int>(row, "Orden");
            Cantidad = DataRecord.GetColumn<int>(row, "Cantidad");
            Precio = DataRecord.GetColumn<decimal>(row, "Precio");
            PrecioValorizado = DataRecord.GetColumn<decimal>(row, "PrecioValorizado");
            Digitable = DataRecord.GetColumn<int>(row, "Digitable");
            CodigoEstrategia = DataRecord.GetColumn<string>(row, "CodigoEstrategia");
            CodigoError = DataRecord.GetColumn<string>(row, "CodigoError");
            CodigoErrorObs = DataRecord.GetColumn<string>(row, "CodigoErrorObs");
            FactorCuadre = DataRecord.GetColumn<int>(row, "FactorCuadre");
            NombreProducto = DataRecord.GetColumn<string>(row, "NombreProducto");
            Descripcion1 = DataRecord.GetColumn<string>(row, "Descripcion1");
            ImagenProducto = DataRecord.GetColumn<string>(row, "ImagenProducto");
            IdMarca = row.ToInt16("IdMarca");
            Activo = row.ToInt16("Activo");
            Digitable = row.ToInt16("Digitable");
            NombreMarca = DataRecord.GetColumn<string>(row, "NombreMarca");
            NombreComercial = DataRecord.GetColumn<string>(row, "NombreComercial");
            Descripcion = DataRecord.GetColumn<string>(row, "Descripcion");
            ImagenBulk = DataRecord.GetColumn<string>(row, "ImagenBulk");
            NombreBulk = DataRecord.GetColumn<string>(row, "NombreBulk");
        }
    }
}
