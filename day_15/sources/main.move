/// DAY 15: Read Object Model & Create FarmState Struct (no UID yet)
///
/// Today you will:
/// 1. Learn about Sui objects (conceptually)
/// 2. Create a simple struct for farm counters
/// 3. Write basic functions to increment counters
///
/// NOTE: Today we're NOT creating a Sui object yet, just a regular struct.
/// We'll add UID and make it an object tomorrow.

module challenge::day_15;

const MAX_PLOTS: u64 = 20;
const E_PLOT_NOT_FOUND: u64 = 1;
const E_PLOT_LIMIT_EXCEEDED: u64 = 2;
const E_INVALID_PLOT_ID: u64 = 3;
const E_PLOT_ALREADY_EXISTS: u64 = 4;

public struct FarmCounters has copy, drop, store {
    planet: u64,
    harvested: u64,
    plots: vector<u8>,
}

fun new_counters(): FarmCounters {
    FarmCounters {
        planet: 0,
        harvested: 0,
        plots: vector::empty(),
    }
}

fun plant(counters: &mut FarmCounters, plotId: u8) {
    //validate plotId
    assert!(plotId >=1 && plotId <= (MAX_PLOTS as u8), E_INVALID_PLOT_ID);

    //check limits
    let len = vector::length(&counters.plots);
    assert!(len < MAX_PLOTS, E_PLOT_LIMIT_EXCEEDED);

    //check if plot already exists in the vector
    let mut i = 0;
    while (i < len) {
        let existing_plot = vector::borrow(&counters.plots, i);
        assert!(*existing_plot != plotId, E_PLOT_ALREADY_EXISTS);
        i = i + 1;
    };

    // counters.planted = counters.planted + 1;
    vector::push_back(&mut counters.plots, plotId);
}

fun harvest(counters: &mut FarmCounters, plotId: u8) {
    let len = vector::length(&counters.plots);

    let mut i = 0;
    let mut found_index = len;
    while (i < len) {
        let existing_plot = vector::borrow(&counters.plots, i);
        if (*existing_plot == plotId) {
            found_index = i;
        };
        i = i + 1;
    };
    // Assert that plot was found (found_index < len means we found it)
    assert!(found_index < len, E_PLOT_NOT_FOUND);

    // Remove the plot from the vector
    vector::remove(&mut counters.plots, found_index);
    counters.harvested = counters.harvested + 1;
}
