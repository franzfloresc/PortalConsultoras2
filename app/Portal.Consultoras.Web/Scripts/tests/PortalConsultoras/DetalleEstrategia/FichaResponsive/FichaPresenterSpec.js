/// <reference path="../../../../tests/TestHelpersModule.js" />

/// <reference path="../../../../General.js" />
/// <reference path="../../../../PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../../PortalConsultoras/DetalleEstrategia/DetalleEstrategiaProvider.js" />

/// <reference path="../../../../PortalConsultoras/DetalleEstrategia/FichaResponsive/FichaPresenter.js" />

describe("DetalleEstrategia - FichaResponsive - FichaPresenter", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = '';
        });

        it("throw an exception when config is undefined", function () {

            try {
                FichaPresenter(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

    });
});