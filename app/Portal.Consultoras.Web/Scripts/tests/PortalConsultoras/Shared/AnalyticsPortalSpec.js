
describe("AnalyticsPortal", function () {
    describe("MarcaProductImpressionRecomendaciones", function () {

        it("retorna false cuando parametro data es null en mobile", function () {

            var result = AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(null, true);

            expect(result).to.eql(false);
        });

        it("retorna false cuando parametro data es null en desktop", function () {

            var result = AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(null, false);

            expect(result).to.eql(false);
        });

        it("retorna false cuando Total es null en desktop", function () {

            var obj = {
                Total: null
            };
            var result = AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(obj, false);

            expect(result).to.eql(false);
        });

        it("retorna false cuando Productos es null en mobile", function () {

            var obj = {
                Total: 2,
                Productos: null
            };
            var result = AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(obj, true);

            expect(result).to.eql(false);
        });

        it("retorna false cuando Productos es null en desktop", function () {

            var obj = {
                Total: 2,
                Productos: null
            };
            var result = AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(obj, false);

            expect(result).to.eql(false);
        });

        it("retorna false cuando Productos es array vacio en mobile", function () {

            var obj = {
                Total: 2,
                Productos: []
            };
            var result = AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(obj, true);

            expect(result).to.eql(false);
        });

        it("retorna false cuando Productos es array vacio en desktop", function () {

            var obj = {
                Total: 2,
                Productos: []
            };
            var result = AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(obj, false);

            expect(result).to.eql(false);
        });

    });
});