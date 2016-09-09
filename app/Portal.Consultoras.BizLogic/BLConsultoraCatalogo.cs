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
                if (reader.Read())
                {
                    beConsultoraCatalogo = new BEConsultoraCatalogo(reader);
                }
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
            DAConsultora oDAConsultora = new DAConsultora(paisId);
            
            BLTablaLogicaDatos oBLTablaLogicaDatos = new BLTablaLogicaDatos();
            List<BETablaLogicaDatos> tabla_Retirada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisId, 12);
            List<BETablaLogicaDatos> tabla_Reingresada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisId, 18);
            List<BETablaLogicaDatos> tabla_Egresada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisId, 19);

            using (IDataReader reader = oDAConsultora.GetConsultorasPorTerritorio(paisId, codigoRegion, codigoZona, codigoSeccion, codigoTerritorio))
            {
                while (reader.Read()) 
                {
                    consultoraCatalogo = new BEConsultoraCatalogo(reader);
                    consultoraCatalogo.Estado = this.GetConsultoraCatalogoEstado(paisId, consultoraCatalogo, tabla_Retirada, tabla_Reingresada, tabla_Egresada);
                    if (consultoraCatalogo.Estado == 1) listaConsultoraCatalogo.Add(consultoraCatalogo); 
                }
            }
            if (listaConsultoraCatalogo.Count > 0) return listaConsultoraCatalogo;
            
            using (IDataReader reader = oDAConsultora.GetConsultorasPorSeccion(paisId, codigoRegion, codigoZona, codigoSeccion))
            {
                while (reader.Read())
                {
                    consultoraCatalogo = new BEConsultoraCatalogo(reader);
                    consultoraCatalogo.Estado = this.GetConsultoraCatalogoEstado(paisId, consultoraCatalogo, tabla_Retirada, tabla_Reingresada, tabla_Egresada);
                    if (consultoraCatalogo.Estado == 1) listaConsultoraCatalogo.Add(consultoraCatalogo);
                }
            }
            if (listaConsultoraCatalogo.Count > 0) return listaConsultoraCatalogo;

            using (IDataReader reader = oDAConsultora.GetConsultorasPorZona(paisId, codigoRegion, codigoZona))
            {
                while (reader.Read())
                {
                    consultoraCatalogo = new BEConsultoraCatalogo(reader);
                    consultoraCatalogo.Estado = this.GetConsultoraCatalogoEstado(paisId, consultoraCatalogo, tabla_Retirada, tabla_Reingresada, tabla_Egresada);
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
            BLTablaLogicaDatos oBLTablaLogicaDatos = new BLTablaLogicaDatos();
            List<BETablaLogicaDatos> tabla_Retirada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 12);
            List<BETablaLogicaDatos> tabla_Reingresada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 18);
            List<BETablaLogicaDatos> tabla_Egresada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 19);

            foreach (BEConsultoraCatalogo consultoraCatalogo in consultorasCatalogos)
            {
                consultoraCatalogo.Estado = this.GetConsultoraCatalogoEstado(paisID, consultoraCatalogo, tabla_Retirada, tabla_Reingresada, tabla_Egresada);
            }
        }

        private int GetConsultoraCatalogoEstado(int paisID, BEConsultoraCatalogo consultoraCatalogo, List<BETablaLogicaDatos> tabla_Retirada, List<BETablaLogicaDatos> tabla_Reingresada, List<BETablaLogicaDatos> tabla_Egresada)
        {
            if (string.IsNullOrEmpty(consultoraCatalogo.CodigoUsuario)) return -1;
            if (string.IsNullOrEmpty(consultoraCatalogo.AutorizaPedido)) return -1; //Se asume para usuarios del tipo SAC
            if (consultoraCatalogo.RolId == 0) return 0;
            if (consultoraCatalogo.IdEstadoActividad == -1) return 1; //Se asume para usuarios del tipo SAC

            bool autorizado = (consultoraCatalogo.AutorizaPedido != "N" && consultoraCatalogo.EsAfiliado);
            // Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
            if (paisID == 11 || paisID == 2 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 4)
            {
                //Validamos si el estado es retirada
                BETablaLogicaDatos Restriccion = tabla_Retirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == consultoraCatalogo.IdEstadoActividad);
                if (Restriccion != null)
                {
                    if (paisID == 4) return 0; //Caso Colombia
                    return autorizado ? 1 : 0;
                }

                //Validamos si el estado es reingresada
                BETablaLogicaDatos Restriccion_reingreso = tabla_Reingresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == consultoraCatalogo.IdEstadoActividad);
                if (Restriccion_reingreso != null)
                {
                    if (paisID == 3)
                    {
                        int ultimaCampania = consultoraCatalogo.UltimaCampania;
                        int campaniaActual = consultoraCatalogo.CampaniaActual;

                        //Se valida las campañas que no ha ingresado
                        if (ultimaCampania != 0 && campaniaActual.ToString().Length == 6 && ultimaCampania.ToString().Length == 6)
                        {
                            string CA = campaniaActual.ToString().Substring(0, 4);
                            string UC = ultimaCampania.ToString().Substring(0, 4);
                            if (CA != UC)
                            {
                                CA = campaniaActual.ToString().Substring(4, 2);
                                UC = ultimaCampania.ToString().Substring(4, 2);
                                campaniaActual = Convert.ToInt32(UC) + Convert.ToInt16(CA);
                                ultimaCampania = Convert.ToInt32(UC);
                            }
                        }

                        if (campaniaActual - ultimaCampania > 3 && ultimaCampania != 0) return 0;
                    }
                    else if (paisID == 4) return 0; //Caso Colombia
                }
                else if (paisID == 4) //Caso Colombia
                {
                    //Egresada o Posible Egreso
                    BETablaLogicaDatos Restriccion_Egresada = tabla_Egresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == consultoraCatalogo.IdEstadoActividad);
                    if (Restriccion_Egresada != null) return 0;
                }
                return autorizado ? 1 : 0;
            }
            // Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
            else if (paisID == 5 || paisID == 10 || paisID == 9 || paisID == 12 || paisID == 13 || paisID == 6 || paisID == 1 || paisID == 14)
            {
                // Validamos si la consultora es retirada
                BETablaLogicaDatos Restriccion = tabla_Retirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == consultoraCatalogo.IdEstadoActividad);
                if (Restriccion != null) return 0; //Validamos el Autoriza Pedido

                return autorizado ? 1 : 0; //Validamos el Autoriza Pedido
            }
            return 1;
        }
    }
}
