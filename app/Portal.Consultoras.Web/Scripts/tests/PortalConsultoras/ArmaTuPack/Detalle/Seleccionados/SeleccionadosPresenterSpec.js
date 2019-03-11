/// <reference path="../../../../../tests/TestHelpersModule.js" />

/// <reference path="../../../../../General.js" />

///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosView.js" />
///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosPresenter.js" />
///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/ArmaTuPackDetalleEvents.js" />

describe("ArmaTuPack - Detalle - SeleccionadosPresenter", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = '';
        });

        it("throw an exception when config is undefined", function () {

            try {
                SeleccionadosPresenter(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config is null", function () {

            try {
                SeleccionadosPresenter(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config.seleccionadosView is undefined", function () {

            try {
                SeleccionadosPresenter({
                    seleccionadosView: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.seleccionadosView is null or undefined");
        });

        it("throw an exception when config.seleccionadosView is null", function () {

            try {
                SeleccionadosPresenter({
                    seleccionadosView: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.seleccionadosView is null or undefined");
        });

        it("throw an exception when config.armaTuPackDetalleEvents is undefined", function () {

            try {
                SeleccionadosPresenter({
                    seleccionadosView : {},
                    armaTuPackDetalleEvents : undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.armaTuPackDetalleEvents is null or undefined");
        });

        it("throw an exception when config.armaTuPackDetalleEvents is null", function () {

            try {
                SeleccionadosPresenter({
                    seleccionadosView : {},
                    armaTuPackDetalleEvents : null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.armaTuPackDetalleEvents is null or undefined");
        });

        it("throw an exception when config.generalModule is undefined", function () {

            try {
                SeleccionadosPresenter({
                    seleccionadosView : {},
                    armaTuPackDetalleEvents : {},
                    generalModule : undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.generalModule is null or undefined");
        });

        it("throw an exception when config.generalModule is null", function () {

            try {
                SeleccionadosPresenter({
                    seleccionadosView : {},
                    armaTuPackDetalleEvents : {},
                    generalModule : null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.generalModule is null or undefined");
        });
    });

    describe("OnGruposLoaded", function () {
        var errorMsg = '';
        //
        var seleccionadosView = null;
        var seleccionadosPresenter = null;

        var generalModule = null;
        var armaTuPackDetalleEvents = null;

        beforeEach(function () {
            errorMsg = '';
            //
            seleccionadosView = sinon.stub(SeleccionadosView());
            //
            generalModule = sinon.stub(GeneralModule);
            armaTuPackDetalleEvents = sinon.stub(ArmaTuPackDetalleEvents());
            //
            seleccionadosPresenter = SeleccionadosPresenter({
                seleccionadosView: seleccionadosView,
                generalModule: generalModule,
                armaTuPackDetalleEvents: armaTuPackDetalleEvents
            });
        });

        afterEach(function () {
            sinon.restore();
        });

        it("throw an exception when data object is undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents is null or undefined");
        });

        it("throw an exception when data object is null", function () {

            try {
                seleccionadosPresenter.onGruposLoaded(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents is null or undefined");
        });

        it("throw an exception when componentes property is null or undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        it("throw an exception when componentes property is null or undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        it("throw an exception when data object has no components", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: []
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        it("render seleccionados when data object has components", function () {
            seleccionadosPresenter.onGruposLoaded({
                componentes: [{}]
            });

            expect(seleccionadosView.renderSeleccionados.calledOnce).to.be.equals(true);
        });
    });
});