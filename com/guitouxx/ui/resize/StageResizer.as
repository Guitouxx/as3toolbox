/**
 * As3Toolbox com.guitouxx.ui.resize
 * StageResizer 1.2
 * Last update : 09/09/10
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
package com.guitouxx.ui.resize
{
	//Imports
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	* Utility class to manage display objects positions and dimensions during a stage resizing
	*/
	public class StageResizer
	{
		//-------------------------------------------------------------------------------------
		// Constants
		//-------------------------------------------------------------------------------------
	
		private static const STATIC_MEMBER : String = "staticMember";
		private static const DYNAMIC_MEMBER : String = "dynamicMember";
		public static const PERCENT : String = "percent";
		public static const PIXEL : String = "pixel";
	
		//-------------------------------------------------------------------------------------
		// Vars
		//-------------------------------------------------------------------------------------
		
		private static var _members : Array = [];
		private static var _widthMin : Number = 500;
		private static var _heightMin : Number = 500;
		private static var _useMinimumSize : Boolean = false;
		private static var _updateOnAdding : Boolean = false;
		private static var _roundPositions : Boolean = false;
		private static var _stage : Stage;
		
		//-------------------------------------------------------------------------------------
		// Getter / Setter
		//-------------------------------------------------------------------------------------
		
		/**
		 * Define the Stage instance
		 * @param	inst	Stage instance	
		*/
		public static function set stage(inst : Stage) : void
		{
			_stage = inst;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		/**
		 * Return stage instance
		 * @return	Stage instance
		*/
		public static function get stage() : Stage { return _stage; }
		
		/**
		 * Determine if we use the minimum stage size
		 * @param	bool	Boolean instance
		*/
		public static function set useMinimumSize(bool : Boolean) : void {_useMinimumSize = bool;}
		
		/**
		 * Determine if we do operations on registered sprite before a resize event listener
		 * @param	bool	Boolean instance
		*/
		public static function set updateOnAdding(bool : Boolean) : void {_updateOnAdding = bool;}
		
		/**
		 * Define if we use round position during the position
		 * @param	bool	Boolean instance
		*/
		public static function set roundPositions(bool : Boolean) : void {_roundPositions = bool;}
		
		//-------------------------------------------------------------------------------------
		// Public Methods
		//-------------------------------------------------------------------------------------
	
		/**
		 * Add a new member to the StageResizer
		 * @param	target	DisplayObject instance
		 * @param	xpos	Percentage X position on the stage [-1 -> no changes]
		 * @param	ypos	Percentage Y position on the stage [-1 -> no changes]
		 * @param	width	Percentage width of the stage [0 -> no changes]
		 * @param	height	Percentage height of the stage [0 -> no changes]
		 * @param	xmargin	Percentage right margin [0 -> no margin, 100 -> margin = sprite.width] in PERCENT_MARGIN mode or pixel margin value in PIXEL_MARGIN mode
		 * @param	ymargin	Percentage bottom margin [0 -> no margin, 100 -> margin = sprite.height] in PERCENT_MARGIN mode or pixel margin value in PIXEL_MARGIN mode
		 * @param	mode	Margins value are pixels (StageResizer.PIXEL) or based on sprite dimensions percentage (StageResizer.PERCENT)
		*/
		public static function addMember(target : DisplayObject, xpos : Number, ypos : Number, width : Number = 0, height : Number = 0, xmargin : Number = 100, ymargin : Number = 100, mode : String = PERCENT) : void
		{
			if(xpos > 0) xpos *= .01;
			if(ypos > 0) ypos *= .01;
			
			if(mode == PERCENT)
			{
				if(xmargin != 0) xmargin = target.width * (xmargin * .01);
				if(ymargin != 0) ymargin = target.height * (ymargin * .01);
			}
			
			//object creation
			var item : Object = {dp:target, type:STATIC_MEMBER, xPos:xpos, yPos:ypos, xMargin:xmargin, yMargin:ymargin, width: width, height:height, mode:mode};
			_members.push(item);
				
			if(_updateOnAdding) _update(item);
		}
		
		/**
		 * Add a dynamic member : positions or dimensions based on other displayobject properties
		 * @param	target	DisplayObject instance
		 * @param	resizeObjects	Array of ResizeObject instance
		 * @see	ResizeObject
		 */
		public static function addDynamicMember(target : DisplayObject, resizeObjects : Array = null) : void
		{
			//object creation
			var item : Object = {dp:target, type:DYNAMIC_MEMBER, resizeObjects:resizeObjects};
			_members.push(item);
			
			//check if reference are placed before the dynamic member
			var obj : ResizeObject;
			for each(obj in item.resizeObjects)
			{
				if(_getMemberPosition(target.name) < _getMemberPosition(obj.reference.name) || _getMemberPosition(obj.reference.name) == -1)
				{
					throw new Error("For a better efficacity, you have to add reference members before dynamic members");
				}
			}
			
			if(_updateOnAdding) _update(item);
		}
		
		/**
		 * Remove a member from the StageResizer
		 * @param	target	DisplayObject instance or Member Name
		*/
		public static function removeMember(target : *) : void
		{
			var item : Object;
			var pos : int = _getMemberPosition((target is String) ? target : target.name);
			if(pos == -1) throw new Error("This member is not registered with StageResizer");

			//Check if we have more than one entry for a specific displayobject
			while(pos != -1)
			{
				pos = _getMemberPosition((target is String) ? target : target.name);
				if(pos >=0) _members.splice(pos, 1);
			}
		}
		
		/**
		 * Remove all members from the StageResizer
		*/
		public static function removeAll() : void
		{
			var item : Object;
			for each(item in _members) removeMember(item.dp.name);
			
			_members = [];
		}
		
		/**
		 * Define the minimum size
		 * @param	w	Minimum width size
		 * @param	h	Minimum height size
		*/
		public static function defineMinimumSize(w : Number, h : Number) : void
		{
			_widthMin = w;
			_heightMin = h;
		}
		
		/**
		 * Enable or disable the resize
		 * @param	bool	Boolean instance
		*/
		public static function enable(bool : Boolean) : void
		{
			if(bool)
			{
				_stage.addEventListener(Event.RESIZE, __resizeListener);
			}
			else
			{
				_stage.removeEventListener(Event.RESIZE, __resizeListener);
			}
		}
		
		/**
		 * Refresh all members positions
		*/
		public static function refresh() : void
		{
			var item : Object;
			for each(item in _members) _update(item);
		}
		
		//-------------------------------------------------------------------------------------
		// Private Methods
		//-------------------------------------------------------------------------------------
		
		/**
		 * Return member position in the array
		 * @param	name	Member name
		 * @return	int instance
		 */
		private static function _getMemberPosition(name : String) : int
		{
			var i:int;
			var n:int = _members.length - 1;
			
			for(i=0;i<=n;i++)
			{
				if(_members[i].dp.name == name) return i;
			}
			
			return -1;
		}
		
		/**
		 * Update member position
		 * @param	member	Object instance
		*/
		private static function _update(member : Object) : void
		{
			var target : DisplayObject = member.dp;
			var finalWidth : Number = stage.stageWidth;
			var finalHeight : Number = stage.stageHeight;
			
			//Check if we have define minimum resize dimensions
			if (_useMinimumSize)
			{
				if(_stage.stageWidth < _widthMin) finalWidth = _widthMin;
				if (_stage.stageHeight < _heightMin) finalHeight = _heightMin;
			}

			if(member.type == STATIC_MEMBER)
			{
				if(member.xPos >= 0) target.x = (finalWidth * member.xPos) - member.xMargin;
				if(member.yPos >= 0) target.y = (finalHeight * member.yPos) - member.yMargin;
				if(member.width != 0) target.width = finalWidth * (member.width * .01);
				if(member.height != 0) target.height = finalHeight * (member.height * .01);
			}
			else
			{
				var object : ResizeObject;
				var newValue : Number;
				
				for each(object in member.resizeObjects)
				{
					newValue = object.reference[object.property] + object.resizeValue;
					
					if(object.mode == StageResizer.PERCENT)
					{
						newValue = (object.resizeValue*.01) * object.reference[object.property];
					}
					
					target[object.property] = newValue;
				}
			}
			
			if(_roundPositions)
			{
				target.x = int(target.x + .5);
				target.y = int(target.y +.5);
			}
		}
		
		//-------------------------------------------------------------------------------------
		// Event Callbacks
		//-------------------------------------------------------------------------------------
		
		/**
		 * Event call when the stage is resized
		 * @param	event	Event.RESIZE
		*/
		private static function __resizeListener(event : Event) : void
		{
			refresh();
		}
	}
} 