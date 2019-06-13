/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/fichaenriquecida/fichaenriquecidapresenter.js" />
/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/fichaenriquecida/fichaenriquecidaview.js" />
/// <reference path="../../../../../portalconsultoras/shared/constantesmodule.js" />

describe("DetalleEstrategia - FichaResponsive - FichaEnriquecida - FichaEnriquecidaPresenter", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = '';
        });

        it("throw an exception when config is undefined", function () {

            try {
                FichaEnriquecidaPresenter(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config is null", function () {

            try {
                FichaEnriquecidaPresenter(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config.fichaEnriquecidaView is undefined", function () {

            try {
                FichaEnriquecidaPresenter({
                    fichaEnriquecidaView: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.fichaEnriquecidaView is null or undefined");
        });

    });
    
    describe("onFichaResponsiveModelLoaded", function () {
        var errorMsg = '';
        var fichaEnriquecidaView = null;
        var fichaEnriquecidaPresenter = null;

        beforeEach(function () {
            fichaEnriquecidaView = sinon.stub(FichaEnriquecidaView());
            fichaEnriquecidaPresenter = FichaEnriquecidaPresenter({
                fichaEnriquecidaView: fichaEnriquecidaView
            });
        });

        afterEach(function () {
            sinon.restore();
        });

        it("throw an exception when fichaEnriquecidaModel is undefined", function () {

            try {
                fichaEnriquecidaPresenter.onFichaResponsiveModelLoaded(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("estrategiaModel is null or undefined");
        });

        it("throw an exception when fichaEnriquecidaModel is null", function () {

            try {
                fichaEnriquecidaPresenter.onFichaResponsiveModelLoaded(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("estrategiaModel is null or undefined");
        });
        
        it("throw an exception when fichaEnriquecidaView do not render fichaenriquecida", function () {
            // Arrange
            var estrategiaModel = {};

            fichaEnriquecidaView.renderFichaEnriquecida.returns(false);

            // Act
            try {
                fichaEnriquecidaPresenter.onFichaResponsiveModelLoaded(estrategiaModel);
            } catch (error) {
                errorMsg = error;
            }

            // Assert
            expect(errorMsg).to.have.string("estrategiaModel is null or undefined");
        });

    });
        
});