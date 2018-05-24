using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCronograma
    {
        public IList<BECronograma> GetCronogramaByCampania(int paisID, int CampaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            var cronogramas = new List<BECronograma>();
            var daCronograma = new DACronograma(paisID);

            using (IDataReader reader = daCronograma.GetCronogramaByCampania(CampaniaID, ZonaID, TipoCronogramaID))
                while (reader.Read())
                {
                    var cronograma = new BECronograma(reader) { PaisID = paisID };
                    cronogramas.Add(cronograma);
                }

            return cronogramas;
        }

        public BECronograma GetCronogramaByCampaniayZona(int paisID, int CampaniaID, int ZonaID)
        {
            var cronograma = new BECronograma();
            var daCronograma = new DACronograma(paisID);

            using (IDataReader reader = daCronograma.GetCronogramaByCampaniayZona(CampaniaID, ZonaID))
                if (reader.Read())
                {
                    cronograma = new BECronograma(reader) { PaisID = paisID };
                }
            return cronograma;
        }

        public int MigrarCronogramaAnticipado(int paisID, int CampaniaID, int ZonaID)
        {
            var daCronograma = new DACronograma(paisID);
            return daCronograma.MigrarCronogramaAnticipado(CampaniaID, ZonaID);
        }

        public List<BELogActualizacionFacturacion> GetLogActualizacionFacturacion(int paisID)
        {
            var cronogramas = new List<BELogActualizacionFacturacion>();
            var daCronograma = new DACronograma(paisID);

            using (IDataReader reader = daCronograma.GetLogActualizacionFacturacion())
                while (reader.Read())
                {
                    var cronograma = new BELogActualizacionFacturacion(reader);
                    cronogramas.Add(cronograma);
                }
            return cronogramas;
        }

        public List<BELogActualizacionFacturacion> UpdLogActualizacionFacturacion(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaReFacturacion, string CodigoUsuario)
        {
            var cronogramas = new List<BELogActualizacionFacturacion>();
            var daCronograma = new DACronograma(paisID);

            using (IDataReader reader = daCronograma.UpdLogActualizacionFacturacion(CampaniaCodigo, Codigos, Tipo, FechaFacturacion, FechaReFacturacion, CodigoUsuario))
                while (reader.Read())
                {
                    var cronograma = new BELogActualizacionFacturacion(reader);
                    cronogramas.Add(cronograma);
                }
            return cronogramas;
        }

        public void UpdateCronogramaDD(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaFinFacturacion, DateTime FechaReFacturacion, string CodigoUsuario)
        {
            var daCronogramaDd = new DACronogramaDD(paisID);
            daCronogramaDd.UpdCronogramaDD(CampaniaCodigo, Codigos, Tipo, FechaFacturacion, FechaFinFacturacion, FechaReFacturacion, CodigoUsuario);
        }

        public void UpdCronogramaDemandaAnticipada(int paisID, string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion)
        {
            var daCronogramaDd = new DACronogramaDD(paisID);
            daCronogramaDd.UpdCronogramaDemandaAnticipadaDD(CampaniaCodigo, ZonaCodigo, FechaFacturacion, FechaReFacturacion);
        }

        public void InsCronogramaDemandaAnticipada(int paisID, string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion)
        {
            var daCronogramaDd = new DACronogramaDD(paisID);
            daCronogramaDd.InsCronogramaDemandaAnticipadaDD(CampaniaCodigo, ZonaCodigo, FechaFacturacion, FechaReFacturacion);
        }

        public void DelCronogramaDemandaAnticipada(int paisID, string ZonaCodigo)
        {
            var daCronogramaDd = new DACronogramaDD(paisID);
            daCronogramaDd.DelCronogramaDemandaAnticipadaDD(ZonaCodigo);
        }

        public List<Cronograma> GetZonasFechaFacturacion(int paisID, DateTime fechaFacturacion)
        {
            var zonasfacturacion = new List<Cronograma>();
            var oDaCronograma = new DACronograma(paisID);

            using (IDataReader reader = oDaCronograma.GetZonasFechaFacturacion(fechaFacturacion))
                while (reader.Read())
                {
                    var zona = new Cronograma(reader);
                    zonasfacturacion.Add(zona);
                }

            return zonasfacturacion;
        }

        public bool GetCronogramaAutomaticoActivacion(int paisID)
        {
            var oDaCronograma = new DACronograma(paisID);
            return oDaCronograma.GetCronogramaAutomaticoActivacion();
        }

        public int GetCampaniaFacturacionPais(int paisID)
        {
            var oDaCronograma = new DACronograma(paisID);
            return oDaCronograma.GetCampaniaFacturacionPais();
        }

        public List<BEPaisCampana> GetCampaniaActivaPais(int paisID, DateTime fechaConsulta)
        {
            var paisCampania = new List<BEPaisCampana>();
            var oDaCronograma = new DACronograma(paisID);

            using (IDataReader reader = oDaCronograma.GetCampaniaActivaPais(fechaConsulta))
                while (reader.Read())
                {
                    var campania = new BEPaisCampana(reader);
                    paisCampania.Add(campania);
                }

            return paisCampania;
        }

        public string GetCampaniaActualAndSiguientePais(int paisID, string codigoIso)
        {
            var daCronograma = new DACronograma(paisID);
            return daCronograma.GetCampaniaActualAndSiguientePais(codigoIso);
        }
    }
}