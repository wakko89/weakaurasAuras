-- eventMB Trigger
function() 
	WA_ADEHLE_EVENTMB_ = {}
	local wa = WA_ADEHLE_EVENTMB_
    -- GLOBALS
    wa.SPELL = "Mind Blast" -- Spell to track CD of
    wa.SPELLGCD = "Levitate"  -- Spell to get GCD from. Any instant-cast spell will do
    wa.PAST = 3 --  How far into the past you want to see
    wa.MBD = 12 -- Max bar duration. nil to use spell duration
    
	-- Initialize globals to avoid errors
    wa.START = wa.START or 0
    wa.DURA = wa.DURA or 0
    wa.END = wa.END or 0
	wa.TIME = wa.TIME or 0
    
    -- LOCALS
    local spell = wa.SPELL
    local spellGCD = wa.SPELLGCD
    local _,dGCD = GetSpellCooldown(spellGCD)
    local sTime,CD = GetSpellCooldown(spell)
    
	if CD == dGCD then -- if spell ready
		wa.END = wa.TIME or 0
	else -- if spell on cooldown
		wa.START = sTime
		wa.DURA = CD
		wa.END = wa.START + wa.DURA
		wa.TIME = GetTime()
	end
	local endTime = wa.END or 0
	local past = wa.PAST or 0
    if ((endTime+past) > GetTime()) then
        return true
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- eventMB Untrigger
function()
	local wa = WA_ADEHLE_EVENTMB_
	--local startTime = wa.START or 0
	--local dura = wa.DURA or 0
	local endTime = wa.END or 0
	local past = wa.PAST or 0
    if not ((endTime + past) > GetTime()) then
        return true
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- eventMB Duration
function()
	local wa = WA_ADEHLE_EVENTMB_
    local maxBarDura = wa.MBD or wa.DURA or 12
    local past = wa.PAST or 3
	local endTime = wa.END or 0
    return maxBarDura + past, endTime + past
end



