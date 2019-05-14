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
});