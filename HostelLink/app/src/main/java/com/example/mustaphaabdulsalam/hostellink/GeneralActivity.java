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
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Mustapha Abdul Salam on 12/18/2016.
 */
public class GeneralActivity extends AppCompatActivity {
    private Button publicHostel;
    private Button privateHostel;
    private Button priceRange;
    private Spinner sp1;
    private Spinner sp2;

    private ArrayAdapter arrayAdapter1;
    private ArrayAdapter arrayAdapter2;

    private List<String> listData1 = new ArrayList<>();
    private List<String> listData2 = new ArrayList<>();

    private String names[];

    private final String URL_INSTITUTIONS = "http://connectstudentslink.com/hostellink/readinstitution.php";
    private static final String HOSTEL_DETAILS = "http://connectstudentslink.com/hostellink/hosteldetail2.php";

    private String result,result2;

    private String regionSelected;
    private String institutionSelected;
    private String hostelType;

    private ArrayList<String> hostelName = new ArrayList<>();
    private ArrayList<String> hostelGender = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.general_info);

        publicHostel = (Button) findViewById(R.id.button1);
        privateHostel = (Button) findViewById(R.id.button2);
        priceRange = (Button) findViewById(R.id.button3);

        sp1 = (Spinner) findViewById(R.id.region);
        sp2 = (Spinner) findViewById(R.id.institution);

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

        arrayAdapter1 = new ArrayAdapter(GeneralActivity.this,android.R.layout.simple_spinner_item, listData1);
        arrayAdapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sp1.setAdapter(arrayAdapter1);

        //final ConnectionDetector cd = new ConnectionDetector(this);

        //if (cd.isConnectingToInternet()) {
            getInstitutions(URL_INSTITUTIONS);
        //} else {
            //Toast.makeText(getApplicationContext(), "Data not switched ON ", Toast.LENGTH_LONG).show();
       // }


        publicHostel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //if (cd.isConnectingToInternet()) {
                    hostelType = "Public";
                    getPublicHostels(hostelType, regionSelected, institutionSelected);
                //} else {
                    //Toast.makeText(getApplicationContext(), "Data not switched ON ", Toast.LENGTH_LONG).show();
                //}
            }
        });

        privateHostel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //if (cd.isConnectingToInternet()) {
                    hostelType = "Private";
                    getPrivateHostels(hostelType, regionSelected, institutionSelected);
                //} else {
                    //Toast.makeText(getApplicationContext(), "Data not switched ON ", Toast.LENGTH_LONG).show();
                //}
            }
        });

        priceRange.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(GeneralActivity.this,PriceRangeActivity.class);
                startActivity(i);
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
                Toast.makeText(getApplicationContext(), "Please select region", Toast.LENGTH_LONG).show();
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
                Toast.makeText(getApplicationContext(), "Please select institution closed to", Toast.LENGTH_LONG).show();
            }
        });
    }

    private void getInstitutions(String url) {
        class GetJSON extends AsyncTask<String, Void, String> {
            ProgressDialog loading;

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                loading = ProgressDialog.show(GeneralActivity.this, "Please Wait...","Fetching Institutions",true,true);
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
                    names = new String[jArray.length()];

                    for(int i=0;i<jArray.length();i++){
                        json = jArray.getJSONObject(i);
                        names[i] = json.getString("INSTITUTION_NAME");
                    }

                    for (int i=0;i<names.length;i++) {
                        listData2.add(names[i]);
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
                spinner_institution();
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

    private void getPublicHostels(String hostel,String region,String institution) {
        class GetJSON extends AsyncTask<String, Void, String> {
            ProgressDialog loading;

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                loading = ProgressDialog.show(GeneralActivity.this, "Please Wait...","Fetching Data",true,true);
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
                            .appendQueryParameter("hostel", value1)
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

                    result2 = sb.toString().trim();


                    JSONArray jArray = new JSONArray(result2);

                    for(int i=0;i<jArray.length();i++){
                        JSONObject json_data = jArray.getJSONObject(i);
                        hostelName.add(json_data.getString("HOSTEL_NAME"));
                        hostelGender.add(json_data.getString("GENDER"));
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

                if (s.equalsIgnoreCase("No record found")) {
                    Toast.makeText(getApplicationContext(), "No record found", Toast.LENGTH_LONG).show();
                } else {
                    displayPublicHostels();
                }

            }
        }

        GetJSON gj = new GetJSON();
        gj.execute(hostel, region, institution);
    }

    private void getPrivateHostels(String hostel,String region,String institution) {
        class GetJSON extends AsyncTask<String, Void, String> {
            ProgressDialog loading;

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                loading = ProgressDialog.show(GeneralActivity.this, "Please Wait...","Fetching Data",true,true);
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
                            .appendQueryParameter("hostel", value1)
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

                    result2 = sb.toString().trim();

                    JSONArray jArray = new JSONArray(result2);

                    for(int i=0;i<jArray.length();i++){
                        JSONObject json_data = jArray.getJSONObject(i);
                        hostelName.add(json_data.getString("HOSTEL_NAME"));
                        hostelGender.add(json_data.getString("GENDER"));
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

                try {
                    displayPrivateHostels();
                } catch (Exception e) {
                    Toast.makeText(getApplicationContext(),e.getMessage(), Toast.LENGTH_LONG).show();
                }
            }
        }

        GetJSON gj = new GetJSON();
        gj.execute(hostel, region, institution);
    }


    private void displayPublicHostels() {
        Intent i = new Intent(GeneralActivity.this, PublicHostelsActivity.class);
        Bundle extras = new Bundle();
        if (extras != null) {
            extras.putStringArrayList("HOSTEL", hostelName);
            extras.putStringArrayList("GENDER", hostelGender);

            i.putExtras(extras);
            startActivity(i);
        } else {
            Toast.makeText(getApplicationContext(), "No record found", Toast.LENGTH_LONG).show();
        }
    }

    private void displayPrivateHostels() {
        Intent i = new Intent(GeneralActivity.this, PrivateHostelsActivity.class);
        Bundle extras = new Bundle();
        if (hostelName.size() > 0 && hostelGender.size() > 0) {
            extras.putStringArrayList("HOSTEL", hostelName);
            extras.putStringArrayList("GENDER", hostelGender);

            i.putExtras(extras);
            startActivity(i);
        } else {
            Toast.makeText(getApplicationContext(), "No record found", Toast.LENGTH_LONG).show();
        }
    }

}
