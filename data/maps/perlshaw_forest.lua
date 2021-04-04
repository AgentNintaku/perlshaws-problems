-- Lua script of map perlshaw_forest.
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

  local me = sol.movement.create("target")
  me:set_target(hero)

  if game:get_value("ukemi_quest_started") then
    Enio:set_enabled(true)

    game:set_value("enio_rescued", false)

    for enemy in map:get_entities_by_type("enemy") do
      enemy.on_dead = function()
        if not map:has_entities("enemy") then
          game:set_value("enio_rescued", true)
          sol.audio.play_sound("chest_appears")
        end
      end
    end

    function Enio:on_interaction()
      if not game:get_value("enio_rescued") then
        game:start_dialog("enio.help")
      else
        game:start_dialog("enio.thanks")
        game:set_value("ukemi_quest_started", nil)
      me:start(Enio)
      end
    end
  end
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
