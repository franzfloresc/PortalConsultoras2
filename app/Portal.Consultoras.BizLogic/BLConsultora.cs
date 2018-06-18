using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

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
                var daConsultora = new DAConsultora(paisID);
                using (IDataReader reader = daConsultora.GetConsultoraCodigo())
                    while (reader.Read())
                    {
                        consultorasCodigo.Add(new BEConsultoraCodigo(reader));
                    }
                CacheManager<BEConsultoraCodigo>.AddData(paisID, ECacheItem.ConsultoraCodigos, consultorasCodigo);
            }
            return consultorasCodigo;
        }

        private List<BEConsultoraCodigo> SelectConsultoraPorCodigoYRowCount(int paisId, string codigo , int rowCount)
        {
            List<BEConsultoraCodigo>  consultorasCodigo = new List<BEConsultoraCodigo>();
            var daConsultora = new DAConsultora(paisId);
            using (IDataReader reader = daConsultora.GetConsultoraCodigoPorCodigoYRowCount(codigo,rowCount))
            while (reader.Read())
            {
                consultorasCodigo.Add(new BEConsultoraCodigo(reader));
            }
            return consultorasCodigo;
        }

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID, string codigo, int rowCount)
        {
            IList<BEConsultoraCodigo> consultoras = SelectConsultoraPorCodigoYRowCount(paisID, codigo , rowCount);

            return consultoras.OrderBy(x => x.Codigo).ToList();
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
            var daConsultora = new DAConsultora(paisID);
            return daConsultora.GetSaldoActualConsultora(Codigo);
        }        

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID, int regionID, int zonaID, string codigo, int rowCount)
        {
            List<BEConsultoraCodigo> consultorasCodigo = SelectConsultoraCodigo(paisID);
            var selConsultorasCodigo = new List<BEConsultoraCodigo>();

            int regionFinId, zonaFinId;
            if (regionID > 0)
            {
                regionFinId = regionID;
                zonaFinId = zonaID > 0 ? zonaID : int.MaxValue;
            }
            else
            {
                regionFinId = int.MaxValue;
                zonaFinId = int.MaxValue;
            }

            foreach (BEConsultoraCodigo consultoraCodigo in consultorasCodigo)
            {
                if (consultoraCodigo.RegionID >= regionID && consultoraCodigo.RegionID <= regionFinId
                    && consultoraCodigo.ZonaID >= zonaID && consultoraCodigo.ZonaID <= zonaFinId
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
            var daConsultora = new DAConsultora(paisID);
            using (IDataReader reader = daConsultora.GetConsultoraById(ConsultoraID))
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

            var daConsultora = new DAConsultora(paisID);
            var daConfiguracionCampania = new DAConfiguracionCampania(paisID);

            using (IDataReader reader = daConsultora.GetConsultoraByCodigo(codigo, codigoZona, numeroDocumento))
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
                    using (IDataReader reader = daConfiguracionCampania.GetConfiguracionCampaniaZona(paisID, beConsultora.ZonaID, beConsultora.RegionID, beConsultora.ConsultoraID))
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

            var daConsultora = new DAConsultora(paisID);
            var daConfiguracionCampania = new DAConfiguracionCampania(paisID);

            using (IDataReader reader = daConsultora.GetConsultoraByCodigo(codigo))
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
                    using (IDataReader reader = daConfiguracionCampania.GetCampaniaByConsultoraHabilitarPedido(paisID, beConsultora.ZonaID, beConsultora.ConsultoraID))
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
            var daConsultora = new DAConsultora(paisID);
            return daConsultora.GetConsultoraIdByCodigo(CodigoConsultora);
        }

        public BEConsultoraDatoSAC GetConsultoraDatoSAC(string paisID, string codigoConsultora, string documento)
        {
            if (string.IsNullOrEmpty(paisID)) return null;
            if (string.IsNullOrEmpty(codigoConsultora) && string.IsNullOrEmpty(documento)) return null;

            BEConsultoraDatoSAC beConsultora = null;
            var daConsultora = new DAConsultora(Convert.ToInt32(paisID));

            using (IDataReader reader = daConsultora.GetConsultoraDatoSAC(paisID, codigoConsultora, documento))
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
            var daConsultora = new DAConsultora(Convert.ToInt32(paisID));

            using (IDataReader reader = daConsultora.GetConsultoraEstadoSAC(paisID, codigoConsultora))
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

            BEConsultoraCUV beConsultoraCvu = new BEConsultoraCUV();
            var daConsultora = new DAConsultora(paisID);

            using (IDataReader reader = daConsultora.GetConsultoraCUVRegular(campaniaID, CUVRegular))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beConsultoraCvu = new BEConsultoraCUV(reader, columns);
                }
            }

            return beConsultoraCvu;
        }

        public BEConsultoraCUV GetConsultoraCUVCredito(int paisID, int campaniaID, string CUVCredito)
        {

            BEConsultoraCUV beConsultoraCvu = new BEConsultoraCUV();
            var daConsultora = new DAConsultora(paisID);

            using (IDataReader reader = daConsultora.GetConsultoraCUVCredito(campaniaID, CUVCredito))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beConsultoraCvu = new BEConsultoraCUV(reader, columns);
                }
            }

            return beConsultoraCvu;
        }

        public List<BEConsultora> GetConsultorasPorUbigeo(int paisId, string codigoUbigeo, string campania, int marcaId, int tipoFiltroUbigeo)
        {
            var vListaConsultora = new List<BEConsultora>();

            if (paisId > 0)
            {
                var daConsultora = new DAConsultora(paisId);
                using (IDataReader reader = daConsultora.GetConsultorasPorUbigeo(paisId, codigoUbigeo, campania, marcaId, tipoFiltroUbigeo))
                {
                    while (reader.Read())
                    {
                        var vConsultora = new BEConsultora(reader);
                        vListaConsultora.Add(vConsultora);
                    }
                }
            }
            return vListaConsultora;
        }

    }
}