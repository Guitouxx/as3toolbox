/**
 * As3Toolbox com.guitouxx.utils.form
 * DateValidator 1.0
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
 * Thanks to Benoit Milgram <http://www.kilooctet.net> 
 */
package com.guitouxx.utils.form.validators
{
	//Imports
	import com.guitouxx.utils.form.IValidator;
	import com.guitouxx.utils.MathUtils;
	
	/**
	 * Check the string syntax for a date
	 */
	public class DateValidator implements IValidator
	{
		//-------------------------------------------------------------------------------------
		// Constant
		//-------------------------------------------------------------------------------------
		
		private static const DAYS : Array = [1, 31];
		private static const MONTH : Array = [1, 12];
		public static const EUROPE_FORMAT : String = "DD-MM-YYYY";
		public static const US_FORMAT : String = "MM-DD-YYYY";
		public static const REVERSE_FORMAT : String = "YYYY-MM-DD";
		
		//-------------------------------------------------------------------------------------
		// Vars
		//-------------------------------------------------------------------------------------
		
		private var _format : String;
		
		//-------------------------------------------------------------------------------------
		// Public Methods
		//-------------------------------------------------------------------------------------
		
		/**
		* Constructor
		*/ 
		public function DateValidator(format : String = EUROPE_FORMAT) : void
		{
			_format = format;
		}
		
		/**
		* Check if the Date is valid
		* @param str	The string to check
		* @return Boolean instance
		*/
		public function isValid(str : String) : Boolean
		{
			if(str.length > _format.length) return false;
			
			var pattern : RegExp = new RegExp("[-/.]", "i");
			var seperator : String = pattern.exec(str);
			
			if(!seperator) return false;
			
			var temp : Array = str.split(seperator);
			var year : Number = Number(temp[2]);
			if(_format == REVERSE_FORMAT) year = Number(temp[0]);
			
			var months : Number = Number(temp[1]);
			if(_format == US_FORMAT) months = Number(temp[0]);
			
			var days : Number = Number(temp[0]);
			if(_format == US_FORMAT) days = Number(temp[1]);
			if(_format == REVERSE_FORMAT) days = Number(temp[2]);
			
			if(isNaN(year) || isNaN(months) || isNaN(days)) return false;
			if(!MathUtils.isInRange(months, MONTH[0], MONTH[1]) || !MathUtils.isInRange(days, DAYS[0], DAYS[1])) return false;
			
			return true;
		}
	}
}
