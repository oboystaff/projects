package com.example.mustaphaabdulsalam.hostellink;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {
    private Button detail,general,vacant;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        detail = (Button) findViewById(R.id.button);
        general = (Button) findViewById(R.id.button2);
        vacant = (Button) findViewById(R.id.button3);

        detail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(MainActivity.this,DetailActivity.class);
                startActivity(i);
            }
        });

        general.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(MainActivity.this,GeneralActivity.class);
                startActivity(i);
            }
        });

        vacant.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(MainActivity.this,VacantActivity.class);
                startActivity(i);
            }
        });
    }
}
