package com.example.mustaphaabdulsalam.hostellink;

import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.InputStream;

/**
 * Created by Mustapha Abdul Salam on 12/19/2016.
 */
public class HostelDetailsActivity extends AppCompatActivity {
    private Button check;
    private TextView manager;
    private TextView phone;
    private TextView gender;
    private TextView capacity;
    private TextView price;
    private ImageView image;
    private String vacant;
    private String location;
    private String path;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.hostel_details);



        check = (Button) findViewById(R.id.button);

        manager = (TextView) findViewById(R.id.textView3);
        phone = (TextView) findViewById(R.id.textView6);
        gender = (TextView) findViewById(R.id.textView9);
        capacity = (TextView) findViewById(R.id.textView15);
        price = (TextView) findViewById(R.id.textView12);
        image = (ImageView) findViewById(R.id.image1);


        Intent intent = getIntent();
        Bundle extras = intent.getExtras();
        path = extras.getString("PATH");
        manager.setText(extras.getString("MANAGER"));
        phone.setText(extras.getString("PHONE"));
        gender.setText(extras.getString("GENDER"));
        capacity.setText(extras.getString("CAPACITY"));
        price.setText(extras.getString("PRICE"));
        vacant = extras.getString("VACANT");
        location = extras.getString("LOCATION");

        new DownloadImageTask(image).execute("http://connectstudentslink.com/hostellink/" + path);


        check.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(HostelDetailsActivity.this, HostelVacantActivity.class);
                Bundle extras = new Bundle();
                extras.putString("MANAGER1", manager.getText().toString());
                extras.putString("PHONE1", phone.getText().toString());
                extras.putString("GENDER1", gender.getText().toString());
                extras.putString("VACANT1", vacant);
                extras.putString("PRICE1", price.getText().toString());
                extras.putString("LOCATION1", location);
                extras.putString("PATH1",path);
                i.putExtras(extras);
                startActivity(i);
            }
        });
    }

    private class DownloadImageTask extends AsyncTask<String, Void, Bitmap> {
        ImageView bmImage;
        ProgressDialog loading;

        public DownloadImageTask(ImageView bmImage) {

            this.bmImage = bmImage;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            loading = ProgressDialog.show(HostelDetailsActivity.this, "Please Wait...","Loading hostel image",true,true);
        }

        @Override
        protected Bitmap doInBackground(String... urls) {
            String urldisplay = urls[0];
            Bitmap mIcon11 = null;

            try {
                InputStream in = new java.net.URL(urldisplay).openStream();
                mIcon11 = BitmapFactory.decodeStream(in);
            } catch (Exception e) {
                Log.e("Error", e.getMessage());
                e.printStackTrace();
            }
            return mIcon11;
        }

        @Override
        protected void onPostExecute(Bitmap result) {
            loading.dismiss();
            bmImage.setImageBitmap(result);
        }
    }
}
