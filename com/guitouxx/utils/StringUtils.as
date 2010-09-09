/**
 * As3Toolbox com.guitouxx.utils
 * StringUtils 1.0
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
package com.guitouxx.utils
{
	/**
	* Utility class to help string instance manipulation
	*/
	public class StringUtils
	{
		//-------------------------------------------------------------------------------------
		// Public Methods
		//-------------------------------------------------------------------------------------
		
		/**
		 * Count words in a string instance 
		 * @param	str	The string to check
		 * @return	Number instance
		*/
		public static function hasWords( str : String ) : Number
		{
			return str.split(" ").length;
		}
		
		
		/**
		 * Cut a string at a specified number of words
		 * @param	str	The string to check
		 * @param	cutIndex	Cut position
		 * @return	String instance
		 * @see #hasWords
		*/
		public static function splitAtWords( str : String, cutIndex : int = 0) : String
		{
			var i:int = 0;
			var temp : int  = 0;
			var newpos : int = 0;
			
			if(cutIndex >= hasWords(str)) return str;
			
			while(i < cutIndex)
			{
				temp = str.indexOf(" ", newpos);
				newpos = temp + 1;
				i++;
			}
			
			return str.substring(0, newpos);
		}
	}
}