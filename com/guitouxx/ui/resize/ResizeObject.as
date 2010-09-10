/**
 * As3Toolbox com.guitouxx.ui.resize
 * ResizeObject 1.0
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
	//Import
	import flash.display.DisplayObject;
	
	/**
	 * Define a Resize Object for dynamic members
	 * @see StageResizer
	 */
	public class ResizeObject
	{
		//-------------------------------------------------------------------------------------
		// Constants
		//-------------------------------------------------------------------------------------
		
		public static const X : String = "x";
		public static const Y : String = "y";
		public static const WIDTH : String = "width";
		public static const HEIGHT : String = "height";
		
		//-------------------------------------------------------------------------------------
		// Vars
		//-------------------------------------------------------------------------------------
		
		public var reference : DisplayObject;
		public var property : String;
		public var resizeValue : Number;
		public var mode : String;
		
		//-------------------------------------------------------------------------------------
		// Public Methods
		//-------------------------------------------------------------------------------------
		
		/**
		 * Create A Resize Object
		 * @param	ref		DisplayObject reference
		 * @param	prop	Type of Property. Possible values : ResizeObject.X, ResizeObject.Y, ResizeObject.WIDTH, ResizeObject.HEIGHT
		 * @param	value	Value based on reference displayobject
		 * @param	resizeMode	Define value in pixel (StageReiszer.PIXEL) or based on reference percentage (StageResizer.PERCENT)
		 */
		public function ResizeObject(ref : DisplayObject, prop : String = X, value : Number = 0, resizeMode : String = StageResizer.PIXEL) : void
		{
			reference = ref;
			property = prop;
			resizeValue = value;
			mode = resizeMode;
		}
	}
}