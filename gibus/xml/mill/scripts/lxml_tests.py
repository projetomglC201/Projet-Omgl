from lxml import etree
from copy import deepcopy
doc = etree.Document("root")
root = etree.Element("root")
doc.append( root )
root.append( etree.Element( "child1" ))
print root
child2 = etree.SubElement( root, "child2" )
print(etree.tostring( root, pretty_print=True ))
for child in root:
        print( child.tag )
root.insert(0, etree.Element("child0"))
start = root[:1]
end   = root[-1:]
print len( root )

element = etree.Element("neu")
element.append( deepcopy( root ) )
print( element )

print root[1] is root[0].getnext() 

print root is root[0].getparent()

root = etree.Element( "root", interesting="totally" )
print etree.tostring( root )

print(root.get( "interesting" ))

print(root.set( "int", "ZXX" ))
print etree.tostring( root )

attributes = root.attrib

root.text = "TEX"
print root.text
print root.attrib
print root.xpath( "//text()" )

build_text_list = etree.XPath("//text()")

texts = build_text_list( root )

parent = texts[0].getparent()

root = etree.Element("root")
etree.SubElement(root, "child").text = "Child 1"
etree.SubElement(root, "child").text = "Child 2"
etree.SubElement(root, "another").text = "Child 3"
etree.SubElement( root[2], "child_of_3" )
etree.SubElement( root[0], "child_of_1" )
print parent.tag
for element in root.iter( "another" ):
        print("%s - %s" % (element.tag, element.text))

print etree.tostring( root, method='xml', encoding="UTF-8", pretty_print=True )
root = etree.XML("<root>data</root>")
print etree.tostring( root, method='xml', encoding="UTF-8", pretty_print=True )
tree = etree.parse( "../xml/simple/database-schema.xml" );
print etree.tostring( tree, method='xml', encoding="UTF-8", pretty_print=True )


