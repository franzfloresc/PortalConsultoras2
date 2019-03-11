/// <reference path="../../../../../tests/TestHelpersModule.js" />

/// <reference path="../../../../../General.js" />
/// <reference path="../../../../../PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../../../PortalConsultoras/DetalleEstrategia/DetalleEstrategiaProvider.js" />

///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/Grupos/GruposMobileView.js" />
///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/Grupos/GruposDesktopView.js" />
///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/Grupos/GruposPresenter.js" />

describe("ArmaTuPack - Detalle - Grupo - GrupoPresenter", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = '';
        });

        it("throw an exception when config is undefined", function () {

            try {
                GruposPresenter(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config is null", function () {

            try {
                GruposPresenter(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config.gruposView is undefined", function () {

            try {
                GruposPresenter({
                    gruposView: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.gruposView is null or undefined");
        });

        it("throw an exception when config.gruposView is null", function () {

            try {
                GruposPresenter({
                    gruposView: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.gruposView is null or undefined");
        });

        it("throw an exception when config.generalModule is undefined", function () {

            try {
                GruposPresenter({
                    gruposView: {},
                    armaTuPackProvider: {},
                    generalModule: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.generalModule is null or undefined");
        });

        it("throw an exception when config.generalModule is null", function () {

            try {
                GruposPresenter({
                    gruposView: {},
                    armaTuPackProvider: {},
                    generalModule: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.generalModule is null or undefined");
        });

        it("throw an exception when config.armaTuPackDetalleEvents is undefined", function () {

            try {
                GruposPresenter({
                    gruposView: {},
                    armaTuPackProvider: {},
                    generalModule: {},
                    armaTuPackDetalleEvents: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.armaTuPackDetalleEvents is null or undefined");
        });

        it("throw an exception when config.armaTuPackDetalleEvents is null", function () {

            try {
                GruposPresenter({
                    gruposView: {},
                    armaTuPackProvider: {},
                    generalModule: {},
                    armaTuPackDetalleEvents: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.armaTuPackDetalleEvents is null or undefined");
        });
    });
});