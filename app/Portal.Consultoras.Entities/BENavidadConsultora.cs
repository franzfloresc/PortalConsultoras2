﻿namespace Portal.Consultoras.Entities
{
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


        public BENavidadConsultora(IDataRecord iDataRecord)
        {
            ImagenId = Convert.ToInt32(iDataRecord["ImagenId"]);
            PaisId = Convert.ToInt32(iDataRecord["PaisId"]);
            CampaniaId = Convert.ToInt32(iDataRecord["CampaniaId"]);
            NombreImg = iDataRecord["NombreImg"].ToString();
        }

        static byte[] ObtenerBytes(string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }
    }

}
