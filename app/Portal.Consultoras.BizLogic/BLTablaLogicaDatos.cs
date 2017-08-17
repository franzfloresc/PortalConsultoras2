using System;
using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLTablaLogicaDatos
    {
        private BLZonificacion BLZonificacion;

        public BLTablaLogicaDatos()
        {
            BLZonificacion = new BLZonificacion();
        }

        public List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, Int16 TablaLogicaID)
        {
            List<BETablaLogicaDatos> TablaLogicaDatos = new List<BETablaLogicaDatos>();

            var DATablaLogicaDatos = new DATablaLogicaDatos(paisID);
            using (IDataReader reader = DATablaLogicaDatos.GetTablaLogicaDatos(TablaLogicaID))
            {
                while (reader.Read())
                {
                    TablaLogicaDatos.Add(new BETablaLogicaDatos(reader));
                }
            }
            return TablaLogicaDatos;
        }

        public List<BETablaLogicaDatos> GetTablaLogicaDatosPais(Int16 TablaLogicaID)
        {
            List<BETablaLogicaDatos> tablalogica = new List<BETablaLogicaDatos>();

            var paises = BLZonificacion.SelectPaisesDD();

            foreach (var pais in paises)
            {
                var DATablaLogicaDatos = new DATablaLogicaDatos(pais.PaisID);
                using (IDataReader reader = DATablaLogicaDatos.GetTablaLogicaDatos(TablaLogicaID))
                {
                    while (reader.Read())
                    {
                        tablalogica.Add(new BETablaLogicaDatos(reader, pais.PaisID));
                    }
                }
            }

            return tablalogica;
        }
    }
}
