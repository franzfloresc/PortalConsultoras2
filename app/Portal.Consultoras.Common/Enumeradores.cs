using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class Enumeradores
    {
        public enum DateInterval
        {
            Second,
            Minute,
            Hour,
            Day,
            Week,
            Month,
            Quarter,
            Year
        }

        public enum TypeDocExtension
        {
            Word,
            Excel
        }

        //2140
        public enum TypeDocPais
        {
            AR = 1,
            BO = 2,
            CL = 3,
            CO = 4,
            CR = 5,
            EC = 6,
            SV = 7,
            GT = 8,
            MX = 9,
            PA = 10,
            PE = 11,
            PR = 12,
            DO = 13,
            VE = 14
        }

        //2295
        public enum TypeMarca
        {
            LBel = 1,
            Esika = 2,
            Cyzone = 3,
            SM = 4,
            HomeCollection = 5,
            Finart = 6,
            Generico = 7,
            Glance = 8
        }
    }
}
