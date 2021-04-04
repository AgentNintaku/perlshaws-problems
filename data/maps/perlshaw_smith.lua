-- Lua script of map perlshaw_smith.
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

--  local path = sol.movement.create("path")

--  path:set_path{4,4,4,4,6,6,6,6,6,6,6,6,6,6,0,0,6,6,6,62,2,2,2,4,4,2,2,2,2,2,2,2,2,2,2,0,0,0,0}
--  path:set_speed(22)
--  path:set_loop()
--  path:start(Rogi)

  if game:get_value("tom_quest_completed") then
    Rogi:set_enabled(true)
    Tom:set_enabled(true)
  end

  local rm = sol.movement.create("random_path")
  rm:set_speed(22)
  rm:start(Rogi)
  local tm = sol.movement.create("random_path")
  tm:start(Tom)

  function Rogi:on_interaction()
    if game:get_value("rogi_quest_completed") then
       game:start_dialog("rogi.thanks")
    else
         game:start_dialog("rogi.give_sword", function()
         hero:start_treasure("sword")
         game:set_value("rogi_quest_completed", true)
         game:set_value("rogi_quest_started", nil)
       end)
    end
  end

  function Tom:on_interaction()
    game:start_dialog("tom.thanks_again")
  end

end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end

