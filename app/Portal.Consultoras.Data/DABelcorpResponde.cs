using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Comunicado;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

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

        #region Gestor de Poputs
        public IDataReader GetListaPoput(int estado, string campania,int Paginas,int Filas)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetListadoPoput");
            Context.Database.AddInParameter(command, "@Campania", DbType.AnsiString, campania);
            Context.Database.AddInParameter(command, "@Activo", DbType.Int32, estado);
            Context.Database.AddInParameter(command, "@Paginas", DbType.Int32, Paginas);
            Context.Database.AddInParameter(command, "@Filas", DbType.Int32, Filas);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetDetallePoput(int comunicadoid)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDetallePoput");
            Context.Database.AddInParameter(command, "@Comunicadoid", DbType.Int32, comunicadoid);
            return Context.ExecuteReader(command);
        }

        public int  GuardarPoputs(string tituloPrincipal, string descripcion, string UrlImagen, string fechaMaxima, string fechaMinima, bool checkDesktop, bool checkMobile, int accionID,string[] arrayColumnasBEComunicadoSegmentacion, string comunicadoId, string nombreArchivo, string codigoCampania, string descripcionAccion)
        {
            int TipoDispositivo = 0;
           DbCommand command = Context.Database.GetStoredProcCommand("dbo.GuardarPoput");
            if (checkMobile && !checkDesktop) TipoDispositivo = 1;
            if (!checkMobile && checkDesktop) TipoDispositivo = 2;
            /*cabecera*/
            Context.Database.AddInParameter(command, "@comunicadoId", DbType.AnsiString, comunicadoId);
            Context.Database.AddInParameter(command, "@tituloPrincipal", DbType.AnsiString, tituloPrincipal);
            Context.Database.AddInParameter(command, "@descripcion", DbType.AnsiString, descripcion);/*No hay campo para encajarlo*/
            Context.Database.AddInParameter(command, "@descripcionAccion", DbType.AnsiString, descripcionAccion);
            Context.Database.AddInParameter(command, "@urlImagen", DbType.AnsiString, UrlImagen);
            Context.Database.AddInParameter(command, "@fechaMinima", DbType.AnsiString, fechaMinima);
            Context.Database.AddInParameter(command, "@fechaMaxima", DbType.AnsiString, fechaMaxima);
            Context.Database.AddInParameter(command, "@TipoDispositivo", DbType.Int32, TipoDispositivo);
            Context.Database.AddInParameter(command, "@nombreArchivo", DbType.AnsiString, nombreArchivo);
            Context.Database.AddInParameter(command, "@codigoCampania", DbType.AnsiString, codigoCampania);
            Context.Database.AddInParameter(command, "@accionID", DbType.Int32, accionID);
            /*Detalle*/
            Context.Database.AddInParameter(command, "@RegionId", DbType.AnsiString, arrayColumnasBEComunicadoSegmentacion[0]!=null? arrayColumnasBEComunicadoSegmentacion[0].ToString():string.Empty );
            Context.Database.AddInParameter(command, "@ZonaId", DbType.AnsiString, arrayColumnasBEComunicadoSegmentacion[1] != null ? arrayColumnasBEComunicadoSegmentacion[0].ToString() : string.Empty);
            Context.Database.AddInParameter(command, "@Estado", DbType.AnsiString, arrayColumnasBEComunicadoSegmentacion[2] != null ? arrayColumnasBEComunicadoSegmentacion[0].ToString() : string.Empty);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, arrayColumnasBEComunicadoSegmentacion[3] != null ? arrayColumnasBEComunicadoSegmentacion[0].ToString() : string.Empty);

            return Context.ExecuteNonQuery(command);
        }
        #endregion
    }
}