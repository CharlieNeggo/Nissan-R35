-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

local M = {}
M.type = "auxiliary"
M.relevantDevice = nil

local htmlTexture = require("htmlTexture")

local min = math.min
local max = math.max

local gaugesScreenName = nil
local htmlPath = nil
local updateTimer = 0
local updateFPS = 60
local invFPS = 1 / updateFPS

local function init(jbeamData)
  gaugesScreenName = "@r35_screen"
  htmlPath = "local://local/vehicles/r35/gauges_screen/gauges_screen.html"
  local unitType = jbeamData.unitType or "metric"
  local width = 512
  local height = 375

  if not gaugesScreenName then
    log("E", "r35TurboGauges", "Got no material name for the texture, can't display anything...")
    M.updateGFX = nop
  else
    if htmlPath then
      htmlTexture.create(gaugesScreenName, htmlPath, width, height, updateFPS, "automatic")
      htmlTexture.call(gaugesScreenName, "setUnits", {unitType = unitType})
    else
      log("E", "r35TurboGauges", "Got no html path for the texture, can't display anything...")
      M.updateGFX = nop
    end
  end
end

M.init = init
M.updateGFX = updateGFX

return M
