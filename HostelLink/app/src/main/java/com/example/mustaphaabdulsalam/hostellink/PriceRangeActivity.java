package com.example.mustaphaabdulsalam.hostellink;

import android.app.ProgressDialog;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Mustapha Abdul Salam on 12/19/2016.
 */
public class PriceRangeActivity extends AppCompatActivity {
    private Button view;
    private Spinner sp1;
    private EditText min;
    private EditText max;
    private CheckBox choose;
    private String priceSelected;
    private String result,result2;

    private static final String HOSTEL_PRICES = "http://connectstudentslink.com/hostellink/hostelprice.php";
    private static final String HOSTEL_PRICES2 = "http://connectstudentslink.com/hostellink/hostelpricedetails.php";
    private String price1[];
    private String price2[];

    private ArrayAdapter arrayAdapter;
    private List<String> listData = new ArrayList<>();

    private ArrayList<String> hostelName = new ArrayList<>();
    private ArrayList<String> hostelPrice = new ArrayList<>();

    private int opt,opt1;
    private String minV,maxV;
    private boolean check = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.price_range);

        view = (Button) findViewById(R.id.button);
        sp1 = (Spinner) findViewById(R.id.price);
        min = (EditText) findViewById(R.id.editText1);
        max = (EditText) findViewById(R.id.editText2);
        choose = (CheckBox) findViewById(R.id.checkBox);

        min.setEnabled(false);
        max.setEnabled(false);

        getPriceRange(HOSTEL_PRICES);

        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (check == true) {
                    getHostelPrice(min.getText().toString(),max.getText().toString());
                } else {
                    opt = priceSelected.indexOf(" ");
                    opt1 = priceSelected.lastIndexOf(" ");
                    minV = priceSelected.substring(0, opt);
                    maxV = priceSelected.substring(opt1 + 1);
                    getHostelPrice(minV,maxV);
                }
            }
        });

        // Price spinner
        sp1.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                priceSelected = sp1.getSelectedItem().toString();

            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(getApplicationContext(), "Please select price", Toast.LENGTH_LONG).show();
            }
        });

        choose.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (choose.isChecked()) {
                    min.setEnabled(true);
                    max.setEnabled(true);
                    sp1.setEnabled(false);
                    sp1.setClickable(false);
                    check = true;
                } else {
                    min.setEnabled(false);
                    max.setEnabled(false);
                    sp1.setEnabled(true);
                    sp1.setClickable(true);
                    check = false;
                }
            }
        });
    }

    private void getPriceRange(String url) {
        class GetJSON extends AsyncTask<String, Void, String> {
            ProgressDialog loading;

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                loading = ProgressDialog.show(PriceRangeActivity.this, "Please Wait...","Fetching Price",true,true);
            }

            @Override
            protected String doInBackground(String... params) {

                String uri = params[0];

                BufferedReader bufferedReader = null;
                try {
                    URL url = new URL(uri);
                    HttpURLConnection con = (HttpURLConnection) url.openConnection();
                    StringBuilder sb = new StringBuilder();

                    bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));

                    String line;
                    while((line = bufferedReader.readLine())!= null){
                        sb.append(line+"\n");
                    }

                    result = sb.toString().trim();

                    JSONArray jArray = new JSONArray(result);
                    JSONObject json = null;
                    price1 = new String[jArray.length()];
                    price2 = new String[jArray.length()];

                    for(int i=0;i<jArray.length();i++){
                        json = jArray.getJSONObject(i);
                        price1[i] = json.getString("min");
                        price2[i] = json.getString("max");
                    }

                    for (int i=0;i<price1.length;i++) {
                        listData.add(price1[i]+" - "+price2[i]);
                    }


                    return result;

                } catch(Exception e){
                    return null;
                }
            }

            @Override
            protected void onPostExecute(String s) {
                super.onPostExecute(s);
                loading.dismiss();
                spinner_price();
            }
        }

        GetJSON gj = new GetJSON();
        gj.execute(url);
    }

    private void spinner_price(){
        arrayAdapter = new ArrayAdapter<String>(this,android.R.layout.simple_spinner_item,listData);
        arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sp1.setAdapter(arrayAdapter);
    }


    private void getHostelPrice(String min,String max) {
        class GetJSON extends AsyncTask<String, Void, String> {
            ProgressDialog loading;

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                loading = ProgressDialog.show(PriceRangeActivity.this, "Please Wait...","Fetching Data",true,true);
            }

            @Override
            protected String doInBackground(String... params) {
                String value1 = params[0];
                String value2 = params[1];

                try {
                    URL url = new URL(HOSTEL_PRICES2);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setReadTimeout(15000);
                    conn.setConnectTimeout(15000);
                    conn.setRequestMethod("POST");
                    conn.setDoInput(true);
                    conn.setDoOutput(true);

                    Uri.Builder builder = new Uri.Builder()
                            .appendQueryParameter("min", value1)
                            .appendQueryParameter("max", value2);
                    String query = builder.build().getEncodedQuery();

                    OutputStream os = conn.getOutputStream();
                    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os, "UTF-8"));
                    writer.write(query);

                    writer.flush();
                    writer.close();

                    InputStream is = conn.getInputStream();
                    BufferedReader rd = new BufferedReader(new InputStreamReader(is));
                    String line;

                    StringBuilder sb = new StringBuilder();

                    while((line = rd.readLine()) != null) {
                        sb.append(line+"\n");
                    }

                    result2 = sb.toString().trim();

                    JSONArray jArray = new JSONArray(result2);

                    for(int i=0;i<jArray.length();i++){
                        JSONObject json_data = jArray.getJSONObject(i);
                        hostelName.add(json_data.getString("HOSTEL_NAME"));
                        hostelPrice.add(json_data.getString("PRICE_PER_HEAD"));
                    }

                }
                catch(Exception e) {
                    Toast.makeText(getApplicationContext(), e.getMessage(), Toast.LENGTH_LONG).show();
                }

                return result2;
            }

            @Override
            protected void onPostExecute(String s) {
                super.onPostExecute(s);
                loading.dismiss();

                displayHostelPrice();

            }
        }

        GetJSON gj = new GetJSON();
        gj.execute(min, max);
    }

    private void displayHostelPrice() {
        Intent i = new Intent(PriceRangeActivity.this, ViewPriceActivity.class);
        Bundle extras = new Bundle();
        if (extras != null) {
            extras.putStringArrayList("HOSTEL", hostelName);
            extras.putStringArrayList("PRICE", hostelPrice);

            i.putExtras(extras);
            startActivity(i);
        } else {
            Toast.makeText(getApplicationContext(), "No record found", Toast.LENGTH_LONG).show();
        }
    }
}
