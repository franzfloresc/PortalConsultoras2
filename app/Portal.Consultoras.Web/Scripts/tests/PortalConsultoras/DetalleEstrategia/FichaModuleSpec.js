/// <reference path="../../../PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../PortalConsultoras/DetalleEstrategia/FichaModule.js" />

describe("FichaModule", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = ''
        });

        //afterEach(function () {
        //    // runs after each test in this block
        //});

        it("throw an exception when config is undefined", function () {

            try {
                FichaModule(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config is null", function () {

            try {
                FichaModule(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when localStorage is undefined", function () {

            try {
                FichaModule({
                    localStorageModule: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.localStorageModule is null or undefined");
        });

        it("throw an exception when localStorage is null", function () {

            try {
                FichaModule({
                    localStorageModule: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.localStorageModule is null or undefined");
        });
    });

    describe("Inicializar", function () {
        var fichaModule = null;

        beforeEach(function () {
            fichaModule = null;
        });

        //it("should return to /ofertas when estrategia is null", function () {

        //    fichaModule = FichaModule({});
        //    fichaModule.Inicializar();

        //    expect(errorMsg).to.have.string("config is null or undefined");
        //});
    });
});