using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraCatalogo
    {
        public BEConsultoraCatalogo GetConsultoraCatalogo(int paisID, string codigoConsultora, bool parametroEsDocumento, int tipoFiltroUbigeo)
        {
            BEConsultoraCatalogo beConsultoraCatalogo = new BEConsultoraCatalogo();
            DAConsultoraCatalogo daConsultoraCatalogo = new DAConsultoraCatalogo(paisID);

            using (IDataReader reader = daConsultoraCatalogo.GetConsultoraCatalogo(paisID, codigoConsultora, parametroEsDocumento, tipoFiltroUbigeo))
            {
                if (reader.Read()) beConsultoraCatalogo = new BEConsultoraCatalogo(reader);
            }

            int estadoInfoPreLogin = new BLUsuario().GetInfoPreLoginConsultoraCatalogo(paisID, beConsultoraCatalogo.CodigoUsuario);
            switch (estadoInfoPreLogin)
            {
                case 3: beConsultoraCatalogo.Estado = 1; break;
                case 1: beConsultoraCatalogo.Estado = 0; break;
                case 2: beConsultoraCatalogo.Estado = 0; break;
                default: beConsultoraCatalogo.Estado = -1; break;
            }

            return beConsultoraCatalogo;
        }

        public List<BEConsultoraCatalogo> GetConsultorasPorCodigoTerritorioGeo(int paisId, string codigoRegion, string codigoZona, string codigoSeccion, string codigoTerritorio)
        {
            List<BEConsultoraCatalogo> listaConsultoraCatalogo = new List<BEConsultoraCatalogo>();
            BEConsultoraCatalogo consultoraCatalogo;
            DAConsultora oDaConsultora = new DAConsultora(paisId);

            int nroCampanias = new BLZonificacion().GetPaisNumeroCampaniasByPaisID(paisId);
            BLTablaLogicaDatos oBlTablaLogicaDatos = new BLTablaLogicaDatos();
            List<BETablaLogicaDatos> tablaRetirada = oBlTablaLogicaDatos.GetList(paisId, 12);
            List<BETablaLogicaDatos> tablaReingresada = oBlTablaLogicaDatos.GetList(paisId, 18);
            List<BETablaLogicaDatos> tablaEgresada = oBlTablaLogicaDatos.GetList(paisId, 19);

            using (IDataReader reader = oDaConsultora.GetConsultorasPorTerritorio(paisId, codigoRegion, codigoZona, codigoSeccion, codigoTerritorio))
            {
                while (reader.Read())
                {
                    consultoraCatalogo = new BEConsultoraCatalogo(reader);
                    consultoraCatalogo.Estado = this.GetConsultoraCatalogoEstado(paisId, nroCampanias, consultoraCatalogo, tablaRetirada, tablaReingresada, tablaEgresada);
                    if (consultoraCatalogo.Estado == 1) listaConsultoraCatalogo.Add(consultoraCatalogo);
                }
            }
            if (listaConsultoraCatalogo.Count > 0) return listaConsultoraCatalogo;

            using (IDataReader reader = oDaConsultora.GetConsultorasPorSeccion(paisId, codigoRegion, codigoZona, codigoSeccion))
            {
                while (reader.Read())
                {
                    consultoraCatalogo = new BEConsultoraCatalogo(reader);
                    consultoraCatalogo.Estado = this.GetConsultoraCatalogoEstado(paisId, nroCampanias, consultoraCatalogo, tablaRetirada, tablaReingresada, tablaEgresada);
                    if (consultoraCatalogo.Estado == 1) listaConsultoraCatalogo.Add(consultoraCatalogo);
                }
            }
            if (listaConsultoraCatalogo.Count > 0) return listaConsultoraCatalogo;

            using (IDataReader reader = oDaConsultora.GetConsultorasPorZona(paisId, codigoRegion, codigoZona))
            {
                while (reader.Read())
                {
                    consultoraCatalogo = new BEConsultoraCatalogo(reader);
                    consultoraCatalogo.Estado = this.GetConsultoraCatalogoEstado(paisId, nroCampanias, consultoraCatalogo, tablaRetirada, tablaReingresada, tablaEgresada);
                    if (consultoraCatalogo.Estado == 1) listaConsultoraCatalogo.Add(consultoraCatalogo);
                }
            }
            return listaConsultoraCatalogo;
        }

        public List<BEConsultoraCatalogo> GetConsultorasCatalogosPorUbigeo(int paisId, string codigoUbigeo, int marcaId, int tipoFiltroUbigeo)
        {
            List<BEConsultoraCatalogo> listaConsultoraCatalogo = new List<BEConsultoraCatalogo>();
            if (paisId > 0)
            {
                var dAConsultoraCatalogo = new DAConsultoraCatalogo(paisId);
                using (IDataReader reader = dAConsultoraCatalogo.GetConsultorasCatalogosPorUbigeo(paisId, codigoUbigeo, marcaId, tipoFiltroUbigeo))
                {
                    while (reader.Read()) { listaConsultoraCatalogo.Add(new BEConsultoraCatalogo(reader)); }
                }
                SetConsultorasCatalogosEstado(paisId, listaConsultoraCatalogo);
            }
            return listaConsultoraCatalogo.Where(x => x.Estado == 1).ToList();
        }

        public List<BEConsultoraCatalogo> GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(int paisId, string codigoUbigeo, string nombres, string apellidos, int marcaId, int tipoFiltroUbigeo)
        {
            List<BEConsultoraCatalogo> listaConsultoraCatalogo = new List<BEConsultoraCatalogo>();
            if (paisId > 0)
            {
                var dAConsultoraCatalogo = new DAConsultoraCatalogo(paisId);
                using (IDataReader reader = dAConsultoraCatalogo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos(paisId, codigoUbigeo, nombres, apellidos, marcaId, tipoFiltroUbigeo))
                {
                    while (reader.Read()) { listaConsultoraCatalogo.Add(new BEConsultoraCatalogo(reader)); }
                }
                SetConsultorasCatalogosEstado(paisId, listaConsultoraCatalogo);
            }
            return listaConsultoraCatalogo.Where(x => x.Estado == 1).ToList();
        }

        public List<BEConsultoraCatalogo> GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos(int paisId, string codigoUbigeo, string nombres, string apellidos, int marcaId, int tipoFiltroUbigeo)
        {
            List<BEConsultoraCatalogo> listaConsultoraCatalogo = new List<BEConsultoraCatalogo>();
            if (paisId > 0)
            {
                var dAConsultoraCatalogo = new DAConsultoraCatalogo(paisId);
                using (IDataReader reader = dAConsultoraCatalogo.GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos(paisId, codigoUbigeo, nombres, apellidos, marcaId, tipoFiltroUbigeo))
                {
                    while (reader.Read()) { listaConsultoraCatalogo.Add(new BEConsultoraCatalogo(reader)); }
                }
                SetConsultorasCatalogosEstado(paisId, listaConsultoraCatalogo);
            }
            return listaConsultoraCatalogo.Where(x => x.Estado == 1).ToList();
        }

        private void SetConsultorasCatalogosEstado(int paisID, List<BEConsultoraCatalogo> consultorasCatalogos)
        {
            int nroCampanias = new BLZonificacion().GetPaisNumeroCampaniasByPaisID(paisID);
            BLTablaLogicaDatos oBlTablaLogicaDatos = new BLTablaLogicaDatos();
            List<BETablaLogicaDatos> tablaRetirada = oBlTablaLogicaDatos.GetList(paisID, 12);
            List<BETablaLogicaDatos> tablaReingresada = oBlTablaLogicaDatos.GetList(paisID, 18);
            List<BETablaLogicaDatos> tablaEgresada = oBlTablaLogicaDatos.GetList(paisID, 19);

            foreach (BEConsultoraCatalogo consultoraCatalogo in consultorasCatalogos)
            {
                consultoraCatalogo.Estado = this.GetConsultoraCatalogoEstado(paisID, nroCampanias, consultoraCatalogo, tablaRetirada, tablaReingresada, tablaEgresada);
            }
        }

        private int GetConsultoraCatalogoEstado(int paisID, int nroCampanias, BEConsultoraCatalogo consultoraCatalogo, List<BETablaLogicaDatos> tabla_Retirada, List<BETablaLogicaDatos> tabla_Reingresada, List<BETablaLogicaDatos> tabla_Egresada)
        {
            if (string.IsNullOrEmpty(consultoraCatalogo.CodigoUsuario)) return -1;
            if (string.IsNullOrEmpty(consultoraCatalogo.AutorizaPedido)) return -1; //Se asume para usuarios del tipo SAC
            if (consultoraCatalogo.RolId == 0) return 0;
            if (consultoraCatalogo.IdEstadoActividad == -1) return 1; //Se asume para usuarios del tipo SAC

            bool autorizado = (consultoraCatalogo.AutorizaPedido != "N" && consultoraCatalogo.EsAfiliado);
            // Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
            if (paisID == 2
                || paisID == 3
                || paisID == Constantes.PaisID.Colombia
                || paisID == Constantes.PaisID.ElSalvador
                || paisID == Constantes.PaisID.Guatemala
                || paisID == Constantes.PaisID.Peru)
            {
                //Validamos si el estado es retirada
                BETablaLogicaDatos restriccion = tabla_Retirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == consultoraCatalogo.IdEstadoActividad);
                if (restriccion != null)
                {
                    if (paisID == Constantes.PaisID.Colombia) return 0;
                    return autorizado ? 1 : 0;
                }

                //Validamos si el estado es reingresada
                BETablaLogicaDatos restriccionReingreso = tabla_Reingresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == consultoraCatalogo.IdEstadoActividad);
                if (restriccionReingreso != null)
                {
                    if (paisID == 3)
                    {
                        //Se valida las campañas que no ha ingresado
                        int campaniaSinIngresar = 0;
                        if (consultoraCatalogo.CampaniaActual.ToString().Length == 6 && consultoraCatalogo.UltimaCampania.ToString().Length == 6)
                        {
                            campaniaSinIngresar = consultoraCatalogo.CampaniaActual - Util.AddCampaniaAndNumero(consultoraCatalogo.UltimaCampania, 3, nroCampanias);
                        }
                        if (campaniaSinIngresar > 0) return 0;
                    }
                    else if (paisID == Constantes.PaisID.Colombia) return 0;
                }
                else if (paisID == Constantes.PaisID.Colombia)
                {
                    //Egresada o Posible Egreso
                    BETablaLogicaDatos restriccionEgresada = tabla_Egresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == consultoraCatalogo.IdEstadoActividad);
                    if (restriccionEgresada != null) return 0;
                }
                return autorizado ? 1 : 0;
            }
            // Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
            else if (paisID == 1
                || paisID == Constantes.PaisID.CostaRica
                || paisID == Constantes.PaisID.Ecuador
                || paisID == Constantes.PaisID.Mexico
                || paisID == Constantes.PaisID.Panama
                || paisID == Constantes.PaisID.PuertoRico
                || paisID == Constantes.PaisID.RepublicaDominicana
                || paisID == Constantes.PaisID.Venezuela)
            {
                // Validamos si la consultora es retirada
                BETablaLogicaDatos restriccion = tabla_Retirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == consultoraCatalogo.IdEstadoActividad);
                if (restriccion != null) return 0; //Validamos el Autoriza Pedido

                return autorizado ? 1 : 0; //Validamos el Autoriza Pedido
            }
            return 1;
        }

        public int InsLogClienteRegistraConsultoraCatalogo(int paisID, int consultoraId, string codigoConsultora,
            int campaniaId, string tipoBusqueda, int conoceConsultora, string codigoDispositivo, string soDispotivivo,
            string unidadGeo1, string unidadGeo2, string unidadGeo3, string nombreCliente, string emailCliente,
            string telefonoCliente, int nuevaConsultora)
        {

            try
            {
                DAConsultoraCatalogo da = new DAConsultoraCatalogo(paisID);
                int registro = da.InsLogClienteRegistraConsultoraCatalogo(consultoraId, codigoConsultora, campaniaId,
                    tipoBusqueda, conoceConsultora, codigoDispositivo, soDispotivivo, unidadGeo1, unidadGeo2, unidadGeo3,
                    nombreCliente, emailCliente, telefonoCliente, nuevaConsultora);
                return registro;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraId.ToString(), paisID.ToString());
                return 0;
            }

        }

    }
}