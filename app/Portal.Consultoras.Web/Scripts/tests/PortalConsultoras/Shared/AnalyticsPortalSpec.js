
describe("Analytics Portal", function () {
    describe("marcaProductImpressionRecomendaciones", function () {

        it("retorna lista vacia cuando parametro lista es null", function () {

            var result = marcaProductImpressionRecomendaciones([], true);

            expect(result).to.eql(false);
        });

    });
});