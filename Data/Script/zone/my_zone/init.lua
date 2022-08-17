require 'common'

local forsaken_desert = {}
--------------------------------------------------
-- Map Callbacks
--------------------------------------------------
function forsaken_desert.Init(zone)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PrintInfo("=>> Init_my_zone")
  

end

function forsaken_desert.Rescued(zone, name, mail)
  COMMON.Rescued(zone, name, mail)
end

function forsaken_desert.EnterSegment(zone, rescuing, segmentID, mapID)
  if rescuing ~= true then
    COMMON.BeginDungeon(zone.ID, segmentID, mapID)
  end
end

function forsaken_desert.ExitSegment(zone, result, rescue, segmentID, mapID)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PrintInfo("=>> ExitSegment_my_zone result "..tostring(result).." segment "..tostring(segmentID))

  --first check for rescue flag; if we're in rescue mode then take a different path
  COMMON.ExitDungeonMissionCheck(zone.ID, segmentID)
  if rescue == true then
    --COMMON.EndRescue(zone, result, segmentID)
    COMMON.EndDungeonDay(result, 'my_zone', -1, 0, 0)
  elseif result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then
    --COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
      COMMON.EndDungeonDay(result, 'my_zone', -1, 0, 0)
  else
    if segmentID == 0 then
        COMMON.EndDungeonDay(result, 'my_zone', -1, 0, 0)
    else
      PrintInfo("No exit procedure found!")
	  --COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
	  COMMON.EndDungeonDay(result, 'my_zone', -1, 0, 0)
    end
  end

end

return forsaken_desert
