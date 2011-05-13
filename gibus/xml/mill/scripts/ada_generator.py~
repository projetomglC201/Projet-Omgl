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
# $Revision: 5459 $
# $Author: graham_s $
# $Date: 2008-07-15 12:07:15 +0100 (Tue, 15 Jul 2008) $
#
"""
 code to generate our ada .ads and .adb files, using Cheetah templating system
 for the most part
"""
from Cheetah.Template import Template
import datetime
from paths import WORKING_PATHS
from table_model import DataSource
from utils import makePlural, adafyName, makePaddedString, INDENT


MAXLENGTH = 120

def makeAddOrderingColumnDecl( var, ending ):
        s = "procedure Add_"+var.adaName+"_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc )" + ending
        return s

def makeAddOrderingColumnBody( var ):
        template = Template( file=WORKING_PATHS.templatesPath+"add_to_criterion_ordering.func.tmpl" )
        template.header = makeAddOrderingColumnDecl( var, ' is' )
        template.criterion = 'elem : d.Order_By_Element := d.Make_Order_By_Element( "'+ var.varname + '", direction  )'
        template.functionName = "Add_"+var.adaName+"_To_Orderings"
        s = str(template)
        return s

def makeUpdateStatement( table ):
        print ""


def makeInsertStatement( table ):
        s = "insert into "+table.name+" values( "

def makeCriteriaDecl( var, isString, ending ):
        if( isString ):
                adaType = 'String'
        else:
                adaType = var.getAdaType()
        return "procedure Add_"+var.adaName+"( c : in out d.Criteria; "+var.adaName+" : "+ adaType +"; op : d.operation_type:= d.eq; join : d.join_type := d.join_and )" + ending

def makePrimaryKeySubmitFields( table ):
        pks = []
        for var in table.variables:
                if( var.isPrimaryKey ):
                        pks.append( table.adaName + '.' + var.adaName  )
        return ', '.join( pks )


def makeCriteriaBody( var, isString = False ):
        if( isString ):
                adaType = 'String'
        else:
                adaType = var.getAdaType()
        template = Template( file=WORKING_PATHS.templatesPath+"add_to_criterion.func.tmpl" )
        if(( var.schemaType == 'BOOLEAN' ) or ( var.schemaType == 'ENUM' )):
                value = adaType+"'Pos( "+var.adaName +" )"
        elif( adaType == 'Unbounded_String' ):
                value = "To_String( "+var.adaName +" )"
        else:
                value = var.adaName
        # handle decimals from generic functions, one per decimal type; these are declared locally to the current package
        #
        if var.isDecimalType():
                function = "make_criterion_element_"+adaType
        else:   # .. otherwise, use the default versions in the db_commons package, aliased as 'd' here
                function = 'd.make_Criterion_Element';
        s = 'elem : d.Criterion := '+ function + '( "'+ var.varname +'", op, join, '+ value
        if var.isStringType():
                s += ", " + var.size ## the length of the sql variable, so we
        template.criterion = s +" )"
        template.header = makeCriteriaDecl( var, isString, ' is' )
        template.adaName = var.adaName
        s = str(template)
        return s

def makePKHeader( table, ending ):
        pks = []
        for var in table.variables:
                if( var.isPrimaryKey ):
                        pks.append( var.adaName + " : " + var.adaType )
        pkFields = '; '.join( pks )
        return "function Retrieve_By_PK( " + pkFields + " ) return " + table.adaQualifiedOutputRecord + ending

def makePKBody( table ):
        template = Template( file=WORKING_PATHS.templatesPath+"retrieve_pk.func.tmpl" )
        template.functionHeader = makePKHeader( table, ' is' )
        template.listType = table.adaQualifiedListName
        template.variableDecl = table.adaName + " : " + table.adaQualifiedOutputRecord
        template.primaryKeyCriteria = makeCriterionList( table, 'c', 'primaryKeyOnly', False )
        template.getNullRecord = table.adaName + " := " +  table.adaQualifiedNullName
        template.getFirstRecord =  table.adaName + " := " + table.adaQualifiedContainerName+ ".First_Element( l )"
        template.notEmpty = "not "+ table.adaQualifiedContainerName +".is_empty( l )"
        template.adaName = table.adaName
        s = str(template)
        return s


def makeNextFreeFunc( table, var ):
        template = Template( file=WORKING_PATHS.templatesPath+"get_next_free.func.tmpl" )
        template.functionHeader = makeNextFreeHeader( var, ' is' )
        template.statement = "select max( "+var.varname+" ) from "+table.name
        template.functionName =  "Next_Free_"+var.adaName
        template.adaName = var.adaName
        s = str(template)
        return s

def makeIsNullFunc( table, adaDataPackageName ):
        template = Template( file=WORKING_PATHS.templatesPath+"is_null.func.tmpl" )
        template.adaName = table.adaName
        template.functionHeader = makeIsNullFuncHeader( table, ' is' )
        template.returnStatement = 'return '+table.adaName + ' = ' + table.adaQualifiedNullName
        template.use = "use "+adaDataPackageName
        template.nullName = table.adaQualifiedNullName
        s = str(template)
        return s

