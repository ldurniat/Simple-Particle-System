------------------------------------------------------------------------------------------------
-- The Game module.
--
-- @module  game
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Apr-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES                                           --                
-- ------------------------------------------------------------------------------------------ --
 
local composer   = require 'composer' 
local particles  = require 'scene.game.lib.particles' 
local objectpool = require 'pl.ldurniat.objectpool.objectpool' 

-- ------------------------------------------------------------------------------------------ --
--                                 MODULE DECLARATION                                         --                 
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
local particlePool

function scene:create( event )

   local createObject = function() 

      return particles.new() 

   end 

   local resetObject = function( object )

      object:reset()

   end

   particlePool = objectpool.init( createObject, 150, resetObject )

end

local function enterFrame( event )
  
   -- Get particle from pool
   local particleFromPool = particlePool:get()

   -- Check there is any particle
   if particleFromPool then

      fountain[#fountain + 1] = particleFromPool

   end   

   for i=#fountain, 1, -1 do

      local particle = fountain[i]
      particle:update()

      -- Is visible?
      if particle:finished() then

         -- Remove particle
         table.remove( fountain, i )
         -- Put back particle into pool
         particlePool:put( particle )
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
 
   for i=#fountain, 1, -1 do

      -- Remove particle
      local particle = table.remove( fountain, i )
      particle:removeSelf()
      particle = nil

   end

   fountain = nil 
   --Remove pool
   particlePool:removeSelf()
   particlePool = nil  

end
 
scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )
 
return scene