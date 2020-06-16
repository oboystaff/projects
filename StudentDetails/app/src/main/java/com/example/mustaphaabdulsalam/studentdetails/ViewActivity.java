package com.example.mustaphaabdulsalam.studentdetails;

import android.database.Cursor;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;

/**
 * Created by Mustapha Abdul Salam on 9/29/2017.
 */
public class ViewActivity extends AppCompatActivity {
    private DatabaseAdapter db;
    private ListView lv;
    private ArrayList<String> cb = new ArrayList<String>();
    private ArrayAdapter<String> adapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.view_activity);

        lv = (ListView) findViewById(R.id.listView);
        adapter = new ArrayAdapter<String>(this,android.R.layout.simple_selectable_list_item,cb);

        db = new DatabaseAdapter(this);

        loadData();
    }


    private void loadData() {
        db.open();
        cb.clear();

        Cursor rs = db.getData();
        while (rs.moveToNext()){
            String info = rs.getString(rs.getColumnIndex(db.FIRSTNAME))+" "+rs.getString(rs.getColumnIndex(db.LASTNAME))+" "+rs.getString(rs.getColumnIndex(db.LOCATION))+" "+rs.getString(rs.getColumnIndex(db.GENDER));
            cb.add(info);
        }

        lv.setAdapter(adapter);

        db.close();
    }
}