def makeIsNullFuncHeader( table, ending ):
        return "function Is_Null( "+ table.adaName + " : " + table.adaQualifiedOutputRecord+ " ) return Boolean"+ending;

def makeIsEmptyFunc( table, adaDataPackageName ):
       template = Template( file=WORKING_PATHS.templatesPath+"is_empty.func.tmpl" )
       template.adaContainerName = table.adaContainerName
       template.functionHeader = makeIsEmptyFuncHeader( table, ' is' )
       template.returnStatement = 'return '+table.adaContainerName+'.Is_Empty('+table.adaContainerName +'e)'
       template.use = "use "+adaDataPackageName
      #  template.nullName = table.adaQualifiedNullName
       s = str(template)
       return s

def makeIsEmptyFuncHeader( table, ending ):
        return "function Is_Empty( "+ table.adaContainerName+"e" +" : " + table.adaQualifiedContainerName+ ".Vector ) return Boolean"+ending;

def makeCardFunc( table, adaDataPackageName ):
       template = Template( file=WORKING_PATHS.templatesPath+"card.func.tmpl" )
       template.adaContainerName = table.adaContainerName
       template.functionHeader = makeCardFuncHeader( table, ' is' )
       template.returnStatement = 'return '+table.adaContainerName+'.Length('+table.adaContainerName +'e)'
       template.use = "use "+adaDataPackageName
      #  template.nullName = table.adaQualifiedNullName
       s = str(template)
       return s

def makeCardFuncHeader( table, ending ):
        return "function Card( "+ table.adaContainerName+"e" +" : " + table.adaQualifiedContainerName+ ".Vector ) return Count_Type"+ending;

def makeRetrieveCHeader( table, ending ):
        return "function Retrieve( c : d.Criteria ) return " + table.adaQualifiedListName +ending

def makeRetrieveCFunc( table ):
        template = Template( file=WORKING_PATHS.templatesPath+"retrieve_by_c.func.tmpl" )
        template.functionHeader = makeRetrieveCHeader( table, ' is' )
        s = str(template)
        return s



def makeRetrieveSHeader( table, ending ):
        return "function Retrieve( sqlstr : String ) return " + table.adaQualifiedListName +ending;

def makeSaveProcHeader( table, ending ):
        return "procedure Save( "+  table.adaName + " : " + table.adaQualifiedOutputRecord+ "; overwrite : Boolean := True )"+ ending

def makeUpdateProcHeader( table, ending ):
        return "procedure Update( "+  table.adaName + " : " + table.adaQualifiedOutputRecord+ " )"+ ending

def makeDeleteSpecificProcHeader( table, ending ):
        return "procedure Delete( " + table.adaName + " : in out " + table.adaQualifiedOutputRecord +" )" + ending

def makeUpdateProcBody( table ):
        template = Template( file=WORKING_PATHS.templatesPath+"update.func.tmpl" )
        template.procedureHeader = makeUpdateProcHeader( table, ' is' )
        template.pkCriteria = makeCriterionList( table, 'pk_c', 'primaryKeyOnly', True )
        template.inputCriteria = makeCriterionList( table, 'values_c', 'allButPrimaryKey', True )
        return str(template)

def makeSaveProcBody( table ):
        template = Template( file=WORKING_PATHS.templatesPath+"save.func.tmpl" )
        template.procedureHeader = makeSaveProcHeader( table, ' is' )
        template.allCriteria = makeCriterionList( table, 'c', 'all', True )
        primaryKey = makePrimaryKeySubmitFields( table )
        template.tmpVariable = table.adaName + "_Tmp"
        template.existsCheck = 'if( not is_Null( '+table.adaName + '_Tmp )) then'
        template.updateCall = 'Update( '+ table.adaName + ' )'
        template.tmpVariableWithAssignment = table.adaName + "_Tmp : " + table.adaQualifiedOutputRecord;
        template.retrieveByPK = table.adaName + '_Tmp := retrieve_By_PK( ' + primaryKey + ' )'
        s = str(template)
        return s


def makeDeleteSpecificProcBody( table ):
        template = Template( file=WORKING_PATHS.templatesPath+"delete_specific.func.tmpl" )
        template.procedureHeader = makeDeleteSpecificProcHeader( table, ' is' )
        template.primaryKeyCriteria = makePrimaryKeyCriterion( table, 'c' )
        template.assignToNullRecord = table.adaName + " := " + table.adaQualifiedNullName
        s = str(template)
        return s



