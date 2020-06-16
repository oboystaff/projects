package com.example.mustaphaabdulsalam.hostellink;

import android.app.ProgressDialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;

import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import android.os.AsyncTask;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;
import java.io.BufferedReader;
import java.io.InputStreamReader;


public class DetailActivity extends AppCompatActivity {
    private Button view;
    private Spinner sp1;
    private Spinner sp2;
    private Spinner sp3;

    private ArrayAdapter arrayAdapter1;
    private ArrayAdapter arrayAdapter2;
    private ArrayAdapter arrayAdapter3;

    private List<String> listData1 =new ArrayList<String>();
    private List<String> listData2 = new ArrayList<>();
    private List<String> listData3 = new ArrayList<>();

    private String names[];
    private String hostels[];

    private String result1,result2,result3;

    private String manager;
    private String phone;
    private String gender;
    private String capacity;
    private String price;
    private String location;
    private String vacant;
    private String path;

    private final String URL_INSTITUTIONS = "http://connectstudentslink.com/hostellink/readinstitution.php";
    private final String URL_HOSTELS = "http://connectstudentslink.com/hostellink/readhostel.php";
    private static final String HOSTEL_DETAILS = "http://connectstudentslink.com/hostellink/hosteldetail.php";

    private String regionSelected;
    private String institutionSelected;
    private String hostelSelected;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.detail_info);
        view = (Button) findViewById(R.id.button);
        sp1 = (Spinner) findViewById(R.id.region);
        sp2 = (Spinner) findViewById(R.id.institution);
        sp3 = (Spinner) findViewById(R.id.hostel);

        listData1.add("<Select Region>");
        listData1.add("Ashanti");
        listData1.add("Greater Accra");
        listData1.add("Northern");
        listData1.add("Volta");
        listData1.add("Brong Ahafo");
        listData1.add("Eastern");
        listData1.add("Western");
        listData1.add("Upper East");
        listData1.add("Upper West");
        listData1.add("Central");


        arrayAdapter1 = new ArrayAdapter(DetailActivity.this,android.R.layout.simple_spinner_item, listData1);
        arrayAdapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sp1.setAdapter(arrayAdapter1);


        getInstitutions(URL_INSTITUTIONS);
        getHostels(URL_HOSTELS);


        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getServerData(hostelSelected, regionSelected, institutionSelected);
            }
        });

        // Regions spinner
        sp1.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                regionSelected = sp1.getSelectedItem().toString();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(getApplicationContext(),"Please select region",Toast.LENGTH_LONG).show();
            }
        });

        // Institutions closed to spinner
        sp2.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                institutionSelected = sp2.getSelectedItem().toString();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(getApplicationContext(),"Please select institution closed to",Toast.LENGTH_LONG).show();
            }
        });

        // Hostel names spinner
        sp3.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                hostelSelected = sp3.getSelectedItem().toString();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(getApplicationContext(),"Please select hostel name",Toast.LENGTH_LONG).show();
            }
        });
    }



    private void getInstitutions(String url) {
        class GetJSON extends AsyncTask<String, Void, String> {
            ProgressDialog loading;

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                loading = ProgressDialog.show(DetailActivity.this, "Please Wait...","Fetching Institutions",true,true);
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

                    result1 = sb.toString().trim();

                    JSONArray jArray = new JSONArray(result1);
                    JSONObject json = null;
                    names = new String[jArray.length()];

                    for(int i=0;i<jArray.length();i++){
                        json = jArray.getJSONObject(i);
                        names[i] = json.getString("INSTITUTION_NAME");
                    }

                    for (int i=0;i<names.length;i++) {
                        listData2.add(names[i]);
                    }


                    return result1;

                } catch(Exception e){
                    return null;
                }
            }

            @Override
            protected void onPostExecute(String s) {
                super.onPostExecute(s);
                loading.dismiss();
                spinner_institution();
            }
        }

        GetJSON gj = new GetJSON();
        gj.execute(url);
    }


    private void getHostels(String url) {
        class GetJSON extends AsyncTask<String, Void, String> {
            ProgressDialog loading;

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                loading = ProgressDialog.show(DetailActivity.this, "Please Wait...","Fetching Hostels",true,true);
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

                    result2 = sb.toString().trim();

                    JSONArray jArray = new JSONArray(result2);
                    JSONObject json = null;
                    hostels = new String[jArray.length()];

                    for(int i=0;i<jArray.length();i++){
                        json = jArray.getJSONObject(i);
                        hostels[i] = json.getString("HOSTEL_NAME");
                    }

                    for (int i=0;i<hostels.length;i++) {
                        listData3.add(hostels[i]);
                    }


                    return result2;

                } catch(Exception e){
                    return null;
                }
            }

            @Override
            protected void onPostExecute(String s) {
                super.onPostExecute(s);
                loading.dismiss();
                spinner_hostel();
            }
        }

        GetJSON gj = new GetJSON();
        gj.execute(url);
    }


    private void spinner_institution(){
        arrayAdapter2 = new ArrayAdapter<String>(this,android.R.layout.simple_spinner_item,names);
        arrayAdapter2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sp2.setAdapter(arrayAdapter2);
    }

    private void spinner_hostel(){
        arrayAdapter3 = new ArrayAdapter<String>(this,android.R.layout.simple_spinner_item,hostels);
        arrayAdapter3.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sp3.setAdapter(arrayAdapter3);
    }

    private void getServerData(String name,String region,String institution) {
        class GetJSON extends AsyncTask<String, Void, String> {
            ProgressDialog loading;

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                loading = ProgressDialog.show(DetailActivity.this, "Please Wait...","Fetching Data",true,true);
            }

            @Override
            protected String doInBackground(String... params) {
                String value1 = params[0];
                String value2 = params[1];
                String value3 = params[2];

                try {
                    URL url = new URL(HOSTEL_DETAILS);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setReadTimeout(15000);
                    conn.setConnectTimeout(15000);
                    conn.setRequestMethod("POST");
                    conn.setDoInput(true);
                    conn.setDoOutput(true);

                    Uri.Builder builder = new Uri.Builder()
                            .appendQueryParameter("name", value1)
                            .appendQueryParameter("region", value2)
                            .appendQueryParameter("institution", value3);
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

                    result3 = sb.toString().trim();

                    JSONArray jArray = new JSONArray(result3);

                    for(int i=0;i<jArray.length();i++){
                        JSONObject json_data = jArray.getJSONObject(i);
                        manager = json_data.getString("MANAGER");
                        phone = json_data.getString("PHONE");
                        gender = json_data.getString("GENDER");
                        capacity = json_data.getString("CAPACITY");
                        price = json_data.getString("PRICE_PER_HEAD");
                        location = json_data.getString("LOCATION");
                        vacant = json_data.getString("VACANT_SPACE");
                        path = json_data.getString("IMAGE_PATH_NAME");
                    }

                }
                catch(Exception e) {
                    Toast.makeText(getApplicationContext(), e.getMessage(), Toast.LENGTH_LONG).show();
                }

                return result3;
            }

            @Override
            protected void onPostExecute(String s) {
                super.onPostExecute(s);
                loading.dismiss();

                Intent i = new Intent(DetailActivity.this, HostelDetailsActivity.class);
                Bundle extras = new Bundle();
                extras.putString("MANAGER", manager);
                extras.putString("PHONE", phone);
                extras.putString("GENDER", gender);
                extras.putString("CAPACITY", capacity);
                extras.putString("PRICE", price);
                extras.putString("LOCATION", location);
                extras.putString("VACANT", vacant);
                extras.putString("PATH", path);
                i.putExtras(extras);
                startActivity(i);
            }
        }

        GetJSON gj = new GetJSON();
        gj.execute(name, region, institution);
    }
}
