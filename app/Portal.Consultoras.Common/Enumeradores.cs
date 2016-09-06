﻿using System;
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


        public enum RespuestaGEO
        {
            OK,
            ERROR
        }

        public enum IdEstadoActividad
        {
            Registrada = 1,
            Retirada = 7
        }

        public enum EstadoGEO
        {
            SinConsultar = 1,
            OK = 2,
            NoEncontroTerritorioNoLatLong = 3,
            NoEncontroTerritorioSiLatLong = 4,
            ErrorConsumoIntegracion = 5,
            Reactivada = 6
        }

        public enum EstadoPostulante
        {
            Todos = 0,
            Registrada = 1,
            EnGestionServicioAlCliente = 2,
            EnAprobacionFFVV = 3,
            Rechazada = 4,
            YaConCodigo = 5,
            Reactivada = 6,
            //PendienteDobleOptin = 7
            GenerandoCodigo = 7,
            EnAprobacionSAC = 8
        }

        public enum TipoParametro
        {
            Correo = 1,
            EstadoPostulante = 2,
            EstadoBurocrediticio = 3,
            EstadoGEO = 4,
            LugarNivel1 = 5,
            LugarNivel2 = 6,
            LugarNivel3 = 7,
            LugarNivel4 = 8,
            LugarNivel5 = 9,          
            PrefijosCelular = 13,
            Validaciones = 14,
            EstadoTelefonico = 15,
            MotivoRechazoTelefonico = 16,
            MensajeBuroCrediticio = 17
        }

        public enum EstadoBurocrediticio
        {
            SinConsultar = 1,
            PuedeSerConsultora = 2,
            NoPuedeSerConsultora = 3,
            PodriaSerConsultoraCuandoTengaAval = 4,
            ErrorConsumoIntegracion = 5,
            Reactivada = 6,
            CodigoDeSuscriptorNoExiste = 7,
            ClaveErrada = 8,
            NumeroTerminalNoExiste = 9,
            TipoDeDocumentoErrado = 10,
            NumeroDeDocumentoErrado = 11,
            PrimerApellidoErrado = 12,
            FinConsultaTipo2 = 13,
            FinConsultaTipo4 = 14,
            FinConsultatipo7 = 15,
            FinConsultaTipo6 = 16,
            Terminaldesactivada = 17,
            ClaveDeConsultaBloqueada = 18,
            FinConsultaTipo1 = 19,
            FinConsultaTipo5 = 20,
            IngresoCorrecto = 21,
            SuPrepagoYaEstaAgotado = 22,
            ClaveVencida = 23,
            ClaveNoHabilitada = 24,
            ModalidadDePrepagoBloqueada = 25,
            ModalidadDePrepagosNoabilitada = 26,
            SuPrepagoYaFueVencido = 27,
            NoSepudoRealizarLaConsulta = 28,
            ClavedeDcifraSinTabla = 29

        }
        public enum TipoMensajeEdad
        {
            MenorDeEdad = 1,
            MayorDeEdad = 2
        }

        public enum TipoEstadoTelefonico
        {
            SinAsignar = 0,
            Aprobado = 1,
            Rechazado = 2,
            Omitido = 3
        }
        public enum TipoDocumento
        {
            Dni = 1,
            CarnetExtranjeria = 2,
            Pasaporte = 3,
            Ruc = 4,
            Otros = 5
        }

        public enum TipoSubEstadoPostulanteRechazada
        {
            RechazadoEV = 1,
            RechazadoYaesPostulante = 2,
            RechazadoYaesConsultora = 3,
            RechazadoBloqueosInternos = 4,
            RechazoValidacionTelefonica = 5,
            RechazoZonaPreferencial = 6,
            RechazadoGZ = 7,
            RechazadoSE = 8,
            RechazadoSAC = 9,
            RechazadoSEWeb = 10

        }

        public enum TipoSubEstadoPostulanteGenerandoCodigo
        {
            PorSE = 1,
            PorGZ = 2,
            PorSAC = 3,
            PorSEWeb = 4
        }

        public enum TipoNivelesRiesgo
        {
            Bajo = 1,
            Medio = 2,
            Alto = 3,
            Otro = 4
        }

    }
}
