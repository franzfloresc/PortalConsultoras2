const $ = require('../../Scripts/jquery-1.11.2');
global.$ = global.jQuery = $;
global.actualizaCelularData = {
    celular: '987654321',
    urlProvider: {}
};
global.IsoPais = ''; 

require('../../Scripts/PortalConsultoras/MiPerfil/ActualizarCelular');

describe('Update Number Phone', () => {
    var mod = window.actualizarCelularModule;

    it('Empty Number', () => {
        var result = mod.Funciones.ValidarCelular('');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('El número no puede estar vacío.');
    });

    it('Invalid Number', () => {
        var result = mod.Funciones.ValidarCelular('XX22');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('No es un número válido.');
    });

    it('Same number', () => {
        var result = mod.Funciones.ValidarCelular('987654321');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('El número no puede ser el mismo.');
    });

    it('Invalid Length Number PE', () => {
        mod.Funciones.SetIsoPais('PE');
        var result = mod.Funciones.ValidarCelular('121212');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('El número debe tener 9 digitos.');
    });

    it('Valid Length Number PE', () => {
        mod.Funciones.SetIsoPais('PE');
        var result = mod.Funciones.ValidarCelular('123456789');

        expect(result.Success).toBeTruthy();
    });

    it('Invalid Length Number CL', () => {
        mod.Funciones.SetIsoPais('CL');
        var result = mod.Funciones.ValidarCelular('123456');

        expect(result.Success).toBeFalsy();
        expect(result.Message).toEqual('El número debe tener 15 digitos.');
    });

    it('Valid Length Number CL', () => {
        mod.Funciones.SetIsoPais('CL');
        var result = mod.Funciones.ValidarCelular('123456789000000');

        expect(result.Success).toBeTruthy();
    });
});