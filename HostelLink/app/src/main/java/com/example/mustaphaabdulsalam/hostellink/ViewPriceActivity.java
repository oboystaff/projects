package com.example.mustaphaabdulsalam.hostellink;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

/**
 * Created by Mustapha Abdul Salam on 12/19/2016.
 */
public class ViewPriceActivity extends AppCompatActivity {
    private TableLayout table;
    private ArrayList<String> hostelName = new ArrayList<>();
    private ArrayList<String> hostelPrice = new ArrayList<>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.view_price_combo);

        table = (TableLayout) findViewById(R.id.table);

        Intent intent = getIntent();
        Bundle extras = intent.getExtras();

        if (extras != null) {
            hostelName = extras.getStringArrayList("HOSTEL");
            hostelPrice = extras.getStringArrayList("PRICE");

            for (int i=0;i<hostelName.size();i++) {
                TableRow tbrow = new TableRow(this);
                TextView t1v = new TextView(this);
                t1v.setText(hostelName.get(i));
                t1v.setTextColor(Color.BLUE);
                t1v.setTextSize(20);
                t1v.setPadding(5, 5, 5, 5);
                t1v.setBackgroundResource(R.drawable.cell_shape);
                tbrow.addView(t1v);
                TextView t2v = new TextView(this);
                t2v.setText(hostelPrice.get(i));
                t2v.setTextColor(Color.BLUE);
                t2v.setTextSize(20);
                t2v.setPadding(5,5,5,5);
                t2v.setBackgroundResource(R.drawable.cell_shape);
                tbrow.addView(t2v);
                table.addView(tbrow);
            }
        } else {
            Toast.makeText(getApplicationContext(), "No record found", Toast.LENGTH_LONG).show();
        }
    }
}
