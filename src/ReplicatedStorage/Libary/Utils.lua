function Format(Int)
	return string.format("%02i", Int)
end

local Utils = {}

function Utils:FormatTime(Seconds)
    print(Seconds)
    local Minutes = (Seconds - Seconds%60)/60
    Seconds = Seconds - Minutes*60
    print(Minutes)
    local Hours = (Minutes - Minutes%60)/60
    Minutes = Minutes - Hours*60
    
    local Days = (Hours - Hours%24)/24
    Hours = Hours - Days*24
    
    if Days > 0 and Hours > 0 and Minutes > 0 then
        return Format(Days)..":"..Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
    elseif Days <= 0 and Hours > 0 and Minutes > 0 then
        return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
    elseif Days <= 0 and Hours <= 0 and Minutes > 0 then
        return Format(Minutes)..":"..Format(Seconds)
    else
        return Format(Minutes)..":"..Format(Seconds)
    end
end

function Utils:CommaNumber(Num)
    Num = tostring(Num)
    return Num:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end



return Utils