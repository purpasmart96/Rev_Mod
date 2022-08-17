require 'common'

local relic_tower = {}
--------------------------------------------------
-- Map Callbacks
--------------------------------------------------
function relic_tower.Init(zone)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PrintInfo("=>> Init_rev_zone")
  

end

function relic_tower.Rescued(zone, name, mail)
  COMMON.Rescued(zone, name, mail)
end

function relic_tower.EnterSegment(zone, rescuing, segmentID, mapID)
  if rescuing ~= true then
    COMMON.BeginDungeon(zone.ID, segmentID, mapID)
  end
end

function relic_tower.ExitSegment(zone, result, rescue, segmentID, mapID)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PrintInfo("=>> ExitSegment_relic_tower result "..tostring(result).." segment "..tostring(segmentID))
  
  --first check for rescue flag; if we're in rescue mode then take a different path
  COMMON.ExitDungeonMissionCheck(zone.ID, segmentID)
  if rescue == true then
    --COMMON.EndRescue(zone, result, segmentID)
    COMMON.EndDungeonDay(result, 'my_zone', -1, 0, 0)
  elseif result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then
    --COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
    COMMON.EndDungeonDay(result, 'rev_zone', -1, 0, 0)
  else
    if segmentID == 0 then
      --COMMON.EndDungeonDay(result, 'guildmaster_island', -1, 1, 0)
      COMMON.EndDungeonDay(result, 'rev_zone', -1, 0, 0)
    else
      PrintInfo("No exit procedure found!")
	  --COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
	  COMMON.EndDungeonDay(result, 'rev_zone', -1, 0, 0)
    end
  end
  
end

return relic_tower
