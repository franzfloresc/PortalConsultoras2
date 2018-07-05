const $ = require('../../Scripts/jquery-1.11.2');
global.$ = global.jQuery = $;
global.AbrirLoad = jest.fn();
global.CerrarLoad = jest.fn();
global.actualizaCelularData = {
    celular: '987654321',
    iniciaNumero: 9,
    urlProvider: {}
};
global.IsoPais = ''; 

require('../../Scripts/PortalConsultoras/MiPerfil/ActualizarCelular');

describe('Update Number Phone', () => {
    var mod = window.actualizarCelularModule;

    it('Empty Number', () => {
        var result = mod.Funciones.ValidarCelular('');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('Debe ingresar celular.');
    });

    it('Invalid Number', () => {
        var result = mod.Funciones.ValidarCelular('XX22');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('El número no cumple con el formato.');
    });

    it('Same number', () => {
        var result = mod.Funciones.ValidarCelular('987654321');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('El número no puede ser el mismo.');
    });

    it('Invalid Length Number PE', () => {
        mod.Funciones.SetIsoPais('PE');
        var result = mod.Funciones.ValidarCelular('9121212');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('El número debe tener 9 digitos.');
    });

    it('Valid Format and Length Number PE', () => {
        mod.Funciones.SetIsoPais('PE');
        var result = mod.Funciones.ValidarCelular('912345678');

        expect(result.Success).toBeTruthy();
    });

    it('Invalid Length Number CL', () => {
        mod.Funciones.SetIsoPais('CL');
        var result = mod.Funciones.ValidarCelular('123456');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('El número debe tener 9 digitos.');
    });

    // it('Valid Length Number CL', () => {
    //     global.actualizaCelularData.iniciaNumero = -1;
    //     mod.Funciones.SetIsoPais('CL');
    //     var result = mod.Funciones.ValidarCelular('123456789');

    //     expect(result.Success).toBeTruthy();
    // });
});