def makeToStringBody( table ):
        template = Template( file=WORKING_PATHS.templatesPath+"to_string.proc.tmpl" )
        # stupidly, indents are not consistent between the ads decl and the body so I have to duplicate
        # this header. I wrote the data decl before I really (??) got the hang of this.
        template.procedureHeader = "function To_String( rec : " + "t"+table.adaName + " ) return String is"
        template.returnStr = 'return  "'+table.adaName+': " &'+"\n"
        p = 0
        for var in table.variables:
                p += 1
                s = INDENT*3 + '"'+var.adaName+' = " & '
                if( var.isStringType() ):
                        s += 'To_String( rec.' + var.adaName +" )"
                elif( var.isDateType() ):
                        s += 'tio.Image( rec.' + var.adaName + ', tio.ISO_Date )';
                else:
                        s += 'rec.' + var.adaName+ "'Img"
                if( p < len( table.variables )):
                        s += " &\n"
                template.returnStr += s
        return str(template);


def makeNextFreeHeader( var, ending ):
        return "function Next_Free_"+var.adaName+" return integer" + ending

def makeChildRetrieveHeader( table, referencingTableName, packagedAdaName, ending ):
        return "function Retrieve_Child_"+referencingTableName+"( " + table.adaName + " : " + table.adaQualifiedOutputRecord +" ) return " + packagedAdaName+ending




def makeChildRetrieveBody( table, referencingTableName, listAdaName, fk ):
        template = Template( file=WORKING_PATHS.templatesPath+"retrieve_child.func.tmpl" )
        template.functionHeader = makeChildRetrieveHeader( table, referencingTableName, listAdaName, ' is' )
        template.functionName = "Retrieve_Child_"+ referencingTableName
        referencePackage = referencingTableName + "_IO"
        localPK = []
        for p in range( len( fk.localCols ) ):
                localName =  table.adaName +"."+ adafyName(fk.localCols[p])
                localPK.append( localName )
        localPKValues = ', '.join( localPK )
        template.returnStatement = "return " + referencePackage + ".retrieve_By_PK( "+localPKValues + " )"
        s = str(template)
        return s


def makeAssociatedRetrieveHeader( table, referencingTableName, listAdaName, ending ):
        return "function Retrieve_Associated_"+ makePlural( referencingTableName )+"( " +  table.adaName + " : " + table.adaQualifiedOutputRecord +" ) return " +listAdaName+ending

def makeAssociatedRetrieveBody( table, referencingTableName, listAdaName, fk ):
        template = Template( file=WORKING_PATHS.templatesPath+"retrieve_associated.func.tmpl" )
        template.functionHeader = makeAssociatedRetrieveHeader( table, referencingTableName, listAdaName, ' is' )
        template.allCriteria = []
        template.functionName = "Retrieve_Associated_"+ makePlural( referencingTableName )
        referencePackage = referencingTableName + "_IO"
        template.returnStatement = "return " + referencePackage + ".retrieve( c )"
        for p in range( len( fk.localCols ) ):
                # note these are the other way around from how you'd think of it
                # since the foriegn key is originally a property of the referencing table
                # not the table we're on (if you see what I mean).
                localName =  adafyName(fk.localCols[p])
                foreignName =  adafyName(fk.foreignCols[p])
                crit = referencePackage+".Add_"+localName+"( c, " + table.adaName+"."+foreignName + " )"
                template.allCriteria.append( crit )
        s = str(template)
        return s


def make_io_ads( dataPackageName, table ):
        outfileName = (WORKING_PATHS.srcDir+table.adaName+'_io.ads').lower()
        outfile = file( outfileName, 'w' );

        template = Template( file=WORKING_PATHS.templatesPath+"io.ads.tmpl" )
        template.IOName = table.adaName+"_IO"
        template.criteria = []
        template.nullName = table.adaQualifiedNullName;
        template.orderingStatements = []
        template.incr_integer_pk_fields = []

        for var in table.variables:
                template.orderingStatements.append(makeAddOrderingColumnDecl( var, ';' ));
                template.criteria.append( makeCriteriaDecl( var, False, ';' ))
                if( var.isStringType() ):
                        template.criteria.append( makeCriteriaDecl( var , True, ';' ))
                if( var.isPrimaryKey ):
                        if( var.isIntegerType() ):
                                template.incr_integer_pk_fields.append( makeNextFreeHeader( var, ';' ));

        template.pkFunc = makePKHeader( table, ';' )

        template.isNullFunc =  makeIsNullFuncHeader( table, ';' );
	template.isEmptyFunc = makeIsEmptyFuncHeader( table, ';');
	template.cardFunc = makeCardFuncHeader( table, ';');
        template.retrieveByCFunc = makeRetrieveCHeader( table, ';' );
        template.retrieveBySFunc = makeRetrieveSHeader( table, ';' );
        template.saveFunc = makeSaveProcHeader( table, ';' );
        template.deleteSpecificFunc = makeDeleteSpecificProcHeader( table, ';' );
        template.outputRecordType = table.adaQualifiedOutputRecord
        template.outputRecordName = table.adaName
        template.associated = []
        template.date = datetime.datetime.now()
        for name in table.childRelations:
                fk = table.childRelations[ name ]
                referencingTableName = adafyName( name )

                if( fk.isOneToOne ):
                        packagedAdaName = dataPackageName+"."+referencingTableName;
                        childFunc = makeChildRetrieveHeader( table, referencingTableName, packagedAdaName, ';' )
                        template.associated.append( childFunc );
                else:
                        listAdaName = dataPackageName+"."+referencingTableName+"_List.Vector"
                        assocFunc = makeAssociatedRetrieveHeader( table, referencingTableName, listAdaName, ';' )
                        template.associated.append( assocFunc );
        template.dataPackageName = dataPackageName
        outfile.write( str(template) )
        outfile.close()

