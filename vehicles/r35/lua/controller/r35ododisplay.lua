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
local updateFPS = 30
local invFPS = 1 / updateFPS

local function updateGFX(dt)
  updateTimer = updateTimer + dt
  if updateTimer > invFPS then
    local data = {}
    local odo = electrics.values.r35odo or 0
	local trip = electrics.values.r35trip or 0
	data.odo = odo
	data.trip = trip
    htmlTexture.call(gaugesScreenName, "updateData", data)
    updateTimer = 0
  end
end

local function init(jbeamData)

  gaugesScreenName = jbeamData.materialName
  year = jbeamData.year
  if year == 2012 or year == 2017 then
	htmlPath = "local://local/vehicles/r35/odometer_2012.html"
  else
	htmlPath = "local://local/vehicles/r35/odometer.html"
  end
  local width = jbeamData.textureWidth or 512
  local height = jbeamData.textureHeight or 256

  if not gaugesScreenName then
    log("E", "r35ododisplay", "Got no material name for the texture, can't display anything...")
    M.updateGFX = nop
  else
    if htmlPath then
      htmlTexture.create(gaugesScreenName, htmlPath, width, height, updateFPS, "automatic")
    else
      log("E", "r35ododisplay", "Got no html path for the texture, can't display anything...")
      M.updateGFX = nop
    end
  end
end

M.init = init
M.updateGFX = updateGFX

return M
