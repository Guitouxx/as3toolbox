/**
 * As3Toolbox com.guitouxx.ui
 * ContextMenuManager 1.0
 * Last update : 20/01/09
 * 
 * 
 * Copyright (c) 2008 Guillaume Tomasi
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included i
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 */ 

/**
 * @author Guillaume Tomasi <http://www.guitouxx.com>
 */
package com.guitouxx.ui
{
	//Imports
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.events.ContextMenuEvent;
	import flash.display.InteractiveObject;
		
	/**
	* Utility class to create a custom context menus. 
	* <br/>Add, Remove, Enable or Disable each menu items
	*/
	public class ContextMenuManager
	{
		//-------------------------------------------------------------------------------------
		// Vars
		//-------------------------------------------------------------------------------------
		
		private var _container : *;
		private var _contextMenu : ContextMenu;
		private var _callbacks : Object = {};
		
		//-------------------------------------------------------------------------------------
		// Getter / Setter 
		//-------------------------------------------------------------------------------------
	
		public function get items():Array { return _contextMenu.customItems; }
		
		//-------------------------------------------------------------------------------------
		// Public Methods 
		//-------------------------------------------------------------------------------------
		
		/**
		 * Create a new instance
		 * @param	container	ContextMenuItem container
		*/
		public function ContextMenuManager(container : *) : void
		{
			if(!container) throw new Error("You have to defined a displayobject to attach your custom menus");
			
			_contextMenu = new ContextMenu();
			_contextMenu.hideBuiltInItems();
			
			_container = container;
			_container.contextMenu = _contextMenu;
		}	
		
		/**
		 * Add an item to the context menu
		 * @param	caption	Item name
		 * @param	callBack Callback function
		 * @param	argument Arguments array
		 * @param	separator Add a separator line
		 * @param	enabled	Enable/Disable the item
		 * @param	visible	Display/Hide the item
		*/
		public function addMenuItem(caption : String, callback : Function = null, params : Array = null, separator : Boolean = false, enabled : Boolean = true, visible : Boolean = true) : void
		{
			var item : ContextMenuItem = new ContextMenuItem(caption, separator, enabled, visible);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, __selected);
			
			_contextMenu.customItems.push(item);
			_callbacks[caption] = {func:callback, args:params};
		}
		
		/**
		 * Remove an item to the context menu
		 * @param	caption	Item name
		*/
		public function removeMenuItem(caption : String) : void
		{
			var position : int = _getItemPosition(caption);	
			if (position == -1) throw new Error("This item doesn't exist");
			
			var menuItem : ContextMenuItem = items[position] as ContextMenuItem;
			menuItem.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, __selected);
			
			items.splice(position, 1);
			
			if(_callbacks[caption]) _callbacks[caption] = null;	
		}
		
		/**
		 * Remove All Items
		 * @param	enable Enable/Disable all items
		 */
		public function removeAll() : void
		{
			var menuItem : ContextMenuItem;
			for each(menuItem in items) removeMenuItem(menuItem.caption);
			
			_contextMenu.customItems = [];
			_callbacks = {};
		}
		
		/**
		 * Enable/Disable a context menu item
		 * @param	caption	Item name
		 * @param	enabled	Enable/Disable the item
		 * @param	visible	Display/Hide the item
		*/
		public function enableItem(caption : String, enable : Boolean, visible : Boolean = true) : void
		{
			var position : int = _getItemPosition(caption);
			if (position == -1) throw new Error("This item doesn't exist");
			
			var menuItem : ContextMenuItem = items[position] as ContextMenuItem;
			menuItem.enabled = enable;
			menuItem.visible = visible;
		}
		
		/**
		 * Enable / Disable all values
		 * @param	enable Enable/Disable all items
		 */
		public function enableAll(enable : Boolean) : void
		{
			var menuItem : ContextMenuItem;
			for each(menuItem in items) menuItem.enabled = enable;
		}
		
		//-------------------------------------------------------------------------------------
		// Private Methods
		//-------------------------------------------------------------------------------------
		
		/**
		 * Return the item position
		 * @param	caption	Item name
		 * @param	array	MenuItems Array
		 * @return	int instance
		*/
		private function _getItemPosition(caption : String) : int
		{
			var i : int;
			var n : int = items.length - 1;

			for (i=0; i<=n; i++)
			{
				if(items[i].caption == caption) return i;
			}
			
			return -1;
		}
		
		//-------------------------------------------------------------------------------------
		// Event Callbacks
		//-------------------------------------------------------------------------------------
		
		/**
		 * Event call when a menu item is selected
		 * @param	event	Regular ContextMenuEvent instance
		*/
		private function __selected(event : ContextMenuEvent) : void
		{
			var item : Object = _callbacks[event.target.caption];
			if(item) item.func.apply(_container, item.args);
		}
	}
}