const $ = require('../../Scripts/jquery-1.11.2');
const fs = require('fs');

global.$ = global.jQuery = $;
global.actualizaCelularData = {
    celular: '987654321',
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
            confirmarSmsCode: jest.fn().mockReturnValue(Promise.resolve({
                Success: true
            })),
        };
        
        var data = fs.readFileSync('./app/Portal.Consultoras.Web/__tests__/MiPerfil/actualizar-celular.html');
        document.body.innerHTML = data.toString();
        actualizarCelularModule.Funciones.SetIsoPais(global.IsoPais);
        actualizarCelularModule.Inicializar();
    });

    it('Invalid Number', (done) => {
        $('#NuevoCelular').val('12')
        $('.btn_continuar').click();

        setImmediate(() => {
            expect($('.text-error').text()).not.toEqual('');
            expect(mod.Services.enviarSmsCode).not.toHaveBeenCalled();
            expect(mod.Services.confirmarSmsCode).not.toHaveBeenCalled();

            done();
        });
    });

    it('Send SMS Code', (done) => {
        $('#NuevoCelular').val('987654328')
        $('.btn_continuar').click();

        setImmediate(() => {
            expect($('.text-error').text()).toEqual('');
            expect(mod.Services.enviarSmsCode).toHaveBeenCalled();
            expect(mod.Services.confirmarSmsCode).not.toHaveBeenCalled();

            done();
        });
    });

    it('Enter SMS Code', (done) => {
        mod.Funciones.InitCounter();

        var i = 1;
        $('.campo_ingreso_codigo_sms').each(function() {
            $(this).val(i++);
        });
        $('.campo_ingreso_codigo_sms').first().keyup();

        setImmediate(() => {
            expect($('.text-error').text()).toEqual('');
            expect(mod.Services.confirmarSmsCode).toHaveBeenCalledWith('123456');
            expect($('.icono_validacion_codigo_sms').hasClass('validacion_exitosa')).toBeTruthy();

            done();
        });
    });
});