def sqlVariablesList( table ):
        selects = []
        s = ''
        p = 0
        for var in table.variables:
                selects.append( var.varname );
                p += 1
                if( ( p % 10 ) == 0 ) :
                        s += INDENT*3 + '"' + (', '.join( selects ))
                        if( p < len( table.variables )):
                                s += ','
                        s += '"'
                        if( p < len( table.variables )):
                                s += " &\n";
                        selects = []
        if( len( selects ) > 0 ):
                s += INDENT*3 + '"' + (', '.join( selects )) + ' "';
        return s

def makeDeletePartString( table ):
        s = 'DELETE_PART : constant String := "delete from '+table.name+' "'
        return s


def makeSelectPartString( table ):
        s = 'SELECT_PART : constant String := "select " &'+"\n"
        s += sqlVariablesList( table )
        s += " &\n";
        s += INDENT*3 + '"from '+table.name+' " '
        return s

def makeInsertPartString( table ):
        s = 'INSERT_PART : constant String := "insert into '+table.name+' (" &'+"\n"
        s += sqlVariablesList( table )
        s += " &\n";
        s += INDENT*3 + '" ) values " '
        return s

def makeUpdatePartString( table ):
        s = 'UPDATE_PART : constant String := "update '+table.name+' set  "'
        return s


def makeCriterionList( table, criterionName, includeAll, qualifyVarname ):
        """
         table,
         criterionName,
         includeAll,
         qualifyVarname - add the ada table name to each entry
        """
        l = [];
        for var in table.variables:
                if( (includeAll == 'all' ) or
                    ( (includeAll == 'primaryKeyOnly') and var.isPrimaryKey ) or
                    ( (includeAll=='allButPrimaryKey') and ( not var.isPrimaryKey ))):
                        varname = var.adaName
                        if( qualifyVarname ):
                                varname = table.adaName+"."+varname
                        critElement = "Add_"+var.adaName+"( "+criterionName +", "+ varname +" )"
                        l.append( critElement );
        return l

def makePrimaryKeyCriterion( table, criterionName ):
        return makeCriterionList( table, criterionName, 'primaryKeyOnly', True )


def makeBinding( databaseAdapter, var, pos ):
        """
         ODBC binding declarations for each type we support,

         The rules here come from much trial end error and digging around on
         the microsoft ODBC site.
        """
        posStr = `pos`
        if( var.isIntegerTypeInODBC()):
                binding = INDENT*2 + "dodbc.I_Out_Binding.SQLBindCol(\n";
                binding += INDENT*4 + "StatementHandle  => ps,\n"
                binding += INDENT*4 + "ColumnNumber     => "+posStr+",\n"
                binding += INDENT*4 + "TargetValue      => "+ var.adaName+"'access,\n"
                binding += INDENT*4 + "IndPtr           => "+ var.adaName+"_len'access )"
        elif( var.isStringType() ):
                charType = databaseAdapter.supportedSqlCharType
                binding = INDENT*2 + "SQLBindCol(\n";
                binding += INDENT*4 + "StatementHandle  => ps,\n"
                binding += INDENT*4 + "ColumnNumber     => "+posStr+",\n"
                binding += INDENT*4 + "TargetType       => " + charType + ",\n"
                binding += INDENT*4 + "TargetValuePtr   => To_SQLPOINTER( "+ var.adaName+"_access.all'address ),\n"
                binding += INDENT*4 + "BufferLength     => "+ var.adaName + "_len,\n"
                binding += INDENT*4 + "StrLen_Or_IndPtr => "+ var.adaName + "_len'access )"
        elif( var.isNumericType() ):
                binding = INDENT*2 + "SQLBindCol(\n";
                binding += INDENT*4 + "StatementHandle  => ps,\n"
                binding += INDENT*4 + "TargetType       => SQL_C_DOUBLE,\n"
                binding += INDENT*4 + "ColumnNumber     => "+posStr+",\n"
                binding += INDENT*4 + "TargetValuePtr   => To_SQLPOINTER( "+ var.adaName+"_access.all'address ),\n"
                binding += INDENT*4 + "BufferLength     => 0,\n"
                binding += INDENT*4 + "StrLen_Or_IndPtr => "+ var.adaName+"_len'access )"
        elif ( var.isDateType() ):
                binding = INDENT*2 + "SQLBindCol(\n";
                binding += INDENT*4 + "StatementHandle  => ps,\n"
                binding += INDENT*4 + "TargetType       => SQL_C_TYPE_TIMESTAMP,\n"
                binding += INDENT*4 + "ColumnNumber     => "+posStr+",\n"
                binding += INDENT*4 + "TargetValuePtr   => To_SQLPOINTER( "+ var.adaName+"_access.all'address ),\n"
                binding += INDENT*4 + "BufferLength     => 0,\n"
                binding += INDENT*4 + "StrLen_Or_IndPtr => "+ var.adaName+"_len'access )"
        else:
                binding = "FIXME: MISSED BINDING FOR VAR " + var.varname
        return binding;

