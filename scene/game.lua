------------------------------------------------------------------------------------------------
-- The Game module.
--
-- @module  game
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Mar-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES                                             --                
-- ------------------------------------------------------------------------------------------ --
 
local composer  = require 'composer' 
local particles = require 'scene.game.lib.particles' 

-- ------------------------------------------------------------------------------------------ --
--                                 MODULE DECLARATION                                       --                 
-- ------------------------------------------------------------------------------------------ --

local scene = composer.newScene()

-- ------------------------------------------------------------------------------------------ --
--                                 LOCALISED VARIABLES                                        --   
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PRIVATE METHODS                                            --   
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PUBLIC METHODS                                             --   
-- ------------------------------------------------------------------------------------------ --

local fountain = {} 

function scene:create( event )
 
   local sceneGroup = self.view

end

local function enterFrame( event )

   -- Create new particle
   fountain[#fountain + 1] = particles.new()

   for i=#fountain, 1, -1 do

      local particle = fountain[i]
      particle:update()

      -- Is visible?
      if particle:finished() then

         -- Remove particle
         table.remove( fountain, i )
         particle:remove()
         particle = nil

      end  

   end

end 
 
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if phase == 'will' then

      -- Add listener
      Runtime:addEventListener( 'enterFrame', enterFrame )

   elseif phase == 'did' then

   end

end
 
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if phase == 'will' then

   elseif phase == 'did' then

      -- Remove listener
      Runtime:removeEventListener( 'enterFrame', enterFrame )

   end
   
end

function scene:destroy( event )
 
end
 
scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )
 
return scene