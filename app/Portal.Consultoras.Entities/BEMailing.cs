﻿using Portal.Consultoras.Common;
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
            if (DataRecord.HasColumn(row, "PlantillaID"))
                PlantillaID = Convert.ToInt32(row["PlantillaID"]);

            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);

            if (DataRecord.HasColumn(row, "NombrePais") && row["NombrePais"] != DBNull.Value)
                NombrePais = Convert.ToString(row["NombrePais"]);

            if (DataRecord.HasColumn(row, "PlantillaDetalle"))
                PlantillaDetalle = Convert.ToString(row["PlantillaDetalle"]);

            if (DataRecord.HasColumn(row, "UsuarioCreacion") && row["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = Convert.ToString(row["UsuarioCreacion"]);

            if (DataRecord.HasColumn(row, "FechaCreacion") && row["FechaCreacion"] != DBNull.Value)
                FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]);

            if (DataRecord.HasColumn(row, "UsuarioModificacion") && row["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);

            if (DataRecord.HasColumn(row, "FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);

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
            if (DataRecord.HasColumn(row, "PlantillaID") && row["PlantillaID"] != DBNull.Value)
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
            if (DataRecord.HasColumn(row, "ID") && row["ID"] != DBNull.Value)
                ID = Convert.ToInt32(row["ID"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "PaisID") && row["PaisID"] != DBNull.Value)
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "RegionID") && row["RegionID"] != DBNull.Value)
                RegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "SeccionID") && row["SeccionID"] != DBNull.Value)
                SeccionID = Convert.ToInt32(row["SeccionID"]);
            if (DataRecord.HasColumn(row, "Plantilla") && row["Plantilla"] != DBNull.Value)
                Plantilla = Convert.ToString(row["Plantilla"]);
            if (DataRecord.HasColumn(row, "FechaEnvio") && row["FechaEnvio"] != DBNull.Value)
                FechaEnvio = Convert.ToDateTime(row["FechaEnvio"]);
            if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value)
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
            if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value)
                ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "PrimerNombre") && row["PrimerNombre"] != DBNull.Value)
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "Email") && row["Email"] != DBNull.Value)
                Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "RegionID") && row["RegionID"] != DBNull.Value)
                RegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "SeccionID") && row["SeccionID"] != DBNull.Value)
                SeccionID = Convert.ToInt32(row["SeccionID"]);
            if (DataRecord.HasColumn(row, "Codigo") && row["Codigo"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "PlantillaID") && row["PlantillaID"] != DBNull.Value)
                PlantillaID = Convert.ToInt32(row["PlantillaID"]);

        }


    }
}
