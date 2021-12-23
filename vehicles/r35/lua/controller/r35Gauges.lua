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

local previousFuel = 0
local fuelSmoother = newTemporalSmoothing(50, 50)
local fuelDisplaySmoother = newTemporalSmoothing(5, 3)
local avgFuelSum = 0
local avgFuelCounter = 0
local updateTimer = 0
local updateFPS = 30
local invFPS = 1 / updateFPS

local function updateGFX(dt)
  updateTimer = updateTimer + dt
  if updateTimer > invFPS then
    local data = {}
    local wheelspeed = electrics.values.wheelspeed or 0
    data.speed = wheelspeed
	data.year = year

    htmlTexture.call(gaugesScreenName, "updateData", data)
    updateTimer = 0
  end
end

local function init(jbeamData)
  previousFuel = 0
  avgFuelSum = 0
  avgFuelCounter = 0
  fuelSmoother:reset()
  fuelDisplaySmoother:reset()

  gaugesScreenName = jbeamData.materialName
  year = jbeamData.year
  if year == 2012 or year == 2017 then
	htmlPath = "local://local/vehicles/r35/gauges_screen_2012.html"
  else
	htmlPath = "local://local/vehicles/r35/gauges_screen.html"
  end
  local unitType = jbeamData.unitType or "metric"
  local width = jbeamData.textureWidth or 512
  local height = jbeamData.textureHeight or 256

  if not gaugesScreenName then
    log("E", "etkGauges", "Got no material name for the texture, can't display anything...")
    M.updateGFX = nop
  else
    if htmlPath then
      htmlTexture.create(gaugesScreenName, htmlPath, width, height, updateFPS, "automatic")
      htmlTexture.call(gaugesScreenName, "setUnits", {unitType = unitType})
    else
      log("E", "r35Gauges", "Got no html path for the texture, can't display anything...")
      M.updateGFX = nop
    end
  end
end

M.init = init
M.updateGFX = updateGFX

return M
