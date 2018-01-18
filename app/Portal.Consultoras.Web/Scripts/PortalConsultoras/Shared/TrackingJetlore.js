
var esPaisTrackingJetlore = esPaisTrackingJetlore || "";

function TrackingJetloreAdd(cantidad, campania, cuv) {
    var esJetlore;

    esJetlore = esPaisTrackingJetlore == "1";

    if (esJetlore) {
        JL.tracker.addToCart({
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        });
    }
}

function TrackingJetloreRemove(cantidad, campania, cuv) {
    var esJetlore;

    esJetlore = esPaisTrackingJetlore == "1";

    if (esJetlore) {
        JL.tracker.removeFromCart({
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        });
    }
}

function TrackingJetloreRemoveAll(lista) {
    var esJetlore;

    esJetlore = esPaisTrackingJetlore == "1";

    if (esJetlore) {
        JL.tracker.removeFromCart(lista);
    }
}

function TrackingJetloreView(cuv, campania) {
    var esJetlore;
    esJetlore = esPaisTrackingJetlore == "1";

    if (esJetlore) {
        JL.tracker.track({
            event: "view",
            deal_id: cuv,
            option_id: campania
        });
    }
}

function TrackingJetloreSearch(cuv, campania) {
    var esJetlore;
    esJetlore = esPaisTrackingJetlore == "1";

    if (esJetlore) {
        JL.tracker.track({
            event: "search",
            text: cuv,
            option_id: campania
        });
    }
}
