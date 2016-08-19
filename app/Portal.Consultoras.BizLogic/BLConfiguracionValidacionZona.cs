using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionValidacionZona
    {
        public IList<BEConfiguracionValidacionZona> GetCampaniasActivas(int paisID, int CampaniaID)
        {
            var lista = new List<BEConfiguracionValidacionZona>();
            var DAConfiguracionValidacionZona = new DAConfiguracionValidacionZona(paisID);

            using (IDataReader reader = DAConfiguracionValidacionZona.GetCampaniasActivas(CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionZona(reader);
                    entidad.PaisID = paisID;
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsConfiguracionValidacionZona(BEConfiguracionValidacion ent, List<BEConfiguracionValidacionZona> lista)
        {
            BEConfiguracionValidacionZona entidad;
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            var DAConfiguracionValidacionZona = new DAConfiguracionValidacionZona(ent.PaisID);
            var DAConfiguracionValidacion = new DAConfiguracionValidacion(ent.PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                DAConfiguracionValidacionZona.DelConfiguracionValidacionZona(ent.CampaniaID);
                DAConfiguracionValidacion.Insert(ent);

                foreach (var item in lista)
                {
                    entidad = new BEConfiguracionValidacionZona();
                    entidad.PaisID = item.PaisID;
                    entidad.CampaniaID = ent.CampaniaID;
                    entidad.ZonaID = item.ZonaID;
                    entidad.ValidacionActiva = item.ValidacionActiva;
                    entidad.DiasDuracionCronograma = item.DiasDuracionCronograma;
                    DAConfiguracionValidacionZona.InsConfiguracionValidacionZona(entidad);
                }
                transaction.Complete();
            }
        }

        public void UpdConfiguracionValidacionZona(BEConfiguracionValidacion ent, List<BEConfiguracionValidacionZona> lista)
        {
            BEConfiguracionValidacionZona entidad;
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            var DAConfiguracionValidacionZona = new DAConfiguracionValidacionZona(ent.PaisID);
            var DAConfiguracionValidacion = new DAConfiguracionValidacion(ent.PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                DAConfiguracionValidacionZona.DelConfiguracionValidacionZona(ent.CampaniaID);
                DAConfiguracionValidacion.Update(ent);

                foreach (var item in lista)
                {
                    entidad = new BEConfiguracionValidacionZona();
                    entidad.PaisID = item.PaisID;
                    entidad.CampaniaID = ent.CampaniaID;
                    entidad.ZonaID = item.ZonaID;
                    entidad.ValidacionActiva = item.ValidacionActiva;
                    entidad.DiasDuracionCronograma = item.DiasDuracionCronograma;
                    DAConfiguracionValidacionZona.InsConfiguracionValidacionZona(entidad);
                }
                transaction.Complete();
            }
        }

        public void DelConfiguracionValidacionZona(int paisID, int CampaniaID)
        {
            var DAConfiguracionValidacionZona = new DAConfiguracionValidacionZona(paisID);
            DAConfiguracionValidacionZona.DelConfiguracionValidacionZona(CampaniaID);
        }

        public IList<BEConfiguracionValidacionZona> GetRegionZonaDiasDuracionCronograma(int PaisID, int RegionID, int ZonaID)
        {
            var lista = new List<BEConfiguracionValidacionZona>();
            var DAConfiguracionValidacionZona = new DAConfiguracionValidacionZona(PaisID);

            using (IDataReader reader = DAConfiguracionValidacionZona.GetRegionZonaDiasDuracionCronograma(RegionID, ZonaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionZona(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void UpdConfiguracionValidacionZonaCronograma(int PaisID, List<BEConfiguracionValidacionZona> listaEntidades)
        {
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            var DAConfiguracionValidacionZona = new DAConfiguracionValidacionZona(PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                foreach (var entidad in listaEntidades)
                {
                    DAConfiguracionValidacionZona.UpdConfiguracionValidacionZonaCronograma(entidad);
                }
                transaction.Complete();
            }
        }

        public BEConfiguracionValidacionZona GetConfiguracionValidacionZona(int paisID, int campaniaID, int zonaID)
        {
            BEConfiguracionValidacionZona entidad = null;
            var DAConfiguracionValidacionZona = new DAConfiguracionValidacionZona(paisID);

            using (IDataReader reader = DAConfiguracionValidacionZona.GetConfiguracionValidacionZona(campaniaID, zonaID))
            {
                if (reader.Read())
                {
                    entidad = new BEConfiguracionValidacionZona(reader);
                    entidad.PaisID = paisID;
                }
            }
            return entidad;
        }
    }
}
