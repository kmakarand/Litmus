// ============================================================================
//
// Copyright (C) 2006-2009 Talend Inc. - www.talend.com
//
// This source code is available under agreement available at
// %InstallDIR%\features\org.talend.rcp.branding.%PRODUCTNAME%\%PRODUCTNAME%license.txt
//
// You should have received a copy of the agreement
// along with this program; if not, write to Talend SA
// 9 rue Pages 92150 Suresnes, France
//
// ============================================================================
package org.talend.cwm.builders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.talend.cwm.relational.RelationalFactory;
import org.talend.cwm.relational.TdTable;
import org.talend.utils.sql.metadata.constants.GetForeignKey;
import org.talend.utils.sql.metadata.constants.GetPrimaryKey;
import org.talend.utils.sql.metadata.constants.TableType;
import orgomg.cwm.resource.relational.ForeignKey;
import orgomg.cwm.resource.relational.PrimaryKey;

/**
 * @author scorreia
 * 
 * A class for creating Tables from a connection. By default, no column is retrieved.
 */
public class TableBuilder extends AbstractTableBuilder<TdTable> {

    private static Logger log = Logger.getLogger(TableBuilder.class);

    private Map<String, PrimaryKey> column2pk = new HashMap<String, PrimaryKey>();

    private Map<String, ForeignKey> column2foreign = new HashMap<String, ForeignKey>();

    /**
     * TableBuilder constructor.
     * 
     * @param conn the connection from which the tables will be created.
     */
    public TableBuilder(Connection conn) {
        super(conn, TableType.TABLE);
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.talend.cwm.builders.AbstractTableBuilder#createTable()
     */
    @Override
    protected TdTable createTable() {
        return RelationalFactory.eINSTANCE.createTdTable();
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.talend.cwm.builders.AbstractTableBuilder#createTable(java.lang.String, java.lang.String,
     * java.sql.ResultSet)
     */
    @Override
    protected TdTable createTable(String catalogName, String schemaPattern, ResultSet tablesSet) throws SQLException {
        TdTable table = super.createTable(catalogName, schemaPattern, tablesSet);
        return table;
    }

    /**
     * DOC scorreia Comment method "getPrimaryKeys".
     * 
     * @param catalogName
     * @param schemaPattern
     * @param table
     * @throws SQLException
     */
    public List<PrimaryKey> getPrimaryKeys(String catalogName, String schemaPattern, String tableName) throws SQLException {
        List<PrimaryKey> pks = new ArrayList<PrimaryKey>();
        ResultSet primaryKeys = null;
        try {
            primaryKeys = connection.getMetaData().getPrimaryKeys(catalogName, schemaPattern, tableName);
            try {
                while (primaryKeys.next()) {
                    PrimaryKey pk = createPrimaryKey(primaryKeys);
                    pks.add(pk);
                }
            } catch (SQLException e) {
                throw e;
            } finally {
                primaryKeys.close();
            }
        } catch (Exception e1) {
            log.warn("Cannot get primary keys with this database driver.", e1);
        }
        return pks;
    }

    /**
     * Method "getPrimaryKey".
     * 
     * @param columnName a column name
     * @return the primary key if any attached to this column. The primary keys must have been created by this table
     * builder.
     */
    public PrimaryKey getPrimaryKey(String columnName) {
        return column2pk.get(columnName);
    }

    /**
     * Method "getForeignKey".
     * 
     * @param columnName a column name
     * @return the foreign key if any attached to this column. The foreign keys must have been created by this table
     * builder.
     */
    public ForeignKey getForeignKey(String columnName) {
        return column2foreign.get(columnName);
    }

    public List<ForeignKey> getForeignKeys(String catalogName, String schemaPattern, String tableName) throws SQLException {
        List<ForeignKey> pks = new ArrayList<ForeignKey>();
        ResultSet foreignKeys = null;
        try {
            foreignKeys = connection.getMetaData().getImportedKeys(catalogName, schemaPattern, tableName);
            try {
                while (foreignKeys.next()) {
                    ForeignKey pk = createForeignKey(foreignKeys);
                    pks.add(pk);
                }
            } catch (SQLException e) {
                throw e;
            } finally {
                foreignKeys.close();
            }
        } catch (Exception e1) {
            log.warn("Cannot get foreign key with this database driver.", e1);
        }
        return pks;
    }

    private ForeignKey createForeignKey(ResultSet foreignKeys) throws SQLException {
        String name = foreignKeys.getString(GetForeignKey.FK_NAME.name());
        String colName = foreignKeys.getString(GetForeignKey.FKCOLUMN_NAME.name());
        ForeignKey foreignKey = orgomg.cwm.resource.relational.RelationalFactory.eINSTANCE.createForeignKey();
        foreignKey.setName(name);
        column2foreign.put(colName, foreignKey);
        return foreignKey;
    }

    private PrimaryKey createPrimaryKey(ResultSet primaryKeys) throws SQLException {
        String pkName = primaryKeys.getString(GetPrimaryKey.PK_NAME.name());
        String colName = primaryKeys.getString(GetPrimaryKey.COLUMN_NAME.name());
        PrimaryKey primaryKey = orgomg.cwm.resource.relational.RelationalFactory.eINSTANCE.createPrimaryKey();
        primaryKey.setName(pkName);
        column2pk.put(colName, primaryKey);
        return primaryKey;
    }

}
