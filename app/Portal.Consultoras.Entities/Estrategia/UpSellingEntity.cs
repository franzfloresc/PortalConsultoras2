using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Estrategia
{
    public class UpSellingEntity
    {
        public int UpSellingId { get; set; }
        public int CodigoCampana { get; set; }

        public decimal MontoMeta { get; set; }

        [Column("TextoMeta1")]
        public string TextoMeta { get; set; }

        [Column("TextoMeta2")]
        public string TextoMetaSecundario { get; set; }

        [Column("TextoGanaste1")]
        public string TextoGanaste { get; set; }

        [Column("TextoGanaste2")]
        public string TextoGanasteSecundario { get; set; }


    }
}
