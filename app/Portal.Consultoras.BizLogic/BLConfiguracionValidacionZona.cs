using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionValidacionZona
    {
        public IList<BEConfiguracionValidacionZona> GetCampaniasActivas(int paisID, int CampaniaID)
        {
            var lista = new List<BEConfiguracionValidacionZona>();
            var daConfiguracionValidacionZona = new DAConfiguracionValidacionZona(paisID);

            using (IDataReader reader = daConfiguracionValidacionZona.GetCampaniasActivas(CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionZona(reader) { PaisID = paisID };
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsConfiguracionValidacionZona(BEConfiguracionValidacion ent, List<BEConfiguracionValidacionZona> lista)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            var daConfiguracionValidacionZona = new DAConfiguracionValidacionZona(ent.PaisID);
            var daConfiguracionValidacion = new DAConfiguracionValidacion(ent.PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                daConfiguracionValidacionZona.DelConfiguracionValidacionZona(ent.CampaniaID);
                daConfiguracionValidacion.Insert(ent);

                foreach (var item in lista)
                {
                    var entidad = new BEConfiguracionValidacionZona
                    {
                        PaisID = item.PaisID,
                        CampaniaID = ent.CampaniaID,
                        ZonaID = item.ZonaID,
                        ValidacionActiva = item.ValidacionActiva,
                        DiasDuracionCronograma = item.DiasDuracionCronograma
                    };
                    daConfiguracionValidacionZona.InsConfiguracionValidacionZona(entidad);
                }
                transaction.Complete();
            }
        }

        public void UpdConfiguracionValidacionZona(BEConfiguracionValidacion ent, List<BEConfiguracionValidacionZona> lista)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            var daConfiguracionValidacionZona = new DAConfiguracionValidacionZona(ent.PaisID);
            var daConfiguracionValidacion = new DAConfiguracionValidacion(ent.PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                daConfiguracionValidacionZona.DelConfiguracionValidacionZona(ent.CampaniaID);
                daConfiguracionValidacion.Update(ent);

                foreach (var item in lista)
                {
                    var entidad = new BEConfiguracionValidacionZona
                    {
                        PaisID = item.PaisID,
                        CampaniaID = ent.CampaniaID,
                        ZonaID = item.ZonaID,
                        ValidacionActiva = item.ValidacionActiva,
                        DiasDuracionCronograma = item.DiasDuracionCronograma
                    };
                    daConfiguracionValidacionZona.InsConfiguracionValidacionZona(entidad);
                }
                transaction.Complete();
            }
        }

        public void DelConfiguracionValidacionZona(int paisID, int CampaniaID)
        {
            var daConfiguracionValidacionZona = new DAConfiguracionValidacionZona(paisID);
            daConfiguracionValidacionZona.DelConfiguracionValidacionZona(CampaniaID);
        }

        public IList<BEConfiguracionValidacionZona> GetRegionZonaDiasDuracionCronograma(int PaisID, int RegionID, int ZonaID)
        {
            var lista = new List<BEConfiguracionValidacionZona>();
            var daConfiguracionValidacionZona = new DAConfiguracionValidacionZona(PaisID);

            using (IDataReader reader = daConfiguracionValidacionZona.GetRegionZonaDiasDuracionCronograma(RegionID, ZonaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionZona(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void UpdConfiguracionValidacionZonaCronograma(int PaisID, List<BEConfiguracionValidacionZona> listaEntidades)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            var daConfiguracionValidacionZona = new DAConfiguracionValidacionZona(PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                foreach (var entidad in listaEntidades)
                {
                    daConfiguracionValidacionZona.UpdConfiguracionValidacionZonaCronograma(entidad);
                }
                transaction.Complete();
            }
        }

        public BEConfiguracionValidacionZona GetConfiguracionValidacionZona(int paisID, int campaniaID, int zonaID)
        {
            BEConfiguracionValidacionZona entidad = null;
            var daConfiguracionValidacionZona = new DAConfiguracionValidacionZona(paisID);

            using (IDataReader reader = daConfiguracionValidacionZona.GetConfiguracionValidacionZona(campaniaID, zonaID))
            {
                if (reader.Read())
                {
                    entidad = new BEConfiguracionValidacionZona(reader) { PaisID = paisID };
                }
            }
            return entidad;
        }
    }
}