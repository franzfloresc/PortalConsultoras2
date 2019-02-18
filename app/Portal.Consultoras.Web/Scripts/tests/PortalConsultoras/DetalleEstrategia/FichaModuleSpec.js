/// <reference path="../../../PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../PortalConsultoras/DetalleEstrategia/FichaModule.js" />

describe("FichaModule", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = ''
        });

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

        it("throw an exception when localStorageModule is undefined", function () {

            try {
                FichaModule({
                    localStorageModule: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.localStorageModule is null or undefined");
        });

        it("throw an exception when localStorageModule is null", function () {

            try {
                FichaModule({
                    localStorageModule: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.localStorageModule is null or undefined");
        });

        it("throw an exception when analyticsPortalModule is undefined", function () {

            try {
                FichaModule({
                    localStorageModule: {},
                    analyticsPortalModule: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.analyticsPortalModule is null or undefined");
        });

        it("throw an exception when analyticsPortalModule is null", function () {

            try {
                FichaModule({
                    localStorageModule: {},
                    analyticsPortalModule: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.analyticsPortalModule is null or undefined");
        });
    });

    describe("Inicializar", function () {
        var fichaModule = null;

        beforeEach(function () {
            fichaModule = null;
        });

        it("", function () {
            //var localStorage = sinon.mock(LocalStorageModule());
            //fichaModule = FichaModule({
            //    localStorageModule: localStorage
            //});

            //fichaModule.Inicializar();
        });
    });
});