--[[
    init.lua
    Created: 08/11/2022 19:15:03
    Description: Autogenerated script file for the map beach.
]]--
-- Commonly included lua functions and data
require 'common'

-- Package name
local beach = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---beach.Init
--Engine callback function
function beach.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  MapStrings = COMMON.AutoLoadLocalizedStrings()
  _DATA.Save.NoSwitching = true
  COMMON.RespawnAllies()

end

---beach.Enter
--Engine callback function
function beach.Enter(map)

  DEBUG.EnableDbgCoro()

    if GAME:GetPlayerPartyCount() < 2 then
      local mon_id = RogueEssence.Dungeon.MonsterID("treecko", 0, "normal", Gender.Male)
      local p = _DATA.Save.ActiveTeam:CreatePlayer(_DATA.Save.Rand, mon_id, 8, "", 0)
      p.IsFounder = true
      p.IsPartner = true
      _DATA.Save.ActiveTeam.Players:Add(p)
      GROUND:SpawnerSetSpawn('TEAMMATE_1', p)
      GROUND:SpawnerDoSpawn('TEAMMATE_1')
    end

    local partner = CH('Partner')

    GAME:FadeIn(20)
    if not SV.beach.IntroComplete then
      beach.BeginCutscene()
      SV.beach.IntroComplete =  true
    end

  AI:SetCharacterAI(partner, "ai.ground_partner", CH('PLAYER'), partner.Position)
  partner.CollisionDisabled = true

end

---beach.Exit
--Engine callback function
function beach.Exit(map)


end

---beach.Update
--Engine callback function
function beach.Update(map)


end

---beach.GameSave
--Engine callback function
function beach.GameSave(map)


end

---beach.GameLoad
--Engine callback function
function beach.GameLoad(map)

  --GAME:FadeIn(20)
  beach.Enter(map)

end

function beach.Sign_Action(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  UI:ResetSpeaker()
  UI:SetAutoFinish(true)
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['SignText']))
  UI:SetAutoFinish(false)
end

function beach.Assembly_Action(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  UI:ResetSpeaker()
  COMMON.ShowTeamAssemblyMenu(obj, COMMON.RespawnAllies)
end

function beach.Storage_Action(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  COMMON:ShowTeamStorageMenu()
end

function beach.Partner_Action()
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine

  local chara = CH('Partner')
  local player = CH('PLAYER')

  --Make the npc face the player
  GROUND:CharTurnToChar(chara, player)
  UI:SetSpeaker(chara)
  UI:SetSpeakerEmotion("Happy")
  UI:WaitShowDialogue(STRINGS:Format(MapStrings['PartnerDialogue1']))
end

function beach.North_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  --local dungeon_entrances = { 'rev_zone', 'my_zone', 'faded_trail', 'test_zone'}
  --local ground_entrances = {{Flag=true, Zone='rev_zone',ID=0,Entry=0}}
  --COMMON.ShowDestinationMenu(dungeon_entrances,ground_entrances)
end

function beach.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function beach.Teammate2_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function beach.Teammate3_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function beach.BeginCutscene()

  GAME:CutsceneMode(true)

  local chara = CH('Partner')
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
  --UI:WaitShowDialogue(STRINGS:Format("Test String"))


  UI:ResetSpeaker()
  GAME:CutsceneMode(false)

end

-------------------------------
-- Entities Callbacks
-------------------------------


return beach

