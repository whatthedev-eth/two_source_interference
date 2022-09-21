%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from contracts.math import cosine_8th, distance_two_points, mul_fp
from contracts.structs import Common_params, Indiv_params, Two_waves_params

//
// Functions for wave physics
//

func intensity{range_check_ptr}(wave_fn: felt) -> felt {
    let intensity = mul_fp(wave_fn, wave_fn);
    return intensity;
}

func wave_sum{range_check_ptr}(wave_fn_1: felt, wave_fn_2: felt) -> felt {
    return wave_fn_1 + wave_fn_2;
}

func wave_function{range_check_ptr}(t: felt, x: felt, y: felt, common: Common_params, wave: Indiv_params) -> felt {
    // unpack common wave parameters
    let omega = common.omega;
    let k = common.k;
    let decay_exp = common.decay_exp;

    // unpack individual wave parameters
    let x0 = wave.x0;
    let y0 = wave.y0;
    let phi = wave.phi;

    // distance from source
    let r = distance_two_points(x0, y0, x, y);
    
    // wave function argument
    let k_r = mul_fp(k, r);
    let omega_t = mul_fp(omega, t);
    let theta = k_r - omega_t + phi;
                              
    // wave function undecayed
    let wave_fn = cosine_8th(theta);
    
    // decayed wave function
    //decayed_wave_fn = wave_fn * r**decay_exp;
    
    //return decayed_wave_fn;
    return wave_fn;
}