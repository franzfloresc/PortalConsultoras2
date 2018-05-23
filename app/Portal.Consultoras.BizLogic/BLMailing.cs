using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

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
            var daMailing = new DAMailing();

            using (IDataReader reader = daMailing.ObtenerPlantillasEmailingSE())
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
            var daMailing = new DAMailing();

            using (IDataReader reader = daMailing.CargarPaisesPlantillaEmailing(plantillaID))
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
            var daMailing = new DAMailing();
            daMailing.RegistrarContenidoEmailingSE(BEMailing);
        }

        public bool AgregarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, string CodigoUsuario)
        {
            var daMailing = new DAMailing();
            return daMailing.AgregarPaisPlantillaEmailingSE(PaisID, PlantillaID, CodigoUsuario) > 0;
        }

        public bool QuitarPaisPlantillaEmailingSE(int PaisID, int PlantillaID)
        {
            var daMailing = new DAMailing();
            return daMailing.QuitarPaisPlantillaEmailingSE(PaisID, PlantillaID) > 0;
        }

        public bool CopiarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, int PaisDestinoID, string CodigoUsuario)
        {
            var daMailing = new DAMailing();
            return daMailing.CopiarPaisPlantillaEmailingSE(PaisID, PlantillaID, PaisDestinoID, CodigoUsuario) > 0;
        }

        public List<BEConsultoraMailing> CondicionesConsultoraSE(int PaisID)
        {
            int paisPeru = 11;//Peru por configuracion de LogEmail   
            var daMailingLista = new DAMailing(paisPeru);
            DataTable dtLogEmailingAutomaticoSe = new DataTable();

            using (IDataReader readerLogEmail = daMailingLista.ListaLogEmailingAutomaticoSE(PaisID))
            {
                dtLogEmailingAutomaticoSe.Load(readerLogEmail);
            }


            List<BEConsultoraMailing> listaConsultoras = new List<BEConsultoraMailing>();
            var daMailing = new DAMailing(PaisID);

            using (IDataReader reader = daMailing.CondicionesConsultoraSE(dtLogEmailingAutomaticoSe))
            {
                while (reader.Read())
                {
                    listaConsultoras.Add(new BEConsultoraMailing(reader));
                }
            }

            return listaConsultoras;
        }

        public void RegistrarLogEnvioAutomatico(int PaisID, BEConsultoraMailing BEConsultora)
        {
            var daMailing = new DAMailing();
            daMailing.RegistrarLogEnvioAutomatico(BEConsultora.CodigoConsultora,
                    BEConsultora.Email, PaisID, BEConsultora.CampaniaID, BEConsultora.RegionID, BEConsultora.ZonaID,
                    BEConsultora.SeccionID, BEConsultora.Plantilla, BEConsultora.ConsultoraID);

        }

        public DateTime GetPaisZonaHoraria(int PaisID)
        {
            var daMailing = new DAMailing(PaisID);
            return daMailing.GetPaisZonaHoraria();

        }

        public List<BEPlantillasMailing> GetPlantillasPais(int PaisID)
        {

            List<BEPlantillasMailing> listaConsultoras = new List<BEPlantillasMailing>();
            var daMailing = new DAMailing();
            using (IDataReader reader = daMailing.GetPlantillasPais(PaisID))
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
            var daMailing = new DAMailing();
            string correoEmisor = "";
            using (IDataReader reader = daMailing.ObtenerCorreoEmisor(PaisID))
            {
                while (reader.Read())
                {
                    if (DataRecord.HasColumn(reader, "CorreoEmisor"))
                        correoEmisor = Convert.ToString(reader["CorreoEmisor"]);
                }
            }
            return correoEmisor;
        }
    }
}
