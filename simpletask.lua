due = 1479717016
threshold = 1477717016

if due~=nil then
    duetime = require "luatz.timetable".new_from_timestamp (due)
    ttime = require "luatz.timetable".new_from_timestamp (threshold)

    return os.time("%W") < duetime("%W") and os.time("%W") > ttime("%W")
end
return false;
