describe("ArmaTuPack - Detalle - Seleccionados", function () {
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
        var generalModule = null;
        var armaTuPackDetalleEvents = null;
        var seleccionadosView = null;
        var seleccionadosPresenter = null;

        beforeEach(function () {
            errorMsg = '';
            //
            generalModule = sinon.stub(GeneralModule);
            armaTuPackDetalleEvents = sinon.stub(ArmaTuPackDetalleEvents());
            seleccionadosView = sinon.stub(SeleccionadosView());
            //
            seleccionadosPresenter = SeleccionadosPresenter({
                seleccionadosView: seleccionadosView,
                armaTuPackDetalleEvents: armaTuPackDetalleEvents,
                generalModule: generalModule
            });
        });

        afterEach(function () {
            sinon.restore();
        });

        it("should return to /Ofertas when data object is undefined", function () {
            seleccionadosPresenter.onGruposLoaded(undefined);

            expect(generalModule.redirectTo.calledOnce).to.equals(true);
        });

        it("should return to /Ofertas when data object is null", function () {
            seleccionadosPresenter.onGruposLoaded(null);

            expect(generalModule.redirectTo.calledOnce).to.equals(true);
        });

        it("should call renderSeleccionados when data object is valid", function () {
            seleccionadosPresenter.onGruposLoaded({});

            expect(seleccionadosView.renderSeleccionados.calledOnce).to.equals(true);
        });
    });
});