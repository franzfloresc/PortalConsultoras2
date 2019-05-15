describe("DetalleEstrategia - FichaResponsive - Estrategia - EstrategiaPresenter", function () {
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