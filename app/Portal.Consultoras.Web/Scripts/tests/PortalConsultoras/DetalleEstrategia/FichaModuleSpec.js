/// <reference path="../../../PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../PortalConsultoras/DetalleEstrategia/FichaModule.js" />

describe("FichaModule", function () {
    describe("Inicializar", function () {

        //beforeAll(function () {
        //    //
        //});
        //afterAll(function () {
        //    //
        //});

        //beforeEach(function () {
        //    //
        //});
        //afterEach(function () {
        //    //
        //});

        it("throw an exception when config is undefined", function () {
            var errorMsg = '';

            try {
                var ficha = FichaModule(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config is null", function () {
            var errorMsg = '';

            try {
                var ficha = FichaModule(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when localStorage is undefined", function () {
            var errorMsg = '';

            try {
                var ficha = FichaModule({
                    localStorageModule: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.localStorageModule is null or undefined");
        });

        it("throw an exception when localStorage is null", function () {
            var errorMsg = '';

            try {
                var ficha = FichaModule({
                    localStorageModule: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.localStorageModule is null or undefined");
        });
    });
});