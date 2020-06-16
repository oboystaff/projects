package com.example.mustaphaabdulsalam.studentdetails;

import android.database.Cursor;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;


public class DatabaseAdapter {

    public static final String FIRSTNAME = "firstname";
    public static final String LASTNAME = "lastname";
    public static final String LOCATION = "location";
    public static final String GENDER = "gender";
    public static final String TABLE_NAME = "student";
    public static final String DATABASE_NAME = "softwareeng";
    public static final int VERSION = 1;

    public static final String TABLE_CREATE = "create table student (firstname varchar(45),lastname varchar(45),location varchar(45),gender varchar(10));";

    DatabaseHelper dbHelper;
    Context ctx;
    SQLiteDatabase db;


    public DatabaseAdapter(Context ctx) {
        this.ctx = ctx;
        dbHelper = new DatabaseHelper(ctx);
    }

    private static class DatabaseHelper extends SQLiteOpenHelper {

        public DatabaseHelper(Context ctx) {
            super(ctx,DATABASE_NAME,null,VERSION);
        }

        public void onCreate(SQLiteDatabase db) {
            try {
                db.execSQL(TABLE_CREATE);
            } catch(Exception e) {
                e.printStackTrace();
            }
        }

        public void onUpgrade(SQLiteDatabase db,int oldVersion,int newVersion) {
            db.execSQL("DROP TABLE IF EXISTS student");
            onCreate(db);
        }
    }

    public DatabaseAdapter open() {
        db = dbHelper.getWritableDatabase();
        return this;
    }

    public void close() {
        dbHelper.close();
    }

    // Inserting records into a database
    public long insertRecord(String fname,String lname,String loc,String gen) {

        ContentValues cv = new ContentValues();
        cv.put(FIRSTNAME,fname);
        cv.put(LASTNAME,lname);
        cv.put(LOCATION,loc);
        cv.put(GENDER,gen);

        return db.insert(TABLE_NAME, null, cv);
    }

    //Updating records in a database
    public long updateRecord(String fname,String lname,String loc,String gen) {

        ContentValues cv = new ContentValues();
        cv.put(FIRSTNAME,fname);
        cv.put(LASTNAME,lname);
        cv.put(LOCATION,loc);
        cv.put(GENDER,gen);

        return db.update(TABLE_NAME, cv, "firstname=?", new String[]{fname});
    }

    //Selecting particular records from database using the cursor class
    public Cursor getSingleData(String fname) {
        Cursor res = db.rawQuery("select * from student where firstname='"+fname+"'",null);
        return res;
    }

    //Retrieving all records in a database
    public Cursor getData() {

        return db.query(TABLE_NAME, new String[]{FIRSTNAME, LASTNAME, LOCATION,GENDER }, null, null, null, null, null);
    }

    //Deleting a particular records from database
    public long deleteRecords(String fname) {

        return db.delete(TABLE_NAME,"firstname=?",new String[]{fname});
    }
}

