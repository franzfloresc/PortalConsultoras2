using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMailing
    {
        [DataMember]
        public int PlantillaID { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string NombrePais { get; set; }

        [DataMember]
        public string PlantillaDetalle { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        public BEMailing(IDataRecord row)
        {
            PlantillaID = row.ToInt32("PlantillaID");
            PaisID = row.ToInt32("PaisID");
            NombrePais = row.ToString("NombrePais");
            PlantillaDetalle = row.ToString("PlantillaDetalle");
            UsuarioCreacion = row.ToString("UsuarioCreacion");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
        }
    }

    [DataContract]
    public class BEPlantillasMailing
    {
        [DataMember]
        public int PlantillaID { get; set; }

        [DataMember]
        public string DescripcionTipo { get; set; }

        [DataMember]
        public string Disponibilidad { get; set; }

        [DataMember]
        public string PlantillaDetalle { get; set; }

        public BEPlantillasMailing(IDataReader row)
        {
            if (DataRecord.HasColumn(row, "PlantillaID"))
                PlantillaID = Convert.ToInt32(row["PlantillaID"]);

            if (DataRecord.HasColumn(row, "Descripcion"))
                DescripcionTipo = Convert.ToString(row["Descripcion"]);

            if (DataRecord.HasColumn(row, "DisponibilidadCampos"))
                Disponibilidad = Convert.ToString(row["DisponibilidadCampos"]);

            if (DataRecord.HasColumn(row, "PlantillaDetalle"))
                PlantillaDetalle = Convert.ToString(row["PlantillaDetalle"]);
        }
    }

    [DataContract]
    public class BELogEmailingAutomaticoSE
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string Correo { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public int SeccionID { get; set; }
        [DataMember]
        public string Plantilla { get; set; }
        [DataMember]
        public DateTime FechaEnvio { get; set; }
        [DataMember]
        public int ConsultoraID { get; set; }
        public BELogEmailingAutomaticoSE(IDataReader row)
        {
            if (DataRecord.HasColumn(row, "ID"))
                ID = Convert.ToInt32(row["ID"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "RegionID"))
                RegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "SeccionID"))
                SeccionID = Convert.ToInt32(row["SeccionID"]);
            if (DataRecord.HasColumn(row, "Plantilla"))
                Plantilla = Convert.ToString(row["Plantilla"]);
            if (DataRecord.HasColumn(row, "FechaEnvio"))
                FechaEnvio = Convert.ToDateTime(row["FechaEnvio"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);

        }
    }



    [DataContract]
    public class BEConsultoraMailing
    {
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public int SeccionID { get; set; }
        [DataMember]
        public int PlantillaID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string Plantilla { get; set; }
        public BEConsultoraMailing(IDataReader row)
        {
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "PrimerNombre"))
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "Email"))
                Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "RegionID"))
                RegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "SeccionID"))
                SeccionID = Convert.ToInt32(row["SeccionID"]);
            if (DataRecord.HasColumn(row, "Codigo"))
                CodigoConsultora = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "PlantillaID"))
                PlantillaID = Convert.ToInt32(row["PlantillaID"]);

        }


    }
}
