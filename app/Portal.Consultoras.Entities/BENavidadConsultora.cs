namespace Portal.Consultoras.Entities
{
    using Portal.Consultoras.Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BENavidadConsultora
    {
        [DataMember]
        public int ImagenId { get; set; }

        [DataMember]
        public int PaisId { get; set; }

        [DataMember]
        public int? CampaniaId { get; set; }


        [DataMember]
        public string NombreImg { get; set; }


        public BENavidadConsultora(IDataRecord row)
        {
            ImagenId = row.ToInt32("ImagenId");
            PaisId = row.ToInt32("PaisId");
            CampaniaId = row.ToInt32("CampaniaId");
            NombreImg = row.ToString("NombreImg");
        }

        //static byte[] ObtenerBytes(string str)
        //{
        //    byte[] bytes = new byte[str.Length * sizeof(char)];
        //    System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
        //    return bytes;
        //}
    }

}
