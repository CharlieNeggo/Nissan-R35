-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

local M = {}

local odo = 0.0
local trip = 0.0


local function readodo()
	local path = "vehicles/r35/odometer/odometer.csv"
	local path2 = "vehicles/r35/odometer/trip.csv"
	-- create new if not existent
	local check_file = io.open(path, "r" )
	if check_file == nil then
		file_ = io.open(path, "w")
		io.close(file_)
	end
	
	-- get data
	file = io.open(path, "r")
	io.input(file)
	value = io.read()
	if value == nil then
		odo = 0
	else
		odo = value
	end
	io.close(file)
	
	-- create new if not existent
	local check_file2 = io.open(path2, "r" )
	if check_file2 == nil then
		file2_ = io.open(path2, "w")
		io.close(file2_)
	end
	
	-- get data
	file2 = io.open(path2, "r")
	io.input(file2)
	value2 = io.read()
	if value2 == nil then
		trip = 0
	else
		trip = value2
	end
	io.close(file2)
end


local function writeodo(value,value2)
	file = io.open("vehicles/r35/odometer/odometer.csv", "w")
	io.output(file)
	io.write(value)
	io.close(file)
	file2 = io.open("vehicles/r35/odometer/trip.csv", "w")
	io.output(file2)
	io.write(value2)
	io.close(file2)
end

local function onInit()
	readodo()
end

local function tripReset()
	trip = 0.0
	electrics.values.trip = 0.0
	gui.message("Trip computer reset!", 5, "vehicle.r35odotrip")
end

local function reset()
	onInit()
end


local function updateGFX(dt)
	odo = odo + electrics.values.wheelspeed * dt
	trip = trip + electrics.values.wheelspeed * dt
	if trip>odo then 
		trip = odo 
	end
	electrics.values.r35odo = 0.0036*odo -- conversion to km
	electrics.values.r35trip = 0.0036*trip
	if dt % 1 == 0 then -- update every second
		writeodo(odo,trip)
	end
end

-- public interface
M.onInit    = onInit
M.reset     = reset
M.updateGFX = updateGFX
M.tripReset = tripReset

return M