def makeRetrieveSFunc( table, database ):
        """
         table - Table class from table_model.py
         database - complete enclosuing Database model from  table_model.py

         Make a fuction that, for a given table (say 'fred'), takes an sql string as input (just the query part)
         and returns a single
         list of fred records (fred_list, as declared in the main database declarations ads file).
         This version has wide_string handling jammed off
         Structure is:
            - declare local versions of all fred's variables
            - declare aliases (pointers) to these variables, where needed
            - declare length holders for each one
            - make the query by appending the query part to a constant 'select part'
            - prepare the query
            - bind variables/aliase
            - execute
            - loop round, map the locals to one record
            --    add the variable to the collection

         There's a certain amount of trial an error in this..
        """
        template = Template( file=WORKING_PATHS.templatesPath+"retrieve_wstr.func.tmpl" )
        template.functionHeader = makeRetrieveSHeader( table, ' is' )
        template.listType = table.adaQualifiedListName
        template.variableDecl = table.adaName + " : " + table.adaQualifiedOutputRecord
        template.addToMap = table.adaQualifiedContainerName+".append( l, "+ table.adaName +" )"
        template.aliasDeclarations = []
        template.pointers = []
        template.lenDeclarations = []
        template.mappingsFromAliasToRecord = []
        template.bindings = []
        pos = 0
        for var in table.variables:
                pos += 1
                alias = var.adaName + ": aliased " + var.odbcType;
                if( var.isStringType() ):
                        alias += " := " + makePaddedString( 4, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', int(var.size) )
                template.aliasDeclarations.append( alias );
                len_decl = var.adaName + "_len : aliased SQLINTEGER := " + var.adaName+"'Size";
                template.lenDeclarations.append( len_decl )
                binding = makeBinding( database.databaseAdapter, var, pos )
                template.bindings.append( binding )
                if( var.isRealOrDecimalType() or var.isDateType() or var.isStringType() ): ## NOTE: is String type is only because we're trying wide_strings here, otherwise
                        if( var.isRealOrDecimalType() ):                                   ## there's a simple SQLBind version that doens't need any of this
                                pointer = var.adaName + "_access : Real_Access := "+var.adaName+"'access"
                                mapping = table.adaName + "." + var.adaName + ":= " + var.adaType + "( "+var.adaName + "_access.all )"
                        elif( var.isDateType()):
                                pointer = var.adaName + "_access : Timestamp_Access := "+var.adaName+"'access"
                                mapping = table.adaName + "." + var.adaName + ":= dodbc.Timestamp_To_Ada_Time( "+var.adaName + "_access.all )"
                        if( var.isStringType() ):
                                mapping = table.adaName + "." + var.adaName + " := Slice_To_Unbounded( " + var.adaName + ", 1, Natural( "+var.adaName+"_len ) )"
                                pointer = var.adaName + "_access : String_Access := "+var.adaName+"'access"

                        template.pointers.append( pointer )
                else:  ## integer/enum types
                        if( var.schemaType == 'ENUM' ):
                                mapping = table.adaName + "." + var.adaName + " := "+ var.adaType+"'Val( " + var.adaName + " )"
                        elif( var.schemaType == 'BOOLEAN' ):
                                mapping = table.adaName + "." + var.adaName + " := Boolean'Val( " + var.adaName + " )"
                        else:
                                mapping = table.adaName + "." + var.adaName + " := " + var.adaName
                template.mappingsFromAliasToRecord.append( mapping )
        s = str(template)
        return s

def make_io_adb( database, table ):
        """
         Make the adb (ada body) file for the io procs given table e.g. fred_io.adb into src/
         table - Table class from table_model.py
         database - complete enclosuing Database model from  table_model.py
        """
        outfileName = (WORKING_PATHS.srcDir+table.adaName+'_io.adb').lower()
        outfile = file( outfileName, 'w' );

        template = Template( file=WORKING_PATHS.templatesPath+"io.adb.tmpl" )
        template.selectPart = makeSelectPartString( table )
        template.insertPart = makeInsertPartString( table )
        template.deletePart = makeDeletePartString( table )
        template.updatePart = makeUpdatePartString( table )
        template.IOName = table.adaName+"_IO"
        template.criteria = []
        template.nullName = table.adaQualifiedNullName;
        template.orderingStatements = []
        template.incr_integer_pk_fields = []
        template.localWiths = []
        template.decimalDeclarations = []
        for dec in table.decimalTypes:
                gentype = "function make_criterion_element_"+dec+" is new d.Make_Decimal_Criterion_Element( "+dec+" )"
                template.decimalDeclarations.append( gentype );
        for var in table.variables:
                template.criteria.append( makeCriteriaBody( var ))
                template.orderingStatements.append(makeAddOrderingColumnBody( var ));
                if( var.isStringType() ):
                        template.criteria.append( makeCriteriaBody( var , True ))
                if( var.isPrimaryKey ):
                        if( var.isIntegerType() ):
                                template.incr_integer_pk_fields.append( makeNextFreeFunc( table, var ) );

        template.pkFunc = makePKBody( table )

        template.isNullFunc =  makeIsNullFunc( table, database.adaDataPackageName )
	template.isEmptyFunc = makeIsEmptyFunc( table, database.adaDataPackageName)
	template.cardFunc = makeCardFunc( table, database.adaDataPackageName)
        template.retrieveByCFunc = makeRetrieveCFunc( table );
        template.retrieveBySFunc = makeRetrieveSFunc( table, database );
        template.updateFunc = makeUpdateProcBody( table );
        template.saveFunc = makeSaveProcBody( table );
        template.deleteSpecificFunc = makeDeleteSpecificProcBody( table );

        template.outputRecordType = table.adaQualifiedOutputRecord
        template.outputRecordName = table.adaName
        template.associated = []
        template.date = datetime.datetime.now()
        for name in table.childRelations:
                fk = table.childRelations[ name ]
                referencingTableName = adafyName( name )
                template.localWiths.append( referencingTableName+"_IO" )
                if( fk.isOneToOne ):
                        packagedAdaName = database.adaDataPackageName+"."+referencingTableName;
                        childFunc = makeChildRetrieveBody( table, referencingTableName, packagedAdaName, fk )
                        template.associated.append( childFunc );
                else:
                        listAdaName = database.adaDataPackageName+"."+referencingTableName+"_List.Vector"
                        assocFunc = makeAssociatedRetrieveBody( table, referencingTableName, listAdaName, fk )
                        template.associated.append( assocFunc );
        template.dataPackageName = database.adaDataPackageName
        outfile.write( str(template) )
        outfile.close()

def makeIO( database ):
        """
        database - complete enclosuing Database model from  table_model.py

        Make all the records needed to handle writing to and from the database
        there is one ads/adb pair per table in the database; for a table 'fred'
        these are fred_io.ads and fred_io.adb
         Write to src/
        """
        for table in database.tables:
                make_io_ads( database.adaDataPackageName, table )
                make_io_adb( database, table )

def makeSingleAdaRecordElement( var ):
        """
        var - Variable class from table_model.py
        Declaration for a single element in a record
        """
        return var.adaName + " : " + var.adaType + " := " + var.getDefaultAdaValue()

def makeContainerPackage( table ):
        """
         table - Table class from table_model.py
         Ada containers package declaration for a table; if table name is 'fred' gives you:
         'package fred_list is new Ada.Containers.Vectors( element_type=>fred, index_type=>Positive );
         (plus some comments)
        """
        s = INDENT*2 + "--\n"
        s += INDENT*2 + "-- container for "+ table.name + " : " +table.description[:MAXLENGTH] +"\n"
        s += INDENT*2 + "--\n"
        s += INDENT*2 + "package "+ table.adaContainerName+" is new Ada.Containers.Vectors\n"
        s += INDENT*3 + "(Element_Type => "+"t"+table.adaName+",\n"
        s += INDENT*3 + "Index_Type => Positive );\n"
        return s

def makeChildCollection( adaName ):
        """
        adaName - a string like Variable_One
        Return a declaration for a list of some type; something like 'freds : fred_List.vector'
        """
        return makePlural( adaName ) + " : "+adaName+"_List.Vector"

def makeRecord( table ):
        """
         table - Table class from table_model.py
        Make the Ada record declaration for the given table. See table_model.py for the (very limited)  b
        xml=>sql=>ada type mappings and defaults.
        """
        s = INDENT*2 +"--\n"
        s += INDENT*2 +"-- record modelling "+ table.name + " : " + table.description[:MAXLENGTH]+"\n"
        s += INDENT*2 +"--\n"
        s += INDENT*2 + 'type ' + 't' + table.adaName + " is record\n";
        for var in table.variables:
                s += INDENT*3 + makeSingleAdaRecordElement( var )+";\n";
        for name in table.childRelations:
                fk = table.childRelations[ name ]
                adaName = adafyName( name )
                if( fk.isOneToOne ):
                        s += INDENT*3 + adaName + "_Child :" + adaName+' := Null_' + adaName+";\n";
                else:
                        s += INDENT*3 + makeChildCollection( adaName )+";\n";

        s += INDENT*2 + "end record;\n"
        return s

def makeToStringDecl( table, ending ):
        s = INDENT*2 +"--\n"
        s += INDENT*2 +"-- simple print routine for "+table.name + " : " +table.description[:MAXLENGTH]+"\n"
        s += INDENT*2 +"--\n"
        s += INDENT*2 + "function To_String( rec : " + "t"+table.adaName + ' ) return String'+ending +"\n";
        return s


def makeDefaultRecordDecl( table ):
        """
        Make a record that signals, effectively, Null, with some unlikely values for the primary key fields
        """
        s = INDENT*2 +"--\n"
        s += INDENT*2 +"-- default value for "+table.name + " : " +table.description[:MAXLENGTH]+"\n"
        s += INDENT*2 +"--\n"
        s += INDENT*2 + table.adaNullName + " : constant " + "t"+ table.adaName + " := (\n";
        elems = []
        for var in table.variables:
                elems.append( INDENT*3 + var.adaName + " => " + var.getDefaultAdaValue() );
        for name in table.childRelations:
                fk = table.childRelations[ name ]
                adaName = adafyName( name )
                if( fk.isOneToOne ):
                        # 1:1 relationship
                        elems.append( INDENT*3 + adaName + '_Child => Null_' + adaName );
                else:
                        elems.append( INDENT*3 + makePlural(adaName) + ' => ' + adaName + "_List.Empty_Vector" );
        s += ",\n". join( elems );

        s += "\n"+INDENT*2 + ");\n"
        return s

def makeDataADS( database ):
        """
         Write a .ads file containing all the data records and container declarations
         writes to a file <database_name>_data.ads in the src output directory.
        """
        rtabs = database.tables[:]
        rtabs.reverse()
        records = []
        for table in rtabs:
                record = makeRecord( table )
                record += makeContainerPackage( table )
                record += makeDefaultRecordDecl( table )
                record += makeToStringDecl( table, ';' );
                records.append( record );
        outfile = file( WORKING_PATHS.srcDir+(database.dataSource.database+'_data.ads'), 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"data.ads.tmpl" )
        template.records = records;
        template.name = database.adaDataPackageName
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close

def makeDataADB( database ):
        """
         Write a .ads file containing all the data record and container declarations
         writes to a file <database_name>_data.adb in the src output directory.
        """
        rtabs = database.tables[:]
        rtabs.reverse()
        template = Template( file=WORKING_PATHS.templatesPath+"data.adb.tmpl" )
        template.toStrings = []
        template.name = database.adaDataPackageName
        template.date = datetime.datetime.now()
        for table in rtabs:
                template.toStrings.append( makeToStringBody( table ) )
        outfile = file( WORKING_PATHS.srcDir+(database.dataSource.database+'_data.adb'), 'w' );
        outfile.write( str(template) )
        outfile.close



def makeEnvironmentADS( runtime ):
        """
         Write an ads file with calls for getting passwords, usernames, database name
         writes to src/environment.ads.
        """
        outfile = file( WORKING_PATHS.srcDir+'environment.ads', 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"environment.ads.tmpl" )
        template.unit_name   = runtime.database+'_db_environment'
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close()


def  makeEnvironmentADB( runtime ):
        """
         Write an adb file with calls for getting passwords, usernames, database name
         writes to src/environment.adb.
        """
        outfile = file( WORKING_PATHS.srcDir+'environment.adb', 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"environment.adb.tmpl" )
        template.unit_name   = runtime.database+'_db_environment'
        template.database = runtime.database
        template.password = runtime.password
        template.username = runtime.username
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close()

def makeBaseTypesADS( database ):
        """
         Add declarations for any decimal types and enumerations to
         an ads file already containing some package defintions, aliases,
         and string types used throughout the output.
         writes to src/base_types.ads
        """
        outfile = file( WORKING_PATHS.srcDir+'base_types.ads', 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"base_types.ads.tmpl" )
        decs = []
        for d in database.decimalTypes.values():
                decs.append( d.toAdaString )
        template.decimal_reps = decs;
        enums = []
        for e in database.enumeratedTypes.values():
                enums.append( e.toAdaString )
        template.enum_reps = enums;
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close()

def makeBasicTypesADB():
        """
        Write a body for the common types declarations to src/base_types.adb
        """
        outfile = file( WORKING_PATHS.srcDir+'base_types.adb', 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"base_types.adb.tmpl" )
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close()

def makeCommons():
        """
        Write versions of support files db_commons, db_commons-odbc and logger to src/
        We just add some headers to each; otherwise they're uncustomised.
        """
        targets = [ 'db_commons', 'db_commons-odbc', 'logger' ]
        exts = [ 'adb', 'ads' ]
        for target in targets:
                for ext in exts:
                        outfile = file( WORKING_PATHS.srcDir + target+"."+ext, 'w' );
                        template = Template( file=WORKING_PATHS.templatesPath+""+target+"."+ext+"."+"tmpl" )
                        template.date = datetime.datetime.now()
                        outfile.write( str(template) )
                        outfile.close()


def writeTestCaseADS( database ):
        """
         Write an  test case ads file
        """
        outfile = file( WORKING_PATHS.testsDir+ database.dataSource.database +  '_test.ads', 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"test_case.ads.tmpl" )
        template.testName = adafyName( database.dataSource.database +  '_test' );
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close()

def makeChildTests( databaseName, table ):
        return ''

def makeCreateTest( databaseName, table ):
        """
         Write an create test
        """
        template = Template( file=WORKING_PATHS.templatesPath+"create_test.proc.tmpl" )
        procName = table.adaName+ "_Create_Test"
        varname = table.adaName+"_Test_Item";
        listname = table.adaName+"_test_list";
        cursor = table.adaContainerName+'.Cursor'
        template.procedureHeader = "procedure "+procName + "(  T : in out AUnit.Test_Cases.Test_Case'Class ) is"
        template.procName = procName;
        ## qualified names here can solve some name clashes, even though the data package is withed
        template.variableDeclaration = varname + " : " + table.adaQualifiedOutputRecord;
        template.listDeclaration = listname + " : " + table.adaQualifiedListName;
        template.printHeader = 'procedure Print( pos : ' + cursor + ' ) is '
        template.clearTable = table.adaName+"_io.Delete( criteria )"
        template.retrieveUser = varname+' := '+table.adaContainerName+'.element( pos )'
        template.toString = 'Logger.info( To_String( '+ varname + ' ))'
        template.completeListStatement = listname +' := '+ table.adaIOPackageName+'.Retrieve( criteria )'
        template.iterate = table.adaContainerName+'.iterate( ' + listname +", print'Access )"
        template.createKeyStatements = []
        template.createDataStatements = []
        template.modifyDataStatements = []
        template.saveStatement = table.adaName+"_io.Save( "+varname+", False )"
        template.updateStatement = table.adaName+"_io.Save( "+varname+" )"
        template.deleteStatement = table.adaName+"_io.Delete( "+varname+" )"
        template.elementFromList = varname+ ' := ' + table.adaContainerName+'.element( '+listname+', i )'
        for var in table.variables:
                if( var.isPrimaryKey ):
                        #
                        # FIXME only works with integers and strings
                        #
                        if var.isStringType():
                                key = varname+'.'+var.adaName+ ' := To_Unbounded_String( "k_" & i\'img )'
                        else:
                                key = varname+'.'+var.adaName+ ' := '+ table.adaName +'_io.Next_Free_'+var.adaName
                        template.createKeyStatements.append( key )
                else:
                        assign = "-- missing"+varname+" declaration "
                        if( var.isStringType() ):
                                data = 'dat for'+var.adaName
                                assign = varname+'.'+var.adaName+ ' := To_Unbounded_String("'+data+'")'
                                template.modifyDataStatements.append( varname+'.'+var.adaName+ ' := To_Unbounded_String("Altered::'+data+'")' )
                        elif( var.isDateType() ):
                                assign = varname+'.'+var.adaName+ ' := Ada.Calendar.Clock'
                        elif( var.isFloatingPointType() ):
                                assign = varname+'.'+var.adaName+ ' := 1010100.012'
                        elif( var.isDecimalType() ):
                                v = '10201.'+( int(var.scale)*'1')
                                assign = varname+'.'+var.adaName+ ' := '+v
                        ## finish??
                        template.createDataStatements.append( assign )
        return str( template )


def writeTestCaseADB( database ):
        """
         Write an  test case ads file
        """
        outfile = file( WORKING_PATHS.testsDir+ database.dataSource.database +  '_test.adb', 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"test_case.adb.tmpl" )
        template.testName = adafyName( database.dataSource.database +  '_test' );
        template.datapackage = adafyName( database.dataSource.database+"_Data" );
        template.dbPackages = []
        template.createRegisters = []
        template.childRegisters = []
        template.createTests = []
        template.childTests = []
        for table in database.tables:
                template.dbPackages.append( table.adaName+"_IO" );
                template.createRegisters.append( "Register_Routine (T, " + table.adaName+ "_Create_Test'Access, " + '"Test of Creation and deletion of '+table.adaName+'" );' );
                template.createTests.append( makeCreateTest( database.dataSource.database, table ))
                if( len( table.childRelations ) > 0 ):
                        template.childRegisters.append( "Register_Routine (T, " + table.adaName+ "_Child_Retrieve_Test'Access, " + '"Test of Finding Children of '+table.adaName+'" );' );
                        template.childTests.append( makeChildTests( database.dataSource.database, table ) )
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close()

def writeSuiteADB( database ):
        """
         Write the exe file bit (adb) for the test case
        """
        outfile = file( WORKING_PATHS.testsDir+ 'suite.adb', 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"suite.adb.tmpl" )
        template.testFile = adafyName( database.dataSource.database +"_Test" )
        template.testCase = adafyName( database.dataSource.database +  '_test.Test_Case' );
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close()

def writeHarness():
        outfile = file( WORKING_PATHS.testsDir+ 'harness.adb', 'w' );
        template = Template( file=WORKING_PATHS.templatesPath+"harness.adb.tmpl" )
        template.date = datetime.datetime.now()
        outfile.write( str(template) )
        outfile.close()




