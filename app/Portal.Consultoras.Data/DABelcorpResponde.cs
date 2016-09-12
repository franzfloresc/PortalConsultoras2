﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DABelcorpResponde : DataAccess
    {
        public DABelcorpResponde()
            : base()
        {

        }

        public IDataReader GetBelcorpResponde(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBelcorpResponde");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);

            return Context.ExecuteReader(command);
        }

        public void InsBelcorpResponde(BEBelcorpResponde BelcorpResponde)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsBelcorpResponde");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, BelcorpResponde.PaisID);
            Context.Database.AddInParameter(command, "@Telefono1", DbType.AnsiString, BelcorpResponde.Telefono1);
            Context.Database.AddInParameter(command, "@Telefono2", DbType.AnsiString, BelcorpResponde.Telefono2);
            Context.Database.AddInParameter(command, "@Escribenos", DbType.AnsiString, BelcorpResponde.Escribenos);
            Context.Database.AddInParameter(command, "@EscribenosURL", DbType.AnsiString, BelcorpResponde.EscribenosURL);
            Context.Database.AddInParameter(command, "@Correo", DbType.AnsiString, BelcorpResponde.Correo);
            Context.Database.AddInParameter(command, "@CorreoBcc", DbType.AnsiString, BelcorpResponde.CorreoBcc);
            Context.Database.AddInParameter(command, "@Chat", DbType.AnsiString, BelcorpResponde.Chat);
            Context.Database.AddInParameter(command, "@ChatURL", DbType.AnsiString, BelcorpResponde.ChatURL);
            Context.Database.AddInParameter(command, "@ParametroPais", DbType.AnsiString, BelcorpResponde.ParametroPais);
            Context.Database.AddInParameter(command, "@ParametroCodigoConsultora", DbType.AnsiString, BelcorpResponde.ParametroCodigoConsultora);

            Context.ExecuteNonQuery(command);
        }
    }
}
