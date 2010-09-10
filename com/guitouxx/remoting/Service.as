/**
 * As3Toolbox com.guitouxx.remoting
 * Service 1.0
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
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import com.guitouxx.remoting.RemoteConnector;

	/**
	* Create a custom Service to connect more easily to a remote php class
	* <br/>This class can call and intercept undefined methods
	* @see RemoteConnector
	*/
	public dynamic class Service extends Proxy implements IEventDispatcher
	{
		//-------------------------------------------------------------------------------------
		// Vars
		//-------------------------------------------------------------------------------------
		
		public static 	var  	GATEWAY				: String;
		public static 	var  	PHP_CLASS			: String;
		
		private 		var 	_dispatcher 		: EventDispatcher	= new EventDispatcher();
		private 		var 	_remoteConnector 	: RemoteConnector;
		
		//-------------------------------------------------------------------------------------
		// Public Methods
		//-------------------------------------------------------------------------------------
		
		/**
		* Constructor
		*/
		public function Service() : void {}
		
		/**
		* Intercept any call if the instance has the specified property
		* @param	name	Name of the property
		* @return	Boolean flag
		*/
		override flash_proxy function hasProperty(name : *) : Boolean
		{
			return false;
		}
		
		/**
		* Intercept any call to return the specified property
		* @param	name	Name of the property
		* @return	Return the property
		*/
		override flash_proxy function getProperty(name:*):*
		{
			return undefined;
		}
		
		/**
		* Intercept all method or properties calling
		* @param	method	The method or property to call
		* @param	...params	Arguments
		* @return	The RemoteConnector created
		*/
		override flash_proxy function callProperty(method : *, ...params : *) : *
		{
			_remoteConnector = new RemoteConnector();
			_remoteConnector.define(GATEWAY, PHP_CLASS);
			_remoteConnector.request(method, params);
			
			return _remoteConnector;
		}
		
		/**
		* Add an event listener to a specific DisplayObject
		* @param 	type	String type of the event
		* @param 	listener	Function callback
		* @param 	useCapture	Flag to use capture or not
		* @param 	priority	Number of priority of this event
		* @param	useWeakReference	Use Weak Reference
		*/
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false ) : void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		* Dispatch a recorded event
		* @param 	event	Event instance
		* @return	Boolean instance
		*/
		public function dispatchEvent( event : Event ) : Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}
		
		/**
		* Check if the event is already recorded 
		* @param 	type	The event Type
		* @return	Boolean instance
		*/
		public function hasEventListener(type : String) : Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		
		/**
		* Remove a recorded event
		* @param 	type	Event Type
		* @param	listener	Funtion callback
		* @param	useCapture	Flag to use capture or not
		*/
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		* Search in all dispatcher object if an event is recorded
		* @param 	type	Event Type
		* @return	Boolean instance	
		*/
		public function willTrigger(type : String) : Boolean
		{
			return _dispatcher.willTrigger(type);
		}
	}
}