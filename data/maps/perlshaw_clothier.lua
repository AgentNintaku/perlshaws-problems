-- Lua script of map perlshaw_clothier.
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

  if game:get_value("enio_rescued") then
    Enio:set_enabled(true)
  end

local mu = sol.movement.create("random")
mu:start(Ukemi)
local me = sol.movement.create("random")
me:start(Enio)

  function Ukemi:on_interaction()
    if game:get_value("enio_home") then
      game:start_dialog("ukemi.enio_home")
    elseif game:get_value("enio_rescued") then
      game:start_dialog("ukemi.give_tunic", function()
        hero:start_treasure("tunic", 2)
        game:set_value("enio_home", true)
      end)
    elseif game:get_value("ukemi_quest_started", true) then 
      game:start_dialog("ukemi.waiting")
    elseif game:has_ability("sword") then
      game:start_dialog("ukemi.quest")
        game:set_value("ukemi_quest_started", true)
    else
      game:start_dialog("ukemi.greet")
    end
  end

  function Enio:on_interaction()
    game:start_dialog("enio.home")
  end



end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
