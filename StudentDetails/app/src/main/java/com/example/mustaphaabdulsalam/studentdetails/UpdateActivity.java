package com.example.mustaphaabdulsalam.studentdetails;

import android.database.Cursor;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

/**
 * Created by Mustapha Abdul Salam on 9/29/2017.
 */
public class UpdateActivity extends AppCompatActivity {
    private EditText firstname;
    private EditText lastname;
    private EditText location;
    private EditText gender;
    private EditText searchName;

    private Button search;
    private Button update;

    private DatabaseAdapter db;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.update_activity);

        firstname = (EditText) findViewById(R.id.editText6);
        lastname = (EditText) findViewById(R.id.editText7);
        location = (EditText) findViewById(R.id.editText8);
        gender = (EditText) findViewById(R.id.editText9);
        searchName = (EditText) findViewById(R.id.editText5);

        search = (Button) findViewById(R.id.button4);
        update = (Button) findViewById(R.id.button5);

        db = new DatabaseAdapter(this);

        search.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                db.open();

                Cursor rs = db.getSingleData(searchName.getText().toString());
                while (rs.moveToNext()){
                    firstname.setText(rs.getString(rs.getColumnIndex(db.FIRSTNAME)));
                    lastname.setText(rs.getString(rs.getColumnIndex(db.LASTNAME)));
                    location.setText(rs.getString(rs.getColumnIndex(db.LOCATION)));
                    gender.setText(rs.getString(rs.getColumnIndex(db.GENDER)));
                }

                db.close();
            }
        });

        update.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                db.open();
                String first = firstname.getText().toString();
                String last = lastname.getText().toString();
                String loc = location.getText().toString();
                String gen = gender.getText().toString();

                long res = db.updateRecord(first,last,loc,gen);

                if (res > 0) {
                    Toast.makeText(getApplicationContext(), "Record updated successfully", Toast.LENGTH_LONG).show();
                }else {

                    Toast.makeText(getApplicationContext(),"Unable to update records", Toast.LENGTH_LONG).show();
                }

                db.close();
            }
        });
    }
}
