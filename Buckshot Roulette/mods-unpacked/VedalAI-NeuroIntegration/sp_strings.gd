class_name SpStrings

const rules_context := "You are currently playing Buckshot Roulette. It is a life and death game where you face off against an unknown entity called 'the dealer'. Your goal is to kill the dealer. The game is comprised of multiple rounds. At the beginning of each round, both you and the dealer start with the same amount of health. A shotgun is loaded with a random assortment of live shells and blanks. You will know how many live shells and blanks there are, but you will not know their order in the shotgun. During your turn, you can use items if you have any, but at the end you have to shoot either yourself or the dealer with the shotgun. This is a gamble. You HAVE to keep track of how many bullets of each type are remaining, and decide accordingly if you want to shoot the dealer and risk losing your turn, or shoot yourself and risk taking damage. When the shotgun is emptied, it will be reloaded with new bullets. You will also get a random amount of items between 2 and 5. If you have reached your maximum of 8 items already, you will not get the rest, so it's best to use your items as much as possible."

static var round_start_context := FormatString.new("A new round has started. Both you and the dealer begin with %d health.")

static var shotgun_reload_context := FormatString.new("The shotgun has been reloaded. There are %d live rounds and %d blanks, inserted in a random order. You need to remember this and keep track of the shells as the game progresses.")

const dealer_object := "The dealer"
const dealer_pronoun_possessive := "Their"
const dealer_pronoun_reflexive := "themselves"
const player_object := "You"
const player_pronoun_possessive := "Your"
const player_pronoun_reflexive := "yourself"
const blank := "blank"
static var live_with_damage := FormatString.new("live round, dealing %d damage")
static var continue_turn := FormatString.new("%s turn continues.")
static var end_turn := FormatString.new("%s turn has ended.")
static var shotgun_shot_context := FormatString.new("%s just shot %s with a %s! %s (Remember to keep track of shots)")

const handcuffs_description := "Your next turn is skipped."
const inverter_description := "The current round in the chamber has been swapped. KEEP THIS IN MIND WHEN IT IS FIRED SO AS TO NOT COUNT INCORRECTLY"
const medicine_description_good := "They gained 2 health."
const medicine_description_bad := "They lost 1 health."
const adrenaline_description := "They are about to steal one of your items!"
static var beer_description := FormatString.new("They ejected a shell from the shotgun, it was a %s! (KEEP TRACK OF THE SHELL COUNT)")
const cigar_description := "They gained 1 health."
const saw_description := "The next shotgun shot will deal double damage."
const magnifying_glass_description := "They now know what the next shell is."
static var dealer_used_item_context := FormatString.new("The dealer just used %s. %s")

const dealer_object_possessive := "The dealer's"
static var turn_skipped_context := FormatString.new("%s turn is skipped!")

const player_died_context := "You died! You lost."
const dealer_died_context := "The dealer died! Good job."

const smoker_guy_revive_context := "A stranger brought you back from the dead into the cruel embrace of life! The crude figure said: 'Get up, the night is young!'"
const true_death_context := "You have died. You behold a white hellscape of spikes and fog, heaven perhaps, or what's left of it."

static var game_win_context := FormatString.new("You won the game, congratulations! You earned %s.")

const live := "live round"
static var magnifying_glass_context := FormatString.new("Using the magnifying glass, you can see that the next round in the shotgun is a %s.")

static var burner_phone_context := FormatString.new("The voice on the other end of the burner phone tells you: \"%s\".")
#You can choose to share this information, but it might end up being used against you. You should probably keep it to yourself.

const medicine_good_player := "lucky! You gained 2 health"
const medicine_bad_player := "unlucky! You lost 1 health"
static var medicine_context := FormatString.new("You took the expired medicine, and you were %s.")

static var beer_context := FormatString.new("After drinking the beer, you ejected the next round from the shotgun. It was a %s! (KEEP TRACK OF THE SHELL COUNT)")

const choose_name_action_force_query := "Please choose a name."
const choose_name_action_description := "Choose your player name. It needs to be between 1 and 6 characters, and can only contain letters."
const choose_name_action_failed_invalid_name := "Invalid name. It needs to be between 1 and 6 characters, and can only contain letters."
const choose_name_action_failed_forbidden_name := "The name you have chosen is forbidden. Please choose a different one."

const player_turn_action_force_query := "It is now your turn. Please perform an action."
static var player_turn_action_force_state := FormatString.new("You currently have %d health, and the following items: %s. The dealer has %d health, and the following items: %s.")
const shoot_action_description := "Pick up the shotgun and shoot someone. If you shoot yourself with a blank, you will continue your turn. Otherwise, if you shoot yourself with a live round or decide to shoot the dealer, your turn will be passed. If the bullet is a live round, damage will be dealt accordingly. If you want to use any items, you should use them before shooting."
const use_item_action_description := "Use an item from your inventory."
const use_item_action_failed_could_not_find := "The item you tried to use could not be found."

const steal_item_action_force_query := "You have used the adrenaline. Choose an item to steal from the dealer."
const steal_item_action_description := "Steal an item from the dealer."

const action_failed_not_your_turn := "Action failed. It is not your turn.";
static var action_failed_missing_required_parameter := FormatString.new("Action failed. Missing required '%s' parameter.");
static var action_failed_invalid_parameter := FormatString.new("Action failed. Invalid '%s' parameter.");
const action_failed_invalid_json := "Action failed. Could not parse action parameters from JSON.";

const action_failed_no_data := "Action failed. Missing command data.";
const action_failed_no_id := "Action failed. Missing command field 'id'.";
const action_failed_no_name := "Action failed. Missing command field 'name'.";
static var action_failed_unknown_action := FormatString.new("Action failed. Unknown action '%s'.");
const action_failed_error := "Action failed. An error occurred.";

const action_failed_vedal_fault_suffix := " (This is probably not your fault, blame Vedal.)"
const action_failed_mod_fault_suffix := " (This is probably not your fault, blame the game integration.)"
