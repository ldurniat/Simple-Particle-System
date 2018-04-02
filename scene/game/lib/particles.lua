------------------------------------------------------------------------------------------------
-- The Particles module.
--
-- @module  particles
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Mar-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 MODULE DECLARATION	                                      --						
-- ------------------------------------------------------------------------------------------ --

local M = {}

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES	                                          --						
-- ------------------------------------------------------------------------------------------ --

local composer = require 'composer' 

-- ------------------------------------------------------------------------------------------ --
--                                 LOCALISED VARIABLES                                        --	
-- ------------------------------------------------------------------------------------------ --

local mRandom = math.random

local _CX = display.contentCenterX
local _B  = display.viewableContentHeight - display.screenOriginY

-- ------------------------------------------------------------------------------------------ --
--                                 PRIVATE METHODS                                            --	
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PUBLIC METHODS                                             --	
-- ------------------------------------------------------------------------------------------ --

------------------------------------------------------------------------------------------------
-- Constructor function of Particle module.
--
-- @return The ship instance.
------------------------------------------------------------------------------------------------
function M.new()

	-- Get the current scene
	local scene = composer.getScene( composer.getSceneName( 'current' ) )
	local parent = scene.view	

	local instance = display.newCircle( parent, _CX, _B - 20, 16 )

	-- Add basic properties
	instance.vx = mRandom( -1, 1 ) + mRandom()
	instance.vy = mRandom( -4, -2 ) + mRandom()  
 
	function instance:update()

		self.x = self.x + self.vx
		self.y = self.y + self.vy
		self.alpha = self.alpha - 0.005
		self:scale( 0.995, 0.995 )

	end

	function instance:finished()

		return self.alpha <= 0 

	end

	function instance:destroy()

		display.remove( self )
		self = nil

	end			

	return instance
	
end	

return M