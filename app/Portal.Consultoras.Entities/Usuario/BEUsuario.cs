using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuario
    {
        private string msCodigoConsultora;
        private string msCodigoUsuario;
        private int miPaisID;
        private string msNombre;
        private string msClaveSecreta;
        private string msActualizarClave;
        private string msConfirmarClave;
        private string msEMail;
        private bool mbEMailActivo;
        private string msTelefono;
        private string msTelefonoTrabajo;
        private string msCelular;
        [Column("Sobrenombre")]
        public string msSobrenombre { get; set; }
        [Column("PrimerNombre")]
        public string msPrimerNombre { get; set; }
        private bool mbCompartirDatos;
        private bool mbActivo;
        private Int16 miTipoUsuario;
        private bool mbCambioClave;
        //Campos dispuestos para la sesión de Usuario
        private string msCodigoISO;
        private int miRegionID;
        private string msCodigorRegion;
        private int miZonaID;
        private string msCodigoZona;
        private long miConsultoraID;
        private short miRolID;

        private int miCampaniaID;

        private DateTime mdFechaInicioFacturacion;
        private DateTime mdFechaFinFacturacion;
        private DateTime mdFechaFinFIC;
        private string msCampaniaDescripcion;
        private TimeSpan tsHoraInicio;
        private TimeSpan tsHoraFin;
        private bool mbZonaValida;
        private string msSimbolo;
        private int miTerritorioID;
        private string msCodigoTerritorio;
        private decimal mmMontoMinimoPedido;
        private decimal mmMontoMaximoPedido;
        private TimeSpan tsHoraInicioNoFacturable;
        private TimeSpan tsHoraCierreNoFacturable;
        private int miDiasAntes;
        private string mCodigoFuente;
        private string mBanderaImagen;
        private string mNombrePais;
        private int mConsultoraNueva;
        private string mSegmento;

        private int miDiasDuracionCronograma;
        private bool mHabilitarRestriccionHoraria;
        private string mAnoCampaniaIngreso;
        private string mPrimerNombre;
        private string mPrimerApellido;
        private int mHorasDuracionRestriccion;
        private bool mostrarAyudaWebTraking;
        private bool mPROLSinStock;
        private DateTime mdFechaModificacion;
        private string mdRol;
        private string mSegmentoConstancia;
        private string mSeccionAnalytics;
        private string mDescripcionNivel;

        [Column("ESCONSULTORALIDER")]
        public int mesConsultoraLider { get; set; }

        private bool bEstadoSimplificacionCUV { get; set; }
        private bool bEsquemaDAConsultora;
        private string digitoVerificador;
        private long consultoraAsociadoID;

        private string mSegmentoAbreviatura;

        [Column("TIENEHANA")]
        public bool tieneHana { get; set; }

        [Column("TieneODD")]
        public int tieneOdd { get; set; }

        [Column("TieneLoginExterno")]
        public int tieneLoginExterno { get; set; }

        public BEUsuario()
        {
        }

        [Obsolete("Use MapUtil.MapToCollection")]
        public BEUsuario(IDataRecord row)
        {
            msCodigoConsultora = row["CodigoConsultora"].ToString();
            msCodigoUsuario = row["CodigoUsuario"].ToString();
            miPaisID = Convert.ToInt32(row["PaisID"]);
            msNombre = row["Nombre"].ToString();
            msClaveSecreta = row["ClaveSecreta"].ToString();
            msEMail = row["EMail"].ToString();
            mbEMailActivo = Convert.ToBoolean(row["EMailActivo"]);
            msTelefono = row["Telefono"].ToString();
            msCelular = row["Celular"].ToString();
            msSobrenombre = row["Sobrenombre"].ToString();
            mbCompartirDatos = Convert.ToBoolean(row["CompartirDatos"]);
            mbActivo = Convert.ToBoolean(row["Activo"]);
            miTipoUsuario = Convert.ToInt16(row["TipoUsuario"]);
            mbCambioClave = Convert.ToBoolean(row["CambioClave"]);

            if (DataRecord.HasColumn(row, "TelefonoTrabajo"))
                msTelefonoTrabajo = Convert.ToString(row["TelefonoTrabajo"]);
            if (DataRecord.HasColumn(row, "AceptoContrato"))
                this.AceptoContrato = Convert.ToBoolean(row["AceptoContrato"]);
            if (DataRecord.HasColumn(row, "MostrarAyudaWebTraking"))
                MostrarAyudaWebTraking = Convert.ToBoolean(row["MostrarAyudaWebTraking"]);
            if (DataRecord.HasColumn(row, "CodigoISO"))
                CodigoISO = Convert.ToString(row["CodigoISO"]);
            if (DataRecord.HasColumn(row, "NombrePais"))
                NombrePais = Convert.ToString(row["NombrePais"]);
            if (DataRecord.HasColumn(row, "RolID"))
                RolID = Convert.ToByte(row["RolID"]);
            if (DataRecord.HasColumn(row, "BanderaImagen"))
                BanderaImagen = Convert.ToString(row["BanderaImagen"]);
            if (DataRecord.HasColumn(row, "Simbolo"))
                msSimbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "Rol"))
                Rol = Convert.ToString(row["Rol"]);

            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"].ToString());

            if (DataRecord.HasColumn(row, "SegmentoConstancia"))
                SegmentoConstancia = Convert.ToString(row["SegmentoConstancia"]);
            if (DataRecord.HasColumn(row, "Seccion"))
                SeccionAnalytics = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "DescripcionNivel"))
                DescripcionNivel = Convert.ToString(row["DescripcionNivel"]);
            if (DataRecord.HasColumn(row, "esConsultoraLider"))
                esConsultoraLider = Convert.ToBoolean(row["esConsultoraLider"]);

            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV"))
                bEstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(row, "EsquemaDAConsultora"))
                bEsquemaDAConsultora = Convert.ToBoolean(row["EsquemaDAConsultora"]);

            if (DataRecord.HasColumn(row, "DigitoVerificador"))
                digitoVerificador = (row["DigitoVerificador"]).ToString();

            if (DataRecord.HasColumn(row, "TieneCDRExpress"))
                TieneCDRExpress = Convert.ToBoolean(row["TieneCDRExpress"]);
            if (DataRecord.HasColumn(row, "EsConsecutivoNueva"))
                EsConsecutivoNueva = Convert.ToBoolean(row["EsConsecutivoNueva"]);

        }

        [Obsolete("Use MapUtil.MapToCollection")]
        public BEUsuario(IDataRecord row, bool Tipo)
        {
            if (DataRecord.HasColumn(row, "PaisID")) miPaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "CodigoISO")) msCodigoISO = Convert.ToString(row["CodigoISO"]);
            else msCodigoISO = "";
            if (DataRecord.HasColumn(row, "RegionID")) miRegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "CodigorRegion")) msCodigorRegion = Convert.ToString(row["CodigorRegion"]);
            else msCodigorRegion = "";
            if (DataRecord.HasColumn(row, "ZonaID")) miZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "CodigoZona")) msCodigoZona = Convert.ToString(row["CodigoZona"]);
            else msCodigoZona = "";
            if (DataRecord.HasColumn(row, "ConsultoraID")) miConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora")) msCodigoConsultora = row["CodigoConsultora"].ToString();
            else msCodigoConsultora = "";
            if (DataRecord.HasColumn(row, "CodigoUsuario")) msCodigoUsuario = row["CodigoUsuario"].ToString();
            else msCodigoUsuario = "";
            if (DataRecord.HasColumn(row, "NombreCompleto")) msNombre = Convert.ToString(row["NombreCompleto"]);
            else msNombre = "";
            if (DataRecord.HasColumn(row, "RolID")) miRolID = Convert.ToInt16(row["RolID"]);
            if (DataRecord.HasColumn(row, "EMail")) msEMail = Convert.ToString(row["EMail"]);
            else msEMail = "";
            if (DataRecord.HasColumn(row, "Simbolo")) msSimbolo = Convert.ToString(row["Simbolo"]);
            else msSimbolo = "";
            if (DataRecord.HasColumn(row, "TerritorioID")) miTerritorioID = Convert.ToInt32(row["TerritorioID"]);
            if (DataRecord.HasColumn(row, "CodigoTerritorio")) msCodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);
            else msCodigoTerritorio = "";
            if (DataRecord.HasColumn(row, "MontoMinimoPedido")) mmMontoMinimoPedido = Convert.ToDecimal(row["MontoMinimoPedido"]);
            if (DataRecord.HasColumn(row, "MontoMaximoPedido")) mmMontoMaximoPedido = Convert.ToDecimal(row["MontoMaximoPedido"]);
            if (DataRecord.HasColumn(row, "BanderaImagen")) mBanderaImagen = Convert.ToString(row["BanderaImagen"]);
            else mBanderaImagen = "";
            if (DataRecord.HasColumn(row, "CodigoFuente")) mCodigoFuente = Convert.ToString(row["CodigoFuente"]);
            else mCodigoFuente = "";
            if (DataRecord.HasColumn(row, "NombrePais")) mNombrePais = Convert.ToString(row["NombrePais"]);
            else mNombrePais = "";
            if (DataRecord.HasColumn(row, "CambioClave")) mbCambioClave = Convert.ToBoolean(row["CambioClave"]);
            if (DataRecord.HasColumn(row, "ConsultoraNueva")) mConsultoraNueva = Convert.ToInt32(row["ConsultoraNueva"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario")) msCodigoUsuario = row["CodigoUsuario"].ToString();
            else msCodigoUsuario = "";
            if (DataRecord.HasColumn(row, "Telefono")) msTelefono = Convert.ToString(row["Telefono"]);
            else msTelefono = "";
            if (DataRecord.HasColumn(row, "Celular")) msCelular = Convert.ToString(row["Celular"]);
            else msCelular = "";
            if (DataRecord.HasColumn(row, "Segmento")) mSegmento = Convert.ToString(row["Segmento"]);
            else mSegmento = "";
            if (DataRecord.HasColumn(row, "SegmentoAbreviatura")) mSegmentoAbreviatura = Convert.ToString(row["SegmentoAbreviatura"]);
            else mSegmentoAbreviatura = "";

            if (DataRecord.HasColumn(row, "Sobrenombre")) msSobrenombre = Convert.ToString(row["Sobrenombre"]);
            else msSobrenombre = "";
            if (string.IsNullOrEmpty(msSobrenombre) && DataRecord.HasColumn(row, "PrimerNombre"))
                msSobrenombre = Convert.ToString(row["PrimerNombre"]);

            if (DataRecord.HasColumn(row, "IndicadorDupla"))
                IndicadorDupla = Convert.ToInt32(row["IndicadorDupla"]);
            if (DataRecord.HasColumn(row, "UsuarioPrueba"))
                UsuarioPrueba = Convert.ToInt32(row["UsuarioPrueba"]);
            if (DataRecord.HasColumn(row, "PasePedidoWeb"))
                PasePedidoWeb = Convert.ToInt32(row["PasePedidoWeb"]);
            if (DataRecord.HasColumn(row, "TipoOferta2"))
                TipoOferta2 = Convert.ToInt32(row["TipoOferta2"]);
            if (DataRecord.HasColumn(row, "CompraKitDupla"))
                CompraKitDupla = Convert.ToInt32(row["CompraKitDupla"]);
            if (DataRecord.HasColumn(row, "CompraOfertaDupla"))
                CompraOfertaDupla = Convert.ToInt32(row["CompraOfertaDupla"]);
            if (DataRecord.HasColumn(row, "CompraOfertaEspecial"))
                CompraOfertaEspecial = Convert.ToInt32(row["CompraOfertaEspecial"]);
            if (DataRecord.HasColumn(row, "IndicadorMeta"))
                IndicadorMeta = Convert.ToInt32(row["IndicadorMeta"]);
            if (DataRecord.HasColumn(row, "ProgramaReconocimiento"))
                ProgramaReconocimiento = Convert.ToInt32(row["ProgramaReconocimiento"]);
            if (DataRecord.HasColumn(row, "NivelEducacion"))
                NivelEducacion = Convert.ToInt32(row["NivelEducacion"]);
            if (DataRecord.HasColumn(row, "SegmentoID"))
                SegmentoID = Convert.ToInt32(row["SegmentoID"]);
            if (DataRecord.HasColumn(row, "FechaNacimiento"))
                FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
            if (DataRecord.HasColumn(row, "FechaLimitePago"))
                FechaLimPago = Convert.ToDateTime(row["FechaLimitePago"]);
            if (DataRecord.HasColumn(row, "VioVideo"))
                VioVideo = Convert.ToInt32(row["VioVideo"]);
            if (DataRecord.HasColumn(row, "VioTutorial"))
                VioTutorial = Convert.ToInt32(row["VioTutorial"]);
            if (DataRecord.HasColumn(row, "VioTutorialDesktop"))
                VioTutorialDesktop = Convert.ToInt32(row["VioTutorialDesktop"]);
            if (DataRecord.HasColumn(row, "Nivel"))
                Nivel = Convert.ToString(row["Nivel"]);
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
            if (DataRecord.HasColumn(row, "TelefonoTrabajo"))
                msTelefonoTrabajo = Convert.ToString(row["TelefonoTrabajo"]);
            if (DataRecord.HasColumn(row, "AnoCampanaIngreso"))
                AnoCampaniaIngreso = Convert.ToString(row["AnoCampanaIngreso"]);
            if (DataRecord.HasColumn(row, "PrimerNombre"))
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "PrimerApellido"))
                PrimerApellido = Convert.ToString(row["PrimerApellido"]);
            if (DataRecord.HasColumn(row, "IndicadorFlexiPago"))
                IndicadorFlexiPago = Convert.ToInt32(row["IndicadorFlexiPago"]);
            if (DataRecord.HasColumn(row, "IndicadorPermisoFIC"))
                IndicadorPermisoFIC = Convert.ToInt32(row["IndicadorPermisoFIC"]);
            if (DataRecord.HasColumn(row, "PedidoFICActivo")) PedidoFICActivo = Convert.ToBoolean(row["PedidoFICActivo"]);
            if (DataRecord.HasColumn(row, "MostrarAyudaWebTraking"))
                MostrarAyudaWebTraking = Convert.ToBoolean(row["MostrarAyudaWebTraking"]);
            if (DataRecord.HasColumn(row, "RolDescripcion"))
                RolDescripcion = Convert.ToString(row["RolDescripcion"]);

            if (DataRecord.HasColumn(row, "NroCampanias"))
                NroCampanias = Convert.ToInt32(row["NroCampanias"]);

            if (DataRecord.HasColumn(row, "Lider"))
                Lider = Convert.ToInt32(row["Lider"]);

            if (DataRecord.HasColumn(row, "ConsultoraAsociada"))
                ConsultoraAsociada = Convert.ToString(row["ConsultoraAsociada"]);
            else
                ConsultoraAsociada = string.Empty;

            if (DataRecord.HasColumn(row, "CampaniaInicioLider"))
                CampaniaInicioLider = Convert.ToString(row["CampaniaInicioLider"]);
            else
                CampaniaInicioLider = string.Empty;

            if (DataRecord.HasColumn(row, "SeccionGestionLider"))
                SeccionGestionLider = Convert.ToString(row["SeccionGestionLider"]);
            else
                SeccionGestionLider = string.Empty;


            if (DataRecord.HasColumn(row, "NivelLider"))
                NivelLider = Convert.ToInt32(row["NivelLider"]);

            if (DataRecord.HasColumn(row, "PortalLideres"))
                PortalLideres = Convert.ToBoolean(row["PortalLideres"]);

            if (DataRecord.HasColumn(row, "LogoLideres"))
                LogoLideres = Convert.ToString(row["LogoLideres"]);
            else
                LogoLideres = string.Empty;

            if (DataRecord.HasColumn(row, "IndicadorContrato"))
                IndicadorContrato = Convert.ToInt32(row["IndicadorContrato"]);

            if (DataRecord.HasColumn(row, "EsJoven"))
                EsJoven = Convert.ToInt32(row["EsJoven"]);

            if (DataRecord.HasColumn(row, "CodigoISO"))
                CodigoISO = Convert.ToString(row["CodigoISO"]);
            if (DataRecord.HasColumn(row, "NombrePais"))
                NombrePais = Convert.ToString(row["NombrePais"]);
            if (DataRecord.HasColumn(row, "RolID"))
                RolID = Convert.ToByte(row["RolID"]);
            if (DataRecord.HasColumn(row, "BanderaImagen"))
                BanderaImagen = Convert.ToString(row["BanderaImagen"]);
            if (DataRecord.HasColumn(row, "Simbolo"))
                msSimbolo = Convert.ToString(row["Simbolo"]);

            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "Rol"))
                Rol = Convert.ToString(row["Rol"]);

            if (DataRecord.HasColumn(row, "CampanaInvitada"))
                CampanaInvitada = Convert.ToString(row["CampanaInvitada"]);
            if (DataRecord.HasColumn(row, "InscritaFlexipago"))
                InscritaFlexipago = Convert.ToString(row["InscritaFlexipago"]);
            if (DataRecord.HasColumn(row, "InvitacionRechazada"))
                InvitacionRechazada = Convert.ToString(row["InvitacionRechazada"]);

            if (DataRecord.HasColumn(row, "SegmentoConstancia"))
                SegmentoConstancia = Convert.ToString(row["SegmentoConstancia"]);
            if (DataRecord.HasColumn(row, "Seccion"))
                SeccionAnalytics = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "DescripcionNivel"))
                DescripcionNivel = Convert.ToString(row["DescripcionNivel"]);
            if (DataRecord.HasColumn(row, "esConsultoraLider"))
                esConsultoraLider = Convert.ToBoolean(row["esConsultoraLider"]);

            if (DataRecord.HasColumn(row, "EMailActivo"))
                EMailActivo = Convert.ToBoolean(row["EMailActivo"]);

            if (DataRecord.HasColumn(row, "SegmentoInternoId"))
                SegmentoInternoID = Convert.ToInt32(row["SegmentoInternoId"]);

            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV"))
                EstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(row, "EsquemaDAConsultora"))
                bEsquemaDAConsultora = Convert.ToBoolean(row["EsquemaDAConsultora"]);
            if (DataRecord.HasColumn(row, "OfertaFinal"))
                OfertaFinal = Convert.ToInt32(row["OfertaFinal"]);
            if (DataRecord.HasColumn(row, "EsOfertaFinalZonaValida"))
                EsOfertaFinalZonaValida = Convert.ToBoolean(row["EsOfertaFinalZonaValida"]);

            if (DataRecord.HasColumn(row, "OfertaFinalGanaMas"))
                OfertaFinalGanaMas = Convert.ToInt32(row["OfertaFinalGanaMas"]);

            if (DataRecord.HasColumn(row, "EsOFGanaMasZonaValida"))
                EsOFGanaMasZonaValida = Convert.ToBoolean(row["EsOFGanaMasZonaValida"]);

            if (DataRecord.HasColumn(row, "CatalogoPersonalizado"))
                CatalogoPersonalizado = Convert.ToInt32(row["CatalogoPersonalizado"]);
            if (DataRecord.HasColumn(row, "EsCatalogoPersonalizadoZonaValida"))
                EsCatalogoPersonalizadoZonaValida = Convert.ToBoolean(row["EsCatalogoPersonalizadoZonaValida"]);
            if (DataRecord.HasColumn(row, "VioTutorialSalvavidas"))
                VioTutorialSalvavidas = Convert.ToInt32(row["VioTutorialSalvavidas"]);
            if (DataRecord.HasColumn(row, "TieneHana"))
                TieneHana = Convert.ToInt32(row["TieneHana"]);
            if (DataRecord.HasColumn(row, "IndicadorBloqueoCDR"))
                IndicadorBloqueoCDR = Convert.ToInt32(row["IndicadorBloqueoCDR"]);
            if (DataRecord.HasColumn(row, "EsCDRWebZonaValida"))
                EsCDRWebZonaValida = Convert.ToInt32(row["EsCDRWebZonaValida"]);
            if (DataRecord.HasColumn(row, "TieneCDR"))
                TieneCDR = Convert.ToInt32(row["TieneCDR"]);
            if (DataRecord.HasColumn(row, "TieneCupon"))
                TieneCupon = Convert.ToInt32(row["TieneCupon"]);
            if (DataRecord.HasColumn(row, "TieneMasVendidos"))
                TieneMasVendidos = Convert.ToInt32(row["TieneMasVendidos"]);
            if (DataRecord.HasColumn(row, "TieneAsesoraOnline"))
                TieneAsesoraOnline = Convert.ToInt32(row["TieneAsesoraOnline"]);
            if (DataRecord.HasColumn(row, "TieneOfertaLog"))
                TieneOfertaLog = Convert.ToInt32(row["TieneOfertaLog"]);

            if (DataRecord.HasColumn(row, "IndicadorGPRSB"))
                IndicadorGPRSB = Convert.ToInt32(row["IndicadorGPRSB"]);

            if (DataRecord.HasColumn(row, "EstadoPedido"))
                EstadoPedido = Convert.ToInt32(row["EstadoPedido"]);

            if (DataRecord.HasColumn(row, "ValidacionAbierta"))
                ValidacionAbierta = Convert.ToBoolean(row["ValidacionAbierta"]);

            if (DataRecord.HasColumn(row, "GerenteZona"))
                NombreGerenteZona = Convert.ToString(row["GerenteZona"]);

            if (DataRecord.HasColumn(row, "DigitoVerificador"))
                digitoVerificador = (row["DigitoVerificador"]).ToString();

            if (DataRecord.HasColumn(row, "TieneODD"))
                OfertaDelDia = Convert.ToBoolean(row["TieneODD"]);

            if (DataRecord.HasColumn(row, "ConsultoraAsociadoID"))
                consultoraAsociadoID = Convert.ToInt64(row["ConsultoraAsociadoID"]);

            if (DataRecord.HasColumn(row, "DocumentoIdentidad"))
                DocumentoIdentidad = Convert.ToString(row["DocumentoIdentidad"]);

            if (DataRecord.HasColumn(row, "TipoUsuario"))
                TipoUsuario = Convert.ToInt16(row["TipoUsuario"]);

            if (DataRecord.HasColumn(row, "TieneLoginExterno"))
                TieneLoginExterno = Convert.ToBoolean(row["TieneLoginExterno"]);

            if (DataRecord.HasColumn(row, "TieneCDRExpress")) TieneCDRExpress = Convert.ToBoolean(row["TieneCDRExpress"]);
            if (DataRecord.HasColumn(row, "EsConsecutivoNueva")) EsConsecutivoNueva = Convert.ToBoolean(row["EsConsecutivoNueva"]);

            if (DataRecord.HasColumn(row, "FechaInicioFacturacion"))
                FechaInicioFacturacion = Convert.ToDateTime(row["FechaInicioFacturacion"]);
            if (DataRecord.HasColumn(row, "FechaFinFacturacion"))
                FechaFinFacturacion = Convert.ToDateTime(row["FechaFinFacturacion"]);
            if (DataRecord.HasColumn(row, "HoraInicio"))
                HoraInicio = DbConvert.ToTimeSpan(row["HoraInicio"]);
            if (DataRecord.HasColumn(row, "HoraFin"))
                HoraFin = DbConvert.ToTimeSpan(row["HoraFin"]);
            if (DataRecord.HasColumn(row, "DiasAntes"))
                DiasAntes = Convert.ToByte(row["DiasAntes"]);
            if (DataRecord.HasColumn(row, "ZonaValida"))
                ZonaValida = Convert.ToInt32(row["ZonaValida"]) != -1;
            if (DataRecord.HasColumn(row, "HoraInicioNoFacturable"))
                HoraInicioNoFacturable = DbConvert.ToTimeSpan(row["HoraInicioNoFacturable"]);
            if (DataRecord.HasColumn(row, "HoraCierreNoFacturable"))
                HoraCierreNoFacturable = DbConvert.ToTimeSpan(row["HoraCierreNoFacturable"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaNormal"))
                HoraCierreZonaNormal = DbConvert.ToTimeSpan(row["HoraCierreZonaNormal"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaDemAnti"))
                HoraCierreZonaDemAnti = DbConvert.ToTimeSpan(row["HoraCierreZonaDemAnti"]);
            if (DataRecord.HasColumn(row, "ZonaHoraria"))
                ZonaHoraria = Convert.ToDouble(row["ZonaHoraria"]);
            if (DataRecord.HasColumn(row, "EsZonaDemAnti"))
                EsZonaDemAnti = Convert.ToInt32(row["EsZonaDemAnti"]);
            if (DataRecord.HasColumn(row, "DiasDuracionCronograma"))
                DiasDuracionCronograma = Convert.ToByte(row["DiasDuracionCronograma"]);
            if (DataRecord.HasColumn(row, "HabilitarRestriccionHoraria"))
                HabilitarRestriccionHoraria = Convert.ToBoolean(row["HabilitarRestriccionHoraria"]);
            if (DataRecord.HasColumn(row, "HorasDuracionRestriccion"))
                HorasDuracionRestriccion = Convert.ToInt32(row["HorasDuracionRestriccion"]);
            if (DataRecord.HasColumn(row, "PROLSinStock"))
                PROLSinStock = Convert.ToBoolean(row["PROLSinStock"]);

            if (DataRecord.HasColumn(row, "NuevoPROL"))
                NuevoPROL = Convert.ToBoolean(row["NuevoPROL"]);

            if (DataRecord.HasColumn(row, "ZonaNuevoPROL"))
                ZonaNuevoPROL = Convert.ToBoolean(row["ZonaNuevoPROL"]);

            if (DataRecord.HasColumn(row, "HoraCierreZonaDemAntiCierre"))
                HoraCierreZonaDemAntiCierre = DbConvert.ToTimeSpan(row["HoraCierreZonaDemAntiCierre"]);

            if (DataRecord.HasColumn(row, "ValidacionInteractiva"))
                ValidacionInteractiva = Convert.ToBoolean(row["ValidacionInteractiva"]);
            if (DataRecord.HasColumn(row, "MensajeValidacionInteractiva"))
                MensajeValidacionInteractiva = Convert.ToString(row["MensajeValidacionInteractiva"]);

            if (DataRecord.HasColumn(row, "EstadoPedido"))
                EstadoPedido = Convert.ToInt32(row["EstadoPedido"]);

            if (DataRecord.HasColumn(row, "ValidacionAbierta"))
                ValidacionAbierta = Convert.ToBoolean(row["ValidacionAbierta"]);

            if (DataRecord.HasColumn(row, "FechaActualPais"))
                FechaActualPais = Convert.ToDateTime(row["FechaActualPais"]);

            if (DataRecord.HasColumn(row, "AceptacionConsultoraDA"))
                AceptacionConsultoraDA = Convert.ToInt32(row["AceptacionConsultoraDA"]);

            if (DataRecord.HasColumn(row, "CompartirDatos"))
                AceptacionConsultoraDA = Convert.ToInt32(row["CompartirDatos"]);

            if (DataRecord.HasColumn(row, "FotoPerfil"))
                FotoPerfil = Convert.ToString(row["FotoPerfil"]);

            if (DataRecord.HasColumn(row, "ConsecutivoNueva"))
                ConsecutivoNueva = Convert.ToInt32(row["ConsecutivoNueva"]);

            if (DataRecord.HasColumn(row, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(row["CodigoPrograma"]);

            if (DataRecord.HasColumn(row, "CompraVDirecta"))
                CompraVDirecta = Convert.ToDouble(row["CompraVDirecta"]);

            if (DataRecord.HasColumn(row, "IVACompraVDirecta"))
                IVACompraVDirecta = Convert.ToDouble(row["IVACompraVDirecta"]);

            if (DataRecord.HasColumn(row, "Retail"))
                Retail = Convert.ToDouble(row["Retail"]);

            if (DataRecord.HasColumn(row, "IVARetail"))
                IVARetail = Convert.ToDouble(row["IVARetail"]);

            if (DataRecord.HasColumn(row, "TotalCompra"))
                TotalCompra = Convert.ToDouble(row["TotalCompra"]);

            if (DataRecord.HasColumn(row, "IvaTotal"))
                IvaTotal = Convert.ToDouble(row["IvaTotal"]);

            if (DataRecord.HasColumn(row, "IndicadorConsultoraOficina"))
                EsConsultoraOficina = Convert.ToInt32(row["IndicadorConsultoraOficina"]) == 1;
        }

        [Column("ConsultoraAsociadoID")]
        [DataMember]
        public long ConsultoraAsociadaID
        {
            get { return consultoraAsociadoID; }
            set { consultoraAsociadoID = value; }
        }

        [DataMember]
        public string RolDescripcion { get; set; }

        [Column("NroCampanias")]
        [DataMember]
        public int NroCampanias { get; set; }
        [DataMember]
        public int IndicadorDupla { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaNormal { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaDemAnti { get; set; }
        [DataMember]
        public double ZonaHoraria { get; set; }
        [DataMember]
        public int EsZonaDemAnti { get; set; }

        [Column("UsuarioPrueba")]
        public bool usuarioPrueba { get; set; }
        private int _UsuarioPrueba;
        [DataMember]
        public int UsuarioPrueba
        {
            get
            {
                return usuarioPrueba ? 1 : _UsuarioPrueba;
            }
            set
            {
                _UsuarioPrueba = value;
            }
        }
        [DataMember]
        public int PasePedidoWeb { get; set; }
        [DataMember]
        public int TipoOferta2 { get; set; }
        [DataMember]
        public int CompraKitDupla { get; set; }
        [DataMember]
        public int CompraOfertaDupla { get; set; }
        [DataMember]
        public int CompraOfertaEspecial { get; set; }
        [DataMember]
        public int IndicadorMeta { get; set; }
        [DataMember]
        public int ProgramaReconocimiento { get; set; }
        [DataMember]
        public int NivelEducacion { get; set; }
        [DataMember]
        public int SegmentoID { get; set; }
        [DataMember]
        [Column("FechaNacimiento")]
        public DateTime FechaNacimiento { get; set; }

        [Column("FechaLimitePago")]
        [DataMember]
        public DateTime FechaLimPago { get; set; }
        [DataMember]
        public int VioVideo { get; set; }
        [DataMember]
        public int VioTutorial { get; set; }
        [DataMember]
        public int VioTutorialDesktop { get; set; }
        [DataMember]
        public String Nivel { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public int IndicadorFlexiPago { get; set; }
        [DataMember]
        public int IndicadorPermisoFIC { get; set; }

        [DataMember]
        public string CampanaInvitada { get; set; }
        [DataMember]
        public string InscritaFlexipago { get; set; }
        [DataMember]
        public string InvitacionRechazada { get; set; }

        [DataMember]
        public int EsJoven { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaDemAntiCierre { get; set; }

        [DataMember]
        public bool ValidacionInteractiva { get; set; }
        [DataMember]
        public string MensajeValidacionInteractiva { get; set; }

        [DataMember]
        [Column("ConsultoraNueva")]
        public int ConsultoraNueva
        {
            get { return mConsultoraNueva; }
            set { mConsultoraNueva = value; }
        }
        [DataMember]
        public bool EsConsultoraNueva { get; set; }

        [DataMember]
        public string NombrePais
        {
            get { return mNombrePais; }
            set { mNombrePais = value; }
        }

        [DataMember]
        public string BanderaImagen
        {
            get { return mBanderaImagen; }
            set { mBanderaImagen = value; }
        }

        [DataMember]
        public string CodigoFuente
        {
            get { return mCodigoFuente; }
            set { mCodigoFuente = value; }
        }

        [Column("CodigoUsuario")]
        [DataMember]
        public string CodigoUsuario
        {
            get { return msCodigoUsuario; }
            set { msCodigoUsuario = value; }
        }

        [Column("CodigoConsultora")]
        [DataMember]
        public string CodigoConsultora
        {
            get { return msCodigoConsultora; }
            set { msCodigoConsultora = value; }
        }

        [Column("PaisID")]
        [DataMember]
        public int PaisID
        {
            get { return miPaisID; }
            set { miPaisID = value; }
        }

        [Column("NombreCompleto")]
        [DataMember]
        public string Nombre
        {
            get { return msNombre; }
            set { msNombre = value; }
        }
        [DataMember]
        public string ClaveSecreta
        {
            get { return msClaveSecreta; }
            set { msClaveSecreta = value; }
        }
        [DataMember]
        public string ActualizarClave
        {
            get { return msActualizarClave; }
            set { msActualizarClave = value; }
        }
        [DataMember]
        public string ConfirmarClave
        {
            get { return msConfirmarClave; }
            set { msConfirmarClave = value; }
        }

        [Column("EMail")]
        [DataMember]
        public string EMail
        {
            get { return msEMail; }
            set { msEMail = value; }
        }
        [DataMember]
        public bool EMailActivo
        {
            get { return mbEMailActivo; }
            set { mbEMailActivo = value; }
        }

        [Column("Telefono")]
        [DataMember]
        public string Telefono
        {
            get { return msTelefono; }
            set { msTelefono = value; }
        }

        [Column("TelefonoTrabajo")]
        [DataMember]
        public string TelefonoTrabajo
        {
            get { return msTelefonoTrabajo; }
            set { msTelefonoTrabajo = value; }
        }

        [Column("Celular")]
        [DataMember]
        public string Celular
        {
            get { return msCelular; }
            set { msCelular = value; }
        }

        [DataMember]
        public string Sobrenombre
        {
            get
            {
                if (string.IsNullOrEmpty(msSobrenombre)) msSobrenombre = msPrimerNombre;
                return msSobrenombre;
            }
            set { msSobrenombre = value; }
        }
        [DataMember]
        public bool CompartirDatos
        {
            get { return mbCompartirDatos; }
            set { mbCompartirDatos = value; }
        }
        [DataMember]
        public bool AceptoContrato { get; set; }
        [DataMember]
        public bool Activo
        {
            get { return mbActivo; }
            set { mbActivo = value; }
        }

        [Column("TipoUsuario")]
        [DataMember]
        public Int16 TipoUsuario
        {
            get { return miTipoUsuario; }
            set { miTipoUsuario = value; }
        }
        [DataMember]
        public bool CambioClave
        {
            get { return mbCambioClave; }
            set { mbCambioClave = value; }
        }

        [Column("CodigoISO")]
        [DataMember]
        public string CodigoISO
        {
            get { return msCodigoISO; }
            set { msCodigoISO = value; }
        }

        [Column("RegionID")]
        [DataMember]
        public int RegionID
        {
            get { return miRegionID; }
            set { miRegionID = value; }
        }

        [Column("CodigorRegion")]
        [DataMember]
        public string CodigorRegion
        {
            get { return msCodigorRegion; }
            set { msCodigorRegion = value; }
        }

        [Column("ZonaID")]
        [DataMember]
        public int ZonaID
        {
            get { return miZonaID; }
            set { miZonaID = value; }
        }

        [Column("CodigoZona")]
        [DataMember]
        public string CodigoZona
        {
            get { return msCodigoZona; }
            set { msCodigoZona = value; }
        }

        [Column("ConsultoraID")]
        [DataMember]
        public long ConsultoraID
        {
            get { return miConsultoraID; }
            set { miConsultoraID = value; }
        }

        [Column("RolID")]
        [DataMember]
        public short RolID
        {
            get { return miRolID; }
            set { miRolID = value; }
        }

        [DataMember]
        public int CampaniaID
        {
            get { return miCampaniaID; }
            set { miCampaniaID = value; }
        }

        [DataMember]
        public DateTime FechaInicioFacturacion
        {
            get { return mdFechaInicioFacturacion; }
            set { mdFechaInicioFacturacion = value; }
        }

        [DataMember]
        public DateTime FechaFinFacturacion
        {
            get { return mdFechaFinFacturacion; }
            set { mdFechaFinFacturacion = value; }
        }

        [DataMember]
        public string CampaniaDescripcion
        {
            get { return msCampaniaDescripcion; }
            set { msCampaniaDescripcion = value; }
        }

        [DataMember]
        public TimeSpan HoraInicio
        {
            get { return tsHoraInicio; }
            set { tsHoraInicio = value; }
        }

        [DataMember]
        public TimeSpan HoraFin
        {
            get { return tsHoraFin; }
            set { tsHoraFin = value; }
        }

        [DataMember]
        public bool ZonaValida
        {
            get { return mbZonaValida; }
            set { mbZonaValida = value; }
        }

        [Column("Simbolo")]
        [DataMember]
        public string Simbolo
        {
            get { return msSimbolo; }
            set { msSimbolo = value; }
        }

        [DataMember]
        public int TerritorioID
        {
            get { return miTerritorioID; }
            set { miTerritorioID = value; }
        }

        [DataMember]
        public string CodigoTerritorio
        {
            get { return msCodigoTerritorio; }
            set { msCodigoTerritorio = value; }
        }

        [Column("MontoMinimoPedido")]
        [DataMember]
        public decimal MontoMinimoPedido
        {
            get { return mmMontoMinimoPedido; }
            set { mmMontoMinimoPedido = value; }
        }

        [Column("MontoMaximoPedido")]
        [DataMember]
        public decimal MontoMaximoPedido
        {
            get { return mmMontoMaximoPedido; }
            set { mmMontoMaximoPedido = value; }
        }

        [DataMember]
        public TimeSpan HoraInicioNoFacturable
        {
            get { return tsHoraInicioNoFacturable; }
            set { tsHoraInicioNoFacturable = value; }
        }

        [DataMember]
        public TimeSpan HoraCierreNoFacturable
        {
            get { return tsHoraCierreNoFacturable; }
            set { tsHoraCierreNoFacturable = value; }
        }

        [DataMember]
        public int DiasAntes
        {
            get { return miDiasAntes; }
            set { miDiasAntes = value; }
        }

        [DataMember]
        public string Segmento
        {
            get { return mSegmento; }
            set { mSegmento = value; }
        }

        [DataMember]
        public int DiasDuracionCronograma
        {
            get { return miDiasDuracionCronograma; }
            set { miDiasDuracionCronograma = value; }
        }

        [DataMember]
        public bool HabilitarRestriccionHoraria
        {
            get { return mHabilitarRestriccionHoraria; }
            set { mHabilitarRestriccionHoraria = value; }
        }

        [DataMember]
        public int HorasDuracionRestriccion
        {
            get { return mHorasDuracionRestriccion; }
            set { mHorasDuracionRestriccion = value; }
        }

        [DataMember]
        [Column("AnoCampanaIngreso")]
        public string AnoCampaniaIngreso
        {
            get { return mAnoCampaniaIngreso; }
            set { mAnoCampaniaIngreso = value; }
        }

        [DataMember]
        public string PrimerNombre
        {
            get { return mPrimerNombre; }
            set { mPrimerNombre = value; }
        }

        [DataMember]
        public string PrimerApellido
        {
            get { return mPrimerApellido; }
            set { mPrimerApellido = value; }
        }

        [DataMember]
        public bool MostrarAyudaWebTraking
        {
            get { return mostrarAyudaWebTraking; }
            set { mostrarAyudaWebTraking = value; }
        }
        [DataMember]
        public int IndicadorOfertaFIC { get; set; }
        [DataMember]
        public string ImagenURLOfertaFIC { get; set; }

        [DataMember]
        public int Lider { get; set; }

        [Column("ConsultoraAsociada")]
        [DataMember]
        public string ConsultoraAsociada { get; set; }

        [DataMember]
        public string CampaniaInicioLider { get; set; }

        [Column("SeccionGestionLider")]
        [DataMember]
        public string SeccionGestionLider { get; set; }

        [DataMember]
        public int NivelLider { get; set; }

        [DataMember]
        public bool PortalLideres { get; set; }

        [DataMember]
        public string LogoLideres { get; set; }

        [DataMember]
        public int IndicadorContrato { get; set; }

        [DataMember]
        public DateTime FechaFinFIC
        {
            get { return mdFechaFinFIC; }
            set { mdFechaFinFIC = value; }
        }

        [DataMember]
        public bool PROLSinStock
        {
            get { return mPROLSinStock; }
            set { mPROLSinStock = value; }
        }

        [DataMember]
        public DateTime FechaModificacion
        {
            get { return mdFechaModificacion; }
            set { mdFechaModificacion = value; }
        }

        [DataMember]
        public string Rol
        {
            get { return mdRol; }
            set { mdRol = value; }
        }

        [DataMember]
        public string SegmentoConstancia
        {
            get { return mSegmentoConstancia; }
            set { mSegmentoConstancia = value; }
        }
        [DataMember]
        public string SeccionAnalytics
        {
            get { return mSeccionAnalytics; }
            set { mSeccionAnalytics = value; }
        }
        [DataMember]
        public string DescripcionNivel
        {
            get { return mDescripcionNivel; }
            set { mDescripcionNivel = value; }
        }

        [DataMember]
        public bool esConsultoraLider
        {
            get { return Convert.ToBoolean(mesConsultoraLider); }
            set { mesConsultoraLider = value ? 1 : 0; }
        }
        [DataMember]
        public string DigitoVerificador
        {
            get { return digitoVerificador; }
            set { digitoVerificador = value; }
        }

        [DataMember]
        public bool NuevoPROL { get; set; }

        [DataMember]
        public bool ZonaNuevoPROL { get; set; }

        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        [Column("Seccion")]
        public string Seccion { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string Region { get; set; }
        [DataMember]
        public string Pais { get; set; }

        [Column("Campania")]
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public DateTime? FechaActualizacionEmail { get; set; }
        [DataMember]
        public DateTime? FechaActivacionSuscripcion { get; set; }
        [DataMember]
        public string FlagActivacionSuscripcion { get; set; }
        [DataMember]
        public DateTime? FechaCancelacionSuscripcion { get; set; }

        [DataMember]
        [Column("SegmentoInternoId")]
        public int? SegmentoInternoID
        {
            get;
            set;
        }

        [DataMember]
        public string SegmentoAbreviatura
        {
            get { return mSegmentoAbreviatura; }
            set { mSegmentoAbreviatura = value; }
        }

        [DataMember]
        public bool EstadoSimplificacionCUV
        {
            get { return bEstadoSimplificacionCUV; }
            set { bEstadoSimplificacionCUV = value; }
        }

        [DataMember]
        public bool EsquemaDAConsultora { get; set; }

        [DataMember]
        public int OfertaFinal { get; set; }

        [DataMember]
        public bool EsOfertaFinalZonaValida { get; set; }

        [DataMember]
        public int OfertaFinalGanaMas { get; set; }

        [DataMember]
        public bool EsOFGanaMasZonaValida { get; set; }

        [DataMember]
        public int CatalogoPersonalizado { get; set; }

        [DataMember]
        public bool EsCatalogoPersonalizadoZonaValida { get; set; }

        [DataMember]
        public int VioTutorialSalvavidas { get; set; }

        [DataMember]
        public int TieneHana
        {
            get { return tieneHana ? 1 : 0; }
            set { tieneHana = value == 1; }
        }

        [DataMember]
        public int IndicadorBloqueoCDR { get; set; }

        [DataMember]
        public int EsCDRWebZonaValida { get; set; }

        [DataMember]
        public int TieneCDR { get; set; }
        [DataMember]
        public int TieneCupon { get; set; }
        [DataMember]
        public int TieneMasVendidos { get; set; }
        [DataMember]
        public int TieneAsesoraOnline { get; set; }
        [DataMember]
        public int TieneOfertaLog { get; set; }
        [DataMember]
        public decimal MontoDeuda { get; set; }

        [DataMember]
        public decimal MontoMinimoFlexipago { get; set; }

        [DataMember]
        public int ConsecutivoNueva { get; set; }

        [DataMember]
        public string CodigoPrograma { get; set; }

        [DataMember]
        public double CompraVDirecta { get; set; }

        [DataMember]
        public double IVACompraVDirecta { get; set; }

        [DataMember]
        public double Retail { get; set; }

        [DataMember]
        public double IVARetail { get; set; }

        [DataMember]
        public double TotalCompra { get; set; }

        [DataMember]
        public double IvaTotal { get; set; }

        public BEUsuario(IDataRecord row, string Lider)
        {
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);

            if (DataRecord.HasColumn(row, "DocIdentidad"))
                NumeroDocumento = Convert.ToString(row["DocIdentidad"]);

            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "Seccion"))
                Seccion = Convert.ToString(row["Seccion"]);

            if (DataRecord.HasColumn(row, "SeccionGestionLider"))
                SeccionGestionLider = Convert.ToString(row["SeccionGestionLider"]);

            if (DataRecord.HasColumn(row, "Telefono"))
                Telefono = Convert.ToString(row["Telefono"]);

            if (DataRecord.HasColumn(row, "Celular"))
                Celular = Convert.ToString(row["Celular"]);

            if (DataRecord.HasColumn(row, "Email"))
                EMail = Convert.ToString(row["Email"]);

            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "Pais"))
                Pais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "Region"))
                Region = Convert.ToString(row["Region"]);

            if (DataRecord.HasColumn(row, "Zona"))
                Zona = Convert.ToString(row["Zona"]);

            if (DataRecord.HasColumn(row, "FechaActualizacionEmail"))
                FechaActualizacionEmail = Convert.ToDateTime(row["FechaActualizacionEmail"]);

            if (DataRecord.HasColumn(row, "FechaActivacionSuscripcion"))
                FechaActivacionSuscripcion = Convert.ToDateTime(row["FechaActivacionSuscripcion"]);

            if (DataRecord.HasColumn(row, "FechaCancelacionSuscripcion"))
                FechaCancelacionSuscripcion = Convert.ToDateTime(row["FechaCancelacionSuscripcion"]);

            if (DataRecord.HasColumn(row, "FlagActivacionSuscripcion"))
                FlagActivacionSuscripcion = Convert.ToString(row["FlagActivacionSuscripcion"]);

            if (DataRecord.HasColumn(row, "SegmentoConstancia"))
                SegmentoConstancia = Convert.ToString(row["SegmentoConstancia"]);
            if (DataRecord.HasColumn(row, "Seccion"))
                SeccionAnalytics = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "DescripcionNivel"))
                DescripcionNivel = Convert.ToString(row["DescripcionNivel"]);
            if (DataRecord.HasColumn(row, "esConsultoraLider"))
                esConsultoraLider = Convert.ToBoolean(row["esConsultoraLider"]);

            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV"))
                EstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]);

            if (DataRecord.HasColumn(row, "EsquemaDAConsultora"))
                bEsquemaDAConsultora = Convert.ToBoolean(row["EsquemaDAConsultora"]);

            if (DataRecord.HasColumn(row, "DigitoVerificador"))
                digitoVerificador = (row["DigitoVerificador"]).ToString();

            if (DataRecord.HasColumn(row, "TieneCDRExpress"))
                TieneCDRExpress = Convert.ToBoolean(row["TieneCDRExpress"]);

        }

        [DataMember]
        private string msSeccion { get; set; }
        [DataMember]
        private string msCampaniaEncuesta { get; set; }
        [DataMember]
        private DateTime mdFechaEncuesta { get; set; }
        [DataMember]
        private string msCampaniaIngreso { get; set; }
        [DataMember]
        private string msRpta1 { get; set; }
        [DataMember]
        private string msRpta2 { get; set; }
        [DataMember]
        private string msRpta3 { get; set; }
        [DataMember]
        private string msRpta4 { get; set; }

        [DataMember]
        public int IndicadorGPRSB { get; set; }
        [DataMember]
        public int EstadoPedido { get; set; }
        [DataMember]
        public bool ValidacionAbierta { get; set; }
        [DataMember]
        public string NombreGerenteZona { get; set; }
        [DataMember]
        public DateTime FechaActualPais { get; set; }

        [DataMember]
        public bool OfertaDelDia
        {
            get { return Convert.ToBoolean(tieneOdd); }
            set { tieneOdd = value ? 1 : 0; }
        }

        [DataMember]
        public int AceptacionConsultoraDA { get; set; }

        [Column("DocumentoIdentidad")]
        [DataMember]
        public string DocumentoIdentidad { get; set; }

        public bool DiaPROL { get; set; }
        public bool EsHoraReserva { get; set; }

        [DataMember]
        public bool TieneLoginExterno
        {
            get { return Convert.ToBoolean(tieneLoginExterno); }
            set { tieneLoginExterno = value ? 1 : 0; }
        }

        public BEUsuario(IDataRecord row, string tipo1, string tipo2)
        {
            if (DataRecord.HasColumn(row, "Codigo"))
                CodigoConsultora = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "Pais"))
                CodigoISO = Convert.ToString(row["Pais"]);
            if (DataRecord.HasColumn(row, "Region"))
                Region = Convert.ToString(row["Region"]);
            if (DataRecord.HasColumn(row, "Zona"))
                Zona = Convert.ToString(row["Zona"]);
            if (DataRecord.HasColumn(row, "Seccion"))
                msSeccion = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "CampaniaEncuesta"))
                msCampaniaEncuesta = Convert.ToString(row["CampaniaEncuesta"]);
            if (DataRecord.HasColumn(row, "FechaRespuesta"))
                mdFechaEncuesta = Convert.ToDateTime(row["FechaRespuesta"]);
            if (DataRecord.HasColumn(row, "CampaniaIngreso"))
                msCampaniaIngreso = Convert.ToString(row["CampaniaIngreso"]);
            if (DataRecord.HasColumn(row, "Rpta1"))
                msRpta1 = Convert.ToString(row["Rpta1"]);
            if (DataRecord.HasColumn(row, "Rpta2"))
                msRpta2 = Convert.ToString(row["Rpta2"]);
            if (DataRecord.HasColumn(row, "Rpta3"))
                msRpta3 = Convert.ToString(row["Rpta3"]);
            if (DataRecord.HasColumn(row, "Rpta4"))
                msRpta4 = Convert.ToString(row["Rpta4"]);
            if (DataRecord.HasColumn(row, "FechaActualPais"))
                FechaActualPais = Convert.ToDateTime(row["FechaActualPais"]);

            if (DataRecord.HasColumn(row, "TieneCDRExpress"))
                TieneCDRExpress = Convert.ToBoolean(row["TieneCDRExpress"]);

        }

        [DataMember]
        public int MensajePedidoDesktop { get; set; }

        [DataMember]
        public int MensajePedidoMobile { get; set; }

        [DataMember]
        public bool TieneCDRExpress { get; set; }
        [DataMember]
        public bool EsConsecutivoNueva { get; set; }

        [DataMember]
        public bool PedidoFICActivo { get; set; }

        [DataMember]
        [Column("FotoPerfil")]
        public string FotoPerfil { get; set; }

        [DataMember]
        public bool AceptaTerminosCondiciones { get; set; }

        [DataMember]
        public bool AceptaPoliticaPrivacidad { get; set; }

        [DataMember]
        public string DestinatariosFeedback { get; set; }

        [DataMember]
        public bool GPRMostrarBannerRechazo { get; set; }
        [DataMember]
        public string GPRBannerTitulo { get; set; }
        [DataMember]
        public string GPRBannerMensaje { get; set; }
        [DataMember]
        public Enumeradores.RechazoBannerUrl GPRBannerUrl { get; set; }
        [DataMember]
        public string GPRTextovinculo { get; set; }

        [DataMember]
        public string FechaVencimiento { get; set; }
        [DataMember]
        public int DiasCierre { get; set; }
        [DataMember]
        public bool EsAniversario { get; set; }
        [DataMember]
        public int AniosPermanencia { get; set; }
        [DataMember]
        public bool EsCumpleanio { get; set; }
        [DataMember]
        public string CodigosConcursos { get; set; }
        [DataMember]
        public string CodigosProgramaNuevas { get; set; }
        [DataMember]
        [Column("PasoSextoPedido")]
        public bool PasoSextoPedido { get; set; }
        [DataMember]
        public short RevistaDigitalSuscripcion { get; set; }
        [DataMember]
        public string UrlBannerGanaMas { get; set; }
        [DataMember]
        public bool TieneGND { get; set; }
        [DataMember]
        public int CuponEstado { get; set; }
        [DataMember]
        public decimal CuponPctDescuento { get; set; }
        [DataMember]
        public decimal CuponMontoMaxDscto { get; set; }
        [DataMember]
        public short CuponTipoCondicion { get; set; }
        [DataMember]
        public BERevistaDigital RevistaDigital { get; set; }
        [DataMember]
        public string CodigosRevistaImpresa { get; set; }
        [DataMember]
        public BEOfertaDelDia OfertaDelDiaModel { get; set; }
        [DataMember]
        public BEGuiaNegocio GuiaNegocio { get; set; }
        [DataMember]
        public bool OptBloqueoProductoDigital { get; set; }
        [DataMember]
        public bool TieneValidacionMontoMaximo { get; set; }
        [DataMember]
        public bool EsShowRoom { get; set; }
        [DataMember]
        public bool MostrarBotonValidar { get; set; }
        [DataMember]
        public string FotoOriginalSinModificar { get; set; }
        [DataMember]
        public bool PuedeActualizar { get; set; }
        [DataMember]
        public bool PuedeEnviarSMS { get; set; }
        [DataMember]
        public bool FotoPerfilAncha { get; set; }
        [DataMember]
        public bool EsConsultoraOficina { get; set; }

        public BEUsuario(IDataRecord row, bool Tipo, bool ValidaHorario)
        {
            if (DataRecord.HasColumn(row, "ConsultoraID")) miConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "ConsultoraAsociadoID")) consultoraAsociadoID = Convert.ToInt64(row["ConsultoraAsociadoID"]);
            if (DataRecord.HasColumn(row, "ZonaHoraria")) ZonaHoraria = Convert.ToDouble(row["ZonaHoraria"]);
            if (DataRecord.HasColumn(row, "HabilitarRestriccionHoraria")) HabilitarRestriccionHoraria = Convert.ToBoolean(row["HabilitarRestriccionHoraria"]);
            if (DataRecord.HasColumn(row, "FechaInicioFacturacion")) FechaInicioFacturacion = Convert.ToDateTime(row["FechaInicioFacturacion"]);
            if (DataRecord.HasColumn(row, "FechaFinFacturacion")) FechaFinFacturacion = Convert.ToDateTime(row["FechaFinFacturacion"]);
            if (DataRecord.HasColumn(row, "HorasDuracionRestriccion")) HorasDuracionRestriccion = Convert.ToInt32(row["HorasDuracionRestriccion"]);
            if (DataRecord.HasColumn(row, "EsZonaDemAnti")) EsZonaDemAnti = Convert.ToInt32(row["EsZonaDemAnti"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaDemAnti")) HoraCierreZonaDemAnti = DbConvert.ToTimeSpan(row["HoraCierreZonaDemAnti"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaNormal")) HoraCierreZonaNormal = DbConvert.ToTimeSpan(row["HoraCierreZonaNormal"]);
        }
    }
}
