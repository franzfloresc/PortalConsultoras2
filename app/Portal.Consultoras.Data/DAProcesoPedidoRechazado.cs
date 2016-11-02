﻿using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAProcesoPedidoRechazado : DataAccess
    {
        public DAProcesoPedidoRechazado(int paisID)
            : base(paisID, EDbSource.Portal)
        { }

        public IDataReader ObtenerProcesoPedidoRechazadoGPR(int campaniaID, long consultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerProcesoPedidoRechazadoGPR_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraID);

            return Context.ExecuteReader(command);
        }
    }
}
