using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionParametroCarga
    {
        public IList<BEConfiguracionParametroCarga> GetCampaniasActivasConfiguracionParametroCarga(int paisID, int CampaniaID)
        {
            var lista = new List<BEConfiguracionParametroCarga>();
            var daConfiguracionParametroCarga = new DAConfiguracionParametroCarga(paisID);

            using (IDataReader reader = daConfiguracionParametroCarga.GetCampaniasActivasConfiguracionParametroCarga(CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionParametroCarga(reader) {PaisID = paisID};
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsConfiguracionParametroCarga(BEConfiguracionValidacion ent, List<BEConfiguracionParametroCarga> lista)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions {IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted};
            var daConfiguracionParametroCarga = new DAConfiguracionParametroCarga(ent.PaisID);
            var daConfiguracionValidacion = new DAConfiguracionValidacion(ent.PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                daConfiguracionParametroCarga.DelConfiguracionParametroCarga(ent.CampaniaID);
                daConfiguracionValidacion.Insert(ent);

                foreach (var item in lista)
                {
                    var entidad = new BEConfiguracionParametroCarga
                    {
                        PaisID = item.PaisID,
                        CampaniaID = ent.CampaniaID,
                        ZonaID = item.ZonaID,
                        ValidacionActiva = item.ValidacionActiva,
                        DiasParametroCarga = item.DiasParametroCarga
                    };
                    daConfiguracionParametroCarga.InsConfiguracionParametroCarga(entidad);
                }
                transaction.Complete();
            }
        }

        public void UpdConfiguracionParametroCarga(BEConfiguracionValidacion ent, List<BEConfiguracionParametroCarga> lista)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions {IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted};
            var daConfiguracionParametroCarga = new DAConfiguracionParametroCarga(ent.PaisID);
            var daConfiguracionValidacion = new DAConfiguracionValidacion(ent.PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                daConfiguracionParametroCarga.DelConfiguracionParametroCarga(ent.CampaniaID);
                daConfiguracionValidacion.Update(ent);

                foreach (var item in lista)
                {
                    var entidad = new BEConfiguracionParametroCarga
                    {
                        PaisID = item.PaisID,
                        CampaniaID = ent.CampaniaID,
                        ZonaID = item.ZonaID,
                        ValidacionActiva = item.ValidacionActiva,
                        DiasParametroCarga = item.DiasParametroCarga
                    };
                    daConfiguracionParametroCarga.InsConfiguracionParametroCarga(entidad);
                }
                transaction.Complete();
            }
        }

        public void DelConfiguracionParametroCarga(int paisID, int CampaniaID)
        {
            var daConfiguracionParametroCarga = new DAConfiguracionParametroCarga(paisID);
            daConfiguracionParametroCarga.DelConfiguracionParametroCarga(CampaniaID);
        }

        public IList<BEConfiguracionParametroCarga> GetRegionZonaDiasParametroCarga(int PaisID, int RegionID, int ZonaID)
        {
            var lista = new List<BEConfiguracionParametroCarga>();
            var daConfiguracionParametroCarga = new DAConfiguracionParametroCarga(PaisID);

            using (IDataReader reader = daConfiguracionParametroCarga.GetRegionZonaDiasParametroCarga(RegionID, ZonaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionParametroCarga(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void UpdConfiguracionParametroCargaPedido(int PaisID, List<BEConfiguracionParametroCarga> listaEntidades)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions {IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted};
            var daConfiguracionParametroCarga = new DAConfiguracionParametroCarga(PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                foreach (var entidad in listaEntidades)
                {
                    daConfiguracionParametroCarga.UpdConfiguracionParametroCargaPedido(entidad);
                }
                transaction.Complete();
            }
        }

        public BEConfiguracionParametroCarga GetConfiguracionParametroCarga(int paisID, int campaniaID, int zonaID)
        {
            BEConfiguracionParametroCarga entidad = null;
            var daConfiguracionParametroCarga = new DAConfiguracionParametroCarga(paisID);

            using (IDataReader reader = daConfiguracionParametroCarga.GetConfiguracionParametroCarga(campaniaID, zonaID))
            {
                if (reader.Read())
                {
                    entidad = new BEConfiguracionParametroCarga(reader) {PaisID = paisID};
                }
            }
            return entidad;
        }
    }
}
