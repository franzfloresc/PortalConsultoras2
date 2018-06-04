using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLCategoria
    {
        public List<BECategoria> SelectCategorias(int paisID)
        {
            var lista = new List<BECategoria>();
            var da = new DACategoria(paisID);

            using (IDataReader reader = da.GetCategorias())
                while (reader.Read())
                {
                    var app = new BECategoria(reader);
                    lista.Add(app);
                }

            return lista;
        }
    }
}
