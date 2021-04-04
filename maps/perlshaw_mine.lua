-- Lua script of map perlshaw_mine.
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

  if game:get_value("tom_quest_completed") then
    Tom:set_enabled(false)
  end
    
    
  local m = sol.movement.create("random_path")
  m:set_speed(44)
  m:start(Tom)

  function Tom:on_interaction()
    if game:get_value("souci_gave_food") then
       game:start_dialog("tom.thanks", function()
         game:set_value("tom_quest_completed", true)
         game:set_value("tom_quest_started", nil)
       end)
    elseif 
      game:get_value("tom_quest_started", true) then 
      game:start_dialog("tom.waiting")
    else
      game:start_dialog("tom.quest", function(answer)
        if answer == 1 then 
          game:start_dialog("tom.waiting")
          game:set_value("tom_quest_started", true)
        else game:start_dialog("tom.no")
        end
      end)
    end
  end

end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end