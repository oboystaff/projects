package com.example.mustaphaabdulsalam.studentdetails;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Mustapha Abdul Salam on 10/20/2017.
 */
public class InsertIntoRemoteDatabase extends AppCompatActivity {
    private EditText firstname;
    private EditText lastname;
    private EditText location;
    private EditText gender;

    private Button save;
    private Button clear;


    String url = "http://192.168.43.103/androidproject/insert2.php";

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


        save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                saveRequest();

                /*
                RequestQueue queue = Volley.newRequestQueue(InsertIntoRemoteDatabase.this);
                StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {

                        Toast.makeText(InsertIntoRemoteDatabase.this, "dfdsfsd"+response, Toast.LENGTH_LONG).show();

                    }
                }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {

                        Toast.makeText(InsertIntoRemoteDatabase.this, "Error: "+error, Toast.LENGTH_LONG).show();
                    }
                }){
                    @Override
                    protected Map<String, String> getParams() throws AuthFailureError {
                        Map<String,String> map = new HashMap<String, String>();
                        map.put("firstname",firstname.getText().toString());
                        map.put("lastname",lastname.getText().toString());
                        map.put("location",location.getText().toString());
                        map.put("gender",gender.getText().toString());

                        return map;
                    }
                };

                queue.add(request);
                */

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
    }

    private void saveRequest() {
        final ProgressDialog mDialog = new ProgressDialog(this);
        mDialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        mDialog.setMessage("Loading...");
        mDialog.show();

        StringRequest request = new StringRequest(Request.Method.POST, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        mDialog.dismiss();
                        Toast.makeText(getApplicationContext(), response, Toast.LENGTH_LONG).show();
                        firstname.setText(null);
                        lastname.setText(null);
                        location.setText(null);
                        gender.setText(null);
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        mDialog.dismiss();
                        Toast.makeText(getApplicationContext(), "Something went wrong", Toast.LENGTH_LONG).show();
                    }
                }){
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> key = new HashMap<>();
                key.put("firstname",firstname.getText().toString());
                key.put("lastname",lastname.getText().toString());
                key.put("location",location.getText().toString());
                key.put("gender",gender.getText().toString());

                return key;
            }
        };

        NetworkCalls.getInstance().addToRequestQueue(request);
    }
}
