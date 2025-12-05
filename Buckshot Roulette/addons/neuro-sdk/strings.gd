class_name Strings

const action_failed_invalid_json := "Action failed. Could not parse action parameters from JSON.";

const action_failed_no_data := "Action failed. Missing command data.";
const action_failed_no_id := "Action failed. Missing command field 'id'.";
const action_failed_no_name := "Action failed. Missing command field 'name'.";
const action_failed_unregistered := "This action has been recently unregistered and can no longer be used."
static var action_failed_unknown_action := FormatString.new("Action failed. Unknown action '%s'.");
const action_failed_error := "Action failed. An error occurred.";

const action_failed_vedal_fault_suffix := " (This is probably not your fault, blame Vedal.)"
const action_failed_mod_fault_suffix := " (This is probably not your fault, blame the game integration.)"

static var action_failed_missing_required_parameter := FormatString.new("Action failed. Missing required '%s' parameter.");
static var action_failed_invalid_parameter := FormatString.new("Action failed. Invalid '%s' parameter.");
