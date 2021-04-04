-- Lua script of map perlshaw.
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

  if not game:get_value("game_started") then
    game:start_dialog("perlshaw.start")
    game:set_value("game_started", true)
  end

  local me = sol.movement.create("random")
  me:set_max_distance(80)
  me:start(Enio)

  local mr = sol.movement.create("random")
  mr:set_max_distance(80)
  mr:set_speed(22)
  mr:start(Rogi)

  function Enio:on_interaction()
    game:start_dialog("enio.bored")
  end

  function Rogi:on_interaction()
    if game:get_value("rogi_quest_started", true) then 
      game:start_dialog("rogi.waiting")
    else
      game:start_dialog("rogi.quest", function(answer)
        if answer == 1 then 
          game:start_dialog("rogi.accepted")
          game:set_value("rogi_quest_started", true)
        else game:start_dialog("rogi.no")
        end
      end)
    end
  end

  if game:get_value("tom_quest_completed") then
    Rogi:set_enabled(false)
    forge_fire:set_enabled(false)
    forge_smoke:set_enabled(false)
  end

  if game:has_ability("sword") then
    Enio:set_enabled(false)
  end

  if game:get_value("enio_home") then
    for enemy in map:get_entities_by_type("enemy") do
      enemy:set_enabled(true)
    end
    sol.audio.play_music("eduardo/boss")
    game:start_dialog("perlshaw.boss_taunt")
  end

  function goblin_boss:on_dead()
    sol.audio.play_music("eduardo/fanfare")
    sol.audio.play_sound("heart_container")
    for enemy in map:get_entities_by_type("enemy") do
      enemy:remove()
    end
    game:start_dialog("perlshaw.boss_defeated")
  end

end  

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
