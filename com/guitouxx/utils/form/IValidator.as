/**
 * As3Toolbox com.guitouxx.utils.form
 * IValidator 1.0
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
package com.guitouxx.utils.form
{
	public interface IValidator
	{
		/**
		* Check if the String is valid for the current strategy
		* @param str	The string to check
		* @return Boolean instance
		*/ 
		function isValid(str : String) : Boolean
	}
}