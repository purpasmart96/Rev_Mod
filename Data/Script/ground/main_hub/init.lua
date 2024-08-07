--[[
    init.lua
    Created: 08/11/2022 19:15:03
    Description: Autogenerated script file for the map main_hub.
]]--
-- Commonly included lua functions and data
require 'common'

-- Package name
local main_hub = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---main_hub.Init
--Engine callback function
function main_hub.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  MapStrings = COMMON.AutoLoadLocalizedStrings()

end

---main_hub.Enter
--Engine callback function
function main_hub.Enter(map)

  GAME:FadeIn(20)
  main_hub.BeginCutscene()

end

---main_hub.Exit
--Engine callback function
function main_hub.Exit(map)


end

---main_hub.Update
--Engine callback function
function main_hub.Update(map)


end

---main_hub.GameSave
--Engine callback function
function main_hub.GameSave(map)


end

---main_hub.GameLoad
--Engine callback function
function main_hub.GameLoad(map)

  GAME:FadeIn(20)

end

function main_hub.Sign_Action(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  UI:ResetSpeaker()
  UI:SetAutoFinish(true)
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['SignText']))
  UI:SetAutoFinish(false)
end

function main_hub.Assembly_Action(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  UI:ResetSpeaker()
  COMMON.ShowTeamAssemblyMenu(obj, COMMON.RespawnAllies)
end

function main_hub.Storage_Action(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  COMMON:ShowTeamStorageMenu()
end

function main_hub.Chara_Partner_Action()
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine

  local chara = CH('Chara_Partner')
  local player = CH('PLAYER')

  --Make the npc face the player
  GROUND:CharTurnToChar(chara, player)
  UI:SetSpeaker(chara)
  UI:SetSpeakerEmotion("Happy")
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PartnerDialogue1']))
end

function main_hub.North_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  --local dungeon_entrances = { 'rev_zone', 'my_zone', 'faded_trail', 'test_zone'}
  --local ground_entrances = {{Flag=true, Zone='rev_zone',ID=0,Entry=0}}
  --COMMON.ShowDestinationMenu(dungeon_entrances,ground_entrances)
end

function main_hub.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function main_hub.Teammate2_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function main_hub.Teammate3_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function main_hub.BeginCutscene()

  GAME:CutsceneMode(true)

  local chara = CH('Chara_Partner')
  local player = CH('PLAYER')
  UI:SetSpeaker(chara)

  GAME:WaitFrames(60)
  GROUND:CharSetEmote(chara, "question", 1)

  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PartnerCutscene1']))
  GROUND:EntTurn(chara, Direction.Right)

  UI:SetSpeakerEmotion("Surprised")
  GROUND:CharSetEmote(chara, "shock", 1)
  SOUND:PlayBattleSE("EVT_Emote_Shock_Bad")
  GAME:WaitFrames(60)

  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PartnerCutscene2']))

  UI:SetSpeaker(player)
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PlayerCutscene1']))

  UI:SetSpeaker(chara)
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PartnerCutscene3']))

  UI:SetSpeaker(player)
  UI:SetSpeakerEmotion("Worried")
  GROUND:CharSetEmote(player, "question", 1)
  SOUND:PlayBattleSE("EVT_Emote_Confused")
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PlayerCutscene2']))

  UI:SetSpeaker(chara)
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PartnerCutscene4']))

  UI:SetSpeaker(player)
  --UI:SetSpeakerEmotion("Question")
  UI:SetSpeakerEmotion("Worried")
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PlayerCutscene3']))

  UI:SetSpeaker(chara)
  --Normal Happy sad inspired worried surprised shouting angry determined joyous teary-eyed crying stunned dizzy sigh special0-3
  UI:SetSpeakerEmotion("Surprised")
  GROUND:CharSetEmote(chara, "sweating", 1)
  SOUND:PlayBattleSE("EVT_Emote_Sweating")
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PartnerCutscene5']))


  UI:ResetSpeaker()
  GAME:CutsceneMode(false)

end

-------------------------------
-- Entities Callbacks
-------------------------------


return main_hub

