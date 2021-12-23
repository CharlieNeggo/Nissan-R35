-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

local M = {}
--Mandatory controller parameters
M.type = "auxiliary"
M.relevantDevice = "transfercase"

local max = math.max
local transfercase = nil
local initialSplitA = nil
local initialSplitB = nil
local smoothedTCS = nil
local esc = controller.getController("esc") or false

local tcsSmoother = newExponentialSmoothing(100)

local function updateGFX(dt)
  local escConfig = esc.getCurrentConfigData()
  if escConfig.name ~= "Off" then
	transfercase.diffTorqueSplitA = 1 - (electrics.values.tcs * 0.5)
	transfercase.diffTorqueSplitB = electrics.values.tcs * 0.5
	electrics.values.notesc = 0
  else
	transfercase.diffTorqueSplitA = 1
	transfercase.diffTorqueSplitB = 0
	electrics.values.notesc = 1
  end
  if escConfig.name == "R Mode" then
	electrics.values.rmodeesc = 1
  else
	electrics.values.rmodeesc = 0
  end
  if escConfig.name == "Comfort Mode" then
	electrics.values.comfortmodeesc = 1
  else
	electrics.values.comfortmodeesc = 0
  end
end

local function init(jbeamData)
  if not esc then
    M.updateGFX = nop
  else
    transfercase = powertrain.getDevice("transfercase")
	
    if transfercase then
      initialSplitA = transfercase.diffTorqueSplitA
      initialSplitB = transfercase.diffTorqueSplitB
	  initialGearRatio = transfercase.gearRatio
    else
      M.updateGFX = nop
    end
	
  end
end

M.init = init
M.round = round
M.updateGFX = updateGFX

return M