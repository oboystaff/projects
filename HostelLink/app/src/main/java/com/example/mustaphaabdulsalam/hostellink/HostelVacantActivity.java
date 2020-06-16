package com.example.mustaphaabdulsalam.hostellink;

import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.ImageView;
import android.widget.TextView;

import java.io.InputStream;

/**
 * Created by Mustapha Abdul Salam on 12/19/2016.
 */
public class HostelVacantActivity extends AppCompatActivity {
    private TextView manager;
    private TextView phone;
    private TextView gender;
    private TextView vacant;
    private TextView price;
    private TextView location;
    private ImageView image;

    private String path;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.hostel_vacant_space);

        manager = (TextView) findViewById(R.id.textView3);
        phone = (TextView) findViewById(R.id.textView6);
        gender = (TextView) findViewById(R.id.textView9);
        vacant = (TextView) findViewById(R.id.textView15);
        price = (TextView) findViewById(R.id.textView12);
        location = (TextView) findViewById(R.id.textView17);
        image = (ImageView) findViewById(R.id.logo);

        Intent intent = getIntent();
        Bundle extras = intent.getExtras();
        manager.setText(extras.getString("MANAGER1"));
        phone.setText(extras.getString("PHONE1"));
        gender.setText(extras.getString("GENDER1"));
        vacant.setText(extras.getString("VACANT1"));
        price.setText(extras.getString("PRICE1"));
        location.setText(extras.getString("LOCATION1"));
        path = extras.getString("PATH1");

        new DownloadImageTask(image).execute("http://connectstudentslink.com/hostellink/" + path);
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
            loading = ProgressDialog.show(HostelVacantActivity.this, "Please Wait...","Loading hostel image",true,true);
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
