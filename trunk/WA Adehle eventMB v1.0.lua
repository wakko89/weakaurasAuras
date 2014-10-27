-- eventMB Trigger
function() 
    -- GLOBALS
    WA_ADEHLE_EVENTMB_SPELL = "Mind Blast" -- Spell to track CD of
    WA_ADEHLE_EVENTMB_SPELLGCD = "Levitate"  -- Spell to get GCD from. Any instant-cast spell will do
    WA_ADEHLE_EVENTMB_PAST = 3 --  How far into the past you want to see
    WA_ADEHLE_EVENTMB_MBD = 12 -- Max bar duration. nil to use spell duration
    
	-- Initialize globals to avoid errors
    WA_ADEHLE_EVENTMB_START = WA_ADEHLE_EVENTMB_START or 0
    WA_ADEHLE_EVENTMB_DURA = WA_ADEHLE_EVENTMB_DURA or 0
    WA_ADEHLE_EVENTMB_END = WA_ADEHLE_EVENTMB_END or 0
	WA_ADEHLE_EVENTMB_TIME = WA_ADEHLE_EVENTMB_TIME or 0
    
    -- LOCALS
    local spell = WA_ADEHLE_EVENTMB_SPELL
    local spellGCD = WA_ADEHLE_EVENTMB_SPELLGCD
    local _,dGCD = GetSpellCooldown(spellGCD)
    local sTime,CD = GetSpellCooldown(spell)
    
    if CD ~= dGCD or CD == 0 then
		if CD == dGCD then -- if spell ready
			WA_ADEHLE_EVENTMB_END = WA_ADEHLE_EVENTMB_TIME
		else -- if spell on cooldown
			WA_ADEHLE_EVENTMB_START = sTime
			WA_ADEHLE_EVENTMB_DURA = CD
			WA_ADEHLE_EVENTMB_END = WA_ADEHLE_EVENTMB_START + WA_ADEHLE_EVENTMB_DURA
			WA_ADEHLE_EVENTMB_TIME = GetTime()
		end
        return true
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- eventMB Untrigger
function()
	local startTime = WA_ADEHLE_EVENTMB_START or 0
	local dura = WA_ADEHLE_EVENTMB_DURA or 0
	local past = WA_ADEHLE_EVENTMB_PAST or 0
    if not (GetTime() > startTime + dura + past) then
        return true
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- eventMB Duration
function()
    local maxBarDura = WA_ADEHLE_EVENTMB_MBD or WA_ADEHLE_EVENTMB_DURA or 12
    local past = WA_ADEHLE_EVENTMB_PAST or 3
	local endTime = WA_ADEHLE_EVENTMB_END or 0
    return maxBarDura + past, endTime + past
end



