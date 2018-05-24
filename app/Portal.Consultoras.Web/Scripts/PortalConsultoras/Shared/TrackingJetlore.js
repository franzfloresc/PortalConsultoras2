
var esPaisTrackingJetlore = esPaisTrackingJetlore || "";

function TrackingJetloreAdd(cantidad, campania, cuv) {
    if (esPaisTrackingJetlore == "1" && JL) {
        JL.tracker.addToCart({
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        });
    }
}

function TrackingJetloreRemove(cantidad, campania, cuv) {
    if (esPaisTrackingJetlore == "1" && JL) {
        JL.tracker.removeFromCart({
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        });
    }
}

function TrackingJetloreRemoveAll(lista) {
    if (esPaisTrackingJetlore == "1" && JL) {
        JL.tracker.removeFromCart(lista);
    }
}

function TrackingJetloreView(cuv, campania) {
    if (esPaisTrackingJetlore == "1" && JL) {
        JL.tracker.track({
            event: "view",
            deal_id: cuv,
            option_id: campania
        });
    }
}

function TrackingJetloreSearch(cuv, campania) {
    if (esPaisTrackingJetlore == "1" && JL) {
        JL.tracker.track({
            event: "search",
            text: cuv,
            option_id: campania
        });
    }
}
