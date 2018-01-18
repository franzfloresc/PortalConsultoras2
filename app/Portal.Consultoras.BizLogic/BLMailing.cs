using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLMailing
    {
        public BLMailing()
        {

        }
        public List<BEPlantillasMailing> ObtenerPlantillasEmailingSE()
        {
            List<BEPlantillasMailing> listaPlantillas = new List<BEPlantillasMailing>();
            var DAMailing = new DAMailing();

            using (IDataReader reader = DAMailing.ObtenerPlantillasEmailingSE())
            {
                while (reader.Read())
                {
                    listaPlantillas.Add(new BEPlantillasMailing(reader));

                }
            }

            return listaPlantillas;
        }

        public List<BEMailing> CargarPaisesPlantillaEmailing(int plantillaID)
        {
            List<BEMailing> listaPaisesPlantilla = new List<BEMailing>();
            var DAMailing = new DAMailing();

            using (IDataReader reader = DAMailing.CargarPaisesPlantillaEmailing(plantillaID))
            {
                while (reader.Read())
                {
                    listaPaisesPlantilla.Add(new BEMailing(reader));

                }
            }

            return listaPaisesPlantilla;
        }

        public void RegistrarContenidoEmailingSE(BEMailing BEMailing)
        {
            var DAMailing = new DAMailing();
            DAMailing.RegistrarContenidoEmailingSE(BEMailing);
        }

        public bool AgregarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, string CodigoUsuario)
        {
            var DAMailing = new DAMailing();
            return DAMailing.AgregarPaisPlantillaEmailingSE(PaisID,PlantillaID,CodigoUsuario)>0;
        }

        public bool QuitarPaisPlantillaEmailingSE(int PaisID, int PlantillaID)
        {
            var DAMailing = new DAMailing();
            return DAMailing.QuitarPaisPlantillaEmailingSE(PaisID, PlantillaID) > 0;
        }

        public bool CopiarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, int PaisDestinoID,string CodigoUsuario)
        {
            var DAMailing = new DAMailing();
            return DAMailing.CopiarPaisPlantillaEmailingSE(PaisID, PlantillaID, PaisDestinoID, CodigoUsuario) > 0;
        }

        public List<BEConsultoraMailing> CondicionesConsultoraSE( int PaisID)
        {
            int PaisPeru = 11;//Peru por configuracion de LogEmail   
            var DAMailingLista = new DAMailing(PaisPeru);
            DataTable DTLogEmailingAutomaticoSE = new DataTable();
 
            using (IDataReader readerLogEmail = DAMailingLista.ListaLogEmailingAutomaticoSE(PaisID))
            {
                DTLogEmailingAutomaticoSE.Load(readerLogEmail);
            }
 

            List<BEConsultoraMailing> listaConsultoras = new List<BEConsultoraMailing>();
            var DAMailing = new DAMailing(PaisID);

            using (IDataReader reader = DAMailing.CondicionesConsultoraSE(DTLogEmailingAutomaticoSE))
            {
                while (reader.Read())
                {
                    listaConsultoras.Add(new BEConsultoraMailing(reader));
                }
            }

            return listaConsultoras;
        }

        public void RegistrarLogEnvioAutomatico(int PaisID,BEConsultoraMailing BEConsultora)
        {
            var DAMailing = new DAMailing();
            DAMailing.RegistrarLogEnvioAutomatico(BEConsultora.CodigoConsultora,
                    BEConsultora.Email, PaisID, BEConsultora.CampaniaID, BEConsultora.RegionID, BEConsultora.ZonaID,
                    BEConsultora.SeccionID, BEConsultora.Plantilla, BEConsultora.ConsultoraID);

        }
        public DateTime GetPaisZonaHoraria(int PaisID)
        {
            var DAMailing = new DAMailing(PaisID);
            return DAMailing.GetPaisZonaHoraria();

        }

        public List<BEPlantillasMailing> GetPlantillasPais(int PaisID)
        {

            List<BEPlantillasMailing> listaConsultoras = new List<BEPlantillasMailing>();
             var DAMailing = new DAMailing();
             using (IDataReader reader =   DAMailing.GetPlantillasPais(PaisID))
             {
                 while (reader.Read())
                 {
                     listaConsultoras.Add(new BEPlantillasMailing(reader));
                 }
             }

             return listaConsultoras;

        }


        public string ObtenerCorreoEmisor(int PaisID)
        {
            var DAMailing = new DAMailing();
            string CorreoEmisor = "";
            using (IDataReader reader = DAMailing.ObtenerCorreoEmisor(PaisID))
            {
                while (reader.Read())
                {
                    if (DataRecord.HasColumn(reader, "CorreoEmisor") && reader["CorreoEmisor"] != DBNull.Value)
                        CorreoEmisor = Convert.ToString(reader["CorreoEmisor"]);
                }
            }
            return CorreoEmisor;
        }
    }
}
