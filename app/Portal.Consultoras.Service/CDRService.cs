﻿using Portal.Consultoras.BizLogic.CDR;
using Portal.Consultoras.Entities.CDR;
using Portal.Consultoras.ServiceContracts;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class CDRService : ICDRService
    {
        private BLCDRWeb BLCDRWeb;
        private BLCDRWebDetalle BLCDRWebDetalle;
        private BLCDRWebMotivoOperacion BLCDRWebMotivoOperacion;
        private BLCDRWebDescripcion BLCDRWebDescripcion;
        private BLLogCDRWeb bLLogCDRWeb;
        private BLLogCDRWebDetalle bLLogCDRWebDetalle;
        private BLCDRParametria BLCDRParametria;
        private BLCDRWebDatos BLCDRWebDatos;

        public CDRService()
        {
            BLCDRWeb = new BLCDRWeb();
            BLCDRWebDetalle = new BLCDRWebDetalle();
            BLCDRWebMotivoOperacion = new BLCDRWebMotivoOperacion();
            BLCDRWebDescripcion = new BLCDRWebDescripcion();
            bLLogCDRWeb = new BLLogCDRWeb();
            bLLogCDRWebDetalle = new BLLogCDRWebDetalle();
            BLCDRParametria = new BLCDRParametria();
            BLCDRWebDatos = new BLCDRWebDatos();
        }

        public int InsCDRWeb(int PaisID, BECDRWeb entity)
        {
            return BLCDRWeb.InsCDRWeb(PaisID, entity);
        }

        public int DelCDRWeb(int PaisID, BECDRWeb entity)
        {
            return BLCDRWeb.DelCDRWeb(PaisID, entity);
        }

        public List<BECDRWeb> GetCDRWeb(int PaisID, BECDRWeb entity)
        {
            return BLCDRWeb.GetCDRWeb(PaisID, entity);
        }

        public int UpdEstadoCDRWeb(int PaisID, BECDRWeb entity)
        {
            return BLCDRWeb.UpdEstadoCDRWeb(PaisID, entity);
        }

        public int InsCDRWebDetalle(int PaisID, BECDRWebDetalle entity)
        {
            return BLCDRWebDetalle.InsCDRWebDetalle(PaisID, entity);
        }

        public int DelCDRWebDetalle(int PaisID, BECDRWebDetalle entity)
        {
            return BLCDRWebDetalle.DelCDRWebDetalle(PaisID, entity);
        }

        public List<BECDRWebDetalle> GetCDRWebDetalle(int PaisID, BECDRWebDetalle entity, int pedidoId)
        {
            return BLCDRWebDetalle.GetCDRWebDetalle(PaisID, entity, pedidoId);
        }

        public List<BECDRWebDetalle> GetCDRWebDetalleLog(int PaisID, BELogCDRWeb entity)
        {
            return BLCDRWebDetalle.GetCDRWebDetalleLog(PaisID, entity);
        }

        public int InsCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity)
        {
            return BLCDRWebMotivoOperacion.InsCDRWebMotivoOperacion(PaisID, entity);
        }

        public int DelCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity)
        {
            return BLCDRWebMotivoOperacion.DelCDRWebMotivoOperacion(PaisID, entity);
        }

        public List<BECDRWebMotivoOperacion> GetCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity)
        {
            return BLCDRWebMotivoOperacion.GetCDRWebMotivoOperacion(PaisID, entity);
        }


        public int InsCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity)
        {
            return BLCDRWebDescripcion.InsCDRWebDescripcion(PaisID, entity);
        }

        public int DelCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity)
        {
            return BLCDRWebDescripcion.DelCDRWebDescripcion(PaisID, entity);
        }

        public List<BECDRWebDescripcion> GetCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity)
        {
            return BLCDRWebDescripcion.GetCDRWebDescripcion(PaisID, entity);
        }

        public BELogCDRWeb GetLogCDRWebByLogCDRWebId(int paisId, long logCDRWebId)
        {
            return this.bLLogCDRWeb.GetByLogCDRWebId(paisId, logCDRWebId);
        }

        public int UpdateLogCDRWebVisualizado(int paisId, long logCDRWebId)
        {
            return this.bLLogCDRWeb.UpdateVisualizado(paisId, logCDRWebId);
        }

        public List<BELogCDRWebDetalle> GetLogCDRWebDetalleByLogCDRWebId(int paisId, long logCDRWebId)
        {
            return this.bLLogCDRWebDetalle.GetByLogCDRWebId(paisId, logCDRWebId);
        }

        public bool DetalleActualizarObservado(int paisId, List<BECDRWebDetalle> lista)
        {
            return BLCDRWebDetalle.DetalleActualizarObservado(paisId, lista);
        }

        public List<BECDRParametria> GetCDRParametria(int paisId, BECDRParametria entidad)
        {
            return BLCDRParametria.GetCDRParametria(paisId, entidad);
        }

        public List<BECDRWebDatos> GetCDRWebDatos(int paisId, BECDRWebDatos entidad)
        {
            return BLCDRWebDatos.GetCDRWebDatos(paisId, entidad);
        }
    }
}
