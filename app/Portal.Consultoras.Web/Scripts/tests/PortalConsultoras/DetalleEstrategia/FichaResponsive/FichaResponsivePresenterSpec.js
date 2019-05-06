/// <reference path="../../../../tests/TestHelpersModule.js" />

/// <reference path="../../../../General.js" />
/// <reference path="../../../../PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../../PortalConsultoras/DetalleEstrategia/DetalleEstrategiaProvider.js" />

/// <reference path="../../../../PortalConsultoras/DetalleEstrategia/FichaResponsive/FichaResponsivePresenter.js" />

describe("DetalleEstrategia - FichaResponsive - FichaResponsivePresenter", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = '';
        });

        it("throw an exception when config is undefined", function () {

            try {
                FichaResponsivePresenter(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

    });
});