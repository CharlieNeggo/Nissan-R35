-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt
local M = {}

local gear_A = 0
local gearIndex = 0

local function onInit()
  electrics.values['disp_R'] = 0
  electrics.values['disp_N'] = 0
  electrics.values['disp_1'] = 0
  electrics.values['disp_2'] = 0
  electrics.values['disp_3'] = 0
  electrics.values['disp_4'] = 0
  electrics.values['disp_5'] = 0
  electrics.values['disp_6'] = 0
  electrics.values['disp_Pa'] = 0
  electrics.values['disp_Ra'] = 0
  electrics.values['disp_Na'] = 0
  electrics.values['disp_Da'] = 0
  electrics.values['disp_P_cvt'] = 0
  electrics.values['disp_R_cvt'] = 0
  electrics.values['disp_N_cvt'] = 0
  electrics.values['disp_D_cvt'] = 0
  electrics.values['disp_L_cvt'] = 0
end

local function reset()
  onInit()
end

local function updateGFX(dt)
  gearIndex = electrics.values.gearIndex or 0
  gear_A = electrics.values['gear_A'] or 0
--Rev
  if gearIndex < -0.5 then
    electrics.values['disp_R'] = 1
  else
    electrics.values['disp_R'] = 0
  end
--Neutral
  if gearIndex >= -0.5 and gearIndex < 0.5 then
    electrics.values['disp_N'] = 1
  else
    electrics.values['disp_N'] = 0
  end
--First
  if gearIndex >= 0.5 and gearIndex < 1.5 then
    electrics.values['disp_1'] = 1
  else
    electrics.values['disp_1'] = 0
  end
--Second
  if gearIndex >= 1.5 and gearIndex < 2.5 then
    electrics.values['disp_2'] = 1
  else
    electrics.values['disp_2'] = 0
  end
--Third
  if gearIndex >= 2.5 and gearIndex < 3.5 then
    electrics.values['disp_3'] = 1
  else
    electrics.values['disp_3'] = 0
  end
--Fourth
  if gearIndex >= 3.5 and gearIndex < 4.5 then
    electrics.values['disp_4'] = 1
  else
    electrics.values['disp_4'] = 0
  end
--Fifth
  if gearIndex >= 4.5 and gearIndex < 5.5 then
    electrics.values['disp_5'] = 1
  else
    electrics.values['disp_5'] = 0
  end
--Sixth
  if gearIndex > 5.5 then
    electrics.values['disp_6'] = 1
  else
    electrics.values['disp_6'] = 0
  end
--Park Auto
  if gear_A < 0.1 then
    electrics.values['disp_Pa'] = 1
  else
    electrics.values['disp_Pa'] = 0
  end
--Reverse Auto
  if gear_A >= 0.1 and gear_A < 0.2 then
    electrics.values['disp_Ra'] = 1
  else
    electrics.values['disp_Ra'] = 0
  end
--Neutral Auto
  if gear_A >= 0.2 and gear_A < 0.3 then
    electrics.values['disp_Na'] = 1
  else
    electrics.values['disp_Na'] = 0
  end
--Drive Auto
  if gear_A >= 0.3 and gear_A < 0.4 then
    electrics.values['disp_Da'] = 1
    --if in D ignore the gearIndex digits
    electrics.values['disp_1'] = 0
    electrics.values['disp_2'] = 0
    electrics.values['disp_3'] = 0
    electrics.values['disp_4'] = 0
    electrics.values['disp_5'] = 0
    electrics.values['disp_6'] = 0
  else
    electrics.values['disp_Da'] = 0
  end
--Park CVT
  if gear_A < 0.15 then
    electrics.values['disp_P_cvt'] = 1
  else
    electrics.values['disp_P_cvt'] = 0
  end
--Reverse CVT
  if gear_A >= 0.15 and gear_A < 0.35 then
    electrics.values['disp_R_cvt'] = 1
  else
    electrics.values['disp_R_cvt'] = 0
  end
--Neutral CVT
  if gear_A >= 0.35 and gear_A < 0.65 then
    electrics.values['disp_N_cvt'] = 1
  else
    electrics.values['disp_N_cvt'] = 0
  end
--Drive CVT
  if gear_A >= 0.65 and gear_A < 0.85 then
    electrics.values['disp_D_cvt'] = 1
  else
    electrics.values['disp_D_cvt'] = 0
  end
 --Low CVT
  if gear_A >= 0.85 then
    electrics.values['disp_L_cvt'] = 1
  else
    electrics.values['disp_L_cvt'] = 0
  end
end

-- public interface
M.onInit      = onInit
M.reset     = reset
M.updateGFX = updateGFX

return M