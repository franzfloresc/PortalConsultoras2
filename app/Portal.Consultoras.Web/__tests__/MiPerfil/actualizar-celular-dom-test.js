const $ = require('../../Scripts/jquery-1.11.2');
const fs = require('fs');

global.$ = global.jQuery = $;
global.AbrirLoad = jest.fn();
global.CerrarLoad = jest.fn();
global.actualizaCelularData = {
    celular: '987654321',
    iniciaNumero: 9,
    urlProvider: {}
};
global.IsoPais = 'PE'; 

require('../../Scripts/PortalConsultoras/MiPerfil/ActualizarCelular');

var mod = window.actualizarCelularModule;

describe('Actualizar Celular', () => {
    
    beforeEach(() => {
        mod.Services = {
            enviarSmsCode: jest.fn().mockReturnValue(Promise.resolve({
                Success: true
            })),
            confirmarSmsCode: jest.fn(code => Promise.resolve({
                Success: code === '123456'
            })),
        };
        
        var data = fs.readFileSync('./__tests__/MiPerfil/actualizar-celular.html');
        document.body.innerHTML = data.toString();
        actualizarCelularModule.Funciones.SetIsoPais(global.IsoPais);
        actualizarCelularModule.Inicializar();
    });

    it('Invalid Number', (done) => {
        $('#NuevoCelular').val('12')
        $('.btn_continuar').click();
        expect(global.AbrirLoad).not.toHaveBeenCalled();

        setImmediate(() => {
            expect($('.text-error').text()).not.toEqual('');
            expect(global.CerrarLoad).not.toHaveBeenCalled();
            expect(mod.Services.enviarSmsCode).not.toHaveBeenCalled();
            expect(mod.Services.confirmarSmsCode).not.toHaveBeenCalled();

            done();
        });
    });

    it('Send SMS Code', (done) => {
        $('#NuevoCelular').val('987654328')
        $('.btn_continuar').click();
        expect(global.AbrirLoad).toHaveBeenCalled();
        setImmediate(() => {
            expect($('.text-error').text()).toEqual('');
            expect(global.CerrarLoad).toHaveBeenCalled();
            expect(mod.Services.enviarSmsCode).toHaveBeenCalled();
            expect(mod.Services.confirmarSmsCode).not.toHaveBeenCalled();

            done();
        });
    });

    it('Enter Invalid SMS Code', (done) => {
        mod.Funciones.InitCounter();
        mod.Funciones.SetSmsCode('012345');

        $('.campo_ingreso_codigo_sms').first().keyup();
        expect(global.AbrirLoad).toHaveBeenCalled();

        setImmediate(() => {
            expect(global.CerrarLoad).toHaveBeenCalled();
            expect(mod.Services.confirmarSmsCode).toHaveBeenCalledWith('012345');
            expect($('.icono_validacion_codigo_sms').hasClass('validacion_erronea')).toBeTruthy();

            done();
        });
    });

    it('Enter Valid SMS Code', (done) => {
        mod.Funciones.InitCounter();
        mod.Funciones.SetSmsCode('123456');

        $('.campo_ingreso_codigo_sms').first().keyup();
        expect(global.AbrirLoad).toHaveBeenCalled();

        setImmediate(() => {
            expect($('.text-error').text()).toEqual('');
            expect(global.CerrarLoad).toHaveBeenCalled();
            expect(mod.Services.confirmarSmsCode).toHaveBeenCalledWith('123456');
            expect($('.icono_validacion_codigo_sms').hasClass('validacion_exitosa')).toBeTruthy();

            done();
        });
    });
});