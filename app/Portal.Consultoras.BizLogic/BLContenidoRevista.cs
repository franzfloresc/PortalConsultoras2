using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLContenidoRevista:IDisposable
    {
        private  DAContenidoRevista _daContenidoRevista;
        public BLContenidoRevista()
        {
            _daContenidoRevista=new DAContenidoRevista();
        }
        public BLContenidoRevista(int paisId)
        {
            _daContenidoRevista = new DAContenidoRevista(paisId);
        }
        public int Insertar(string nroCompania, string rutaImagenPortada)
        {

            return _daContenidoRevista.Insertar(nroCompania, rutaImagenPortada);
        }

        public int ActualizarById(int id, string rutaImagenPortada)
        {
           return _daContenidoRevista.ActualizarById(id,rutaImagenPortada);
        }
        public int EliminarById(int id)
        {
           return _daContenidoRevista.EliminarById(id);
        }

        public BEContenidoRevista ObtenerByCampania(string campania)
        {
            return _daContenidoRevista.ObtenerByCampania(campania);
        }
        public IList<BEContenidoRevista> ObtenerByCampania(string campania, int pageSize, int pageNum, out int totalRows)
        {
            return _daContenidoRevista.ObtenerByCampania(campania,pageSize,pageNum,out totalRows);
        }
        public BEContenidoRevista ObtenerById(int id)
        {
            return _daContenidoRevista.ObtenerById(id);
        }
        public void Dispose()
        {
            _daContenidoRevista = null;
        }
    }
}
