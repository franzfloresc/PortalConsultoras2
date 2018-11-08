using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ArmaTuPack;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic.ArmaTuPack
{
    public class BLArmaTuPack : IArmaTuPackBusinessLogic
    {
        private readonly ITablaLogicaDatosBusinessLogic bLTablaLogicaDatos;

        public BLArmaTuPack(ITablaLogicaDatosBusinessLogic _bLTablaLogicaDatos)
        {
            bLTablaLogicaDatos = _bLTablaLogicaDatos;
        }
        public BLArmaTuPack() : this(new BLTablaLogicaDatos()) { }

        public bool CuvEstaEnLimite(int paisID, int campaniaID, string zona, string cuv, int cantidadIngresada, int cantidadActual)
        {
            var dicCuvListZona = GetDictionaryCuvZonaListCache(paisID, campaniaID.ToString());
            if (!dicCuvListZona.ContainsKey(cuv)) return false;

            var listZona = dicCuvListZona[cuv];
            if (listZona.Count > 0 && !listZona.Contains(zona)) return false;
            
            if (cantidadIngresada > 1) return true;
            if (cantidadActual > 0) return true;
            return false;
        }

        private Dictionary<string, List<string>> GetDictionaryCuvZonaListCache(int paisID, string campaniaID)
        {
            return CacheManager<Dictionary<string, List<string>>>.ValidateDataElement(paisID, ECacheItem.CuvListZonaArmaTuPack, campaniaID.ToString(), () => GetDictionaryCuvListZona(paisID, campaniaID), new TimeSpan(7, 0, 0, 0));
        }
        private Dictionary<string, List<string>> GetDictionaryCuvListZona(int paisID, string campaniaID)
        {
            var dicCuvListZona = new Dictionary<string, List<string>>();

            var listProgramaCampania = GetListProgramaCache(paisID).Where(p => p.ListCampania.Contains(campaniaID)).ToList();
            foreach(var programa in listProgramaCampania)
            {
                foreach (var cuv in programa.ListCuv)
                {
                    if (!dicCuvListZona.ContainsKey(cuv)) dicCuvListZona.Add(cuv, programa.ListZona);
                }
            }

            return dicCuvListZona;
        }

        private List<BEProgramaArmaTuPack> GetListProgramaCache(int paisID)
        {
            return CacheManager<List<BEProgramaArmaTuPack>>.ValidateDataElement(paisID, ECacheItem.ProgramaArmaTuPack, "", () => GetListPrograma(paisID), new TimeSpan(7, 0, 0, 0));
        }
        private List<BEProgramaArmaTuPack> GetListPrograma(int paisID)
        {
            var listConfig = bLTablaLogicaDatos.GetListCache(paisID, Constantes.TablaLogica.ArmaTuPack);

            var listGrupos = GetListItemsConfig(listConfig, "Grupos");
            if (listGrupos.Count == 0) return new List<BEProgramaArmaTuPack>();

            return listGrupos.Select(g => new BEProgramaArmaTuPack
            {
                ListCampania = GetListItemsConfig(listConfig, string.Format("{0}.Campanias", g)),
                ListZona = GetListItemsConfig(listConfig, string.Format("{0}.Zonas", g)),
                ListCuv = GetListItemsConfig(listConfig, string.Format("{0}.Cuvs", g))
            }).ToList();
        }

        private List<string> GetListItemsConfig(List<BETablaLogicaDatos> listTablaLogicaDato, string codigo)
        {
            var item = listTablaLogicaDato.FirstOrDefault(d => d.Codigo == codigo);
            if (item == null || string.IsNullOrWhiteSpace(item.Valor)) return new List<string>();

            return item.Valor.Split(new char[] { ',', ';' }).Select(s => s.Trim()).ToList();
        }
    }
}
