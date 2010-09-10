/**
 * As3Toolbox com.guitouxx.remoting 
 * RemoteConnector 1.0
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
	import flash.events.NetStatusEvent;
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import com.guitouxx.remoting.RemoteEvents;
	
	/**
	* Manage exchange between Flash and online server 
	* @see RemoteEvents
	*/
	public class RemoteConnector extends EventDispatcher
	{
		//-------------------------------------------------------------------------------------
		// Vars
		//-------------------------------------------------------------------------------------
		
		private	var _url : String;
		private	var _gate : NetConnection;
		private	var _class : String;
		private	var _callback : Function;
		private	var _responder : Responder;
		
		//-------------------------------------------------------------------------------------
		// Public Methods
		//-------------------------------------------------------------------------------------
		
		/**
		* Constructor : Create a RemoteConnector Instance
		* @see flash.net.NetConnection
		* @see flash.net.ObjectEncoding
		*/ 
		public function RemoteConnector() : void
		{
			_gate = new NetConnection(); 
			_gate.objectEncoding = ObjectEncoding.AMF3;
		}
		
		/**
		 * Define the gateway URL and the PHP Class name
		 * @param	url	Url for the gateway
		 * @param	className	Name of the class which contains php services
		 */
		public function define(url : String, className : String) : void
		{
			_url = url;
			_class	= className;
			
			_gate.connect(_url);
			
			_responder = new Responder(__onsuccess, __onfault);
		}
		
		/**
		* Defines the callback function
		* @param	func	Callback function
		*/ 
		public function setCallback(func : Function) : void
		{
			_callback = func;
		}

		/**
		* Call a server method
		* @param	meth	Name of the Method
		* @param	args	Arguments pass to the method
		*/ 
		public function request(method : String, args : * = null) : void
		{
			var params : Array = [_class + "." + method, _responder];
			_gate.call.apply(_gate, params.concat(args));
		}
		
		//-------------------------------------------------------------------------------------
		// Private Methods
		//-------------------------------------------------------------------------------------
		
		/**
		* Convert a recordset result into a associative array
		* @param	result	Results information after the request method
		* @return	Array instance
		*/ 
		private function _conversion(result : Object) : Array
		{
			var datas : Array = [];
			var element : Object;
			var p : String;
			var q : String;
			
			for(p in result.initialData)
			{
				element = {}
				for(q in result.columnNames) element[result.columnNames[q]] = result.initialData[p][q];
				datas.push(element);
			}
			
			return datas;
		}
		
		//-------------------------------------------------------------------------------------
		// Event Callbacks
		//-------------------------------------------------------------------------------------
		
		/**
		* Responder callback if success
		* @param	result	Results information after the request method
		*/ 
		private function __onsuccess(result : *) : void
		{
			var results : *;
			
			//recover the results if it's an object instance
			if(result && typeof(result) == "object" && result.serverInfo != undefined)
			{
				results = null;
				if(result.serverInfo.totalCount >= 1) results = _conversion(result.serverInfo);
			}
			else
			{
				results = result;
			}

			if(_callback is Function)
			{
				_callback(results);
			}
			else
			{
				var remoteEvent : RemoteEvents = new RemoteEvents(RemoteEvents.COMPLETE);
				remoteEvent.rows = result;
				dispatchEvent(remoteEvent);
			}
		}
		
		/**
		* Responder callback if error
		* @param	error	Error object
		*/ 
		private function __onfault(error : Object) : void
		{
			var i : String;
			var errorString : String = "";
			for (i in error) errorString = errorString.concat(">" + i + ": " + error[i]  + "\n");
			
			var fault : String = ">fault: \n" + errorString;
			
			if(_callback is Function)
			{
				_callback(fault);
			}
			else
			{
				var remoteEvent : RemoteEvents = new RemoteEvents(RemoteEvents.ERROR);
				remoteEvent.error = fault;
				dispatchEvent(remoteEvent);
			}
		}
	}
}