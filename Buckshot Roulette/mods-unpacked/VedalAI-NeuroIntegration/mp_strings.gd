class_name MpStrings

const join_friend_lobby_action_description := "Join a lobby from your friends list."
const join_friend_lobby_action_failed_steam_uninitialized = "Action failed. Steam is not initialized. It might be closed.";
const join_friend_lobby_action_failed_no_lobbies = "Action failed. None of your friends are currently in a Buckshot Roulette lobby.";
const join_friend_lobby_action_failed_invalid_friend = "Action failed. Friend either does not exist or is not currently in a Buckshot Roulette lobby.";

const start_game_action_description := "Start the game."

static var round_start_context := FormatString.new("A new round has started. All players begin with %d health.")

static var other_turn_start_context := FormatString.new("It is now %s's turn.")

static var other_player_details := FormatString.new(" %s currently has %d health, and the following items: %s.")
static var player_turn_action_force_state := FormatString.new("You currently have %d health, and the following items: %s.")
const player_turn_action_force_query := "It is now your turn. Please perform an action. If you want to use any items, you should use them before picking up the shotgun."
const pickup_shotgun_action_description := "Pick up the shotgun and prepare to shoot someone. You cannot use items after doing this."

const steal_item_action_force_query := "You have used the adrenaline. Choose an item to steal from another player."
const steal_item_action_description := "Steal an item from another player."

const shoot_action_force_query := "You have picked up the shotgun. Choose someone to shoot. If you shoot yourself with a blank, you will continue your turn. Otherwise, if you shoot yourself with a live round or decide to shoot someone else, your turn will be passed. If the bullet is a live round, damage will be dealt accordingly."
const shoot_action_description := "Shoot someone. You may decide to shoot yourself if you believe that the current shell is a blank."

const skip_turn_action_force_query := "You have used the jammer. Choose a player to skip their next turn."
const skip_turn_action_description := "Choose a player to skip their next turn."

const self_died_context := "You died! You lost. You have to wait for the next round to play again."
static var other_died_context := FormatString.new("%s died. They have to wait for the next round to play again.")

const jammer_description := "They now get to choose a person to skip their next turn."
const burner_phone_description := "They now know some information about a future shell."
const adrenaline_description := "They are about to steal one of someone else's items!"
const remote_description_cw := "clockwise"
const remote_description_ccw := "counterclockwise"
static var remote_description := FormatString.new("The turn order has been swapped. It is now %s.")
static var other_used_item_context := FormatString.new("%s just used %s. %s")

static var burner_phone_context := FormatString.new("The voice on the other end of the burner phone tells you: \"%s\". If you share this information with other players, it may be used against you, so be careful what you say.")

const self_just_jammed_context := "You have been jammed. Your next turn is skipped."
static var other_just_jammed_context := FormatString.new("%s has been jammed. Their next turn is skipped.")

const grab_briefcase_self_context := "You are the last player alive. You win this round. You get a briefcase full of money."
static var grab_briefcase_other_context := FormatString.new("%s is the last player alive. They win this round.")

static var game_end_context := FormatString.new("The game has ended. %s")
