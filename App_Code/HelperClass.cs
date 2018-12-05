using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for HelperClass
/// </summary>
public class HelperClass
{
	public HelperClass()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void createNode(System.Xml.XmlTextWriter writer, string StartElementName, string ElementValue)
    {
        writer.WriteStartElement(StartElementName);
        writer.WriteString(ElementValue);
        writer.WriteEndElement();
    }
}