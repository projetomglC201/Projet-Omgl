#!/usr/bin/env python
#
# copyrigh(c) 2007 Graham Stark (graham.stark@virtual-worlds.biz)
#
# ////////////////////////////////
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
# 
# It is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this software; see the file docs/gpl_v3.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
# 
# /////////////////////////////
# $Revision: 8623 $
# $Author: graham_s $
# $Date: 2010-02-12 20:11:18 +0000 (Fri, 12 Feb 2010) $
#

import sys, os
from lxml import etree
from sql_generator import makeDatabaseSQL
from ada_generator import makeEnvironmentADS, makeEnvironmentADB, makeBaseTypesADS
from ada_generator import makeDataADS, makeDataADB, makeCommons, makeIO, makeBasicTypesADB
from ada_generator import writeTestCaseADS, writeHarness, writeSuiteADB, writeTestCaseADB 

from paths import WORKING_PATHS
from table_model import parseXMLFiles, databaseToXML
from etc_files import writeMiscFiles;

if( len(sys.argv[1]) < 1 ):
        print "use python mill.py [target dir; should have schemas in xml/ dir]"

print "***** using the following paths ********"

print WORKING_PATHS ## a global variable, I'm afraid

WORKING_PATHS.makeTargetDirs();

print "parsing schema"
database = parseXMLFiles()
print database;
print "writing sql database schema to " + WORKING_PATHS.dbDir
makeDatabaseSQL( database )

print "making ada source files to " + WORKING_PATHS.srcDir
makeDataADS( database );
makeDataADB( database );
makeEnvironmentADS( database.dataSource )
makeEnvironmentADB( database.dataSource )
makeBaseTypesADS( database );
makeBasicTypesADB();
makeIO( database )
makeCommons()

print "writing sample configuration and project file to "+WORKING_PATHS.etcDir
writeMiscFiles( database )
print "writing test cases"
writeTestCaseADS( database )
writeSuiteADB( database )
writeHarness()
writeTestCaseADB( database )
print "done!"
## test testcode
doc = databaseToXML( database )
print etree.tostring( doc, method='xml', encoding="UTF-8", pretty_print=True )
