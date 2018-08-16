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
            
                PlantillaID = row.ToInt32("PlantillaID");

            
                DescripcionTipo = row.ToString("Descripcion");

            
                Disponibilidad = row.ToString("DisponibilidadCampos");

            
                PlantillaDetalle = row.ToString("PlantillaDetalle");
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
            
                ID = row.ToInt32("ID");
            
                CodigoConsultora = row.ToString("CodigoConsultora");
            
                Correo = row.ToString("Correo");
            
                PaisID = row.ToInt32("PaisID");
            
                CampaniaID = row.ToInt32("CampaniaID");
            
                RegionID = row.ToInt32("RegionID");
            
                ZonaID = row.ToInt32("ZonaID");
            
                SeccionID = row.ToInt32("SeccionID");
            
                Plantilla = row.ToString("Plantilla");
            
                FechaEnvio = row.ToDateTime("FechaEnvio");
            
                ConsultoraID = row.ToInt32("ConsultoraID");

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
            
                ConsultoraID = row.ToInt32("ConsultoraID");
            
                PrimerNombre = row.ToString("PrimerNombre");
            
                Email = row.ToString("Email");
            
                CampaniaID = row.ToInt32("CampaniaID");
            
                RegionID = row.ToInt32("RegionID");
            
                ZonaID = row.ToInt32("ZonaID");
            
                SeccionID = row.ToInt32("SeccionID");
            
                CodigoConsultora = row.ToString("Codigo");
            
                PlantillaID = row.ToInt32("PlantillaID");

        }


    }
}
