/**
 * @file ISourceIndexConverter.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-20
 * @updatedate 2010-1-20
 */   
package org.baicaix.source {

	/**
	 * @author dengyang
	 */
	public interface IResourceIndexConverter {
		function getIndex(url : String) : int;
		function getURL(index : int) : String;
	}
}
