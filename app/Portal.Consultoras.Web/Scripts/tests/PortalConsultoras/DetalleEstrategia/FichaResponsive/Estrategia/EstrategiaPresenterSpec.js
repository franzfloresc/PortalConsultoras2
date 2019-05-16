/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/estrategia/estrategiapresenter.js" />
/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/estrategia/estrategiaview.js" />
/// <reference path="../../../../../portalconsultoras/shared/constantesmodule.js" />
/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/ficharesponsiveevents.js" />


describe("DetalleEstrategia - FichaResponsive - Estrategia - EstrategiaPresenter", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = '';
        });

        it("throw an exception when config is undefined", function () {

            try {
                EstrategiaPresenter(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config is null", function () {

            try {
                EstrategiaPresenter(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config.estrategiaView is undefined", function () {

            try {
                EstrategiaPresenter({
                    estrategiaView: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.estrategiaView is null or undefined");
        });

        it("throw an exception when config.estrategiaView is null", function () {

            try {
                EstrategiaPresenter({
                    estrategiaView: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.estrategiaView is null or undefined");
        });

        it("throw an exception when config.generalModule is undefined", function () {

            try {
                EstrategiaPresenter({
                    estrategiaView: {},
                    generalModule: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.generalModule is null or undefined");
        });

        it("throw an exception when config.generalModule is null", function () {

            try {
                EstrategiaPresenter({
                    estrategiaView: {},
                    generalModule: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.generalModule is null or undefined");
        });

        // it("throw an exception when config.armaTuPackDetalleEvents is undefined", function () {

        //     try {
        //         GruposPresenter({
        //             gruposView: {},
        //             armaTuPackProvider: {},
        //             generalModule: {},
        //             armaTuPackDetalleEvents: undefined
        //         });
        //     } catch (error) {
        //         errorMsg = error;
        //     }

        //     expect(errorMsg).to.have.string("config.armaTuPackDetalleEvents is null or undefined");
        // });

        // it("throw an exception when config.armaTuPackDetalleEvents is null", function () {

        //     try {
        //         GruposPresenter({
        //             gruposView: {},
        //             armaTuPackProvider: {},
        //             generalModule: {},
        //             armaTuPackDetalleEvents: null
        //         });
        //     } catch (error) {
        //         errorMsg = error;
        //     }

        //     expect(errorMsg).to.have.string("config.armaTuPackDetalleEvents is null or undefined");
        // });
    });

    describe("onEstrategiaModelLoaded",function(){
        var errorMsg = '';
        //
        var generalModule = null;
        //
        var fichaResponsiveEvents = null;
        var estrategiaView = null;
        var estrategiaPresenter = null;

        beforeEach(function () {
            generalModule = sinon.stub(GeneralModule);
            //
            fichaResponsiveEvents = sinon.stub(FichaResponsiveEvents());
            estrategiaView = sinon.stub(EstrategiaView());
            estrategiaPresenter = EstrategiaPresenter({
                estrategiaView: estrategiaView,
                generalModule: generalModule,
                fichaResponsiveEvents : fichaResponsiveEvents
            });
        });
        
        afterEach(function () {
            sinon.restore();
        });

        it("throw an exception when estrategiaModel is undefined", function () {
            
            try {
                estrategiaPresenter.onEstrategiaModelLoaded(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("estrategiaModel is null or undefined");
        });

        it("throw an exception when estrategiaModel is null", function () {
            
            try {
                estrategiaPresenter.onEstrategiaModelLoaded(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("estrategiaModel is null or undefined");
        });

        it("throw an exception when estrategiaView do not render breadcrumbs", function () {
            // Arrange
            var estrategiaModel = {};
            estrategiaView.renderBreadcrumbs.returns(false);

            // Act
            try {
                estrategiaPresenter.onEstrategiaModelLoaded(estrategiaModel);
            } catch (error) {
                errorMsg = error;
            }

            // Assert
            expect(errorMsg).to.have.string("estrategiaView do not render model");
        });

        it("throw an exception when estrategiaView do not render estrategia information", function () {
            // Arrange
            var estrategiaModel = {};
            estrategiaView.renderBreadcrumbs.returns(true);
            estrategiaView.renderEstrategia.returns(false);

            // Act
            try {
                estrategiaPresenter.onEstrategiaModelLoaded(estrategiaModel);
            } catch (error) {
                errorMsg = error;
            }

            // Assert
            expect(errorMsg).to.have.string("estrategiaView do not render model");
        });

        it("throw an exception when estrategiaView do not render lan background and stamp for lan", function () {
            // Arrange
            var estrategiaModel = {
                codigoEstrategia : ConstantesModule.TipoEstrategia.Lanzamiento
            };
            estrategiaView.renderBreadcrumbs.returns(true);
            estrategiaView.renderEstrategia.returns(true);
            estrategiaView.renderBackgroundAndStamp.returns(false);

            // Act
            try {
                estrategiaPresenter.onEstrategiaModelLoaded(estrategiaModel);
            } catch (error) {
                errorMsg = error;
            }

            // Assert
            expect(errorMsg).to.have.string("estrategiaView do not render background and stamp");
        });

        it("return true when estrategiaView render model", function () {
            // Arrange
            var estrategiaModel = {};
            estrategiaView.renderBreadcrumbs.returns(true);
            estrategiaView.renderEstrategia.returns(true);
            // estrategiaView.render.returns(true);

            // Act
            var result =  estrategiaPresenter.onEstrategiaModelLoaded(estrategiaModel);
            
            // Assert
            expect(result).to.be.eql(true);
        });
    });
});