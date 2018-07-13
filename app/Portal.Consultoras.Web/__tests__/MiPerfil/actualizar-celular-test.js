const $ = require('../../Scripts/jquery-1.11.2');
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

describe('Update Number Phone', () => {
    var mod = window.actualizarCelularModule;

    it('Empty Number', () => {
        var result = mod.Funciones.ValidarCelular('');

        expect(result.Success).toBeFalsy();
        expect(result.Messages.length).toEqual(1);
        expect(result.Messages).toContain('Debe ingresar celular.');
    });

    it('Invalid Number', () => {
        var result = mod.Funciones.ValidarCelular('XX22');

        expect(result.Success).toBeFalsy();
        expect(result.Messages.length).toEqual(3);
        expect(result.Messages).toContain('El número no cumple con el formato.');
        expect(result.Messages).toContain('El número debe tener 9 digitos.');
        expect(result.Messages).toContain('El número debe empezar con 9.');
    });

    it('Same number', () => {
        var result = mod.Funciones.ValidarCelular('987654321');

        expect(result.Success).toBeFalsy();
        expect(result.Messages.length).toEqual(1);
        expect(result.Messages).toContain('El número no puede ser el mismo.');
    });

    it('Invalid Length Number PE', () => {
        mod.Funciones.SetIsoPais('PE');
        var result = mod.Funciones.ValidarCelular('9121212');

        expect(result.Success).toBeFalsy();
        expect(result.Messages.length).toEqual(1);
        expect(result.Messages).toContain('El número debe tener 9 digitos.');
    });

    it('Valid Format and Length Number PE', () => {
        mod.Funciones.SetIsoPais('PE');
        var result = mod.Funciones.ValidarCelular('912345678');

        expect(result.Success).toBeTruthy();
    });

    it('Invalid Number CL', () => {
        mod.Funciones.SetIsoPais('CL');
        var result = mod.Funciones.ValidarCelular('123456');

        expect(result.Success).toBeFalsy();
        expect(result.Messages.length).toEqual(2);
        expect(result.Messages).toContain('El número debe tener 9 digitos.');
        expect(result.Messages).toContain('El número debe empezar con 9.');
    });

    it('Valid Number CL', () => {
        global.actualizaCelularData.iniciaNumero = -1;
        mod.Funciones.SetIsoPais('CL');
        var result = mod.Funciones.ValidarCelular('923456789');

        expect(result.Success).toBeTruthy();
    });
});