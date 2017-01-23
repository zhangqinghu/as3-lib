package net.guodong.data
{        
	/**
	 * A simple typed Dictionary Class. It maps strings to objects of a given type. (To allow any type to be mapped, pass "Object" as the class type instead)
	 */
	public class CustomDictionary 
	{
		private var m_keys:Array; //Holds the string keys
		private var m_values:Array; //Holds the values that the keys map to (Avoiding associated arrays to allow more control)
		private var m_type:Class; //The class type to allow into this dictionary
		
		/**
		 * Instantiates a new Dictionary class. You are required to pass in a type, use "Object" if you want to allow all types.
		 * @param        type The class name to use as the type for this Dictionary
		 */
		public function CustomDictionary(type:Class) 
		{
			m_keys = new Array();
			m_values = new Array();
			if (type == null)
				m_type = Object;
			else
				m_type = type;
		}
		
		/**
		 * Retrieves the amount of keys in the dictionary
		 */
		public function get length():int
		{
			return m_keys.length;
		}
		
		/**
		 * Returns a copy of the keys array
		 */
		public function get Keys():Array
		{
			var arr:Array = new Array();
			for (var i:int = 0; i < m_keys.length; i++)
				arr.push(m_keys[i]);
			
			return arr;
		}
		
		/**
		 * Returns a new array containing soley the values within the dictionary
		 */
		public function get Values():Array
		{
			var arr:Array = new Array();
			for (var i:int = 0; i < m_values.length; i++)
				arr.push(m_values[i]);
			
			return arr;
		}
		
		/**
		 * Adds a new object to the Dictionary.
		 * @param        name The key to use for the object. If the key already exists, a warning message will be traced since you should use setKey() instead
		 * @param        obj The object ot map this key to
		 * @return True if success, false if there is an error
		 */
		public function push(name:String, obj:*):Boolean
		{
			if (!(obj is Object))
			{
				trace("Error, attempt to add an Object that does not match the defined type: " + m_type);
				return false;
			}
			
			if (!containsKey(name))
			{
				m_keys.push(name);
				m_values.push(obj);
			} else
			{
				trace("Warning, attempted to provide a duplicate key \"" + name +  "\". This key's value has been replaced by the new Object.");
				m_values[m_keys.indexOf(name)] = obj;
			}
			
			return true;
		}
		
		
		/**
		 * Pops the last object from the end of the dictionary
		 * @return The object removed from the dictionary
		 */
		public function pop():*
		{
			if (m_keys.length > 0)
				return remove(m_keys[m_keys.length - 1]);
			return null;
		}
		
		/**
		 * Removes an object from the array
		 * @param        name The key of the object to remove
		 * @return The object that was just removed
		 */
		public function remove(name:String):*
		{
			var index:int = m_keys.indexOf(name);
			if (index < 0)
			{
				trace("Error removing key: " + name);
				return null;
			}
			
			var obj:* = m_values[index];
			m_values[index] = null;
			m_values.splice(index, 1);
			m_keys.splice(index, 1);
			
			return obj;
		}
		
		
		/**
		 * Returns a key specified by a given value
		 * @param        value The value to search for in the dictionary
		 * @return The key that 
		 */
		public function getValue(value:*):String
		{
			if (value == null)
				return null;
			var index:int = m_values.indexOf(value);
			if (index < 0)
				return null;
			
			return m_keys[index];
		}
		
		/**
		 * Returns a value specified by a given key
		 * @param        key The key to search for
		 * @return The value associated with the given key
		 */
		public function getKey(key:String):*
		{
			for (var i:int = 0; i < m_keys.length; i++)
				if (m_keys[i] == key)
					return m_values[i];
			
			return null;
		}
		
		/**
		 * Rename a key
		 * @param        key The key to be renamed
		 * @param        newKey The new name for the key
		 * @return True if the rename is successful
		 */
		public function renameKey(key:String, newKey:String):Boolean
		{
			if (getKey(newKey))
			{
				trace("Error, key already exists: " + newKey);
				return false;
			} else if (!getKey(key))
			{
				trace("Error, key does not exist: " + key);
				return false;
			}
			m_keys[m_keys.indexOf(key)] = newKey;
			return true;
		}
		
		/**
		 * Sets a key to a value, or adds it if it doesn't exist
		 * @param        key They key whose mapping will be changed
		 * @param        obj The object to map to the given key
		 */
		public function setKey(key:String, obj:*):void
		{
			if (containsKey(key))
			{
				var index:int = m_keys.indexOf(key);
				if (!(obj is m_type))
				{
					trace("Error, attempt to add an Object that does not match the defined type: " + m_type);
					return;
				}
				m_values[index] = null;
				m_values[index] = obj;
			} else
			{
				push(key, obj);
			}
		}
		
		/**
		 * Returns whether or not the array contains a given key
		 * @param        name The name of the key to check for
		 * @return True of the dictionary contains this key, false otherwise
		 */
		public function containsKey(name:String):Boolean
		{
			return (getKey(name) != null);
		}
		
		/**
		 * Returns true if the array contains a given value
		 * @param        value The value to search for
		 * @return True if he value exists in this dictionary, false otherwise
		 */
		public function containsValue(value:*):Boolean
		{
			return (getValue(value) != null);
		}
		
		/**
		 * Removes all values and keys from the dictionary
		 */
		public function clear():void
		{
			while (m_keys.length > 0)
				m_keys.splice(0, 1);
			while (m_values.length > 0)
				m_values.splice(0, 1);
		}
	}
}