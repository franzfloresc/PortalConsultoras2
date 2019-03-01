/// <reference path="../../../tests/TestHelpersModule.js" />
/// <reference path="../../../PortalConsultoras/TusClientes/TusClientesView.js" />
/// <reference path="../../../PortalConsultoras/TusClientes/TusClientesProvider.js" />
/// <reference path="../../../PortalConsultoras/TusClientes/PanelMantenerModule.js" />
/// <reference path="../../../PortalConsultoras/TusClientes/TusClientesModule.js" />
/// <reference path="../../../../node_modules/sinon/pkg/sinon.js" />

describe("TusClientes", function () {
    describe("Constructor", function () {
        var errorMsg = "";

        beforeEach(function () {
            errorMsg = "";
        });

        it("throw an exception when config is undefined", function () {
            try {
                TusClientesModule(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");      
        });

        it("throw an exception when config is null", function () {
            try {
                TusClientesModule(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");  
        });

        it("throw an exception when config.tusClientesView is undefined", function () {
            try {
                TusClientesModule({
                    tusClientesView : undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.tusClientesView is null or undefined");      
        });

        it("throw an exception when config.tusClientesView is undefined", function () {
            try {
                TusClientesModule({
                    tusClientesView : null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.tusClientesView is null or undefined");      
        });

        it("throw an exception when config.tusClientesProvider is undefined", function () {
            try {
                TusClientesModule({
                    tusClientesView : {},
                    tusClientesProvider : undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.tusClientesProvider is null or undefined");      
        });

        it("throw an exception when config.tusClientesProvider is undefined", function () {
            try {
                TusClientesModule({
                    tusClientesView : {},
                    tusClientesProvider : null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.tusClientesProvider is null or undefined");      
        });

        it("throw an exception when config.panelMantenerModule is undefined", function () {
            try {
                TusClientesModule({
                    tusClientesView : {},
                    tusClientesProvider : {},
                    panelMantenerModule : undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.panelMantenerModule is null or undefined");      
        });

        it("throw an exception when config.panelMantenerModule is null", function () {
            try {
                TusClientesModule({
                    tusClientesView : {},
                    tusClientesProvider : {},
                    panelMantenerModule : null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.panelMantenerModule is null or undefined");      
        });
    });

    describe("Init", function () {
        var tusClientesModule = null;
        //
        var tusClientesView = null;
        var tusClientesProvider = null;
        var panelMantenerModule = null;
        var checkTimeout = null;

        beforeEach(function () {
            tusClientesView = sinon.stub(TusClientesView());
            tusClientesProvider = sinon.stub(TusClientesProvider());
            panelMantenerModule = sinon.stub(PanelMantenerModule({}));
            checkTimeout = sinon.spy();

            tusClientesProvider
                .consultarPromise
                .returns(
                    TestHelpersModule.getResolvedPromiseWithData({
                        miData: []
                    })
                );

            tusClientesModule = new TusClientesModule({
                tusClientesView: tusClientesView,
                tusClientesProvider: tusClientesProvider,
                panelMantenerModule: panelMantenerModule,
                checkTimeout: checkTimeout
            });
        });

        it("should call tusClientesView.filtroNombreCliente", function () {
            tusClientesModule.init();

            expect(tusClientesView.filtroNombreCliente.calledOnce).to.equals(true);
        });

        it("should call tusClientesView.clientes", function () {
            tusClientesModule.init();

            expect(tusClientesView.clientes.calledOnce).to.equals(true);
        });
    });
});
