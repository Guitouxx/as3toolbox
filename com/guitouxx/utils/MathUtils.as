/**
 * As3Toolbox com.guitouxx.utils
 * MathUtils 1.0
 * Last update : 20/12/08
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
 * @author Guillaume Tomasi <http://blog.guitouxx.com/class/>
 */
package com.guitouxx.utils
{
	/**
	* Utility class to help numbers manipulation
	*/
	public class MathUtils
	{
		//-------------------------------------------------------------------------------------
		// Public Methods
		//-------------------------------------------------------------------------------------
		
		/**
		 * Choose a random number between a range of numbers
		 * @param	min	Minimal value
		 * @param	max	Maximal value
		 * @return	Number instance
		*/
		public static function randomInt( min : Number, max : Number) : Number
		{
			return Math.round((max-min)*Math.random()+min);
		}
		
		/**
		 * Check if a number is divisible by the other
		 * @param	base	Base Number
		 * @param	divided	Divided number
		 * @return	Boolean instance
		*/
		public static function isDivisible(base : Number, divided : Number) : Boolean
		{
			return (String (base / divided).indexOf(".") == -1);
		}
		
		/**
		 * Check if a number exists between a interval
		 * @param	base	Base number
		 * @param	begin	Range begin
		 * @param	end	Range end
		 * @return	Boolean instance
		*/
		public static function isInRange( base : Number = 0, begin : Number = 0, end : Number = 0) : Boolean
		{
			return (base >= begin) && (base <= end);
		}
		
		/**
		 * Check if a number need a "0" at the first char
		 * @param	base	Base number
		 * @return	String instance
		*/
		public static function addZero(base : Number) : String
		{
			return (base <= 9) ? "0"+base.toString() : base.toString();
		}
	}
}