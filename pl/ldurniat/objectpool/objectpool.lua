------------------------------------------------------------------------------------------------
-- The Object Pool module.
-- 
-- Simple module for Corona for reusing objects instead of creating new ones.
--
-- @module  objectpool
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Apr-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES                                           --                
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 MODULE DECLARATION	                                      --						
-- ------------------------------------------------------------------------------------------ --

local M = {}

-- ------------------------------------------------------------------------------------------ --
--                                 LOCALISED VARIABLES                                        --   
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PRIVATE METHODS                                            --   
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PUBLIC METHODS                                             --   
-- ------------------------------------------------------------------------------------------ --

------------------------------------------------------------------------------------------------
--- Constructor function of objectpool module.
-- 
-- @param createObject Name of function where a single instance of your object is created.
-- @param count The number of objects to create in this pool.
-- @param resetObject (Optional) name of function that handles resetting returned objects.
--
-- @return The new pool instance.
-- @usage local newPool = objectpool.init( createObject, 100, resetObject )
------------------------------------------------------------------------------------------------
function M.init( createObject, count, resetObject )

	local instance = {}
	instance.pool = {}

	for i=1, count do

		instance.pool[#instance.pool + 1] = createObject()

	end

	--- Gets a single unused object from the pool.
	--
	-- @return A single instance of an unused object from the pool, or nil if no unused objects exists.
	function instance:get()

		local index = #self.pool

		if index > 0 then 

			-- Get last available object from pool
			local object = self.pool[index]
			self.pool[index] = nil

			-- "Add" object on the screen
			object.alpha = 1

			-- Set default values for object 
			if resetObject then
			
				resetObject( object )

			end		

			return object 

		end

		-- The pool is empty
		return nil

	end

	--- Put back object into pool.object
	--
	-- @param object The object placed back into pool.object
	function instance:put( object )

		-- "Remove" from the screen
		object.alpha = 0
		-- Cancel all transition on this object
		transition.cancel( object )
		-- Put back object into pool 
		self.pool[#self.pool + 1] = object

	end	

	--- Remove pool. 
	function instance:removeSelf()

		for i=#self.pool, 1 do

			local object = table.remove( self.pool, i )
			object:removeSelf()
			object = nil

		end

		self.pool = nil	

	end	

	return instance

end

return M