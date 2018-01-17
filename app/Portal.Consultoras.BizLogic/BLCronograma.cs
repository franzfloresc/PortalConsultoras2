using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCronograma
    {
        public IList<BECronograma> GetCronogramaByCampania(int paisID, int CampaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            var cronogramas = new List<BECronograma>();
            var DACronograma = new DACronograma(paisID);

            using (IDataReader reader = DACronograma.GetCronogramaByCampania(CampaniaID, ZonaID, TipoCronogramaID))
                while (reader.Read())
                {
                    var cronograma = new BECronograma(reader);
                    cronograma.PaisID = paisID;
                    cronogramas.Add(cronograma);
                }

            return cronogramas;
        }

        public BECronograma GetCronogramaByCampaniayZona(int paisID, int CampaniaID, int ZonaID)
        {
            var cronograma = new BECronograma();
            var DACronograma = new DACronograma(paisID);

            using (IDataReader reader = DACronograma.GetCronogramaByCampaniayZona(CampaniaID, ZonaID))
                if (reader.Read())
                {
                    cronograma = new BECronograma(reader);
                    cronograma.PaisID = paisID;
                }
            return cronograma;
        }

        public int MigrarCronogramaAnticipado(int paisID, int CampaniaID, int ZonaID)
        {
            var DACronograma = new DACronograma(paisID);
            return DACronograma.MigrarCronogramaAnticipado(CampaniaID, ZonaID);
        }

        public List<BELogActualizacionFacturacion> GetLogActualizacionFacturacion(int paisID)
        {
            var cronogramas = new List<BELogActualizacionFacturacion>();
            var DACronograma = new DACronograma(paisID);

            using (IDataReader reader = DACronograma.GetLogActualizacionFacturacion())
                while (reader.Read())
                {
                    var cronograma = new BELogActualizacionFacturacion(reader);
                    cronogramas.Add(cronograma);
                }
            return cronogramas;
        }

        public List<BELogActualizacionFacturacion> UpdLogActualizacionFacturacion(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion,DateTime FechaReFacturacion, string CodigoUsuario)
        {
            var cronogramas = new List<BELogActualizacionFacturacion>();
            var DACronograma = new DACronograma(paisID);

            using (IDataReader reader = DACronograma.UpdLogActualizacionFacturacion(CampaniaCodigo, Codigos, Tipo, FechaFacturacion, FechaReFacturacion, CodigoUsuario))
                while (reader.Read())
                {
                    var cronograma = new BELogActualizacionFacturacion(reader);
                    cronogramas.Add(cronograma);
                }
            return cronogramas;
        }

        public void UpdateCronogramaDD(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaFinFacturacion, DateTime FechaReFacturacion, string CodigoUsuario)
        {
            var DACronogramaDD = new DACronogramaDD(paisID);
            DACronogramaDD.UpdCronogramaDD(CampaniaCodigo, Codigos, Tipo, FechaFacturacion, FechaFinFacturacion, FechaReFacturacion, CodigoUsuario);
        }

        public void UpdCronogramaDemandaAnticipada(int paisID, string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion)
        {
            var DACronogramaDD = new DACronogramaDD(paisID);
            DACronogramaDD.UpdCronogramaDemandaAnticipadaDD(CampaniaCodigo, ZonaCodigo, FechaFacturacion, FechaReFacturacion);
        }

        public void InsCronogramaDemandaAnticipada(int paisID, string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion)
        {
            var DACronogramaDD = new DACronogramaDD(paisID);
            DACronogramaDD.InsCronogramaDemandaAnticipadaDD(CampaniaCodigo, ZonaCodigo, FechaFacturacion, FechaReFacturacion);
        }

        public void DelCronogramaDemandaAnticipada(int paisID, string ZonaCodigo)
        {
            var DACronogramaDD = new DACronogramaDD(paisID);
            DACronogramaDD.DelCronogramaDemandaAnticipadaDD(ZonaCodigo);
        }

        public List<Cronograma> GetZonasFechaFacturacion(int paisID, DateTime fechaFacturacion)
        {
            var zonasfacturacion = new List<Cronograma>();
            var oDACronograma = new DACronograma(paisID);

            using (IDataReader reader = oDACronograma.GetZonasFechaFacturacion(fechaFacturacion))
                while (reader.Read())
                {
                    var zona = new Cronograma(reader);
                    zonasfacturacion.Add(zona);
                }

            return zonasfacturacion;
        }

        public bool GetCronogramaAutomaticoActivacion(int paisID)
        {
            var oDACronograma = new DACronograma(paisID);
            return oDACronograma.GetCronogramaAutomaticoActivacion();
        }

        public int GetCampaniaFacturacionPais(int paisID)
        {
            var oDACronograma = new DACronograma(paisID);
            return oDACronograma.GetCampaniaFacturacionPais(); 
        }

        public List<BEPaisCampana> GetCampaniaActivaPais(int paisID, DateTime fechaConsulta)
        {
            var paisCampania = new List<BEPaisCampana>();
            var oDACronograma = new DACronograma(paisID);

            using (IDataReader reader = oDACronograma.GetCampaniaActivaPais(fechaConsulta))
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