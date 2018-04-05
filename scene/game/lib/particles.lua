------------------------------------------------------------------------------------------------
-- The Particles module.
--
-- @module  particles
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Apr-2018
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
-- @return The particle instance.
------------------------------------------------------------------------------------------------
function M.new()

	-- Get the current scene
	local scene = composer.getScene( composer.getSceneName( 'current' ) )
	local parent = scene.view	

	-- Create new instance
	local instance = display.newCircle( parent, 0, 0, 16 )
 
 	-- Set default values
	function instance:reset() 

		-- Set position
		self.x = _CX
		self.y = _B - 20
		-- Set scale
		self.xScale = 1
		self.yScale = 1
		-- Set velocity
		self.vx = mRandom( -1, 1 ) + mRandom()
		self.vy = mRandom( -4, -2 ) + mRandom() 

	end	

	-- Update position, scale and transparency
	function instance:update()

		self:translate( self.vx, self.vy )
		self.alpha = self.alpha - 0.005
		self:scale( 0.995, 0.995 )

	end

	-- Return true if instance is not visible otherwise return false
	function instance:finished()

		return self.alpha <= 0 

	end

	instance:reset()		

	return instance
	
end	

return M