-- Lua script of map perlshaw_restaurant.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.

local movement = sol.movement.create("random_path")
movement:start(Souci)

  function Souci:on_interaction()
    if game:get_value("souci_gave_food") then
       game:start_dialog("souci.got_tom_food")
    elseif 
      game:get_value("tom_quest_started") then 
      game:start_dialog("souci.help_tom", function()
        game:set_value("souci_gave_food", true)
        sol.audio.play_sound("picked_item")
      end)
    else
      game:start_dialog("souci.welcome")
    end
  end

end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
