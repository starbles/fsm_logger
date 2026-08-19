function __fsm_logger_runtime() {
    if (global[$ "__fsm_logger"] == undefined) {
        global.__fsm_logger = { registered_hooks: undefined }
    }

    return global.__fsm_logger;
}

function fsm_logger_register_callbacks() {
    var _rt = __fsm_logger_runtime();

    if (_rt.registered_hooks != undefined) return;

    _rt.registered_hooks = true;

    mmapi_filter("fsm.transition", fsm_logger_transition);
}

function fsm_logger_transition(_value, _ctx) {
    var _owner = _value.owner;

    if (is_struct(_owner)) return undefined;

    if (!instance_exists(_owner)) return undefined;

    if (_owner.object_index != obj_ari) return undefined;

    var _message =
        "Ari FSM: "
        + string(_value.from)
        + " -> "
        + string(_value.to);

    mmapi_log_info("fsm_logger", _message);

    mmapi_log_flush("fsm_logger");

    return undefined
}

mmapi_mod_declare("fsm_logger", "1.0.0");
fsm_logger_register_callbacks();