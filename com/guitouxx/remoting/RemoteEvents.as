/**
 * As3Toolbox com.guitouxx.remoting
 * RemoteEvents 1.0
 * Last update : 21/12/08
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
package com.guitouxx.remoting
{
	// Imports
	import flash.events.Event;
	
	/**
	* Represent events during a remote connection
	* @see flash.events.Event
	*/
	public class RemoteEvents extends Event
	{
		//-------------------------------------------------------------------------------------
		// Constants
		//-------------------------------------------------------------------------------------

		public static const COMPLETE : String = "onComplete";
		public static const ERROR : String = "onFault";
		
		//-------------------------------------------------------------------------------------
		// Vars
		//-------------------------------------------------------------------------------------

		public var rows : Object;
		public var error : String;
		
		//-------------------------------------------------------------------------------------
		// Public Methods
		//-------------------------------------------------------------------------------------
		
		/**
		* Constructor : Create a Remote Event (more attributes than the standard Event)
		* @param	type	String type of the event
		* @param	bubbles	Bubbles functionnality
		* @param	cancelable	Delete functionnality
		*/
		public function RemoteEvents(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		* Clone event (override)
		* @return 	Custom RemoteEvents
		*/ 
		public override function clone() : Event
		{
			var event : RemoteEvents =  new RemoteEvents(type, bubbles, cancelable);
			event.rows = rows;
			event.error = error;
			
			return event;
		}
	}
}