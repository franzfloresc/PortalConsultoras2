using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultora
    {
        private List<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID)
        {
            List<BEConsultoraCodigo> consultorasCodigo = (List<BEConsultoraCodigo>)CacheManager<BEConsultoraCodigo>.GetData(paisID, ECacheItem.ConsultoraCodigos);
            if (consultorasCodigo == null)
            {
                consultorasCodigo = new List<BEConsultoraCodigo>();
                var DAConsultora = new DAConsultora(paisID);
                using (IDataReader reader = DAConsultora.GetConsultoraCodigo())
                    while (reader.Read())
                    {
                        consultorasCodigo.Add(new BEConsultoraCodigo(reader));
                    }
                CacheManager<BEConsultoraCodigo>.AddData(paisID, ECacheItem.ConsultoraCodigos, consultorasCodigo);
            }
            return consultorasCodigo;
        }

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID, string codigo, int rowCount)
        {
            IList<BEConsultoraCodigo> consultoras = SelectConsultoraCodigo(paisID);

            return (from consultora in consultoras
                    where consultora.Codigo.Contains(codigo)
                    select consultora).Take(rowCount).ToList();
        }

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID, string codigo)
        {
            IList<BEConsultoraCodigo> consultoras = SelectConsultoraCodigo(paisID);

            return (from consultora in consultoras
                    where consultora.Codigo.Equals(codigo)
                    select consultora).ToList();
        }

        public void LoadConsultoraCodigo(int paisID)
        {
            SelectConsultoraCodigo(paisID);
        }

        public decimal GetSaldoActualConsultora(int paisID, string Codigo)
        {
            var DAConsultora = new DAConsultora(paisID);
            return DAConsultora.GetSaldoActualConsultora(Codigo);
        }        

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID, int regionID, int zonaID, string codigo, int rowCount)
        {
            List<BEConsultoraCodigo> consultorasCodigo = SelectConsultoraCodigo(paisID);
            var selConsultorasCodigo = new List<BEConsultoraCodigo>();

            int regionFinID, zonaFinID;
            if (regionID > 0)
            {
                regionFinID = regionID;
                zonaFinID = zonaID > 0 ? zonaID : int.MaxValue;
            }
            else
            {
                regionFinID = int.MaxValue;
                zonaFinID = int.MaxValue;
            }

            foreach (BEConsultoraCodigo consultoraCodigo in consultorasCodigo)
            {
                if (consultoraCodigo.RegionID >= regionID && consultoraCodigo.RegionID <= regionFinID
                    && consultoraCodigo.ZonaID >= zonaID && consultoraCodigo.ZonaID <= zonaFinID
                    && consultoraCodigo.Codigo.Contains(codigo))
                {
                    selConsultorasCodigo.Add(consultoraCodigo);
                    if (selConsultorasCodigo.Count >= rowCount)
                        break;
                }
            }

            return selConsultorasCodigo;
        }

        public List<BEConsultora> SelectConsultoraByID(int paisID, Int64 ConsultoraID)
        {
            List<BEConsultora> consultora = new List<BEConsultora>();
            var DAConsultora = new DAConsultora(paisID);
            using (IDataReader reader = DAConsultora.GetConsultoraById(ConsultoraID))
                while (reader.Read())
                {
                    consultora.Add(new BEConsultora(reader));
                }
            return consultora;
        }

        public List<BEConsultoraDD> SelectConsultoraDatos(int paisID, string codigoZona, string codigoSeccion, string codigoConsultora, string nombreConsultora)
        {
            var consultoras = new List<BEConsultoraDD>();
            var daConsultora = new DAConsultora(paisID);

            using (IDataReader reader = daConsultora.GetConsultoraDatos(codigoZona, codigoSeccion, codigoConsultora, nombreConsultora))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                while (reader.Read())
                {
                    consultoras.Add(new BEConsultoraDD(reader, columns));
                }
            }
            return consultoras;
        }

        public BEConsultoraDD GetConsultoraByCodigo(int paisID, string codigo)
        {
            return this.GetConsultoraByCodigo(paisID, codigo, null, null);
        }
        public BEConsultoraDD GetConsultoraByCodigo(int paisID, string codigo, string codigoZona)
        {
            return this.GetConsultoraByCodigo(paisID, codigo, codigoZona, null);
        }
        public BEConsultoraDD GetConsultoraByCodigo(int paisID, string codigo, string codigoZona, string numeroDocumento)
        {
            if (string.IsNullOrEmpty(codigo) && string.IsNullOrEmpty(codigoZona) && string.IsNullOrEmpty(numeroDocumento))
                return null;

            BEConsultoraDD beConsultora = null;
            BEConfiguracionCampania configuracion = null;

            var DAConsultora = new DAConsultora(paisID);
            var DAConfiguracionCampania = new DAConfiguracionCampania(paisID);

            using (IDataReader reader = DAConsultora.GetConsultoraByCodigo(codigo, codigoZona, numeroDocumento))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beConsultora = new BEConsultoraDD(reader, columns);
                }
            }

            if (beConsultora != null)
            {
                beConsultora.PaisID = paisID;

                if (beConsultora.ConsultoraID != 0)
                {
                    using (IDataReader reader = DAConfiguracionCampania.GetConfiguracionCampaniaZona(paisID, beConsultora.ZonaID, beConsultora.RegionID, beConsultora.ConsultoraID))
                        if (reader.Read())
                            configuracion = new BEConfiguracionCampania(reader);

                    if (configuracion != null)
                    {
                        beConsultora.CampaniaID = configuracion.CampaniaID;
                    }
                }
            }
            return beConsultora;
        }

        public BEConsultoraDD GetConsultoraByCodigoHabilitarPedido(int paisID, string codigo)
        {
            BEConsultoraDD beConsultora = null;

            var DAConsultora = new DAConsultora(paisID);
            var DAConfiguracionCampania = new DAConfiguracionCampania(paisID);

            using (IDataReader reader = DAConsultora.GetConsultoraByCodigo(codigo))
            {
                var columns = ((IDataRecord)reader).GetAllNames();
                if (reader.Read())
                {
                    beConsultora = new BEConsultoraDD(reader, columns);
                }
            }

            if (beConsultora != null)
            {
                beConsultora.PaisID = paisID;

                if (beConsultora.ConsultoraID != 0)
                {
                    using (IDataReader reader = DAConfiguracionCampania.GetCampaniaByConsultoraHabilitarPedido(paisID, beConsultora.ZonaID, beConsultora.ConsultoraID))
                        if (reader.Read())
                        {
                            beConsultora.CampaniaID = reader.IsDBNull(reader.GetOrdinal("CampaniaID")) ? 0 : reader.GetInt32(reader.GetOrdinal("CampaniaID"));
                        }
                }
            }
            return beConsultora;

        }

        public long GetConsultoraIdByCodigo(int paisID, string CodigoConsultora)
        {
            var DAConsultora = new DAConsultora(paisID);
            return DAConsultora.GetConsultoraIdByCodigo(CodigoConsultora);
        }

        public BEConsultoraDatoSAC GetConsultoraDatoSAC(string paisID, string codigoConsultora, string documento)
        {
            if (string.IsNullOrEmpty(paisID)) return null;
            if (string.IsNullOrEmpty(codigoConsultora) && string.IsNullOrEmpty(documento)) return null;

            BEConsultoraDatoSAC beConsultora = null;
            var DAConsultora = new DAConsultora(Convert.ToInt32(paisID));

            using (IDataReader reader = DAConsultora.GetConsultoraDatoSAC(paisID, codigoConsultora, documento))
            {
                if (reader.Read())
                {
                    beConsultora = new BEConsultoraDatoSAC(reader);
                }
            }

            return beConsultora;
        }
        public BEConsultoraEstadoSAC GetConsultoraEstadoSAC(string paisID, string codigoConsultora)
        {
            if (string.IsNullOrEmpty(paisID)) return null;
            if (string.IsNullOrEmpty(codigoConsultora)) return null;

            BEConsultoraEstadoSAC beConsultora = null;
            var DAConsultora = new DAConsultora(Convert.ToInt32(paisID));

            using (IDataReader reader = DAConsultora.GetConsultoraEstadoSAC(paisID, codigoConsultora))
            {
                if (reader.Read())
                {
                    beConsultora = new BEConsultoraEstadoSAC(reader);
                }
            }

            return beConsultora;
        }

        public BEConsultoraTop GetConsultoraTop(int paisID, string codigoConsultora)
        {

            BEConsultoraTop beConsultoraTop = new BEConsultoraTop();
            var daConsultora = new DAConsultora(paisID);

            using (IDataReader reader = daConsultora.GetConsultoraTop(codigoConsultora))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beConsultoraTop = new BEConsultoraTop(reader, columns);
                }
            }

            return beConsultoraTop;
        }

        public BEConsultoraCUV GetConsultoraCUVRegular(int paisID, int campaniaID, string CUVRegular)
        {

            BEConsultoraCUV beConsultoraCVU = new BEConsultoraCUV();
            var daConsultora = new DAConsultora(paisID);

            using (IDataReader reader = daConsultora.GetConsultoraCUVRegular(campaniaID, CUVRegular))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beConsultoraCVU = new BEConsultoraCUV(reader, columns);
                }
            }

            return beConsultoraCVU;
        }

        public BEConsultoraCUV GetConsultoraCUVCredito(int paisID, int campaniaID, string CUVCredito)
        {

            BEConsultoraCUV beConsultoraCVU = new BEConsultoraCUV();
            var daConsultora = new DAConsultora(paisID);

            using (IDataReader reader = daConsultora.GetConsultoraCUVCredito(campaniaID, CUVCredito))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beConsultoraCVU = new BEConsultoraCUV(reader, columns);
                }
            }

            return beConsultoraCVU;
        }


        public List<BEConsultora> GetConsultorasPorUbigeo(int paisId, string codigoUbigeo, string campania, int marcaId, int tipoFiltroUbigeo)
        {
            var vConsultora = new BEConsultora();
            var vListaConsultora = new List<BEConsultora>();

            if (paisId > 0)
            {
                var DAConsultora = new DAConsultora(paisId);
                using (IDataReader reader = DAConsultora.GetConsultorasPorUbigeo(paisId, codigoUbigeo, campania, marcaId, tipoFiltroUbigeo))
                {
                    while (reader.Read())
                    {
                        vConsultora = new BEConsultora(reader);
                        vListaConsultora.Add(vConsultora);
                    }
                }
            }
            return vListaConsultora;
        }


    }
}
