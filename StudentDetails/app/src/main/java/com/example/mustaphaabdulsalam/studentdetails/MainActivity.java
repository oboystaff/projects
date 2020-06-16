package com.example.mustaphaabdulsalam.studentdetails;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    private EditText firstname;
    private EditText lastname;
    private EditText location;
    private EditText gender;

    private Button save;
    private Button clear;
    private Button view;
    private Button update;

    private DatabaseAdapter db;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        firstname = (EditText) findViewById(R.id.editText);
        lastname = (EditText) findViewById(R.id.editText2);
        location = (EditText) findViewById(R.id.editText3);
        gender = (EditText) findViewById(R.id.editText4);

        save = (Button) findViewById(R.id.button);
        clear = (Button) findViewById(R.id.button2);
        //view = (Button) findViewById(R.id.button3);
        //update = (Button) findViewById(R.id.button6);


        db = new DatabaseAdapter(this);

        save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String first = firstname.getText().toString();
                String last = lastname.getText().toString();
                String loc = location.getText().toString();
                String gen = gender.getText().toString();

                db.open();
                long res = db.insertRecord(first,last,loc,gen);

                if (res >0) {
                    Toast.makeText(getApplicationContext(),"Record saved successfully", Toast.LENGTH_SHORT).show();
                }else {

                    Toast.makeText(getApplicationContext(),"Unable to save records", Toast.LENGTH_SHORT).show();
                }
            }
        });

        clear.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                firstname.setText(null);
                lastname.setText(null);
                location.setText(null);
                gender.setText(null);
            }
        });

        /*
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(MainActivity.this,ViewActivity.class);
                startActivity(i);
            }
        });

        update.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(MainActivity.this,UpdateActivity.class);
                startActivity(i);
            }
        });
        */
    }
}
