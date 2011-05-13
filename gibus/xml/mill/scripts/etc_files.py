from paths import WORKING_PATHS
from Cheetah.Template import Template
import datetime
from utils import adafyName

def writeProjectFile( database ):
        outfile = file( WORKING_PATHS.outputRootDir + database.dataSource.database+'.gpr' , 'w' );
        template = Template( file=WORKING_PATHS.templatesPath + 'project_file.tmpl' )
        template.date = datetime.datetime.now()
        template.projectName = adafyName(database.dataSource.database)
        outfile.write( str(template) )
        outfile.close()

def writeODBCIni( database ):
        dbname = database.dataSource.database
        outfile = file( WORKING_PATHS.etcDir + 'odbc.ini' , 'w' );
        ## stop cheeta dying because of unicode characters; no idea what's going on here.
        dbtype = database.dataSource.databaseType.encode('ascii', 'replace') 
        odbcName = WORKING_PATHS.templatesPath + dbtype + '_odbc_ini.tmpl'
        template = Template( file=odbcName )
        template.date = datetime.datetime.now()
        template.description = 'Database '+ database.description 
        template.database = dbname 
        template.dbDecl = '['+dbname+']'
        outfile.write( str(template) )
        outfile.close()
        
#
# write a sample odbc file and project file into etc/ in the output dir
#
def writeMiscFiles( database ):
        writeProjectFile( database )
        writeODBCIni( database )
