/// <reference path="../../../../../tests/TestHelpersModule.js" />

/// <reference path="../../../../../General.js" />

///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosView.js" />
///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosPresenter.js" />
///  <reference path="../../../../../PortalConsultoras/ArmaTuPack/Detalle/ArmaTuPackDetalleEvents.js" />

describe("ArmaTuPack - Detalle - SeleccionadosPresenter", function () {
    var fakeComponentsWithNoSelected = function () {
        return {
            "success": true,
            "esMultimarca": true,
            "TipoEstrategiaID": 3018,
            "EstrategiaID": 41497,
            "CUV2": "31575",
            "CodigoVariante": "2003",
            "FlagNueva": 0,
            "componentes": [
                {
                    "Cantidad": 1,
                    //"CodigoProducto": null,
                    //"Cuv": "30379",
                    //"Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                    //"DescripcionComercial": null,
                    "DescripcionMarca": "Ésika",
                    "Digitable": 1,
                    "FactorCuadre": 2,
                    "Grupo": "1",
                    //"Id": 0,
                    "IdMarca": 2,
                    //"Imagen": null,
                    //"ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084550_B.jpg",
                    //"ImagenProductoSugerido": null,
                    //"NombreBulk": "Miel glacé",
                    "NombreComercial": "Labial de Máxima duración.   2 g / .07 oz.",
                    "DescripcionPlural": "Labiales",
                    "DescripcionSingular": "Labial",
                    //"Orden": 26,
                    //"PrecioCatalogo": 2975,
                    //"PrecioCatalogoString": "2.975",
                    //"Volumen": "2 g / .07 oz.",
                    "Hermanos": [
                        {
                            "Cantidad": 1,
                            "CodigoProducto": null,
                            "Cuv": "30405",
                            "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                            "DescripcionComercial": null,
                            "DescripcionMarca": "Ésika",
                            "Digitable": 1,
                            "FactorCuadre": 4,
                            "Grupo": "1",
                            "Id": 0,
                            "IdMarca": 2,
                            "Imagen": null,
                            "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085007_B.jpg",
                            "ImagenProductoSugerido": null,
                            "NombreBulk": "Rosado nude",
                            "NombreComercial": "Labial de Máxima duración. Rosado nude 2 g / .07 oz.",
                            "Orden": 7,
                            "PrecioCatalogo": 2975,
                            "PrecioCatalogoString": "2.975",
                            "Volumen": "2 g / .07 oz.",
                            "Hermanos": null,
                            "TieneStock": true,
                            "EstrategiaGrupoId": 0
                        },
                        {
                            "Cantidad": 1,
                            "CodigoProducto": null,
                            "Cuv": "30387",
                            "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                            "DescripcionComercial": null,
                            "DescripcionMarca": "Ésika",
                            "Digitable": 1,
                            "FactorCuadre": 4,
                            "Grupo": "1",
                            "Id": 0,
                            "IdMarca": 2,
                            "Imagen": null,
                            "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084554_B.jpg",
                            "ImagenProductoSugerido": null,
                            "NombreBulk": "Rosa light",
                            "NombreComercial": "Labial de Máxima duración. Rosa light 2 g / .07 oz.",
                            "Orden": 8,
                            "PrecioCatalogo": 2975,
                            "PrecioCatalogoString": "2.975",
                            "Volumen": "2 g / .07 oz.",
                            "Hermanos": null,
                            "TieneStock": true,
                            "EstrategiaGrupoId": 0
                        }
                    ],
                    "TieneStock": true,
                    //"EstrategiaGrupoId": 0
                },
                {
                    "Cantidad": 1,
                    "CodigoProducto": null,
                    "Cuv": "30577",
                    "Descripcion": "Labial liquido hidratante mate.",
                    "DescripcionComercial": null,
                    "DescripcionMarca": "Ésika",
                    "Digitable": 1,
                    "FactorCuadre": 2,
                    "Grupo": "3",
                    "Id": 0,
                    "IdMarca": 2,
                    "Imagen": null,
                    "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093966_B.jpg",
                    "ImagenProductoSugerido": null,
                    "NombreBulk": "Rojo carmin",
                    "NombreComercial": "Hidracolor Mate.   6 ml / .21 fl.oz.",
                    "DescripcionPlural": "Maquillaje",
                    "DescripcionSingular": "Maquillaje",
                    "Orden": 54,
                    "PrecioCatalogo": 3308,
                    "PrecioCatalogoString": "3.308",
                    "Volumen": "6 ml / .21 fl.oz.",
                    "Hermanos": [
                        {
                            "Cantidad": 1,
                            "CodigoProducto": null,
                            "Cuv": "30583",
                            "Descripcion": "Labial liquido hidratante mate.",
                            "DescripcionComercial": null,
                            "DescripcionMarca": "Ésika",
                            "Digitable": 1,
                            "FactorCuadre": 2,
                            "Grupo": "3",
                            "Id": 0,
                            "IdMarca": 2,
                            "Imagen": null,
                            "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201903/E/productos/bulk/CL_200093969_B.jpg",
                            "ImagenProductoSugerido": null,
                            "NombreBulk": "Chocolate intenso",
                            "NombreComercial": "Hidracolor Mate. Chocolate intenso 6 ml / .21 fl.oz.",
                            "Orden": 46,
                            "PrecioCatalogo": 3308,
                            "PrecioCatalogoString": "3.308",
                            "Volumen": "6 ml / .21 fl.oz.",
                            "Hermanos": null,
                            "TieneStock": true,
                            "EstrategiaGrupoId": 0
                        },
                        {
                            "Cantidad": 1,
                            "CodigoProducto": null,
                            "Cuv": "30571",
                            "Descripcion": "Labial liquido hidratante mate.",
                            "DescripcionComercial": null,
                            "DescripcionMarca": "Ésika",
                            "Digitable": 1,
                            "FactorCuadre": 2,
                            "Grupo": "3",
                            "Id": 0,
                            "IdMarca": 2,
                            "Imagen": null,
                            "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093963_B.jpg",
                            "ImagenProductoSugerido": null,
                            "NombreBulk": "Vino misterio",
                            "NombreComercial": "Hidracolor Mate. Vino misterio 6 ml / .21 fl.oz.",
                            "Orden": 47,
                            "PrecioCatalogo": 3308,
                            "PrecioCatalogoString": "3.308",
                            "Volumen": "6 ml / .21 fl.oz.",
                            "Hermanos": null,
                            "TieneStock": true,
                            "EstrategiaGrupoId": 0
                        }
                    ],
                    "TieneStock": true,
                    "EstrategiaGrupoId": 0
                }
            ],
            "mensaje": "SiMongo|GetEstrategiaProductos = 57|GetEstrategiaDetalleCompuesta = 4|OrdenarComponentesPorMarca = 4|"
        };
    };
    
    var fakeComponentsWithTwoSelected = function () {
        return {
            "success": true,
            "esMultimarca": true,
            "TipoEstrategiaID": 3018,
            "EstrategiaID": 41497,
            "CUV2": "31575",
            "CodigoVariante": "2003",
            "FlagNueva": 0,
            "componentes": [
                {
                    "Cantidad": 1,
                    //"CodigoProducto": null,
                    //"Cuv": "30379",
                    //"Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                    //"DescripcionComercial": null,
                    "DescripcionMarca": "Ésika",
                    "Digitable": 1,
                    "FactorCuadre": 2,
                    "Grupo": "1",
                    //"Id": 0,
                    "IdMarca": 2,
                    //"Imagen": null,
                    //"ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084550_B.jpg",
                    //"ImagenProductoSugerido": null,
                    //"NombreBulk": "Miel glacé",
                    "NombreComercial": "Labial de Máxima duración.   2 g / .07 oz.",
                    "DescripcionPlural": "Labiales",
                    "DescripcionSingular": "Labial",
                    //"Orden": 26,
                    //"PrecioCatalogo": 2975,
                    //"PrecioCatalogoString": "2.975",
                    //"Volumen": "2 g / .07 oz.",
                    "Hermanos": [
                        {
                            "Cantidad": 1,
                            "CodigoProducto": null,
                            "Cuv": "30405",
                            "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                            "DescripcionComercial": null,
                            "DescripcionMarca": "Ésika",
                            "Digitable": 1,
                            "FactorCuadre": 4,
                            "Grupo": "1",
                            "Id": 0,
                            "IdMarca": 2,
                            "Imagen": null,
                            "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085007_B.jpg",
                            "ImagenProductoSugerido": null,
                            "NombreBulk": "Rosado nude",
                            "NombreComercial": "Labial de Máxima duración. Rosado nude 2 g / .07 oz.",
                            "Orden": 7,
                            "PrecioCatalogo": 2975,
                            "PrecioCatalogoString": "2.975",
                            "Volumen": "2 g / .07 oz.",
                            "Hermanos": null,
                            "TieneStock": true,
                            "EstrategiaGrupoId": 0,
                            cantidadSeleccionados : 2
                        },
                        {
                            "Cantidad": 1,
                            "CodigoProducto": null,
                            "Cuv": "30387",
                            "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                            "DescripcionComercial": null,
                            "DescripcionMarca": "Ésika",
                            "Digitable": 1,
                            "FactorCuadre": 4,
                            "Grupo": "1",
                            "Id": 0,
                            "IdMarca": 2,
                            "Imagen": null,
                            "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084554_B.jpg",
                            "ImagenProductoSugerido": null,
                            "NombreBulk": "Rosa light",
                            "NombreComercial": "Labial de Máxima duración. Rosa light 2 g / .07 oz.",
                            "Orden": 8,
                            "PrecioCatalogo": 2975,
                            "PrecioCatalogoString": "2.975",
                            "Volumen": "2 g / .07 oz.",
                            "Hermanos": null,
                            "TieneStock": true,
                            "EstrategiaGrupoId": 0,
                            cantidadSeleccionados : 0
                        }
                    ],
                    "TieneStock": true,
                    //"EstrategiaGrupoId": 0
                    cantidadSeleccionados : 2
                },
                {
                    "Cantidad": 1,
                    "CodigoProducto": null,
                    "Cuv": "30577",
                    "Descripcion": "Labial liquido hidratante mate.",
                    "DescripcionComercial": null,
                    "DescripcionMarca": "Ésika",
                    "Digitable": 1,
                    "FactorCuadre": 2,
                    "Grupo": "3",
                    "Id": 0,
                    "IdMarca": 2,
                    "Imagen": null,
                    "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093966_B.jpg",
                    "ImagenProductoSugerido": null,
                    "NombreBulk": "Rojo carmin",
                    "NombreComercial": "Hidracolor Mate.   6 ml / .21 fl.oz.",
                    "DescripcionPlural": "Maquillaje",
                    "DescripcionSingular": "Maquillaje",
                    "Orden": 54,
                    "PrecioCatalogo": 3308,
                    "PrecioCatalogoString": "3.308",
                    "Volumen": "6 ml / .21 fl.oz.",
                    "Hermanos": [
                        {
                            "Cantidad": 1,
                            "CodigoProducto": null,
                            "Cuv": "30583",
                            "Descripcion": "Labial liquido hidratante mate.",
                            "DescripcionComercial": null,
                            "DescripcionMarca": "Ésika",
                            "Digitable": 1,
                            "FactorCuadre": 2,
                            "Grupo": "3",
                            "Id": 0,
                            "IdMarca": 2,
                            "Imagen": null,
                            "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201903/E/productos/bulk/CL_200093969_B.jpg",
                            "ImagenProductoSugerido": null,
                            "NombreBulk": "Chocolate intenso",
                            "NombreComercial": "Hidracolor Mate. Chocolate intenso 6 ml / .21 fl.oz.",
                            "Orden": 46,
                            "PrecioCatalogo": 3308,
                            "PrecioCatalogoString": "3.308",
                            "Volumen": "6 ml / .21 fl.oz.",
                            "Hermanos": null,
                            "TieneStock": true,
                            "EstrategiaGrupoId": 0,
                            cantidadSeleccionados : 0
                        },
                        {
                            "Cantidad": 1,
                            "CodigoProducto": null,
                            "Cuv": "30571",
                            "Descripcion": "Labial liquido hidratante mate.",
                            "DescripcionComercial": null,
                            "DescripcionMarca": "Ésika",
                            "Digitable": 1,
                            "FactorCuadre": 2,
                            "Grupo": "3",
                            "Id": 0,
                            "IdMarca": 2,
                            "Imagen": null,
                            "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093963_B.jpg",
                            "ImagenProductoSugerido": null,
                            "NombreBulk": "Vino misterio",
                            "NombreComercial": "Hidracolor Mate. Vino misterio 6 ml / .21 fl.oz.",
                            "Orden": 47,
                            "PrecioCatalogo": 3308,
                            "PrecioCatalogoString": "3.308",
                            "Volumen": "6 ml / .21 fl.oz.",
                            "Hermanos": null,
                            "TieneStock": true,
                            "EstrategiaGrupoId": 0,
                            cantidadSeleccionados : 0
                        }
                    ],
                    "TieneStock": true,
                    "EstrategiaGrupoId": 0,
                    cantidadSeleccionados : 0
                }
            ],
            "componentesSeleccionados": [
                {
                    "Cantidad": 1,
                    "CodigoProducto": null,
                    "Cuv": "30405",
                    "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                    "DescripcionComercial": null,
                    "DescripcionMarca": "Ésika",
                    "Digitable": 1,
                    "FactorCuadre": 4,
                    "Grupo": "1",
                    "Id": 0,
                    "IdMarca": 2,
                    "Imagen": null,
                    "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085007_B.jpg",
                    "ImagenProductoSugerido": null,
                    "NombreBulk": "Rosado nude",
                    "NombreComercial": "Labial de Máxima duración. Rosado nude 2 g / .07 oz.",
                    "Orden": 7,
                    "PrecioCatalogo": 2975,
                    "PrecioCatalogoString": "2.975",
                    "Volumen": "2 g / .07 oz.",
                    "Hermanos": null,
                    "TieneStock": true,
                    "EstrategiaGrupoId": 0
                },
                {
                    "Cantidad": 1,
                    "CodigoProducto": null,
                    "Cuv": "30405",
                    "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                    "DescripcionComercial": null,
                    "DescripcionMarca": "Ésika",
                    "Digitable": 1,
                    "FactorCuadre": 4,
                    "Grupo": "1",
                    "Id": 0,
                    "IdMarca": 2,
                    "Imagen": null,
                    "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085007_B.jpg",
                    "ImagenProductoSugerido": null,
                    "NombreBulk": "Rosado nude",
                    "NombreComercial": "Labial de Máxima duración. Rosado nude 2 g / .07 oz.",
                    "Orden": 7,
                    "PrecioCatalogo": 2975,
                    "PrecioCatalogoString": "2.975",
                    "Volumen": "2 g / .07 oz.",
                    "Hermanos": null,
                    "TieneStock": true,
                    "EstrategiaGrupoId": 0
                }
            ],
            "mensaje": "SiMongo|GetEstrategiaProductos = 57|GetEstrategiaDetalleCompuesta = 4|OrdenarComponentesPorMarca = 4|",
            FactorCuadre : 4
        };
    };

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
        var seleccionadosView = null;
        var seleccionadosPresenter = null;

        var generalModule = null;
        var armaTuPackDetalleEvents = null;

        beforeEach(function () {
            errorMsg = '';
            //
            seleccionadosView = sinon.stub(
                SeleccionadosView({
                    seleccionadosContainerId: "#seleccionados"
                })
            );
            //
            generalModule = sinon.stub(GeneralModule);
            armaTuPackDetalleEvents = sinon.stub(ArmaTuPackDetalleEvents());
            //
            seleccionadosPresenter = SeleccionadosPresenter({
                seleccionadosView: seleccionadosView,
                generalModule: generalModule,
                armaTuPackDetalleEvents: armaTuPackDetalleEvents
            });
        });

        afterEach(function () {
            sinon.restore();
        });

        it("throw an exception when data object is undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents is null or undefined");
        });

        it("throw an exception when data object is null", function () {

            try {
                seleccionadosPresenter.onGruposLoaded(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents is null or undefined");
        });

        it("throw an exception when componentes property is null or undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        it("throw an exception when componentes property is null or undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        it("throw an exception when data object has no components", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: []
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        describe("data object has components", function () {
            beforeEach(function () {
                seleccionadosPresenter.onGruposLoaded(fakeComponentsWithNoSelected());
            });

            it("Should not have a null model", function () {
                // Act

                // Arrange
                
                // Assert
                expect(seleccionadosPresenter.packComponents).to.not.be.equals(null);
            });

            it("Should render componentesSeleccionados When model has components", function () {
                // Act

                // Arrange

                // Assert
                expect(seleccionadosView.renderSeleccionados.calledOnce).to.be.equals(true);
            });

            it("Should disable add button When cantidadSeleccionados is less than FactorCuadre", function () {
                // Act

                // Arrange
                
                // Assert
                var cantidadSeleccionados = seleccionadosPresenter.packComponents().componentesSeleccionados.length;
                var factorCuadre = seleccionadosPresenter.packComponents().FactorCuadre;
                expect(cantidadSeleccionados).to.be.lessThan(factorCuadre);
                expect(seleccionadosView.disableAgregar.callCount).to.be.equals(1);
            });

            it("Should hide tooltip", function () {
                // Act

                // Arrange
                
                // Assert
                expect(seleccionadosView.hideTooltip.callCount).to.be.equals(1);
            });
        });
    });

    describe("onSelectedComponentsChanged", function () {
        var errorMsg = '';
        //
        var seleccionadosView = null;
        var seleccionadosPresenter = null;

        var generalModule = null;
        var armaTuPackDetalleEvents = null;

        beforeEach(function () {
            errorMsg = '';
            //
            seleccionadosView = sinon.stub(
                SeleccionadosView({
                    seleccionadosContainerId: "#seleccionados"
                })
            );
            //
            generalModule = sinon.stub(GeneralModule);
            armaTuPackDetalleEvents = sinon.stub(ArmaTuPackDetalleEvents());
            //
            seleccionadosPresenter = SeleccionadosPresenter({
                seleccionadosView: seleccionadosView,
                generalModule: generalModule,
                armaTuPackDetalleEvents: armaTuPackDetalleEvents
            });
        });

        afterEach(function () {
            sinon.restore();
        });

        it("throw an exception when data object is undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents is null or undefined");
        });

        it("throw an exception when data object is null", function () {

            try {
                seleccionadosPresenter.onGruposLoaded(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents is null or undefined");
        });

        it("throw an exception when componentes property is null or undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        it("throw an exception when componentes property is null or undefined", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        it("throw an exception when data object has no components", function () {

            try {
                seleccionadosPresenter.onGruposLoaded({
                    componentes: []
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("packComponents has no components");
        });

        describe("Given the quantity of selected components is lower than FactorCuadre When we update selecteds", function () {
            beforeEach(function () {
                seleccionadosPresenter.onSelectedComponentsChanged(fakeComponentsWithTwoSelected());
            });

            it("Should update selected items ", function () {
                // Arrange
                
                // Act

                // Assert
                expect(seleccionadosView.refreshSeleccionados.callCount).to.be.equals(1);
            });

            it("Should disable add button ", function () {
                // Arrange
                
                // Act

                // Assert
                expect(seleccionadosView.disableAgregar.callCount).to.be.equals(1);
            });

            it("Should hide tooltip ", function () {
                // Arrange
                
                // Act

                // Assert
                expect(seleccionadosView.hideTooltip.callCount).to.be.equals(1);
            });
        });
    });

    describe("addPack", function () {
        var errorMsg = '';
        //
        var seleccionadosView = null;
        var seleccionadosPresenter = null;

        var generalModule = null;
        var armaTuPackDetalleEvents = null;

        beforeEach(function () {
            errorMsg = '';
            //
            seleccionadosView = sinon.stub(
                SeleccionadosView({
                    seleccionadosContainerId: "#seleccionados"
                })
            );
            //
            generalModule = sinon.stub(GeneralModule);
            armaTuPackDetalleEvents = sinon.stub(ArmaTuPackDetalleEvents());
            //
            seleccionadosPresenter = SeleccionadosPresenter({
                seleccionadosView: seleccionadosView,
                generalModule: generalModule,
                armaTuPackDetalleEvents: armaTuPackDetalleEvents
            });
        });

        afterEach(function () {
            sinon.restore();
        });

        describe("Given the quantity of selected components is lower than FactorCuadre When we add the pack", function () {
            it("Should show tooltip ", function () {
                // Arrange
                seleccionadosPresenter.onSelectedComponentsChanged(fakeComponentsWithNoSelected());
                
                // Act
                seleccionadosPresenter.addPack();

                // Assert
                seleccionadosView.showTooltip();
            });

            it("Should show tooltip ", function () {
                // Arrange
                seleccionadosPresenter.onSelectedComponentsChanged(fakeComponentsWithNoSelected());
                
                // Act
                seleccionadosPresenter.addPack();

                // Assert
                expect(seleccionadosView.showTooltip.callCount).to.be.equals(1);
            });

            it("Should fire onShowWarnings event ", function () {
                // Arrange
                seleccionadosPresenter.onSelectedComponentsChanged(fakeComponentsWithNoSelected());
                
                // Act
                seleccionadosPresenter.addPack();

                // Assert
                expect(armaTuPackDetalleEvents.applyChanges.callCount).to.be.equals(1);
                var firstCall = 0; var firstParam = 0;
                expect(armaTuPackDetalleEvents.applyChanges.args[firstCall][firstParam]).to.equals(armaTuPackDetalleEvents.eventName.onShowWarnings);
            });
        });
    });
});