/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/estrategia/estrategiapresenter.js" />
/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/estrategia/estrategiaview.js" />
/// <reference path="../../../../../portalconsultoras/shared/constantesmodule.js" />
/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/ficharesponsiveevents.js" />

describe("DetalleEstrategia - FichaResponsive - Estrategia - EstrategiaPresenter", function () {
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
        //
        estrategiaView = sinon.stub(EstrategiaView());
        estrategiaView.renderBreadcrumbs.returns(true);
        estrategiaView.renderEstrategia.returns(true);
        estrategiaView.renderBackgroundAndStamp.returns(true);
        estrategiaView.renderReloj.returns(true);
        estrategiaView.renderRelojStyle.returns(true);
        estrategiaView.renderAgregar.returns(true);
        estrategiaView.showTitleAgregado.returns(true);
        estrategiaView.setEstrategiaTipoBotonAgregar.returns(true);
        estrategiaView.showCarrusel.returns(true);
        estrategiaView.fixButtonAddProduct.returns(true);
        //
        estrategiaPresenter = EstrategiaPresenter({
            estrategiaView: estrategiaView,
            generalModule: generalModule,
            fichaResponsiveEvents : fichaResponsiveEvents
        });
    });

    afterEach(function () {
        sinon.restore();
    });

    describe("Constructor", function () {

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
               CodigoEstrategia : ConstantesModule.TipoEstrategia.Lanzamiento
           };
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

    describe("onEstrategiaModelClick", function () {
        var eventClick = document.createEvent("MouseEvents");

        beforeEach(function () {
            eventClick.initMouseEvent(
                "click", 
                Event.bubbles, 
                Event.cancelable, 
                UIEvent.view, 
                UIEvent.detail, 
                screenX, 
                screenY, 
                MouseEvent.clientX, 
                MouseEvent.clientY, 
                MouseEvent.ctrlKey, 
                MouseEvent.altKey, 
                MouseEvent.shiftKey, 
                MouseEvent.metaKey, 
                null, 
                null);
        });

        it("throw an exception when parameter event is different to event", function () {
            try {
                estrategiaPresenter.onEstrategiaModelClick(undefined, true, true, true, true);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("event is undefined");
        });

        it("throw an exception when popup is different to boolean", function () {
            try {
                estrategiaPresenter.onEstrategiaModelClick(eventClick, undefined, 0, true, true);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("popup is undefined");
        });

        it("throw an exception when limite is different to number", function () {
            try {
                estrategiaPresenter.onEstrategiaModelClick(eventClick, false, undefined, true, true);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("limite is undefined");
        });

        it("throw an exception when esFicha is different to boolean", function () {
            try {
                estrategiaPresenter.onEstrategiaModelClick(eventClick, false, 0, undefined, true);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("esFicha is undefined");
        });

        it("throw an exception when esEditable is different to boolean", function () {
            try {
                estrategiaPresenter.onEstrategiaModelClick(eventClick, false, 0, false, undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("esEditable is undefined");
        });
    });

});