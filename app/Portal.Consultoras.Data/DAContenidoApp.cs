﻿using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAContenidoApp : DataAccess
    {
        public DAContenidoApp()
            : base()
        {

        }

        public IDataReader Get(string Codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppGet");
            Context.Database.AddInParameter(command, "@Codigo", DbType.AnsiString, Codigo);
            return Context.ExecuteReader(command);

        }

        public void UpdContenidoApp(BEContenidoAppHistoria p)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppUpd");
            Context.Database.AddInParameter(command, "@IdContenido", DbType.Int32, p.IdContenido);
            Context.Database.AddInParameter(command, "@UrlMiniatura", DbType.AnsiString, p.UrlMiniatura);
            Context.Database.AddInParameter(command, "@DesdeCampania", DbType.Int32, p.DesdeCampania);

            try
            {
                bool iresult = Context.ExecuteNonQuery(command) == 1 ? true : false;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            
        }

        public IDataReader GetList(BEContenidoAppList p)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppDetaList");
            Context.Database.AddInParameter(command, "@IdContenido", DbType.Int32, p.IdContenido);
            return Context.ExecuteReader(command);
        }

        public void InsertContenidoAppDeta(BEContenidoAppDeta p)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppDetaInsert");
            Context.Database.AddInParameter(command, "@IdContenido", DbType.Int32, p.IdContenido);
            Context.Database.AddInParameter(command, "@RutaContenido", DbType.AnsiString, p.RutaContenido);
            Context.Database.AddInParameter(command, "@tipo", DbType.AnsiString, p.Tipo);

            try
            {
                bool iresult = Context.ExecuteNonQuery(command) == 1 ? true : false;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public int UpdContenidoAppDeta(BEContenidoAppDeta p)
        {
          
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppDetaUpd");
            Context.Database.AddInParameter(command, "@IdContenidoDeta", DbType.Int32, p.IdContenidoDeta);
            Context.Database.AddInParameter(command, "@IdContenido", DbType.Int32, p.IdContenido);
            Context.Database.AddOutParameter(command, "@respuesta", DbType.Int32, 1000);

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@respuesta"].Value);


        }
    }
}