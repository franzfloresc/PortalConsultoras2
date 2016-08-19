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
    public class BLConfiguracionParametroCarga
    {
        public IList<BEConfiguracionParametroCarga> GetCampaniasActivasConfiguracionParametroCarga(int paisID, int CampaniaID)
        {
            var lista = new List<BEConfiguracionParametroCarga>();
            var DAConfiguracionParametroCarga = new DAConfiguracionParametroCarga(paisID);

            using (IDataReader reader = DAConfiguracionParametroCarga.GetCampaniasActivasConfiguracionParametroCarga(CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionParametroCarga(reader);
                    entidad.PaisID = paisID;
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsConfiguracionParametroCarga(BEConfiguracionValidacion ent, List<BEConfiguracionParametroCarga> lista)
        {
            BEConfiguracionParametroCarga entidad;
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            var DAConfiguracionParametroCarga = new DAConfiguracionParametroCarga(ent.PaisID);
            var DAConfiguracionValidacion = new DAConfiguracionValidacion(ent.PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                DAConfiguracionParametroCarga.DelConfiguracionParametroCarga(ent.CampaniaID);
                DAConfiguracionValidacion.Insert(ent);

                foreach (var item in lista)
                {
                    entidad = new BEConfiguracionParametroCarga();
                    entidad.PaisID = item.PaisID;
                    entidad.CampaniaID = ent.CampaniaID;
                    entidad.ZonaID = item.ZonaID;
                    entidad.ValidacionActiva = item.ValidacionActiva;
                    entidad.DiasParametroCarga = item.DiasParametroCarga;
                    DAConfiguracionParametroCarga.InsConfiguracionParametroCarga(entidad);
                }
                transaction.Complete();
            }
        }

        public void UpdConfiguracionParametroCarga(BEConfiguracionValidacion ent, List<BEConfiguracionParametroCarga> lista)
        {
            BEConfiguracionParametroCarga entidad;
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            var DAConfiguracionParametroCarga = new DAConfiguracionParametroCarga(ent.PaisID);
            var DAConfiguracionValidacion = new DAConfiguracionValidacion(ent.PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                DAConfiguracionParametroCarga.DelConfiguracionParametroCarga(ent.CampaniaID);
                DAConfiguracionValidacion.Update(ent);

                foreach (var item in lista)
                {
                    entidad = new BEConfiguracionParametroCarga();
                    entidad.PaisID = item.PaisID;
                    entidad.CampaniaID = ent.CampaniaID;
                    entidad.ZonaID = item.ZonaID;
                    entidad.ValidacionActiva = item.ValidacionActiva;
                    entidad.DiasParametroCarga = item.DiasParametroCarga;
                    DAConfiguracionParametroCarga.InsConfiguracionParametroCarga(entidad);
                }
                transaction.Complete();
            }
        }

        public void DelConfiguracionParametroCarga(int paisID, int CampaniaID)
        {
            var DAConfiguracionParametroCarga = new DAConfiguracionParametroCarga(paisID);
            DAConfiguracionParametroCarga.DelConfiguracionParametroCarga(CampaniaID);
        }

        public IList<BEConfiguracionParametroCarga> GetRegionZonaDiasParametroCarga(int PaisID, int RegionID, int ZonaID)
        {
            var lista = new List<BEConfiguracionParametroCarga>();
            var DAConfiguracionParametroCarga = new DAConfiguracionParametroCarga(PaisID);

            using (IDataReader reader = DAConfiguracionParametroCarga.GetRegionZonaDiasParametroCarga(RegionID, ZonaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionParametroCarga(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void UpdConfiguracionParametroCargaPedido(int PaisID, List<BEConfiguracionParametroCarga> listaEntidades)
        {
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            var DAConfiguracionParametroCarga = new DAConfiguracionParametroCarga(PaisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                foreach (var entidad in listaEntidades)
                {
                    DAConfiguracionParametroCarga.UpdConfiguracionParametroCargaPedido(entidad);
                }
                transaction.Complete();
            }
        }

        public BEConfiguracionParametroCarga GetConfiguracionParametroCarga(int paisID, int campaniaID, int zonaID)
        {
            BEConfiguracionParametroCarga entidad = null;
            var DAConfiguracionParametroCarga = new DAConfiguracionParametroCarga(paisID);

            using (IDataReader reader = DAConfiguracionParametroCarga.GetConfiguracionParametroCarga(campaniaID, zonaID))
            {
                if (reader.Read())
                {
                    entidad = new BEConfiguracionParametroCarga(reader);
                    entidad.PaisID = paisID;
                }
            }
            return entidad;
        }
    }
}
