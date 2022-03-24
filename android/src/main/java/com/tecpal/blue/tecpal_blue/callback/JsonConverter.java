package com.tecpal.blue.tecpal_blue.callback;

import androidx.annotation.Nullable;

import org.json.JSONException;

public interface JsonConverter<T> {

    @Nullable
    String toJson(T value) throws JSONException;
}
